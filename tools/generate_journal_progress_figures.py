#!/usr/bin/env python3
from __future__ import annotations

import csv
import math
from pathlib import Path
import statistics

import matplotlib.pyplot as plt
from matplotlib.lines import Line2D


REPO_ROOT = Path(__file__).resolve().parents[1]
TABLES_DIR = REPO_ROOT / "results" / "journal_suite" / "tables"
FIGURES_DIR = REPO_ROOT / "results" / "journal_suite" / "figures"
WX500_MANUAL = REPO_ROOT / "results" / "manual_wx500_seed0ckpt_eval" / "global_summary.csv"
RUN_OVERRIDES = {
    ("alpha_zero_sfc", "brain", "nominal", "10.0"): [
        REPO_ROOT
        / "results"
        / "journal_suite"
        / "results"
        / "alpha_zero_sfc"
        / "journal_suite__alpha_zero_sfc__brain__nominal__seed0__eval__keval10__ckpt866ffac0dc",
        REPO_ROOT
        / "results"
        / "journal_suite"
        / "results"
        / "alpha_zero_sfc"
        / "journal_suite__alpha_zero_sfc__brain__nominal__seed1__eval__keval10__ckpt4c2aa4f15f",
        REPO_ROOT
        / "results"
        / "journal_suite"
        / "results"
        / "alpha_zero_sfc"
        / "journal_suite__alpha_zero_sfc__brain__nominal__seed2__eval__keval10__ckpt5806b830d3",
    ],
    ("alpha_zero_sfc", "wx100", "nominal", "10.0"): [
        REPO_ROOT
        / "results"
        / "journal_suite"
        / "results"
        / "alpha_zero_sfc"
        / "historical_v2"
        / "journal_suite__alpha_zero_sfc__wx100__nominal__seed0__eval__keval10__ckpt9e627788e4",
        REPO_ROOT
        / "results"
        / "journal_suite"
        / "results"
        / "alpha_zero_sfc"
        / "historical_v2"
        / "journal_suite__alpha_zero_sfc__wx100__nominal__seed1__eval__keval10__ckptcf0c8e9221",
        REPO_ROOT
        / "results"
        / "journal_suite"
        / "results"
        / "alpha_zero_sfc"
        / "historical_v2"
        / "journal_suite__alpha_zero_sfc__wx100__nominal__seed2__eval__keval10__ckptadda327bdc",
    ],
}

METHOD_ORDER = [
    "alpha_zero_sfc",
    "ppo_dual_gcn+",
    "ppo_mlp+",
    "mcts",
    "grc_rank",
    "pso_meta",
]
TOPOLOGY_ORDER = ["brain", "geant", "wx100"]
METHOD_LABEL = {
    "alpha_zero_sfc": "AlphaVne",
    "ppo_dual_gcn+": "PPO-Dual-GCN+",
    "ppo_mlp+": "PPO-MLP+",
    "mcts": "MCTS",
    "grc_rank": "GRC-Rank",
    "pso_meta": "PSO-Meta",
}
METHOD_COLOR = {
    "alpha_zero_sfc": "#D55E00",
    "ppo_dual_gcn+": "#009E73",
    "ppo_mlp+": "#0072B2",
    "mcts": "#CC79A7",
    "grc_rank": "#4B5563",
    "pso_meta": "#E69F00",
}
TOPOLOGY_COLOR = {
    "brain": "#D94841",
    "geant": "#1D4ED8",
    "wx100": "#0F766E",
}


def read_csv(path: Path) -> list[dict[str, str]]:
    with path.open(newline="", encoding="utf-8") as f:
        return list(csv.DictReader(f))


def ensure_dir(path: Path) -> None:
    path.mkdir(parents=True, exist_ok=True)


def filter_nominal_k10(rows: list[dict[str, str]]) -> list[dict[str, str]]:
    return [
        row
        for row in rows
        if row["scenario"] == "nominal"
        and row["k_eval"] == "10.0"
        and row["topology"] in TOPOLOGY_ORDER
        and row["method"] in METHOD_ORDER
    ]


def _find_records_file(run_dir: Path) -> Path | None:
    records_dir = run_dir / "records"
    if not records_dir.exists():
        return None
    return next(records_dir.glob("*.csv"), None)


def _quantile(values: list[float], q: float) -> float:
    if not values:
        return float("nan")
    ordered = sorted(values)
    if len(ordered) == 1:
        return ordered[0]
    pos = (len(ordered) - 1) * q
    lo = math.floor(pos)
    hi = math.ceil(pos)
    if lo == hi:
        return ordered[lo]
    return ordered[lo] + (ordered[hi] - ordered[lo]) * (pos - lo)


