#!/usr/bin/env python3
"""Visualize solver comparison results: alpha_zero_sfc vs baselines."""

import os
import re
import glob
import pandas as pd
import matplotlib.pyplot as plt
import matplotlib
import numpy as np
from pathlib import Path
from datetime import datetime

matplotlib.use("Agg")
plt.rcParams.update({
    "figure.figsize": (14, 8),
    "font.size": 12,
    "axes.titlesize": 14,
    "axes.labelsize": 12,
})

RESULTS_DIR = Path("/home/stephen-reilly/dev/virne/results/journal_suite/results")
OUTPUT_DIR = Path("/home/stephen-reilly/dev/virne/results/journal_suite/plots")
OUTPUT_DIR.mkdir(exist_ok=True)

TOPOLOGIES = ["geant", "brain", "wx100"]
SEEDS = [0, 1, 2]
KEVAL = "keval10"

BASELINE_SOLVERS = ["grc_rank", "ppo_mlp+", "ppo_dual_gcn+", "mcts", "pso_meta"]
SOLVER_DISPLAY = {
    "alpha_zero_sfc": "AlphaZero-SFC",
    "grc_rank": "GRC-Rank",
    "ppo_mlp+": "PPO-MLP+",
    "ppo_dual_gcn+": "PPO-Dual-GCN+",
    "mcts": "MCTS",
    "pso_meta": "PSO-Meta",
}

SOLVER_COLORS = {
    "alpha_zero_sfc": "#e74c3c",
    "grc_rank": "#3498db",
    "ppo_mlp+": "#2ecc71",
    "ppo_dual_gcn+": "#9b59b6",
    "mcts": "#f39c12",
    "pso_meta": "#1abc9c",
}


def find_alpha_zero_summaries():
    """Find the most recent alpha_zero_sfc keval10 eval summary for each topology+seed."""
    alpha_dir = RESULTS_DIR / "alpha_zero_sfc"
    results = {}

    for topo in TOPOLOGIES:
        for seed in SEEDS:
            pattern = f"journal_suite__alpha_zero_sfc__{topo}__nominal__seed{seed}__eval__{KEVAL}__ckpt*"
            # Find all matching directories (not batch variants or seed3)
            matches = []
            for d in alpha_dir.iterdir():
                if d.is_dir() and re.match(
                    rf"journal_suite__alpha_zero_sfc__{topo}__nominal__seed{seed}__eval__{KEVAL}__ckpt[a-f0-9]+$",
                    d.name,
                ):
                    summary = d / "summary.csv"
                    if summary.exists():
                        mtime = summary.stat().st_mtime
                        matches.append((mtime, d, summary))
                # Also check attempt variants
                elif d.is_dir() and re.match(
                    rf"journal_suite__alpha_zero_sfc__{topo}__nominal__seed{seed}__eval__{KEVAL}__ckpt[a-f0-9]+__attempt\d+$",
                    d.name,
                ):
                    summary = d / "summary.csv"
                    if summary.exists():
                        mtime = summary.stat().st_mtime
                        matches.append((mtime, d, summary))

            if matches:
                matches.sort(reverse=True)  # most recent first
                _, run_dir, summary_path = matches[0]
                results[(topo, seed)] = summary_path
                print(f"  alpha_zero_sfc | {topo} seed{seed} -> {run_dir.name}")

    return results


def find_baseline_summaries():
    """Find baseline solver summaries for each topology+seed."""
    results = {}

    for solver in BASELINE_SOLVERS:
        solver_dir = RESULTS_DIR / solver
        # Baselines use flat summary CSV files named with the run_id
        # Also check for subdirectory structure like alpha
        for topo in TOPOLOGIES:
            for seed in SEEDS:
                run_pattern = f"journal_suite__{solver.replace('+', 'plus')}__{topo}__nominal__seed{seed}__eval__{KEVAL}__ckpt*"

                # Try subdirectory with summary.csv first
                found = False
                for d in solver_dir.iterdir():
                    if d.is_dir() and re.match(
                        rf"journal_suite__{re.escape(solver.replace('+', 'plus'))}__{topo}__nominal__seed{seed}__eval__{KEVAL}__ckpt\w+$",
                        d.name,
                    ):
                        summary = d / "summary.csv"
                        if summary.exists():
                            results[(solver, topo, seed)] = summary
                            found = True
                            break

                if found:
                    continue

                # Try flat summary CSV files
                for f in solver_dir.iterdir():
                    if f.is_file() and f.suffix == ".csv" and f"__{topo}__nominal__seed{seed}__eval__{KEVAL}__" in f.name and "summary" in f.name:
                        results[(solver, topo, seed)] = f
                        found = True
                        break

                if not found:
                    print(f"  WARNING: No summary found for {solver} | {topo} seed{seed}")

    return results


