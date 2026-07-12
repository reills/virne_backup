#!/usr/bin/env python3
"""Summarize the paired AlphaVNE vs no-NN MCTS evaluation."""

from __future__ import annotations

import argparse
import csv
import math
import re
import statistics
from pathlib import Path


T_975 = {
    1: 12.706,
    2: 4.303,
    3: 3.182,
    4: 2.776,
    5: 2.571,
    6: 2.447,
    7: 2.365,
    8: 2.306,
    9: 2.262,
    10: 2.228,
    11: 2.201,
    12: 2.179,
    13: 2.160,
    14: 2.145,
    15: 2.131,
    16: 2.120,
    17: 2.110,
    18: 2.101,
    19: 2.093,
    20: 2.086,
    21: 2.080,
    22: 2.074,
    23: 2.069,
    24: 2.064,
    25: 2.060,
    26: 2.056,
    27: 2.052,
    28: 2.048,
    29: 2.045,
    30: 2.042,
}


def read_last_row(path: Path) -> dict[str, str]:
    with path.open(newline="") as handle:
        rows = list(csv.DictReader(handle))
    if not rows:
        raise RuntimeError(f"empty summary: {path}")
    return rows[-1]


def mean(values: list[float]) -> float:
    return sum(values) / len(values)


def sample_std(values: list[float]) -> float:
    return statistics.stdev(values) if len(values) > 1 else 0.0


def paired_ci95(values: list[float]) -> tuple[float, float]:
    center = mean(values)
    if len(values) < 2:
        return center, center
    standard_error = sample_std(values) / math.sqrt(len(values))
    critical = T_975.get(len(values) - 1, 1.960)
    return center - critical * standard_error, center + critical * standard_error


