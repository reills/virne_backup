#!/usr/bin/env python3
"""Validate and summarize the official FlagVNE matched-trace campaign."""

from __future__ import annotations

import argparse
import csv
import json
import math
import statistics
from pathlib import Path
from typing import Iterable


T_975 = {1: 12.706, 2: 4.303, 3: 3.182, 4: 2.776}


def read_rows(path: Path) -> list[dict[str, str]]:
    if not path.is_file():
        raise RuntimeError(f"missing CSV: {path}")
    with path.open(newline="", encoding="utf-8") as handle:
        rows = list(csv.DictReader(handle))
    if not rows:
        raise RuntimeError(f"empty CSV: {path}")
    return rows


def read_last(path: Path) -> dict[str, str]:
    return read_rows(path)[-1]


def write_csv(path: Path, rows: list[dict[str, object]]) -> None:
    if not rows:
        raise RuntimeError(f"refusing to write an empty CSV: {path}")
    path.parent.mkdir(parents=True, exist_ok=True)
    fields = list(rows[0])
    with path.open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(handle, fieldnames=fields)
        writer.writeheader()
        writer.writerows({key: row.get(key, "") for key in fields} for row in rows)


def as_int(row: dict[str, str], key: str) -> int:
    try:
        return int(float(row[key]))
    except (KeyError, TypeError, ValueError) as exc:
        raise RuntimeError(f"invalid integer field {key!r}: {row.get(key)!r}") from exc


def as_float(row: dict[str, str], key: str) -> float:
    try:
        value = float(row[key])
    except (KeyError, TypeError, ValueError) as exc:
        raise RuntimeError(f"invalid numeric field {key!r}: {row.get(key)!r}") from exc
    if not math.isfinite(value):
        raise RuntimeError(f"non-finite field {key!r}: {value!r}")
    return value


def mean(values: Iterable[float]) -> float:
    values = list(values)
    return sum(values) / len(values)


def sample_std(values: Iterable[float]) -> float:
    values = list(values)
    return statistics.stdev(values) if len(values) > 1 else 0.0


def paired_ci95(values: Iterable[float]) -> tuple[float, float]:
    values = list(values)
    center = mean(values)
    if len(values) < 2:
        return center, center
    margin = T_975.get(len(values) - 1, 1.960) * sample_std(values) / math.sqrt(len(values))
    return center - margin, center + margin


def flag_summary_path(campaign_root: Path, topology: str, seed: int) -> Path:
    candidates = [
        campaign_root / "cells" / topology / f"seed_{seed}" / "eval" / "summary.csv",
        campaign_root / "cells" / topology / f"seed_{seed}" / "summary.csv",
    ]
    matches = [path for path in candidates if path.is_file()]
    if len(matches) != 1:
        raise RuntimeError(
            f"expected one FlagVNE summary for {topology} seed={seed}, found {matches}"
        )
    return matches[0]


def load_flag_row(campaign_root: Path, topology: str, seed: int, k: int) -> dict[str, object]:
    summary_path = flag_summary_path(campaign_root, topology, seed)
    complete = summary_path.parent / ".complete"
    if not complete.is_file():
        raise RuntimeError(f"FlagVNE cell lacks completion marker: {complete}")
    row = read_last(summary_path)
    if row.get("solver_name") != "flag_vne":
        raise RuntimeError(f"unexpected solver in {summary_path}: {row.get('solver_name')!r}")
    if as_int(row, "seed") != seed:
        raise RuntimeError(f"seed mismatch in {summary_path}")
    if as_int(row, "k_shortest") != k:
        raise RuntimeError(f"routing-k mismatch in {summary_path}")
    arrivals = as_int(row, "num_arrival_requests")
    successes = as_int(row, "success_count")
    if arrivals != 1000:
        raise RuntimeError(f"expected 1000 held-out arrivals in {summary_path}, found {arrivals}")
    acceptance = as_float(row, "acceptance_rate")
    if not 0.0 <= acceptance <= 1.0:
        raise RuntimeError(f"acceptance outside [0,1] in {summary_path}")
    if abs(acceptance - successes / arrivals) > 1e-9:
        raise RuntimeError(f"acceptance/success mismatch in {summary_path}")
    expected_suffix = f"/nominal/{topology}/seed_{seed}/test"
    source_dataset = row.get("source_dataset_dir", "").rstrip("/")
    if not source_dataset.endswith(expected_suffix):
        raise RuntimeError(
            f"FlagVNE cell is not on the canonical nominal test trace: {source_dataset!r}"
        )
    return {
        "topology": topology,
        "seed": seed,
        "k_eval": k,
        "acceptance_rate": acceptance,
        "long_term_r2c_ratio": as_float(row, "long_term_r2c_ratio"),
        "clock_running_time": as_float(row, "clock_running_time"),
        "success_count": successes,
        "dataset_tree_sha256": row.get("dataset_tree_sha256", ""),
        "source_dataset_dir": source_dataset,
        "run_id": row.get("run_id", ""),
        "summary_path": str(summary_path.resolve()),
    }