def load_all_data():
    """Load all summary data into a single DataFrame."""
    print("Finding alpha_zero_sfc summaries (most recent per topology+seed)...")
    alpha_summaries = find_alpha_zero_summaries()

    print("\nFinding baseline summaries...")
    baseline_summaries = find_baseline_summaries()

    rows = []

    # Load alpha_zero_sfc
    for (topo, seed), path in alpha_summaries.items():
        df = pd.read_csv(path)
        row = df.iloc[0].to_dict()
        row["solver"] = "alpha_zero_sfc"
        row["topology"] = topo
        row["seed_val"] = seed
        rows.append(row)

    # Load baselines
    for (solver, topo, seed), path in baseline_summaries.items():
        df = pd.read_csv(path)
        row = df.iloc[0].to_dict()
        row["solver"] = solver
        row["topology"] = topo
        row["seed_val"] = seed
        rows.append(row)

    data = pd.DataFrame(rows)
    print(f"\nLoaded {len(data)} eval summaries")
    print(f"Solvers: {data['solver'].unique()}")
    print(f"Topologies: {data['topology'].unique()}")
    print(f"Seeds: {sorted(data['seed_val'].unique())}")
    return data


def plot_acceptance_rate_by_topology(data):
    """Bar chart: acceptance rate per solver, grouped by topology (mean over seeds with error bars)."""
    fig, axes = plt.subplots(1, 3, figsize=(18, 6), sharey=True)
    all_solvers = ["alpha_zero_sfc"] + BASELINE_SOLVERS

    for idx, topo in enumerate(TOPOLOGIES):
        ax = axes[idx]
        topo_data = data[data["topology"] == topo]
        means = []
        stds = []
        labels = []
        colors = []

        for solver in all_solvers:
            s_data = topo_data[topo_data["solver"] == solver]
            if len(s_data) > 0:
                means.append(s_data["acceptance_rate"].mean())
                stds.append(s_data["acceptance_rate"].std() if len(s_data) > 1 else 0)
                labels.append(SOLVER_DISPLAY.get(solver, solver))
                colors.append(SOLVER_COLORS.get(solver, "#95a5a6"))

        x = np.arange(len(labels))
        bars = ax.bar(x, means, yerr=stds, capsize=4, color=colors, edgecolor="black", linewidth=0.5, alpha=0.85)

        # Add value labels on bars
        for bar, mean in zip(bars, means):
            ax.text(bar.get_x() + bar.get_width() / 2, bar.get_height() + 0.005,
                    f"{mean:.3f}", ha="center", va="bottom", fontsize=9, fontweight="bold")

        ax.set_xticks(x)
        ax.set_xticklabels(labels, rotation=35, ha="right", fontsize=10)
        ax.set_title(f"{topo.upper()}", fontsize=14, fontweight="bold")
        ax.set_ylim(0, min(1.0, max(means) * 1.3))
        if idx == 0:
            ax.set_ylabel("Acceptance Rate")
        ax.grid(axis="y", alpha=0.3)

    fig.suptitle("Acceptance Rate by Topology (keval=10, mean ± std over seeds 0-2)", fontsize=16, fontweight="bold")
    plt.tight_layout()
    path = OUTPUT_DIR / "acceptance_rate_by_topology.png"
    fig.savefig(path, dpi=150, bbox_inches="tight")
    print(f"Saved: {path}")
    plt.close()