def write_csv(path: Path, rows: list[dict[str, object]], fields: list[str]) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    with path.open("w", newline="") as handle:
        writer = csv.DictWriter(handle, fieldnames=fields)
        writer.writeheader()
        writer.writerows({field: row.get(field, "") for field in fields} for row in rows)


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--solver-results-root", type=Path, required=True)
    parser.add_argument("--analysis-root", type=Path, required=True)
    parser.add_argument("--stamp", required=True)
    parser.add_argument("--k", type=int, required=True)
    parser.add_argument("--budget", type=int, required=True)
    parser.add_argument("--topologies", nargs="+", required=True)
    parser.add_argument("--seeds", nargs="+", type=int, required=True)
    parser.add_argument("--allow-partial", action="store_true")
    args = parser.parse_args()

    pattern = re.compile(
        rf"^journal_suite__alpha_zero_sfc__(?P<topology>{'|'.join(map(re.escape, args.topologies))})"
        rf"__matched_nn_vs_no_nn_k{args.k}__(?P<arm>nn|no_nn)__budget{args.budget}"
        rf"__seed(?P<seed>\d+)__eval__{re.escape(args.stamp)}$"
    )

    rows: list[dict[str, object]] = []
    glob_pattern = (
        f"journal_suite__alpha_zero_sfc__*__matched_nn_vs_no_nn_k{args.k}__*"
        f"__budget{args.budget}__seed*__eval__{args.stamp}/summary.csv"
    )
    for path in sorted(args.solver_results_root.glob(glob_pattern)):
        match = pattern.match(path.parent.name)
        if not match:
            continue
        data = read_last_row(path)
        rows.append(
            {
                "topology": match.group("topology"),
                "seed": int(match.group("seed")),
                "arm": match.group("arm"),
                "k_eval": args.k,
                "mcts_simulations": args.budget,
                "acceptance_rate": float(data["acceptance_rate"]),
                "long_term_r2c_ratio": float(data.get("long_term_r2c_ratio", "nan")),
                "clock_running_time": float(data.get("clock_running_time", "nan")),
                "success_count": int(float(data.get("success_count", 0))),
                "place_failure_count": int(float(data.get("place_failure_count", 0))),
                "route_failure_count": int(float(data.get("route_failure_count", 0))),
                "run_id": path.parent.name,
                "summary_path": str(path),
            }
        )

    cells = {(str(row["topology"]), int(row["seed"]), str(row["arm"])) for row in rows}
    expected = {
        (topology, seed, arm)
        for topology in args.topologies
        for seed in args.seeds
        for arm in ("nn", "no_nn")
    }
    missing = sorted(expected - cells)
    if missing and not args.allow_partial:
        formatted = ", ".join(f"{topology}/seed{seed}/{arm}" for topology, seed, arm in missing)
        raise RuntimeError(f"missing {len(missing)} matched evaluation cells: {formatted}")

    rows.sort(key=lambda row: (str(row["topology"]), int(row["seed"]), str(row["arm"])))
    raw_fields = [
        "topology",
        "seed",
        "arm",
        "k_eval",
        "mcts_simulations",
        "acceptance_rate",
        "long_term_r2c_ratio",
        "clock_running_time",
        "success_count",
        "place_failure_count",
        "route_failure_count",
        "run_id",
        "summary_path",
    ]
    write_csv(args.analysis_root / "eval_summary.csv", rows, raw_fields)

    paired_rows: list[dict[str, object]] = []
    report_lines = [
        "# Matched AlphaVNE vs no-NN MCTS ablation",
        "",
        f"- Evaluation routing budget: `k={args.k}`",
        f"- MCTS simulations per placement decision: `{args.budget}`",
        f"- Seeds: `{' '.join(map(str, args.seeds))}`",
        "- Pairing: identical topology, seed, substrate file, request trace, and solver constraints.",
        "- The only intended method difference is neural policy/value guidance.",
        "",
        "## Aggregate results",
        "",
        "| Topology | AlphaVNE acceptance | No-NN acceptance | Paired gain | 95% CI | AlphaVNE runtime (s) | No-NN runtime (s) |",
        "| --- | ---: | ---: | ---: | ---: | ---: | ---: |",
    ]

    for topology in args.topologies:
        by_cell = {
            (int(row["seed"]), str(row["arm"])): row
            for row in rows
            if row["topology"] == topology
        }
        paired_seeds = [
            seed
            for seed in args.seeds
            if (seed, "nn") in by_cell and (seed, "no_nn") in by_cell
        ]
        if not paired_seeds:
            continue
        nn_acc = [float(by_cell[(seed, "nn")]["acceptance_rate"]) for seed in paired_seeds]
        no_nn_acc = [float(by_cell[(seed, "no_nn")]["acceptance_rate"]) for seed in paired_seeds]
        differences = [nn - no_nn for nn, no_nn in zip(nn_acc, no_nn_acc)]
        ci_low, ci_high = paired_ci95(differences)
        nn_runtime = [float(by_cell[(seed, "nn")]["clock_running_time"]) for seed in paired_seeds]
        no_nn_runtime = [float(by_cell[(seed, "no_nn")]["clock_running_time"]) for seed in paired_seeds]
        paired_row = {
            "topology": topology,
            "matched_seeds": len(paired_seeds),
            "nn_acceptance_mean": mean(nn_acc),
            "nn_acceptance_sample_std": sample_std(nn_acc),
            "no_nn_acceptance_mean": mean(no_nn_acc),
            "no_nn_acceptance_sample_std": sample_std(no_nn_acc),
            "paired_acceptance_gain_mean": mean(differences),
            "paired_gain_ci95_low": ci_low,
            "paired_gain_ci95_high": ci_high,
            "nn_runtime_mean": mean(nn_runtime),
            "no_nn_runtime_mean": mean(no_nn_runtime),
        }
        paired_rows.append(paired_row)
        report_lines.append(
            f"| {topology.upper()} | {mean(nn_acc):.3f} ± {sample_std(nn_acc):.3f} | "
            f"{mean(no_nn_acc):.3f} ± {sample_std(no_nn_acc):.3f} | {mean(differences):+.3f} | "
            f"[{ci_low:+.3f}, {ci_high:+.3f}] | {mean(nn_runtime):.1f} | {mean(no_nn_runtime):.1f} |"
        )

    paired_fields = [
        "topology",
        "matched_seeds",
        "nn_acceptance_mean",
        "nn_acceptance_sample_std",
        "no_nn_acceptance_mean",
        "no_nn_acceptance_sample_std",
        "paired_acceptance_gain_mean",
        "paired_gain_ci95_low",
        "paired_gain_ci95_high",
        "nn_runtime_mean",
        "no_nn_runtime_mean",
    ]
    write_csv(args.analysis_root / "paired_summary.csv", paired_rows, paired_fields)

    report_lines.extend(
        [
            "",
            "## Per-seed results",
            "",
            "| Topology | Seed | AlphaVNE | No-NN | Paired difference |",
            "| --- | ---: | ---: | ---: | ---: |",
        ]
    )
    for topology in args.topologies:
        by_cell = {
            (int(row["seed"]), str(row["arm"])): row
            for row in rows
            if row["topology"] == topology
        }
        for seed in args.seeds:
            if (seed, "nn") not in by_cell or (seed, "no_nn") not in by_cell:
                continue
            nn = float(by_cell[(seed, "nn")]["acceptance_rate"])
            no_nn = float(by_cell[(seed, "no_nn")]["acceptance_rate"])
            report_lines.append(f"| {topology.upper()} | {seed} | {nn:.3f} | {no_nn:.3f} | {nn - no_nn:+.3f} |")

    if missing:
        report_lines.extend(["", f"Warning: partial report; {len(missing)} cells are missing."])
    (args.analysis_root / "report.md").write_text("\n".join(report_lines) + "\n")

    table_lines = [
        r"\begin{table}[t]",
        r"\centering",
        r"\small",
        rf"\caption{{Matched neural-guidance ablation at $k={args.k}$ and {args.budget} MCTS simulations per placement decision. Acceptance is mean $\pm$ sample standard deviation; $\Delta$ is the paired AlphaVNE minus no-NN difference with a 95\% confidence interval.}}",
        r"\label{tab:matched_nn_no_nn}",
        r"\begin{tabular}{lccc}",
        r"\toprule",
        r"Topology & AlphaVNE & No-NN MCTS & $\Delta$ (95\% CI) \\",
        r"\midrule",
    ]
    for row in paired_rows:
        table_lines.append(
            f"{str(row['topology']).upper()} & "
            f"{float(row['nn_acceptance_mean']):.3f} $\\pm$ {float(row['nn_acceptance_sample_std']):.3f} & "
            f"{float(row['no_nn_acceptance_mean']):.3f} $\\pm$ {float(row['no_nn_acceptance_sample_std']):.3f} & "
            f"{float(row['paired_acceptance_gain_mean']):+.3f} "
            f"[{float(row['paired_gain_ci95_low']):+.3f}, {float(row['paired_gain_ci95_high']):+.3f}] \\\\"
        )
    table_lines.extend([r"\bottomrule", r"\end{tabular}", r"\end{table}", ""])
    (args.analysis_root / "matched_nn_vs_no_nn_table.tex").write_text("\n".join(table_lines))

    print(f"wrote {args.analysis_root / 'eval_summary.csv'}")
    print(f"wrote {args.analysis_root / 'paired_summary.csv'}")
    print(f"wrote {args.analysis_root / 'report.md'}")
    print(f"wrote {args.analysis_root / 'matched_nn_vs_no_nn_table.tex'}")


if __name__ == "__main__":
    main()
