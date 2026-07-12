#!/usr/bin/env python3
"""Summarize the matched k=1 AlphaVNE journal component ablation."""

from __future__ import annotations

import argparse
import csv
import math
import re
import statistics
from pathlib import Path


VARIANT_LABELS = {
    "full": "Full AlphaVNE",
    "no_candidate_features": "No candidate features",
    "no_reachability": "No reachability filter",
    "fixed_order": "Fixed virtual-node order",
    "no_nn": "No neural guidance",
}

T_975 = {
    1: 12.706, 2: 4.303, 3: 3.182, 4: 2.776, 5: 2.571,
    6: 2.447, 7: 2.365, 8: 2.306, 9: 2.262, 10: 2.228,
    11: 2.201, 12: 2.179, 13: 2.160, 14: 2.145, 15: 2.131,
    16: 2.120, 17: 2.110, 18: 2.101, 19: 2.093, 20: 2.086,
    21: 2.080, 22: 2.074, 23: 2.069, 24: 2.064, 25: 2.060,
    26: 2.056, 27: 2.052, 28: 2.048, 29: 2.045, 30: 2.042,
}


def mean(values: list[float]) -> float:
    return sum(values) / len(values)


def sample_std(values: list[float]) -> float:
    return statistics.stdev(values) if len(values) > 1 else 0.0


def ci95(values: list[float]) -> tuple[float, float]:
    center = mean(values)
    if len(values) < 2:
        return center, center
    margin = T_975.get(len(values) - 1, 1.960) * sample_std(values) / math.sqrt(len(values))
    return center - margin, center + margin


