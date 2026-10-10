#!/usr/bin/env python3
"""Summarize policy/value inference-head ablations on matched AlphaVNE checkpoints."""

from __future__ import annotations

import argparse
import csv
import math
import statistics
from pathlib import Path


ARMS = ("no_nn", "policy_only", "value_only", "nn")
T_975 = {1: 12.706, 2: 4.303, 3: 3.182, 4: 2.776}


def read_last_row(path: Path) -> dict[str, str]:
    if not path.is_file():
        raise RuntimeError(f"missing result: {path}")
    with path.open(newline="", encoding="utf-8") as handle:
        rows = list(csv.DictReader(handle))
    if not rows:
        raise RuntimeError(f"empty result: {path}")
    return rows[-1]


def mean(values: list[float]) -> float:
    return sum(values) / len(values)


def sample_std(values: list[float]) -> float:
    return statistics.stdev(values) if len(values) > 1 else 0.0


def paired_ci95(values: list[float]) -> tuple[float, float]:
    center = mean(values)
    if len(values) < 2:
        return center, center
    margin = T_975.get(len(values) - 1, 1.960) * sample_std(values) / math.sqrt(len(values))
    return center - margin, center + margin


def write_csv(path: Path, rows: list[dict[str, object]], fields: list[str]) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    with path.open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(handle, fieldnames=fields)
        writer.writeheader()
        for row in rows:
            writer.writerow({field: row.get(field, "") for field in fields})