def plot_acceptance_rate_per_seed(data):
    """Grouped bar chart: acceptance rate per solver for each seed, one subplot per topology."""
    fig, axes = plt.subplots(1, 3, figsize=(20, 7), sharey=True)
    all_solvers = ["alpha_zero_sfc"] + BASELINE_SOLVERS
    n_solvers = len(all_solvers)
    bar_width = 0.12

    for idx, topo in enumerate(TOPOLOGIES):
        ax = axes[idx]
        topo_data = data[data["topology"] == topo]

        for i, solver in enumerate(all_solvers):
            s_data = topo_data[topo_data["solver"] == solver]
            seed_vals = []
            acc_vals = []
            for seed in SEEDS:
                row = s_data[s_data["seed_val"] == seed]
                if len(row) > 0:
                    seed_vals.append(seed)
                    acc_vals.append(row["acceptance_rate"].values[0])

            x = np.array(seed_vals) + i * bar_width
            ax.bar(x, acc_vals, width=bar_width, label=SOLVER_DISPLAY.get(solver, solver) if idx == 0 else "",
                   color=SOLVER_COLORS.get(solver, "#95a5a6"), edgecolor="black", linewidth=0.3, alpha=0.85)

        ax.set_xticks([s + bar_width * (n_solvers - 1) / 2 for s in SEEDS])
        ax.set_xticklabels([f"Seed {s}" for s in SEEDS])
        ax.set_title(f"{topo.upper()}", fontsize=14, fontweight="bold")
        if idx == 0:
            ax.set_ylabel("Acceptance Rate")
        ax.grid(axis="y", alpha=0.3)
        ax.set_ylim(0, 1.0)

    handles, labels = axes[0].get_legend_handles_labels()
    fig.legend(handles, labels, loc="upper center", ncol=n_solvers, fontsize=10, bbox_to_anchor=(0.5, 1.02))
    fig.suptitle("Acceptance Rate per Seed (keval=10)", fontsize=16, fontweight="bold", y=1.06)
    plt.tight_layout()
    path = OUTPUT_DIR / "acceptance_rate_per_seed.png"
    fig.savefig(path, dpi=150, bbox_inches="tight")
    print(f"Saved: {path}")
    plt.close()


def plot_cost_revenue_comparison(data):
    """Cost and revenue comparison: total_cost and total_revenue per solver by topology."""
    fig, axes = plt.subplots(2, 3, figsize=(20, 12), sharey="row")
    all_solvers = ["alpha_zero_sfc"] + BASELINE_SOLVERS

    for idx, topo in enumerate(TOPOLOGIES):
        topo_data = data[data["topology"] == topo]

        for row_idx, (metric, label) in enumerate([("total_revenue", "Total Revenue"), ("total_cost", "Total Cost")]):
            ax = axes[row_idx][idx]
            means = []
            stds = []
            labels_list = []
            colors = []

            for solver in all_solvers:
                s_data = topo_data[topo_data["solver"] == solver]
                if len(s_data) > 0:
                    means.append(s_data[metric].mean())
                    stds.append(s_data[metric].std() if len(s_data) > 1 else 0)
                    labels_list.append(SOLVER_DISPLAY.get(solver, solver))
                    colors.append(SOLVER_COLORS.get(solver, "#95a5a6"))

            x = np.arange(len(labels_list))
            bars = ax.bar(x, means, yerr=stds, capsize=4, color=colors, edgecolor="black", linewidth=0.5, alpha=0.85)

            ax.set_xticks(x)
            ax.set_xticklabels(labels_list, rotation=35, ha="right", fontsize=9)
            ax.set_title(f"{topo.upper()} - {label}", fontsize=12, fontweight="bold")
            ax.grid(axis="y", alpha=0.3)

            # Add value labels
            for bar, mean in zip(bars, means):
                ax.text(bar.get_x() + bar.get_width() / 2, bar.get_height(),
                        f"{mean:.0f}", ha="center", va="bottom", fontsize=8)

    fig.suptitle("Total Revenue & Cost by Topology (keval=10, mean over seeds)", fontsize=16, fontweight="bold")
    plt.tight_layout()
    path = OUTPUT_DIR / "cost_revenue_by_topology.png"
    fig.savefig(path, dpi=150, bbox_inches="tight")
    print(f"Saved: {path}")
    plt.close()