def load_alpha_rows(
    results_root: Path,
    fallback_csv: Path,
    brain_prefix: str,
    topologies: list[str],
    seeds: list[int],
    k: int,
) -> dict[tuple[str, int], dict[str, object]]:
    fallback: dict[tuple[str, int], dict[str, str]] = {}
    for row in read_rows(fallback_csv):
        if row.get("method") != "alpha_vne":
            continue
        try:
            key = (row["topology"], int(row["seed"]))
        except (KeyError, ValueError):
            continue
        if int(float(row.get("k_eval", -1))) == k:
            fallback[key] = row

    loaded: dict[tuple[str, int], dict[str, object]] = {}
    alpha_root = results_root / "alpha_zero_sfc"
    for topology in topologies:
        for seed in seeds:
            key = (topology, seed)
            if topology == "brain":
                pattern = f"*{brain_prefix}*__seed{seed}__eval__keval{k}__*-summary.csv"
                matches = sorted(alpha_root.glob(pattern))
                if len(matches) != 1:
                    raise RuntimeError(
                        f"expected one authoritative BRAIN AlphaVNE summary for seed={seed}, "
                        f"found {len(matches)} using {pattern}"
                    )
                raw = read_last(matches[0])
                path = matches[0]
            else:
                if key not in fallback:
                    raise RuntimeError(f"missing canonical AlphaVNE row: {key}")
                index_row = fallback[key]
                source = index_row.get("source_path", "")
                if not source:
                    raise RuntimeError(f"canonical AlphaVNE row has no source path: {key}")
                path = Path(source)
                source_rows = read_rows(path)
                matching = [
                    row
                    for row in source_rows
                    if as_int(row, "seed") == seed
                    and row.get("run_id", "") == index_row.get("run_id", "")
                ]
                if len(matching) != 1:
                    raise RuntimeError(
                        f"expected one authoritative AlphaVNE source row for {key}, "
                        f"found {len(matching)} in {path}"
                    )
                raw = matching[0]
                nested_summary = raw.get("summary_path", "")
                if nested_summary:
                    path = Path(nested_summary)
                    raw = read_last(path)
                for metric in ("acceptance_rate", "long_term_r2c_ratio", "clock_running_time"):
                    if abs(as_float(raw, metric) - as_float(index_row, metric)) > 1e-12:
                        raise RuntimeError(f"AlphaVNE index/source {metric} mismatch for {key}")
            if as_int(raw, "seed") != seed:
                raise RuntimeError(f"AlphaVNE seed mismatch for {key}")
            expected_suffix = f"/nominal/{topology}/seed_{seed}/test"
            dataset_dir = raw.get("v_nets_dataset_dir") or raw.get("p_net_dataset_dir") or ""
            if dataset_dir and not dataset_dir.rstrip("/").endswith(expected_suffix):
                raise RuntimeError(f"AlphaVNE dataset mismatch for {key}: {dataset_dir}")
            loaded[key] = {
                "acceptance_rate": as_float(raw, "acceptance_rate"),
                "long_term_r2c_ratio": as_float(raw, "long_term_r2c_ratio"),
                "clock_running_time": as_float(raw, "clock_running_time"),
                "run_id": raw.get("run_id", ""),
                "summary_path": str(path),
            }
    return loaded