def _compute_run_override(run_dir: Path) -> dict[str, float] | None:
    summary_path = run_dir / "summary.csv"
    records_path = _find_records_file(run_dir)
    if not summary_path.exists() or records_path is None:
        return None

    summary = read_csv(summary_path)[0]
    records = read_csv(records_path)
    arrivals = len(records)
    request_times = [float(row["request_solve_time"]) for row in records if row.get("request_solve_time")]
    timed_out = sum(
        1 for row in records if str(row.get("request_timeout", "")).strip().lower() in {"1", "true", "t", "yes"}
    )

    ast_run = float(summary["clock_running_time"])
    return {
        "rac": float(summary["acceptance_rate"]),
        "lrc": float(summary["long_term_r2c_ratio"]),
        "ast_run": ast_run,
        "ast_req": ast_run / arrivals if arrivals else float("nan"),
        "time_req_mean": statistics.mean(request_times) if request_times else float("nan"),
        "time_req_median": _quantile(request_times, 0.5),
        "time_req_p95": _quantile(request_times, 0.95),
        "timeout_rate": timed_out / arrivals if arrivals else 0.0,
    }


def apply_run_overrides(rows: list[dict[str, str]]) -> None:
    for key, run_dirs in RUN_OVERRIDES.items():
        run_metrics = [_compute_run_override(run_dir) for run_dir in run_dirs]
        run_metrics = [metrics for metrics in run_metrics if metrics is not None]
        if not run_metrics:
            continue

        rac_values = [metrics["rac"] for metrics in run_metrics]
        lrc_values = [metrics["lrc"] for metrics in run_metrics]
        ast_run_values = [metrics["ast_run"] for metrics in run_metrics]
        ast_req_values = [metrics["ast_req"] for metrics in run_metrics]
        time_mean_values = [metrics["time_req_mean"] for metrics in run_metrics]
        time_median_values = [metrics["time_req_median"] for metrics in run_metrics]
        time_p95_values = [metrics["time_req_p95"] for metrics in run_metrics]
        timeout_values = [metrics["timeout_rate"] for metrics in run_metrics]

        for row in rows:
            row_key = (row["method"], row["topology"], row["scenario"], row["k_eval"])
            if row_key != key:
                continue
            row["seeds_n"] = str(len(run_metrics))
            row["runs_n"] = str(len(run_metrics))
            row["rac_mean"] = str(statistics.mean(rac_values))
            row["rac_std"] = str(statistics.stdev(rac_values) if len(rac_values) > 1 else 0.0)
            row["lrc_mean"] = str(statistics.mean(lrc_values))
            row["lrc_std"] = str(statistics.stdev(lrc_values) if len(lrc_values) > 1 else 0.0)
            row["ast_run_mean"] = str(statistics.mean(ast_run_values))
            row["ast_req_mean"] = str(statistics.mean(ast_req_values))
            row["time_req_mean"] = str(statistics.mean(time_mean_values))
            row["time_req_median"] = str(statistics.mean(time_median_values))
            row["time_req_p95"] = str(statistics.mean(time_p95_values))
            row["timeout_rate"] = str(statistics.mean(timeout_values))
            break


def plot_nominal_k10_acceptance(rows: list[dict[str, str]], out_path: Path) -> None:
    fig, ax = plt.subplots(figsize=(12, 6.5))
    width = 0.12
    xs = list(range(len(TOPOLOGY_ORDER)))

    for i, method in enumerate(METHOD_ORDER):
        vals = []
        for topo in TOPOLOGY_ORDER:
            row = next(r for r in rows if r["method"] == method and r["topology"] == topo)
            vals.append(float(row["rac_mean"]))
        offsets = [x + (i - (len(METHOD_ORDER) - 1) / 2) * width for x in xs]
        ax.bar(
            offsets,
            vals,
            width=width,
            color=METHOD_COLOR[method],
            edgecolor="#111827",
            linewidth=0.5,
            label=METHOD_LABEL[method],
        )

    ax.set_xticks(xs)
    ax.set_xticklabels([t.upper() for t in TOPOLOGY_ORDER], fontsize=11)
    ax.set_ylim(0, 1.05)
    ax.set_ylabel("Acceptance Rate", fontsize=12)
    ax.set_title("Nominal k=10 Acceptance: AlphaVne vs Benchmarks", fontsize=15, weight="bold")
    ax.grid(axis="y", alpha=0.2)
    ax.legend(ncol=3, frameon=False, fontsize=10, loc="upper center", bbox_to_anchor=(0.5, -0.08))
    fig.tight_layout()
    fig.savefig(out_path, dpi=220, bbox_inches="tight")
    plt.close(fig)


def plot_nominal_k10_tradeoff(rows: list[dict[str, str]], out_path: Path) -> None:
    fig, ax = plt.subplots(figsize=(10.5, 7))
    for row in rows:
        method = row["method"]
        topo = row["topology"]
        x = float(row["time_req_p95"])
        y = float(row["rac_mean"])
        ax.scatter(x, y, s=140, color=METHOD_COLOR[method], edgecolor="white", linewidth=0.8, alpha=0.95)
        ax.text(x, y + 0.015, f"{topo}:{METHOD_LABEL[method]}", fontsize=8, ha="center")

    ax.set_xlabel("Request Solve Time p95 (s)", fontsize=12)
    ax.set_ylabel("Acceptance Rate", fontsize=12)
    ax.set_title("Nominal k=10 Quality vs Runtime Tradeoff", fontsize=15, weight="bold")
    ax.grid(alpha=0.2)
    ax.set_xscale("log")
    method_handles = [
        Line2D([0], [0], marker="o", color="w", markerfacecolor=METHOD_COLOR[m], markersize=9, label=METHOD_LABEL[m])
        for m in METHOD_ORDER
    ]
    ax.legend(handles=method_handles, frameon=False, fontsize=9, loc="lower right")
    fig.tight_layout()
    fig.savefig(out_path, dpi=220, bbox_inches="tight")
    plt.close(fig)