def plot_r2c_ratio(data):
    """Revenue-to-cost ratio comparison."""
    fig, axes = plt.subplots(1, 3, figsize=(18, 6), sharey=True)
    all_solvers = ["alpha_zero_sfc"] + BASELINE_SOLVERS

    for idx, topo in enumerate(TOPOLOGIES):
        ax = axes[idx]
        topo_data = data[data["topology"] == topo]
        means = []
        stds = []
        labels = []
        colors = []

        for solver in all_solvers:
            s_data = topo_data[topo_data["solver"] == solver]
            if len(s_data) > 0:
                means.append(s_data["long_term_r2c_ratio"].mean())
                stds.append(s_data["long_term_r2c_ratio"].std() if len(s_data) > 1 else 0)
                labels.append(SOLVER_DISPLAY.get(solver, solver))
                colors.append(SOLVER_COLORS.get(solver, "#95a5a6"))

        x = np.arange(len(labels))
        bars = ax.bar(x, means, yerr=stds, capsize=4, color=colors, edgecolor="black", linewidth=0.5, alpha=0.85)

        for bar, mean in zip(bars, means):
            ax.text(bar.get_x() + bar.get_width() / 2, bar.get_height() + 0.005,
                    f"{mean:.3f}", ha="center", va="bottom", fontsize=9, fontweight="bold")

        ax.set_xticks(x)
        ax.set_xticklabels(labels, rotation=35, ha="right", fontsize=10)
        ax.set_title(f"{topo.upper()}", fontsize=14, fontweight="bold")
        if idx == 0:
            ax.set_ylabel("Long-term R2C Ratio")
        ax.grid(axis="y", alpha=0.3)

    fig.suptitle("Long-term Revenue-to-Cost Ratio by Topology (keval=10, mean ± std over seeds)", fontsize=16, fontweight="bold")
    plt.tight_layout()
    path = OUTPUT_DIR / "r2c_ratio_by_topology.png"
    fig.savefig(path, dpi=150, bbox_inches="tight")
    print(f"Saved: {path}")
    plt.close()


def plot_solve_time(data):
    """Runtime/latency comparison using clock_running_time."""
    fig, axes = plt.subplots(1, 3, figsize=(18, 6), sharey=True)
    all_solvers = ["alpha_zero_sfc"] + BASELINE_SOLVERS

    for idx, topo in enumerate(TOPOLOGIES):
        ax = axes[idx]
        topo_data = data[data["topology"] == topo]
        means = []
        stds = []
        labels = []
        colors = []

        for solver in all_solvers:
            s_data = topo_data[topo_data["solver"] == solver]
            if len(s_data) > 0:
                means.append(s_data["clock_running_time"].mean())
                stds.append(s_data["clock_running_time"].std() if len(s_data) > 1 else 0)
                labels.append(SOLVER_DISPLAY.get(solver, solver))
                colors.append(SOLVER_COLORS.get(solver, "#95a5a6"))

        x = np.arange(len(labels))
        bars = ax.bar(x, means, yerr=stds, capsize=4, color=colors, edgecolor="black", linewidth=0.5, alpha=0.85)

        for bar, mean in zip(bars, means):
            ax.text(bar.get_x() + bar.get_width() / 2, bar.get_height(),
                    f"{mean:.1f}s", ha="center", va="bottom", fontsize=9, fontweight="bold")

        ax.set_xticks(x)
        ax.set_xticklabels(labels, rotation=35, ha="right", fontsize=10)
        ax.set_title(f"{topo.upper()}", fontsize=14, fontweight="bold")
        if idx == 0:
            ax.set_ylabel("Eval Runtime (seconds)")
        ax.grid(axis="y", alpha=0.3)

    fig.suptitle("Evaluation Runtime by Topology (keval=10, mean ± std over seeds)", fontsize=16, fontweight="bold")
    plt.tight_layout()
    path = OUTPUT_DIR / "eval_runtime_by_topology.png"
    fig.savefig(path, dpi=150, bbox_inches="tight")
    print(f"Saved: {path}")
    plt.close()


def plot_heatmap_summary(data):
    """Heatmap of acceptance rate: solvers x topology (mean over seeds)."""
    all_solvers = ["alpha_zero_sfc"] + BASELINE_SOLVERS
    pivot = data.groupby(["solver", "topology"])["acceptance_rate"].mean().unstack()
    pivot = pivot.reindex(index=all_solvers, columns=TOPOLOGIES)

    fig, ax = plt.subplots(figsize=(10, 6))
    im = ax.imshow(pivot.values, cmap="RdYlGn", aspect="auto", vmin=0, vmax=max(0.8, pivot.values.max() * 1.1))

    ax.set_xticks(range(len(TOPOLOGIES)))
    ax.set_xticklabels([t.upper() for t in TOPOLOGIES], fontsize=12)
    ax.set_yticks(range(len(all_solvers)))
    ax.set_yticklabels([SOLVER_DISPLAY.get(s, s) for s in all_solvers], fontsize=12)

    # Annotate cells
    for i in range(len(all_solvers)):
        for j in range(len(TOPOLOGIES)):
            val = pivot.values[i, j]
            if not np.isnan(val):
                ax.text(j, i, f"{val:.3f}", ha="center", va="center", fontsize=13, fontweight="bold",
                        color="white" if val < 0.3 else "black")

    plt.colorbar(im, ax=ax, label="Acceptance Rate", shrink=0.8)
    ax.set_title("Acceptance Rate Heatmap (mean over seeds, keval=10)", fontsize=14, fontweight="bold")
    plt.tight_layout()
    path = OUTPUT_DIR / "acceptance_rate_heatmap.png"
    fig.savefig(path, dpi=150, bbox_inches="tight")
    print(f"Saved: {path}")
    plt.close()