def read_last_row(path: Path) -> dict[str, str]:
    with path.open(newline="") as handle:
        rows = list(csv.DictReader(handle))
    if not rows:
        raise RuntimeError(f"empty summary: {path}")
    return rows[-1]


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
    parser.add_argument("--variants", nargs="+", required=True)
    parser.add_argument("--allow-partial", action="store_true")
    args = parser.parse_args()

    unknown = sorted(set(args.variants) - set(VARIANT_LABELS))
    if unknown:
        raise ValueError(f"unknown variants: {', '.join(unknown)}")

    topology_pattern = "|".join(map(re.escape, args.topologies))
    variant_pattern = "|".join(map(re.escape, args.variants))
    pattern = re.compile(
        rf"^journal_suite__alpha_zero_sfc__(?P<topology>{topology_pattern})"
        rf"__journal_components_k{args.k}__(?P<variant>{variant_pattern})"
        rf"__budget{args.budget}__seed(?P<seed>\d+)__eval__{re.escape(args.stamp)}$"
    )

    rows: list[dict[str, object]] = []
    glob_pattern = (
        f"journal_suite__alpha_zero_sfc__*__journal_components_k{args.k}__*"
        f"__budget{args.budget}__seed*__eval__{args.stamp}/summary.csv"
    )
    for path in sorted(args.solver_results_root.glob(glob_pattern)):
        match = pattern.match(path.parent.name)
        if not match:
            continue
        data = read_last_row(path)
        rows.append({
            "topology": match.group("topology"),
            "seed": int(match.group("seed")),
            "variant": match.group("variant"),
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
        })

    actual = {(str(r["topology"]), int(r["seed"]), str(r["variant"])) for r in rows}
    expected = {
        (topology, seed, variant)
        for topology in args.topologies
        for seed in args.seeds
        for variant in args.variants
    }
    missing = sorted(expected - actual)
    if missing and not args.allow_partial:
        cells = ", ".join(f"{t}/seed{s}/{v}" for t, s, v in missing)
        raise RuntimeError(f"missing {len(missing)} evaluation cells: {cells}")

    rows.sort(key=lambda r: (str(r["topology"]), int(r["seed"]), args.variants.index(str(r["variant"]))))
    raw_fields = [
        "topology", "seed", "variant", "k_eval", "mcts_simulations",
        "acceptance_rate", "long_term_r2c_ratio", "clock_running_time",
        "success_count", "place_failure_count", "route_failure_count",
        "run_id", "summary_path",
    ]
    write_csv(args.analysis_root / "eval_summary.csv", rows, raw_fields)

    aggregate_rows: list[dict[str, object]] = []
    for topology in args.topologies:
        for variant in args.variants:
            group = [r for r in rows if r["topology"] == topology and r["variant"] == variant]
            if not group:
                continue
            acceptance = [float(r["acceptance_rate"]) for r in group]
            r2c = [float(r["long_term_r2c_ratio"]) for r in group]
            runtime = [float(r["clock_running_time"]) for r in group]
            aggregate_rows.append({
                "topology": topology,
                "variant": variant,
                "seeds": len(group),
                "acceptance_mean": mean(acceptance),
                "acceptance_sample_std": sample_std(acceptance),
                "long_term_r2c_mean": mean(r2c),
                "runtime_mean_seconds": mean(runtime),
            })
    aggregate_fields = [
        "topology", "variant", "seeds", "acceptance_mean",
        "acceptance_sample_std", "long_term_r2c_mean", "runtime_mean_seconds",
    ]
    write_csv(args.analysis_root / "aggregate_summary.csv", aggregate_rows, aggregate_fields)

    paired_rows: list[dict[str, object]] = []
    for topology in args.topologies:
        by_cell = {
            (int(r["seed"]), str(r["variant"])): r
            for r in rows if r["topology"] == topology
        }
        for variant in args.variants:
            if variant == "full":
                continue
            paired_seeds = [
                seed for seed in args.seeds
                if (seed, "full") in by_cell and (seed, variant) in by_cell
            ]
            if not paired_seeds:
                continue
            differences = [
                float(by_cell[(seed, "full")]["acceptance_rate"])
                - float(by_cell[(seed, variant)]["acceptance_rate"])
                for seed in paired_seeds
            ]
            low, high = ci95(differences)
            paired_rows.append({
                "topology": topology,
                "ablation_variant": variant,
                "matched_seeds": len(paired_seeds),
                "full_minus_ablation_mean": mean(differences),
                "paired_difference_sample_std": sample_std(differences),
                "ci95_low": low,
                "ci95_high": high,
            })
    paired_fields = [
        "topology", "ablation_variant", "matched_seeds", "full_minus_ablation_mean",
        "paired_difference_sample_std", "ci95_low", "ci95_high",
    ]
    write_csv(args.analysis_root / "paired_summary.csv", paired_rows, paired_fields)

    aggregate = {(str(r["topology"]), str(r["variant"])): r for r in aggregate_rows}
    report = [
        "# AlphaVNE journal component ablation",
        "",
        f"- Routing candidates: `k={args.k}` during both training and evaluation.",
        f"- MCTS simulations per placement decision: `{args.budget}`.",
        f"- Seeds: `{' '.join(map(str, args.seeds))}`.",
        "- Every neural ablation is disabled during both training and evaluation.",
        "- Pairing uses identical topology, seed, substrate, request trace, constraints, and search budget.",
        "",
        "## Aggregate acceptance",
        "",
        "| Topology | Variant | Seeds | Acceptance | Long-term R/C | Runtime (s) |",
        "| --- | --- | ---: | ---: | ---: | ---: |",
    ]
    for row in aggregate_rows:
        report.append(
            f"| {str(row['topology']).upper()} | {VARIANT_LABELS[str(row['variant'])]} | "
            f"{row['seeds']} | {float(row['acceptance_mean']):.3f} ± "
            f"{float(row['acceptance_sample_std']):.3f} | "
            f"{float(row['long_term_r2c_mean']):.3f} | "
            f"{float(row['runtime_mean_seconds']):.1f} |"
        )
    report.extend([
        "",
        "## Paired contribution relative to the full solver",
        "",
        "Positive values mean the full AlphaVNE solver accepted more requests.",
        "",
        "| Topology | Removed/replaced component | Seeds | Full minus ablation | 95% CI |",
        "| --- | --- | ---: | ---: | ---: |",
    ])
    for row in paired_rows:
        report.append(
            f"| {str(row['topology']).upper()} | {VARIANT_LABELS[str(row['ablation_variant'])]} | "
            f"{row['matched_seeds']} | {float(row['full_minus_ablation_mean']):+.3f} | "
            f"[{float(row['ci95_low']):+.3f}, {float(row['ci95_high']):+.3f}] |"
        )
    if missing:
        report.extend(["", f"Warning: partial report; {len(missing)} cells are missing."])
    (args.analysis_root / "report.md").write_text("\n".join(report) + "\n")

    headings = {
        "full": "Full",
        "no_candidate_features": r"No cand. feat.",
        "no_reachability": r"No reach. filter",
        "fixed_order": "Fixed order",
        "no_nn": "No NN",
    }
    table = [
        r"\begin{table*}[t]",
        r"\centering",
        r"\small",
        rf"\caption{{Component ablation with $k={args.k}$ and {args.budget} MCTS simulations per placement decision. All neural variants are retrained under their ablated configuration. Values are mean acceptance $\pm$ sample standard deviation over matched seeds.}}",
        r"\label{tab:alpha_vne_component_ablation}",
        r"\begin{tabular}{l" + "c" * len(args.variants) + "}",
        r"\toprule",
        "Topology & " + " & ".join(headings[v] for v in args.variants) + r" \\",
        r"\midrule",
    ]
    for topology in args.topologies:
        cells = []
        for variant in args.variants:
            row = aggregate.get((topology, variant))
            cells.append(
                "--" if row is None else
                f"{float(row['acceptance_mean']):.3f} $\\pm$ {float(row['acceptance_sample_std']):.3f}"
            )
        table.append(topology.upper() + " & " + " & ".join(cells) + r" \\")
    table.extend([r"\bottomrule", r"\end{tabular}", r"\end{table*}", ""])
    (args.analysis_root / "journal_component_ablation_table.tex").write_text("\n".join(table))

    for name in ("eval_summary.csv", "aggregate_summary.csv", "paired_summary.csv", "report.md", "journal_component_ablation_table.tex"):
        print(f"wrote {args.analysis_root / name}")


if __name__ == "__main__":
    main()