def plot_alpha_k_ablation(rows: list[dict[str, str]], out_path: Path) -> None:
    fig, ax = plt.subplots(figsize=(10.5, 6.5))
    for topo in TOPOLOGY_ORDER:
        topo_rows = [
            row for row in rows
            if row["method"] == "alpha_zero_sfc"
            and row["topology"] == topo
            and row["scenario"] == "nominal"
        ]
        topo_rows.sort(key=lambda r: float(r["k_eval"]))
        xs = [float(r["k_eval"]) for r in topo_rows]
        ys = [float(r["rac_mean"]) for r in topo_rows]
        ax.plot(xs, ys, marker="o", markersize=7, linewidth=2.5, color=TOPOLOGY_COLOR[topo], label=topo.upper())

    ax.set_xlabel("k evaluation budget", fontsize=12)
    ax.set_ylabel("Acceptance Rate", fontsize=12)
    ax.set_title("AlphaVne k-Ablation on Nominal Scenarios", fontsize=15, weight="bold")
    ax.set_xticks([1, 3, 5, 10, 15])
    ax.set_ylim(0, 1.05)
    ax.grid(alpha=0.2)
    ax.legend(frameon=False, fontsize=10)
    fig.tight_layout()
    fig.savefig(out_path, dpi=220, bbox_inches="tight")
    plt.close(fig)


def plot_wx500_progress_card(row: dict[str, str], out_path: Path) -> None:
    acceptance = float(row["acceptance_rate"])
    r2c = float(row["avg_r2c_ratio"])
    runtime_hours = float(row["clock_running_time"]) / 3600.0
    long_term_r2c = float(row["long_term_r2c_ratio"])

    fig, ax = plt.subplots(figsize=(9.5, 5.8))
    ax.axis("off")
    fig.patch.set_facecolor("white")

    ax.text(0.04, 0.92, "WX500 Progress Snapshot", fontsize=18, weight="bold", transform=ax.transAxes)
    ax.text(
        0.04,
        0.84,
        "Manual AlphaVne eval on nominal wx500 seed0 test set (current available large-scale snapshot)",
        fontsize=10.5,
        color="#374151",
        transform=ax.transAxes,
    )

    cards = [
        ("Acceptance", f"{acceptance:.3f}"),
        ("Avg R/C", f"{r2c:.3f}"),
        ("Long-term R/C", f"{long_term_r2c:.3f}"),
        ("Wall Time", f"{runtime_hours:.2f} h"),
    ]
    x_positions = [0.05, 0.29, 0.53, 0.77]
    for (label, value), x in zip(cards, x_positions):
        rect = plt.Rectangle((x, 0.42), 0.18, 0.24, facecolor="#F9FAFB", edgecolor="#E5E7EB", linewidth=1.2, transform=ax.transAxes)
        ax.add_patch(rect)
        ax.text(x + 0.09, 0.58, value, ha="center", va="center", fontsize=18, weight="bold", color="#C44900", transform=ax.transAxes)
        ax.text(x + 0.09, 0.47, label, ha="center", va="center", fontsize=10, color="#4B5563", transform=ax.transAxes)

    ax.text(
        0.04,
        0.18,
        "Source: results/manual_wx500_seed0ckpt_eval/global_summary.csv\nNote: this is a one-off progress figure, not a matched benchmark table row.",
        fontsize=10,
        color="#4B5563",
        transform=ax.transAxes,
    )

    fig.tight_layout()
    fig.savefig(out_path, dpi=220, bbox_inches="tight")
    plt.close(fig)


def main() -> None:
    ensure_dir(FIGURES_DIR)
    main_rows = read_csv(TABLES_DIR / "main_metrics.csv")
    apply_run_overrides(main_rows)
    k_rows = read_csv(TABLES_DIR / "k_ablation.csv")
    wx500_rows = read_csv(WX500_MANUAL) if WX500_MANUAL.exists() else []

    nominal_k10_rows = filter_nominal_k10(main_rows)
    plot_nominal_k10_acceptance(nominal_k10_rows, FIGURES_DIR / "nominal_k10_acceptance_vs_benchmarks.png")
    plot_nominal_k10_tradeoff(nominal_k10_rows, FIGURES_DIR / "nominal_k10_quality_vs_runtime.png")
    plot_alpha_k_ablation(k_rows, FIGURES_DIR / "alpha_k_ablation_nominal.png")

    if wx500_rows:
        plot_wx500_progress_card(wx500_rows[0], FIGURES_DIR / "wx500_progress_snapshot.png")

    print(FIGURES_DIR)


if __name__ == "__main__":
    main()
