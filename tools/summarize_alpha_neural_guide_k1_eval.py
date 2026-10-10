#!/usr/bin/env python3
"""Summarize matched MLP/Transformer evaluations at a reduced routing k."""

from __future__ import annotations

import argparse
import csv
import math
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


def optional_float(value: str | None) -> float:
    if value is None or value == "":
        return float("nan")
    return float(value)


def write_csv(path: Path, rows: list[dict[str, object]], fields: list[str]) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    with path.open("w", newline="") as handle:
        writer = csv.DictWriter(handle, fieldnames=fields)
        writer.writeheader()
        writer.writerows({field: row.get(field, "") for field in fields} for row in rows)


def source_eval_id(
    topology: str,
    seed: int,
    backbone: str,
    source_arm: str,
    train_k: int,
    source_stamp: str,
) -> str:
    return (
        f"journal_suite__alpha_zero_sfc__{topology}__{source_arm}_{backbone}"
        f"__seed{seed}__eval__keval{train_k}__{source_stamp}"
    )


def target_eval_id(
    topology: str,
    seed: int,
    backbone: str,
    arm: str,
    train_k: int,
    eval_k: int,
    stamp: str,
) -> str:
    return (
        f"journal_suite__alpha_zero_sfc__{topology}__{arm}_{backbone}"
        f"__seed{seed}__eval__ktrain{train_k}__keval{eval_k}__{stamp}"
    )