def run_dir(root: Path, topology: str, seed: int, arm: str, k: int, budget: int, stamp: str) -> Path:
    run_id = (
        f"journal_suite__alpha_zero_sfc__{topology}__matched_nn_vs_no_nn_k{k}"
        f"__{arm}__budget{budget}__seed{seed}__eval__{stamp}"
    )
    return root / run_id


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--solver-results-root", type=Path, required=True)
    parser.add_argument("--output-root", type=Path, required=True)
    parser.add_argument("--stamp", required=True)
    parser.add_argument("--topologies", nargs="+", default=["brain", "geant"])
    parser.add_argument("--seeds", nargs="+", type=int, default=[0, 1, 2, 3, 4])
    parser.add_argument("--k", type=int, default=1)
    parser.add_argument("--budget", type=int, default=96)
    args = parser.parse_args()

    per_seed: list[dict[str, object]] = []
    by_cell: dict[tuple[str, int, str], float] = {}
    for topology in args.topologies:
        for seed in args.seeds:
            for arm in ARMS:
                directory = run_dir(
                    args.solver_results_root, topology, seed, arm, args.k, args.budget, args.stamp
                )
                summary_path = directory / "summary.csv"
                row = read_last_row(summary_path)
                acceptance = float(row["acceptance_rate"])
                by_cell[(topology, seed, arm)] = acceptance
                per_seed.append(
                    {
                        "topology": topology,
                        "seed": seed,
                        "arm": arm,
                        "policy_enabled": arm in {"policy_only", "nn"},
                        "value_enabled": arm in {"value_only", "nn"},
                        "k_eval": args.k,
                        "simulations_per_placement": args.budget,
                        "acceptance_rate": acceptance,
                        "clock_running_time": float(row["clock_running_time"]),
                        "summary_path": str(summary_path.resolve()),
                    }
                )

    expected = len(args.topologies) * len(args.seeds) * len(ARMS)
    if len(per_seed) != expected:
        raise RuntimeError(f"expected {expected} rows, found {len(per_seed)}")

    aggregate: list[dict[str, object]] = []
    contrasts = (
        ("value_added_to_policy", "nn", "policy_only"),
        ("policy_added_to_value", "nn", "value_only"),
        ("policy_only_vs_no_nn", "policy_only", "no_nn"),
        ("value_only_vs_no_nn", "value_only", "no_nn"),
    )
    for topology in args.topologies:
        for arm in ARMS:
            values = [by_cell[(topology, seed, arm)] for seed in args.seeds]
            aggregate.append(
                {
                    "topology": topology,
                    "row_type": "arm",
                    "name": arm,
                    "left_arm": arm,
                    "right_arm": "",
                    "mean": mean(values),
                    "sample_std": sample_std(values),
                    "ci95_low": "",
                    "ci95_high": "",
                    "matched_seeds": len(values),
                }
            )
        for name, left, right in contrasts:
            deltas = [
                by_cell[(topology, seed, left)] - by_cell[(topology, seed, right)]
                for seed in args.seeds
            ]
            ci_low, ci_high = paired_ci95(deltas)
            aggregate.append(
                {
                    "topology": topology,
                    "row_type": "contrast",
                    "name": name,
                    "left_arm": left,
                    "right_arm": right,
                    "mean": mean(deltas),
                    "sample_std": sample_std(deltas),
                    "ci95_low": ci_low,
                    "ci95_high": ci_high,
                    "matched_seeds": len(deltas),
                }
            )

    write_csv(args.output_root / "per_seed.csv", per_seed, list(per_seed[0]))
    write_csv(args.output_root / "aggregate.csv", aggregate, list(aggregate[0]))

    def aggregate_row(topology: str, name: str, row_type: str) -> dict[str, object]:
        matches = [
            row for row in aggregate
            if row["topology"] == topology and row["name"] == name and row["row_type"] == row_type
        ]
        if len(matches) != 1:
            raise RuntimeError(f"missing aggregate row: {topology} {row_type} {name}")
        return matches[0]

    latex = [
        r"\subsection{Policy and Value Head Isolation}",
        r"\label{sec:value_head_ablation}",
        "",
        rf"\Cref{{tab:value_head_ablation}} evaluates the same checkpoints and feasibility transition at $k={args.k}$ and {args.budget} simulations while enabling neither head, each head alone, or both heads. This inference-time intervention isolates how each trained head guides search; it does not retrain single-head networks or measure value calibration.",
        "",
        r"\begin{table}[t]",
        r"\centering",
        r"\caption{Matched policy/value-head isolation. Values are mean acceptance $\pm$ sample standard deviation over five seeds.}",
        r"\label{tab:value_head_ablation}",
        r"\begin{tabular}{lcc}",
        r"\toprule",
        r"Search guidance & BRAIN & GEANT \\",
        r"\midrule",
    ]
    labels = (
        ("No neural head", "no_nn"),
        ("Policy only", "policy_only"),
        ("Value only", "value_only"),
        ("Policy and value", "nn"),
    )
    for label, arm in labels:
        brain = aggregate_row("brain", arm, "arm")
        geant = aggregate_row("geant", arm, "arm")
        latex.append(
            f"{label} & {float(brain['mean']):.3f} $\\pm$ {float(brain['sample_std']):.3f} "
            f"& {float(geant['mean']):.3f} $\\pm$ {float(geant['sample_std']):.3f} \\\\"
        )
    latex.extend([r"\bottomrule", r"\end{tabular}", r"\end{table}", ""])
    for topology in args.topologies:
        value = aggregate_row(topology, "value_added_to_policy", "contrast")
        policy = aggregate_row(topology, "policy_added_to_value", "contrast")
        latex.append(
            f"On {topology.upper()}, adding the value head to policy-only guidance changes acceptance by "
            f"{float(value['mean']):+.3f} [{float(value['ci95_low']):+.3f}, {float(value['ci95_high']):+.3f}], "
            f"while adding the policy head to value-only guidance changes it by "
            f"{float(policy['mean']):+.3f} [{float(policy['ci95_low']):+.3f}, {float(policy['ci95_high']):+.3f}]."
        )
    (args.output_root / "manuscript_fragment.tex").write_text(
        "\n\n".join(latex) + "\n", encoding="utf-8"
    )


if __name__ == "__main__":
    main()