def plot_radar_chart(data):
    """Radar/spider chart comparing solvers on multiple metrics (per topology)."""
    metrics = ["acceptance_rate", "long_term_r2c_ratio", "avg_r2c_ratio"]
    metric_labels = ["Acceptance Rate", "Long-term R2C", "Avg R2C"]
    all_solvers = ["alpha_zero_sfc"] + BASELINE_SOLVERS

    fig, axes = plt.subplots(1, 3, figsize=(20, 7), subplot_kw=dict(polar=True))

    for idx, topo in enumerate(TOPOLOGIES):
        ax = axes[idx]
        topo_data = data[data["topology"] == topo]

        # Compute mean per solver
        angles = np.linspace(0, 2 * np.pi, len(metrics), endpoint=False).tolist()
        angles += angles[:1]  # close the polygon

        for solver in all_solvers:
            s_data = topo_data[topo_data["solver"] == solver]
            if len(s_data) == 0:
                continue
            values = [s_data[m].mean() for m in metrics]
            values += values[:1]
            ax.plot(angles, values, "o-", label=SOLVER_DISPLAY.get(solver, solver),
                    color=SOLVER_COLORS.get(solver, "#95a5a6"), linewidth=2, markersize=5)
            ax.fill(angles, values, alpha=0.1, color=SOLVER_COLORS.get(solver, "#95a5a6"))

        ax.set_xticks(angles[:-1])
        ax.set_xticklabels(metric_labels, fontsize=10)
        ax.set_title(f"{topo.upper()}", fontsize=14, fontweight="bold", y=1.08)

    handles, labels = axes[0].get_legend_handles_labels()
    fig.legend(handles, labels, loc="lower center", ncol=len(all_solvers), fontsize=10)
    fig.suptitle("Multi-metric Radar Comparison (keval=10, mean over seeds)", fontsize=16, fontweight="bold", y=1.02)
    plt.tight_layout()
    path = OUTPUT_DIR / "radar_comparison.png"
    fig.savefig(path, dpi=150, bbox_inches="tight")
    print(f"Saved: {path}")
    plt.close()


def plot_summary_table(data):
    """Create a nice summary table as an image."""
    all_solvers = ["alpha_zero_sfc"] + BASELINE_SOLVERS
    metrics = {
        "acceptance_rate": "Accept. Rate",
        "long_term_r2c_ratio": "R2C Ratio",
        "total_revenue": "Revenue",
        "total_cost": "Cost",
        "clock_running_time": "Runtime (s)",
    }

    rows = []
    for topo in TOPOLOGIES:
        for solver in all_solvers:
            mask = (data["solver"] == solver) & (data["topology"] == topo)
            s_data = data[mask]
            if len(s_data) == 0:
                continue
            row = {
                "Topology": topo.upper(),
                "Solver": SOLVER_DISPLAY.get(solver, solver),
            }
            for col, label in metrics.items():
                mean = s_data[col].mean()
                std = s_data[col].std() if len(s_data) > 1 else 0
                if col in ("total_revenue", "total_cost"):
                    row[label] = f"{mean:,.0f} ± {std:,.0f}"
                elif col == "clock_running_time":
                    row[label] = f"{mean:.1f} ± {std:.1f}"
                else:
                    row[label] = f"{mean:.4f} ± {std:.4f}"
            rows.append(row)

    table_df = pd.DataFrame(rows)

    fig, ax = plt.subplots(figsize=(18, len(rows) * 0.35 + 2))
    ax.axis("off")

    table = ax.table(
        cellText=table_df.values,
        colLabels=table_df.columns,
        cellLoc="center",
        loc="center",
    )
    table.auto_set_font_size(False)
    table.set_fontsize(9)
    table.scale(1, 1.4)

    # Style header
    for j in range(len(table_df.columns)):
        table[0, j].set_facecolor("#2c3e50")
        table[0, j].set_text_props(color="white", fontweight="bold")

    # Highlight alpha_zero_sfc rows
    for i in range(len(table_df)):
        if "AlphaZero" in str(table_df.iloc[i]["Solver"]):
            for j in range(len(table_df.columns)):
                table[i + 1, j].set_facecolor("#fadbd8")

    # Alternate topology shading
    current_topo = None
    shade = False
    for i in range(len(table_df)):
        if table_df.iloc[i]["Topology"] != current_topo:
            current_topo = table_df.iloc[i]["Topology"]
            shade = not shade
        if shade and "AlphaZero" not in str(table_df.iloc[i]["Solver"]):
            for j in range(len(table_df.columns)):
                table[i + 1, j].set_facecolor("#eaf2f8")

    ax.set_title("Summary Table: All Solvers x Topologies (keval=10, mean ± std over seeds 0-2)",
                 fontsize=14, fontweight="bold", pad=20)
    plt.tight_layout()
    path = OUTPUT_DIR / "summary_table.png"
    fig.savefig(path, dpi=150, bbox_inches="tight")
    print(f"Saved: {path}")
    plt.close()