def load_result(
    path: Path,
    topology: str,
    seed: int,
    backbone: str,
    eval_k: int,
    budget: int,
    role: str,
) -> dict[str, object]:
    data = read_last_row(path)
    return {
        "topology": topology,
        "seed": seed,
        "backbone": backbone,
        "result_role": role,
        "k_eval": eval_k,
        "mcts_simulations": budget,
        "acceptance_rate": float(data["acceptance_rate"]),
        "long_term_r2c_ratio": optional_float(data.get("long_term_r2c_ratio")),
        "clock_running_time": optional_float(data.get("clock_running_time")),
        "success_count": int(float(data.get("success_count", 0))),
        "place_failure_count": int(float(data.get("place_failure_count", 0))),
        "route_failure_count": int(float(data.get("route_failure_count", 0))),
        "run_id": path.parent.name,
        "summary_path": str(path),
    }


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--solver-results-root", type=Path, required=True)
    parser.add_argument("--analysis-root", type=Path, required=True)
    parser.add_argument("--stamp", required=True)
    parser.add_argument("--arm", required=True)
    parser.add_argument("--source-stamp", required=True)
    parser.add_argument("--source-arm", required=True)
    parser.add_argument("--train-k", type=int, required=True)
    parser.add_argument("--eval-k", type=int, required=True)
    parser.add_argument("--budget", type=int, required=True)
    parser.add_argument("--topologies", nargs="+", required=True)
    parser.add_argument("--seeds", nargs="+", type=int, required=True)
    parser.add_argument("--backbones", nargs="+", required=True)
    parser.add_argument("--allow-partial", action="store_true")
    args = parser.parse_args()

    rows: list[dict[str, object]] = []
    missing: list[str] = []
    for topology in args.topologies:
        for backbone in args.backbones:
            for seed in args.seeds:
                baseline_id = source_eval_id(
                    topology,
                    seed,
                    backbone,
                    args.source_arm,
                    args.train_k,
                    args.source_stamp,
                )
                target_id = target_eval_id(
                    topology,
                    seed,
                    backbone,
                    args.arm,
                    args.train_k,
                    args.eval_k,
                    args.stamp,
                )
                for run_id, eval_k, role in (
                    (baseline_id, args.train_k, "existing_baseline"),
                    (target_id, args.eval_k, "new_re_evaluation"),
                ):
                    path = args.solver_results_root / run_id / "summary.csv"
                    if not path.is_file():
                        missing.append(f"{topology}/seed{seed}/{backbone}/k{eval_k}")
                        continue
                    rows.append(
                        load_result(
                            path,
                            topology,
                            seed,
                            backbone,
                            eval_k,
                            args.budget,
                            role,
                        )
                    )

    if missing and not args.allow_partial:
        raise RuntimeError(
            f"missing {len(missing)} expected evaluation cells: {', '.join(missing)}"
        )

    rows.sort(
        key=lambda row: (
            str(row["topology"]),
            str(row["backbone"]),
            int(row["seed"]),
            -int(row["k_eval"]),
        )
    )
    raw_fields = [
        "topology",
        "seed",
        "backbone",
        "result_role",
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

    cells = {
        (
            str(row["topology"]),
            int(row["seed"]),
            str(row["backbone"]),
            int(row["k_eval"]),
        ): row
        for row in rows
    }

    k_rows: list[dict[str, object]] = []
    for topology in args.topologies:
        for backbone in args.backbones:
            paired_seeds = [
                seed
                for seed in args.seeds
                if (topology, seed, backbone, args.train_k) in cells
                and (topology, seed, backbone, args.eval_k) in cells
            ]
            if not paired_seeds:
                continue
            baseline = [
                float(cells[(topology, seed, backbone, args.train_k)]["acceptance_rate"])
                for seed in paired_seeds
            ]
            reduced = [
                float(cells[(topology, seed, backbone, args.eval_k)]["acceptance_rate"])
                for seed in paired_seeds
            ]
            differences = [new - old for new, old in zip(reduced, baseline)]
            ci_low, ci_high = paired_ci95(differences)
            baseline_runtime = [
                float(cells[(topology, seed, backbone, args.train_k)]["clock_running_time"])
                for seed in paired_seeds
            ]
            reduced_runtime = [
                float(cells[(topology, seed, backbone, args.eval_k)]["clock_running_time"])
                for seed in paired_seeds
            ]
            speedup = mean(baseline_runtime) / mean(reduced_runtime)
            k_rows.append(
                {
                    "topology": topology,
                    "backbone": backbone,
                    "matched_seeds": len(paired_seeds),
                    "baseline_k": args.train_k,
                    "reduced_k": args.eval_k,
                    "baseline_acceptance_mean": mean(baseline),
                    "baseline_acceptance_sample_std": sample_std(baseline),
                    "reduced_acceptance_mean": mean(reduced),
                    "reduced_acceptance_sample_std": sample_std(reduced),
                    "paired_acceptance_change_mean": mean(differences),
                    "paired_change_ci95_low": ci_low,
                    "paired_change_ci95_high": ci_high,
                    "baseline_runtime_mean": mean(baseline_runtime),
                    "reduced_runtime_mean": mean(reduced_runtime),
                    "runtime_speedup_ratio": speedup,
                }
            )

    k_fields = [
        "topology",
        "backbone",
        "matched_seeds",
        "baseline_k",
        "reduced_k",
        "baseline_acceptance_mean",
        "baseline_acceptance_sample_std",
        "reduced_acceptance_mean",
        "reduced_acceptance_sample_std",
        "paired_acceptance_change_mean",
        "paired_change_ci95_low",
        "paired_change_ci95_high",
        "baseline_runtime_mean",
        "reduced_runtime_mean",
        "runtime_speedup_ratio",
    ]
    write_csv(args.analysis_root / "k_comparison_summary.csv", k_rows, k_fields)

    architecture_rows: list[dict[str, object]] = []
    if "mlp" in args.backbones and "transformer" in args.backbones:
        for topology in args.topologies:
            paired_seeds = [
                seed
                for seed in args.seeds
                if (topology, seed, "mlp", args.eval_k) in cells
                and (topology, seed, "transformer", args.eval_k) in cells
            ]
            if not paired_seeds:
                continue
            mlp = [
                float(cells[(topology, seed, "mlp", args.eval_k)]["acceptance_rate"])
                for seed in paired_seeds
            ]
            transformer = [
                float(
                    cells[(topology, seed, "transformer", args.eval_k)][
                        "acceptance_rate"
                    ]
                )
                for seed in paired_seeds
            ]
            differences = [tr - mlp_value for tr, mlp_value in zip(transformer, mlp)]
            ci_low, ci_high = paired_ci95(differences)
            mlp_runtime = [
                float(cells[(topology, seed, "mlp", args.eval_k)]["clock_running_time"])
                for seed in paired_seeds
            ]
            transformer_runtime = [
                float(
                    cells[(topology, seed, "transformer", args.eval_k)][
                        "clock_running_time"
                    ]
                )
                for seed in paired_seeds
            ]
            architecture_rows.append(
                {
                    "topology": topology,
                    "k_eval": args.eval_k,
                    "matched_seeds": len(paired_seeds),
                    "mlp_acceptance_mean": mean(mlp),
                    "mlp_acceptance_sample_std": sample_std(mlp),
                    "transformer_acceptance_mean": mean(transformer),
                    "transformer_acceptance_sample_std": sample_std(transformer),
                    "paired_transformer_minus_mlp_mean": mean(differences),
                    "paired_difference_ci95_low": ci_low,
                    "paired_difference_ci95_high": ci_high,
                    "mlp_runtime_mean": mean(mlp_runtime),
                    "transformer_runtime_mean": mean(transformer_runtime),
                }
            )

    architecture_fields = [
        "topology",
        "k_eval",
        "matched_seeds",
        "mlp_acceptance_mean",
        "mlp_acceptance_sample_std",
        "transformer_acceptance_mean",
        "transformer_acceptance_sample_std",
        "paired_transformer_minus_mlp_mean",
        "paired_difference_ci95_low",
        "paired_difference_ci95_high",
        "mlp_runtime_mean",
        "transformer_runtime_mean",
    ]
    write_csv(
        args.analysis_root / "architecture_k1_summary.csv",
        architecture_rows,
        architecture_fields,
    )

    report_lines = [
        "# Matched MLP/Transformer evaluation at reduced routing k",
        "",
        f"- Source checkpoints: `{args.source_arm}`, stamp `{args.source_stamp}`.",
        f"- The checkpoints were trained at `k={args.train_k}`; no retraining was performed.",
        f"- The new evaluation changes only the routing candidate count to `k={args.eval_k}`.",
        f"- MCTS simulations per placement decision: `{args.budget}`.",
        f"- Matched seeds: `{' '.join(map(str, args.seeds))}`.",
        "",
        f"## Architecture comparison at k={args.eval_k}",
        "",
        "| Topology | MLP acceptance | Transformer acceptance | Transformer - MLP | 95% CI | MLP runtime (s) | Transformer runtime (s) |",
        "| --- | ---: | ---: | ---: | ---: | ---: | ---: |",
    ]
    for row in architecture_rows:
        report_lines.append(
            f"| {str(row['topology']).upper()} | "
            f"{float(row['mlp_acceptance_mean']):.3f} +/- {float(row['mlp_acceptance_sample_std']):.3f} | "
            f"{float(row['transformer_acceptance_mean']):.3f} +/- {float(row['transformer_acceptance_sample_std']):.3f} | "
            f"{float(row['paired_transformer_minus_mlp_mean']):+.3f} | "
            f"[{float(row['paired_difference_ci95_low']):+.3f}, {float(row['paired_difference_ci95_high']):+.3f}] | "
            f"{float(row['mlp_runtime_mean']):.1f} | {float(row['transformer_runtime_mean']):.1f} |"
        )

    report_lines.extend(
        [
            "",
            f"## Change from k={args.train_k} to k={args.eval_k}",
            "",
            "| Topology | Guide | k baseline acceptance | k reduced acceptance | Paired change | 95% CI | Runtime speedup |",
            "| --- | --- | ---: | ---: | ---: | ---: | ---: |",
        ]
    )
    for row in k_rows:
        report_lines.append(
            f"| {str(row['topology']).upper()} | {str(row['backbone']).upper()} | "
            f"{float(row['baseline_acceptance_mean']):.3f} +/- {float(row['baseline_acceptance_sample_std']):.3f} | "
            f"{float(row['reduced_acceptance_mean']):.3f} +/- {float(row['reduced_acceptance_sample_std']):.3f} | "
            f"{float(row['paired_acceptance_change_mean']):+.3f} | "
            f"[{float(row['paired_change_ci95_low']):+.3f}, {float(row['paired_change_ci95_high']):+.3f}] | "
            f"{float(row['runtime_speedup_ratio']):.2f}x |"
        )

    report_lines.extend(
        [
            "",
            "Runtime speedup is the mean baseline runtime divided by the mean reduced-k runtime. Runs were executed sequentially to avoid GPU contention.",
        ]
    )
    if missing:
        report_lines.extend(["", f"Warning: partial report; {len(missing)} cells are missing."])
    args.analysis_root.mkdir(parents=True, exist_ok=True)
    (args.analysis_root / "report.md").write_text("\n".join(report_lines) + "\n")

    table_lines = [
        r"\begin{table}[t]",
        r"\centering",
        r"\small",
        rf"\caption{{Matched neural-guide evaluation at $k={args.eval_k}$ using checkpoints trained at $k={args.train_k}$ and {args.budget} MCTS simulations per placement decision. Acceptance is mean $\pm$ sample standard deviation; $\Delta$ is the paired Transformer-minus-MLP difference with a 95\% confidence interval.}}",
        r"\label{tab:neural_guide_k1_comparison}",
        r"\begin{tabular}{lccc}",
        r"\toprule",
        r"Topology & MLP & Transformer & $\Delta$ (95\% CI) \\",
        r"\midrule",
    ]
    for row in architecture_rows:
        table_lines.append(
            f"{str(row['topology']).upper()} & "
            f"{float(row['mlp_acceptance_mean']):.3f} $\\pm$ {float(row['mlp_acceptance_sample_std']):.3f} & "
            f"{float(row['transformer_acceptance_mean']):.3f} $\\pm$ {float(row['transformer_acceptance_sample_std']):.3f} & "
            f"{float(row['paired_transformer_minus_mlp_mean']):+.3f} "
            f"[{float(row['paired_difference_ci95_low']):+.3f}, {float(row['paired_difference_ci95_high']):+.3f}] \\\\"
        )
    table_lines.extend([r"\bottomrule", r"\end{tabular}", r"\end{table}", ""])
    (args.analysis_root / "neural_guide_k1_comparison.tex").write_text(
        "\n".join(table_lines)
    )

    print(f"wrote {args.analysis_root / 'eval_summary.csv'}")
    print(f"wrote {args.analysis_root / 'architecture_k1_summary.csv'}")
    print(f"wrote {args.analysis_root / 'k_comparison_summary.csv'}")
    print(f"wrote {args.analysis_root / 'report.md'}")
    print(f"wrote {args.analysis_root / 'neural_guide_k1_comparison.tex'}")


if __name__ == "__main__":
    main()