def render_outputs(
    output_root: Path,
    flag_rows: list[dict[str, object]],
    paired_rows: list[dict[str, object]],
    topologies: list[str],
    k: int,
) -> None:
    aggregate: list[dict[str, object]] = []
    paired_aggregate: list[dict[str, object]] = []
    for topology in topologies:
        flags = [row for row in flag_rows if row["topology"] == topology]
        pairs = [row for row in paired_rows if row["topology"] == topology]
        flag_acceptance = [float(row["flagvne_acceptance"]) for row in pairs]
        alpha_acceptance = [float(row["alpha_acceptance"]) for row in pairs]
        deltas = [float(row["alpha_minus_flagvne_acceptance"]) for row in pairs]
        low, high = paired_ci95(deltas)
        aggregate.append(
            {
                "method": "flag_vne_official",
                "topology": topology,
                "scenario": "nominal",
                "k_eval": k,
                "seeds_n": len(flags),
                "acceptance_mean": mean(flag_acceptance),
                "acceptance_sample_std": sample_std(flag_acceptance),
                "long_term_r2c_mean": mean(float(row["long_term_r2c_ratio"]) for row in flags),
                "long_term_r2c_sample_std": sample_std(
                    float(row["long_term_r2c_ratio"]) for row in flags
                ),
                "runtime_mean_seconds": mean(float(row["clock_running_time"]) for row in flags),
            }
        )
        paired_aggregate.append(
            {
                "topology": topology,
                "matched_seeds": len(pairs),
                "k_eval": k,
                "alpha_acceptance_mean": mean(alpha_acceptance),
                "flagvne_acceptance_mean": mean(flag_acceptance),
                "alpha_minus_flagvne_mean": mean(deltas),
                "alpha_minus_flagvne_ci95_low": low,
                "alpha_minus_flagvne_ci95_high": high,
                "alpha_runtime_mean_seconds": mean(
                    float(row["alpha_runtime_seconds"]) for row in pairs
                ),
                "flagvne_runtime_mean_seconds": mean(
                    float(row["flagvne_runtime_seconds"]) for row in pairs
                ),
            }
        )

    write_csv(output_root / "per_seed.csv", flag_rows)
    write_csv(output_root / "aggregate.csv", aggregate)
    write_csv(output_root / "paired_alpha.csv", paired_rows)
    write_csv(output_root / "paired_summary.csv", paired_aggregate)

    report = [
        "# Official FlagVNE matched-trace comparison",
        "",
        "The authors' full FlagVNE implementation was trained separately for each topology and seed, then evaluated on the corresponding held-out nominal trace.",
        f"All methods use the same 1,000-request test streams and k={k} routing candidate limit.",
        "Runtime is reported as an outcome; this is not a wall-clock-matched comparison.",
        "",
    ]
    for row in paired_aggregate:
        report.append(
            f"- {str(row['topology']).upper()}: AlphaVNE "
            f"{float(row['alpha_acceptance_mean']):.3f}, FlagVNE "
            f"{float(row['flagvne_acceptance_mean']):.3f}, paired AlphaVNE-minus-FlagVNE "
            f"{float(row['alpha_minus_flagvne_mean']):+.3f} "
            f"[{float(row['alpha_minus_flagvne_ci95_low']):+.3f}, "
            f"{float(row['alpha_minus_flagvne_ci95_high']):+.3f}]."
        )
    (output_root / "report.md").write_text("\n".join(report) + "\n", encoding="utf-8")

    latex = [
        r"\subsection{Comparison with the Authors' FlagVNE Implementation}",
        r"\label{sec:flagvne_official}",
        "",
        rf"We ran the authors' full FlagVNE implementation on the same five seeded training and held-out test streams used in the main comparison, with $k={k}$. The adapter changes only the dataset-loading boundary and output normalization; FlagVNE's bidirectional policy and task-policy training loop remain in the authors' repository.",
        "",
        r"\begin{table}[t]",
        r"\centering",
        r"\caption{Matched-trace comparison with official FlagVNE. Acceptance is mean $\pm$ sample standard deviation. $\Delta$ is paired AlphaVNE-minus-FlagVNE with a 95\% confidence interval.}",
        r"\label{tab:flagvne_official}",
        r"\begin{tabular}{lccc}",
        r"\toprule",
        r"Topology & AlphaVNE & FlagVNE & $\Delta$ \\",
        r"\midrule",
    ]
    aggregates = {str(row["topology"]): row for row in aggregate}
    for row in paired_aggregate:
        topology = str(row["topology"])
        flag = aggregates[topology]
        alpha_values = [
            float(pair["alpha_acceptance"])
            for pair in paired_rows
            if pair["topology"] == topology
        ]
        latex.append(
            f"{topology.upper()} & {float(row['alpha_acceptance_mean']):.3f} "
            f"$\\pm$ {sample_std(alpha_values):.3f} & "
            f"{float(row['flagvne_acceptance_mean']):.3f} "
            f"$\\pm$ {float(flag['acceptance_sample_std']):.3f} & "
            f"{float(row['alpha_minus_flagvne_mean']):+.3f} "
            f"[{float(row['alpha_minus_flagvne_ci95_low']):+.3f}, "
            f"{float(row['alpha_minus_flagvne_ci95_high']):+.3f}] \\\\"
        )
    latex.extend(
        [
            r"\bottomrule",
            r"\end{tabular}",
            r"\end{table}",
            "",
            r"The comparison uses equal traces and routing-candidate limits. It does not equalize wall-clock time; the per-seed CSV reports elapsed time for both methods.",
        ]
    )
    (output_root / "manuscript_fragment.tex").write_text(
        "\n".join(latex) + "\n", encoding="utf-8"
    )


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--campaign-root", type=Path, required=True)
    parser.add_argument("--results-root", type=Path, default=Path("results/journal_suite/results"))
    parser.add_argument(
        "--alpha-fallback-csv",
        type=Path,
        default=Path("paperjournal/results_data/new_alpha_per_seed.csv"),
    )
    parser.add_argument(
        "--alpha-brain-prefix",
        default="journal_suite__brain_k10_steps5000_20260513T224921Z",
    )
    parser.add_argument("--output-root", type=Path, required=True)
    parser.add_argument("--topologies", nargs="+", default=["brain", "geant"])
    parser.add_argument("--seeds", nargs="+", type=int, default=[0, 1, 2, 3, 4])
    parser.add_argument("--k", type=int, default=10)
    args = parser.parse_args()

    expected = len(args.topologies) * len(args.seeds)
    flag_rows = [
        load_flag_row(args.campaign_root, topology, seed, args.k)
        for topology in args.topologies
        for seed in args.seeds
    ]
    if len(flag_rows) != expected:
        raise RuntimeError(f"expected {expected} FlagVNE rows, found {len(flag_rows)}")
    alpha = load_alpha_rows(
        args.results_root,
        args.alpha_fallback_csv,
        args.alpha_brain_prefix,
        args.topologies,
        args.seeds,
        args.k,
    )

    paired: list[dict[str, object]] = []
    for flag in flag_rows:
        key = (str(flag["topology"]), int(flag["seed"]))
        a = alpha[key]
        paired.append(
            {
                "topology": key[0],
                "seed": key[1],
                "k_eval": args.k,
                "alpha_acceptance": a["acceptance_rate"],
                "flagvne_acceptance": flag["acceptance_rate"],
                "alpha_minus_flagvne_acceptance": float(a["acceptance_rate"])
                - float(flag["acceptance_rate"]),
                "alpha_long_term_r2c": a["long_term_r2c_ratio"],
                "flagvne_long_term_r2c": flag["long_term_r2c_ratio"],
                "alpha_runtime_seconds": a["clock_running_time"],
                "flagvne_runtime_seconds": flag["clock_running_time"],
                "dataset_tree_sha256": flag["dataset_tree_sha256"],
                "alpha_run_id": a["run_id"],
                "flagvne_run_id": flag["run_id"],
                "alpha_summary_path": a["summary_path"],
                "flagvne_summary_path": flag["summary_path"],
            }
        )

    args.output_root.mkdir(parents=True, exist_ok=True)
    render_outputs(args.output_root, flag_rows, paired, args.topologies, args.k)
    manifest = {
        "campaign_root": str(args.campaign_root.resolve()),
        "alpha_results_root": str(args.results_root.resolve()),
        "alpha_fallback_csv": str(args.alpha_fallback_csv.resolve()),
        "alpha_brain_prefix": args.alpha_brain_prefix,
        "topologies": args.topologies,
        "seeds": args.seeds,
        "k": args.k,
        "validated_cells": expected,
    }
    (args.output_root / "source_manifest.json").write_text(
        json.dumps(manifest, indent=2, sort_keys=True) + "\n", encoding="utf-8"
    )
    print(f"validated and summarized {expected} official FlagVNE cells in {args.output_root}")


if __name__ == "__main__":
    main()
