#!/usr/bin/env python3
"""Generate quick comparison plots from journal-suite global_summary.csv."""

from __future__ import annotations

import argparse
import re
from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np
import pandas as pd


RUN_ID_PATTERN = (
    r"journal_suite__"
    r"(?P<method>.+?)__"
    r"(?P<topology>[^_]+)__"
    r"(?P<scenario>[^_]+)__"
    r"seed(?P<seed>\d+)__"
    r"(?P<stage>train|eval)__"
    r"(?P<klabel>ktrain\d+|keval\d+)"
)


def _ordered(values: list[str], preferred: list[str]) -> list[str]:
    index = {value: i for i, value in enumerate(preferred)}
    return sorted(values, key=lambda value: (index.get(value, 10_000), value))


def _load_and_dedupe(summary_csv: Path) -> pd.DataFrame:
    df = pd.read_csv(summary_csv)
    if "run_id" not in df.columns:
        raise ValueError(f"Missing required column 'run_id' in {summary_csv}")

    meta = df["run_id"].str.extract(RUN_ID_PATTERN).add_prefix("meta_")
    if meta.isna().any(axis=None):
        missing = int(meta.isna().any(axis=1).sum())
        raise ValueError(f"Failed to parse {missing} run_id values")
    df = pd.concat([df, meta], axis=1)

    if "start_run_time" in df.columns:
        sort_key = pd.to_datetime(df["start_run_time"], format="%Y%m%dT%H%M%S", errors="coerce")
        df = df.assign(_sort_key=sort_key).sort_values(["_sort_key", "start_run_time"])
    else:
        df = df.assign(_sort_key=np.arange(len(df), dtype=float))

    deduped = df.groupby("run_id", as_index=False).tail(1).copy()
    deduped["method"] = deduped["meta_method"]
    deduped["topology"] = deduped["meta_topology"]
    deduped["scenario"] = deduped["meta_scenario"]
    deduped["stage"] = deduped["meta_stage"]
    deduped["klabel"] = deduped["meta_klabel"]
    deduped["run_seed"] = pd.to_numeric(deduped["meta_seed"], errors="coerce")
    deduped["k_value"] = pd.to_numeric(
        deduped["klabel"].str.extract(r"(\d+)")[0], errors="coerce"
    )
    return deduped


def _plot_train_acceptance(deduped: pd.DataFrame, out_dir: Path) -> None:
    train = deduped[deduped["stage"] == "train"].copy()
    if train.empty:
        return

    stats = (
        train.groupby(["solver_name", "topology"])["acceptance_rate"]
        .agg(["mean", "std", "count"])
        .reset_index()
    )
    stats.rename(columns={"count": "n"}, inplace=True)
    stats.to_csv(out_dir / "train_acceptance_stats.csv", index=False)

    methods = _ordered(
        list(stats["solver_name"].unique()),
        ["alpha_zero_sfc", "ppo_mlp+", "ppo_dual_gcn+"],
    )
    topologies = _ordered(
        list(stats["topology"].unique()),
        ["brain", "geant", "wx100", "wx500"],
    )

    x = np.arange(len(topologies))
    width = 0.8 / max(len(methods), 1)
    offsets = np.linspace(-0.4 + width / 2, 0.4 - width / 2, len(methods))

    colors = {
        "alpha_zero_sfc": "#1b9e77",
        "ppo_mlp+": "#d95f02",
        "ppo_dual_gcn+": "#7570b3",
    }

    fig, ax = plt.subplots(figsize=(9, 5.2))
    for method, offset in zip(methods, offsets):
        sub = (
            stats[stats["solver_name"] == method]
            .set_index("topology")
            .reindex(topologies)
            .reset_index()
        )
        means = sub["mean"].to_numpy(dtype=float)
        stds = sub["std"].fillna(0.0).to_numpy(dtype=float)
        ax.bar(
            x + offset,
            means,
            width=width,
            yerr=stds,
            capsize=3,
            label=method,
            color=colors.get(method, "#4e79a7"),
            edgecolor="black",
            linewidth=0.5,
            alpha=0.9,
        )

    ax.set_title("Train Acceptance by Topology (mean ± std across seeds)")
    ax.set_xlabel("Topology")
    ax.set_ylabel("Acceptance Rate")
    ax.set_xticks(x, topologies)
    ax.set_ylim(0.0, 1.05)
    ax.grid(axis="y", linestyle="--", alpha=0.3)
    ax.legend(frameon=False, ncol=min(3, len(methods)))
    fig.tight_layout()
    fig.savefig(out_dir / "train_acceptance_by_topology.png", dpi=220)
    plt.close(fig)