def plot_acceptance_improvement(data):
    """Show alpha_zero_sfc improvement delta over each baseline."""
    all_solvers = ["alpha_zero_sfc"] + BASELINE_SOLVERS

    fig, axes = plt.subplots(1, 3, figsize=(18, 6))

    for idx, topo in enumerate(TOPOLOGIES):
        ax = axes[idx]
        topo_data = data[data["topology"] == topo]
        alpha_mean = topo_data[topo_data["solver"] == "alpha_zero_sfc"]["acceptance_rate"].mean()

        deltas = []
        labels = []
        colors = []
        for solver in BASELINE_SOLVERS:
            s_data = topo_data[topo_data["solver"] == solver]
            if len(s_data) > 0:
                baseline_mean = s_data["acceptance_rate"].mean()
                delta_pct = ((alpha_mean - baseline_mean) / baseline_mean) * 100 if baseline_mean > 0 else 0
                deltas.append(delta_pct)
                labels.append(SOLVER_DISPLAY.get(solver, solver))
                colors.append("#2ecc71" if delta_pct >= 0 else "#e74c3c")

        x = np.arange(len(labels))
        bars = ax.bar(x, deltas, color=colors, edgecolor="black", linewidth=0.5, alpha=0.85)
        ax.axhline(y=0, color="black", linewidth=0.8)

        for bar, delta in zip(bars, deltas):
            va = "bottom" if delta >= 0 else "top"
            ax.text(bar.get_x() + bar.get_width() / 2, bar.get_height(),
                    f"{delta:+.1f}%", ha="center", va=va, fontsize=10, fontweight="bold")

        ax.set_xticks(x)
        ax.set_xticklabels(labels, rotation=35, ha="right", fontsize=10)
        ax.set_title(f"{topo.upper()}", fontsize=14, fontweight="bold")
        if idx == 0:
            ax.set_ylabel("% Change vs AlphaZero-SFC")
        ax.grid(axis="y", alpha=0.3)

    fig.suptitle("AlphaZero-SFC Acceptance Rate Improvement over Baselines (keval=10)", fontsize=16, fontweight="bold")
    plt.tight_layout()
    path = OUTPUT_DIR / "acceptance_improvement_delta.png"
    fig.savefig(path, dpi=150, bbox_inches="tight")
    print(f"Saved: {path}")
    plt.close()


if __name__ == "__main__":
    print("=" * 60)
    print("Solver Comparison Visualization")
    print("=" * 60)

    data = load_all_data()

    print(f"\n{'=' * 60}")
    print("Generating plots...")
    print("=" * 60)

    plot_acceptance_rate_by_topology(data)
    plot_acceptance_rate_per_seed(data)
    plot_cost_revenue_comparison(data)
    plot_r2c_ratio(data)
    plot_solve_time(data)
    plot_heatmap_summary(data)
    plot_radar_chart(data)
    plot_acceptance_improvement(data)
    plot_summary_table(data)

    print(f"\nAll plots saved to: {OUTPUT_DIR}")
    print("Done!")
