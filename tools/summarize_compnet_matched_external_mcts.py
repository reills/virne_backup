#!/usr/bin/env python3
"""Summarize AlphaVNE and classical MCTS at the same simulation budget."""

from __future__ import annotations

import argparse
import csv
import math
import statistics
from pathlib import Path


T_975 = {1: 12.706, 2: 4.303, 3: 3.182, 4: 2.776}


def read_rows(path: Path) -> list[dict[str, str]]:
    if not path.is_file():
        raise RuntimeError(f"missing CSV: {path}")
    with path.open(newline="", encoding="utf-8") as handle:
        rows = list(csv.DictReader(handle))
    if not rows:
        raise RuntimeError(f"empty CSV: {path}")
    return rows


def read_last_row(path: Path) -> dict[str, str]:
    return read_rows(path)[-1]


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


def find_mcts_summary(root: Path, topology: str, seed: int, k: int) -> Path:
    prefix = f"journal_suite__mcts_budget96__{topology}__nominal__seed{seed}__eval__keval{k}__ckptbase"
    matches = sorted(
        (path for path in (root / "mcts").glob(f"{prefix}*/summary.csv")),
        key=lambda path: path.stat().st_mtime_ns,
    )
    if not matches:
        raise RuntimeError(f"missing MCTS result for {topology} seed={seed}: {prefix}")
    return matches[-1]


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--alpha-eval-csv", type=Path, required=True)
    parser.add_argument("--results-root", type=Path, required=True)
    parser.add_argument("--output-root", type=Path, required=True)
    parser.add_argument("--topologies", nargs="+", default=["brain", "geant"])
    parser.add_argument("--seeds", nargs="+", type=int, default=[0, 1, 2, 3, 4])
    parser.add_argument("--k", type=int, default=1)
    parser.add_argument("--budget", type=int, default=96)
    args = parser.parse_args()

    alpha_by_cell: dict[tuple[str, int], dict[str, str]] = {}
    for row in read_rows(args.alpha_eval_csv):
        if row.get("arm") != "nn":
            continue
        if int(row["k_eval"]) != args.k or int(row["mcts_simulations"]) != args.budget:
            continue
        key = (row["topology"], int(row["seed"]))
        if key in alpha_by_cell:
            raise RuntimeError(f"duplicate AlphaVNE result: {key}")
        alpha_by_cell[key] = row

    per_seed: list[dict[str, object]] = []
    for topology in args.topologies:
        for seed in args.seeds:
            key = (topology, seed)
            if key not in alpha_by_cell:
                raise RuntimeError(f"missing AlphaVNE result: {key}")
            alpha = alpha_by_cell[key]
            mcts_path = find_mcts_summary(args.results_root, topology, seed, args.k)
            mcts = read_last_row(mcts_path)
            if int(float(mcts.get("seed", -1))) != seed:
                raise RuntimeError(f"MCTS seed mismatch in {mcts_path}")
            if mcts.get("solver_name") != "mcts":
                raise RuntimeError(f"unexpected solver in {mcts_path}: {mcts.get('solver_name')}")
            alpha_acceptance = float(alpha["acceptance_rate"])
            mcts_acceptance = float(mcts["acceptance_rate"])
            per_seed.append(
                {
                    "topology": topology,
                    "seed": seed,
                    "k_eval": args.k,
                    "simulations_per_placement": args.budget,
                    "alpha_acceptance": alpha_acceptance,
                    "mcts_acceptance": mcts_acceptance,
                    "paired_acceptance_gain": alpha_acceptance - mcts_acceptance,
                    "alpha_runtime_seconds": float(alpha["clock_running_time"]),
                    "mcts_runtime_seconds": float(mcts["clock_running_time"]),
                    "alpha_summary_path": alpha["summary_path"],
                    "mcts_summary_path": str(mcts_path.resolve()),
                }
            )

    expected = len(args.topologies) * len(args.seeds)
    if len(per_seed) != expected:
        raise RuntimeError(f"expected {expected} matched rows, found {len(per_seed)}")

    aggregate: list[dict[str, object]] = []
    for topology in args.topologies:
        rows = [row for row in per_seed if row["topology"] == topology]
        deltas = [float(row["paired_acceptance_gain"]) for row in rows]
        ci_low, ci_high = paired_ci95(deltas)
        aggregate.append(
            {
                "topology": topology,
                "matched_seeds": len(rows),
                "k_eval": args.k,
                "simulations_per_placement": args.budget,
                "alpha_acceptance_mean": mean([float(row["alpha_acceptance"]) for row in rows]),
                "alpha_acceptance_sample_std": sample_std([float(row["alpha_acceptance"]) for row in rows]),
                "mcts_acceptance_mean": mean([float(row["mcts_acceptance"]) for row in rows]),
                "mcts_acceptance_sample_std": sample_std([float(row["mcts_acceptance"]) for row in rows]),
                "paired_gain_mean": mean(deltas),
                "paired_gain_ci95_low": ci_low,
                "paired_gain_ci95_high": ci_high,
                "alpha_runtime_mean_seconds": mean([float(row["alpha_runtime_seconds"]) for row in rows]),
                "mcts_runtime_mean_seconds": mean([float(row["mcts_runtime_seconds"]) for row in rows]),
            }
        )

    per_seed_fields = list(per_seed[0])
    aggregate_fields = list(aggregate[0])
    write_csv(args.output_root / "per_seed.csv", per_seed, per_seed_fields)
    write_csv(args.output_root / "aggregate.csv", aggregate, aggregate_fields)

    lines = [
        "# Equal-simulation AlphaVNE versus classical MCTS",
        "",
        f"Both methods use k={args.k} and {args.budget} simulations per placement decision on the same five seeded traces.",
        "Elapsed time remains a measured outcome rather than a normalization constraint.",
        "",
    ]
    for row in aggregate:
        lines.append(
            f"- {row['topology']}: AlphaVNE {float(row['alpha_acceptance_mean']):.3f}, "
            f"MCTS {float(row['mcts_acceptance_mean']):.3f}, paired gain "
            f"{float(row['paired_gain_mean']):+.3f} "
            f"[{float(row['paired_gain_ci95_low']):+.3f}, {float(row['paired_gain_ci95_high']):+.3f}]."
        )
    (args.output_root / "report.md").write_text("\n".join(lines) + "\n", encoding="utf-8")

    latex = [
        r"\subsection{Equal-Simulation External MCTS Comparison}",
        r"\label{sec:matched_external_mcts}",
        "",
        rf"To separate search budget from the configured-system comparison, \Cref{{tab:matched_external_mcts}} fixes both methods at {args.budget} simulations per placement decision and $k={args.k}$ on the same five seeded traces. Runtime remains an outcome rather than a normalization constraint.",
        "",
        r"\begin{table}[t]",
        r"\centering",
        r"\caption{Equal-simulation AlphaVNE and classical MCTS comparison. Acceptance is mean $\pm$ sample standard deviation; $\Delta$ is the paired AlphaVNE-minus-MCTS difference with a 95\% confidence interval.}",
        r"\label{tab:matched_external_mcts}",
        r"\begin{tabular}{lccc}",
        r"\toprule",
        r"Topology & AlphaVNE & Classical MCTS & $\Delta$ \\",
        r"\midrule",
    ]
    for row in aggregate:
        name = str(row["topology"]).upper()
        latex.append(
            f"{name} & {float(row['alpha_acceptance_mean']):.3f} $\\pm$ {float(row['alpha_acceptance_sample_std']):.3f} "
            f"& {float(row['mcts_acceptance_mean']):.3f} $\\pm$ {float(row['mcts_acceptance_sample_std']):.3f} "
            f"& {float(row['paired_gain_mean']):+.3f} "
            f"[{float(row['paired_gain_ci95_low']):+.3f}, {float(row['paired_gain_ci95_high']):+.3f}] \\\\"
        )
    latex.extend(
        [
            r"\bottomrule",
            r"\end{tabular}",
            r"\end{table}",
            "",
            r"This comparison controls the number of simulations but does not equalize wall-clock time. The runtime columns in the source CSV quantify the cost of neural inference and the different transition implementations.",
        ]
    )
    (args.output_root / "manuscript_fragment.tex").write_text(
        "\n".join(latex) + "\n", encoding="utf-8"
    )


if __name__ == "__main__":
    main()