def _plot_alpha_eval_k(deduped: pd.DataFrame, out_dir: Path) -> None:
    alpha_eval = deduped[
        (deduped["solver_name"] == "alpha_zero_sfc") & (deduped["stage"] == "eval")
    ].copy()
    if alpha_eval.empty:
        return

    stats = (
        alpha_eval.groupby(["topology", "k_value"])["acceptance_rate"]
        .agg(["mean", "std", "count"])
        .reset_index()
        .sort_values(["topology", "k_value"])
    )
    stats.rename(columns={"count": "n"}, inplace=True)
    stats.to_csv(out_dir / "alpha_eval_k_stats.csv", index=False)

    topologies = _ordered(list(stats["topology"].unique()), ["brain", "geant", "wx100", "wx500"])
    colors = {
        "brain": "#e7298a",
        "geant": "#66a61e",
        "wx100": "#1f78b4",
        "wx500": "#a6761d",
    }

    fig, ax = plt.subplots(figsize=(8.8, 5.0))
    for topology in topologies:
        sub = stats[stats["topology"] == topology]
        x = sub["k_value"].to_numpy(dtype=float)
        y = sub["mean"].to_numpy(dtype=float)
        yerr = sub["std"].fillna(0.0).to_numpy(dtype=float)
        ax.errorbar(
            x,
            y,
            yerr=yerr,
            marker="o",
            markersize=5,
            linewidth=2,
            capsize=3,
            label=topology,
            color=colors.get(topology, None),
        )
        for _, row in sub.iterrows():
            if int(row["n"]) < 3:
                ax.annotate(
                    f"n={int(row['n'])}",
                    (row["k_value"], row["mean"]),
                    textcoords="offset points",
                    xytext=(0, 7),
                    ha="center",
                    fontsize=8,
                    color="#333333",
                )

    ax.set_title("AlphaZero Eval: Acceptance vs K (mean ± std across seeds)")
    ax.set_xlabel("K (MCTS budget)")
    ax.set_ylabel("Acceptance Rate")
    ax.set_ylim(0.0, 1.05)
    ax.grid(True, linestyle="--", alpha=0.3)
    ax.legend(title="Topology", frameon=False)
    fig.tight_layout()
    fig.savefig(out_dir / "alpha_eval_k_sweep.png", dpi=220)
    plt.close(fig)


def _plot_eval_acceptance_k10(deduped: pd.DataFrame, out_dir: Path) -> None:
    eval_df = deduped[(deduped["stage"] == "eval") & (deduped["k_value"] == 10)].copy()
    if eval_df.empty:
        return

    stats = (
        eval_df.groupby(["solver_name", "topology"])["acceptance_rate"]
        .agg(["mean", "std", "count"])
        .reset_index()
    )
    stats.rename(columns={"count": "n"}, inplace=True)
    stats.to_csv(out_dir / "eval_acceptance_k10_stats.csv", index=False)

    methods = _ordered(
        list(stats["solver_name"].unique()),
        ["alpha_zero_sfc", "ppo_mlp+", "ppo_dual_gcn+"],
    )
    topologies = _ordered(
        list(stats["topology"].unique()),
        ["brain", "geant", "wx100", "wx500"],
    )

    x = np.arange(len(topologies))
    width = 0.8 / max(len(methods), 1)
    offsets = np.linspace(-0.4 + width / 2, 0.4 - width / 2, len(methods))

    colors = {
        "alpha_zero_sfc": "#1b9e77",
        "ppo_mlp+": "#d95f02",
        "ppo_dual_gcn+": "#7570b3",
    }

    fig, ax = plt.subplots(figsize=(9.2, 5.2))
    for method, offset in zip(methods, offsets):
        sub = (
            stats[stats["solver_name"] == method]
            .set_index("topology")
            .reindex(topologies)
            .reset_index()
        )
        means = sub["mean"].to_numpy(dtype=float)
        stds = sub["std"].fillna(0.0).to_numpy(dtype=float)
        counts = sub["n"].fillna(0).to_numpy(dtype=float)
        ax.bar(
            x + offset,
            means,
            width=width,
            yerr=stds,
            capsize=3,
            label=method,
            color=colors.get(method, "#4e79a7"),
            edgecolor="black",
            linewidth=0.5,
            alpha=0.9,
        )
        for xi, yi, ni in zip(x + offset, means, counts):
            if np.isnan(yi):
                continue
            if int(ni) < 3:
                ax.annotate(
                    f"n={int(ni)}",
                    (xi, yi),
                    textcoords="offset points",
                    xytext=(0, 6),
                    ha="center",
                    fontsize=8,
                    color="#333333",
                )

    ax.set_title("Eval Acceptance by Topology at k=10 (mean ± std across seeds)")
    ax.set_xlabel("Topology")
    ax.set_ylabel("Acceptance Rate")
    ax.set_xticks(x, topologies)
    ax.set_ylim(0.0, 1.05)
    ax.grid(axis="y", linestyle="--", alpha=0.3)
    ax.legend(frameon=False, ncol=min(3, len(methods)))
    fig.tight_layout()
    fig.savefig(out_dir / "eval_acceptance_k10_by_topology.png", dpi=220)
    plt.close(fig)


def _write_run_table(deduped: pd.DataFrame, out_dir: Path) -> None:
    columns = [
        "solver_name",
        "method",
        "topology",
        "scenario",
        "stage",
        "klabel",
        "k_value",
        "run_seed",
        "acceptance_rate",
        "avg_r2c_ratio",
        "place_failure_count",
        "route_failure_count",
        "run_id",
    ]
    present = [column for column in columns if column in deduped.columns]
    deduped.sort_values(["solver_name", "stage", "topology", "run_seed", "k_value"]).to_csv(
        out_dir / "deduped_run_table.csv", index=False, columns=present
    )


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--summary-csv",
        type=Path,
        default=Path("results/journal_suite/results/global_summary.csv"),
        help="Path to global_summary.csv",
    )
    parser.add_argument(
        "--out-dir",
        type=Path,
        default=Path("results/journal_suite/figures/quicklook"),
        help="Output directory for PNG/CSV artifacts",
    )
    args = parser.parse_args()

    args.out_dir.mkdir(parents=True, exist_ok=True)
    deduped = _load_and_dedupe(args.summary_csv)
    _write_run_table(deduped, args.out_dir)
    _plot_train_acceptance(deduped, args.out_dir)
    _plot_alpha_eval_k(deduped, args.out_dir)
    _plot_eval_acceptance_k10(deduped, args.out_dir)

    print(f"Wrote quicklook artifacts to: {args.out_dir}")


if __name__ == "__main__":
    main()
