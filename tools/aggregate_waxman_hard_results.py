#!/usr/bin/env python3
from __future__ import annotations

import argparse
import csv
import math
import statistics
from dataclasses import dataclass
from pathlib import Path


METHOD_DISPLAY = {
    "alpha_zero_sfc": "AlphaVNE",
    "grc_rank": "GRC-Rank",
    "mcts": "MCTS",
    "ppo_dual_gcn_plus": "PPO-Dual-GCN+",
    "ppo_mlp_plus": "PPO-MLP+",
    "pso_meta": "PSO-Meta",
}

SOLVER_DIR_TO_METHOD = {
    "alpha_zero_sfc": "alpha_zero_sfc",
    "grc_rank": "grc_rank",
    "mcts": "mcts",
    "ppo_dual_gcn+": "ppo_dual_gcn_plus",
    "ppo_mlp+": "ppo_mlp_plus",
    "pso_meta": "pso_meta",
}

METHOD_TO_SOLVER_DIR = {value: key for key, value in SOLVER_DIR_TO_METHOD.items()}
NONTRAINABLE_METHODS = {"grc_rank", "mcts", "pso_meta"}


@dataclass(frozen=True)
class RunMetric:
    method_key: str
    topology_key: str
    scenario_key: str
    seed: int
    k_eval: int
    acceptance_rate: float
    long_term_r2c_ratio: float
    clock_running_time: float
    run_id: str
    summary_path: Path


def _parse_items(raw: str) -> list[str]:
    return [part.strip() for part in raw.replace(",", " ").split() if part.strip()]


def _read_summary(summary_path: Path) -> dict[str, str]:
    with summary_path.open(newline="") as f:
        reader = csv.DictReader(f)
        rows = list(reader)
    if not rows:
        raise ValueError(f"empty summary file: {summary_path}")
    return rows[0]


def _float(row: dict[str, str], key: str) -> float:
    value = row.get(key, "")
    if value in {"", "None", "nan"}:
        return math.nan
    return float(value)


def _find_latest_summary(
    *,
    results_root: Path,
    method_key: str,
    topology_key: str,
    scenario_token: str,
    seed: int,
    k_eval: int,
) -> Path | None:
    solver_dir = METHOD_TO_SOLVER_DIR.get(method_key)
    if solver_dir is None:
        return None
    root = results_root / solver_dir
    run_solver_token = solver_dir.replace("+", "plus")
    run_token = (
        f"__{run_solver_token}__{topology_key}__{scenario_token}"
        f"__seed{seed}__eval__keval{k_eval}"
    )
    candidates = sorted(
        [
            *root.glob(f"*{run_token}*-summary.csv"),
            *root.glob(f"*{run_token}*/summary.csv"),
            *root.glob(f"*{run_token}*/**/*-summary.csv"),
        ],
        key=lambda path: path.stat().st_mtime,
    )
    return candidates[-1] if candidates else None


def _load_metrics(
    *,
    results_root: Path,
    methods: list[str],
    topology_key: str,
    hard_scenario_key: str,
    scenario_token: str,
    seeds: list[int],
    k_eval: int,
    allow_nontrainable_zero_shot_fallback: bool,
) -> tuple[list[RunMetric], list[str]]:
    metrics: list[RunMetric] = []
    missing: list[str] = []
    for method_key in methods:
        for seed in seeds:
            summary_path = _find_latest_summary(
                results_root=results_root,
                method_key=method_key,
                topology_key=topology_key,
                scenario_token=scenario_token,
                seed=seed,
                k_eval=k_eval,
            )
            used_scenario_token = scenario_token
            if (
                summary_path is None
                and allow_nontrainable_zero_shot_fallback
                and method_key in NONTRAINABLE_METHODS
            ):
                fallback_scenario_token = f"nominal_to_{hard_scenario_key}"
                summary_path = _find_latest_summary(
                    results_root=results_root,
                    method_key=method_key,
                    topology_key=topology_key,
                    scenario_token=fallback_scenario_token,
                    seed=seed,
                    k_eval=k_eval,
                )
                if summary_path is not None:
                    used_scenario_token = fallback_scenario_token
            if summary_path is None:
                missing.append(f"{method_key}/seed{seed}")
                continue
            row = _read_summary(summary_path)
            run_id = summary_path.parent.name if summary_path.name == "summary.csv" else summary_path.stem
            metrics.append(
                RunMetric(
                    method_key=method_key,
                    topology_key=topology_key,
                    scenario_key=used_scenario_token,
                    seed=seed,
                    k_eval=k_eval,
                    acceptance_rate=_float(row, "acceptance_rate"),
                    long_term_r2c_ratio=_float(row, "long_term_r2c_ratio"),
                    clock_running_time=_float(row, "clock_running_time"),
                    run_id=run_id,
                    summary_path=summary_path,
                )
            )
    return metrics, missing


def _mean(values: list[float]) -> float:
    clean = [value for value in values if not math.isnan(value)]
    return statistics.fmean(clean) if clean else math.nan


def _std(values: list[float]) -> float:
    clean = [value for value in values if not math.isnan(value)]
    if len(clean) < 2:
        return 0.0
    return statistics.stdev(clean)


def _fmt(value: float, digits: int = 3) -> str:
    if math.isnan(value):
        return "--"
    return f"{value:.{digits}f}"


def _fmt_time(value: float) -> str:
    if math.isnan(value):
        return "--"
    return f"{value:.1f}"


def _latex_text(text: str) -> str:
    replacements = {
        "\\": r"\textbackslash{}",
        "&": r"\&",
        "%": r"\%",
        "$": r"\$",
        "#": r"\#",
        "_": r"\_",
        "{": r"\{",
        "}": r"\}",
        "~": r"\textasciitilde{}",
        "^": r"\textasciicircum{}",
    }
    return "".join(replacements.get(char, char) for char in text)


def _write_summary_csv(path: Path, metrics: list[RunMetric]) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    with path.open("w", newline="") as f:
        writer = csv.writer(f)
        writer.writerow(
            [
                "method",
                "topology",
                "scenario",
                "seed",
                "k_eval",
                "acceptance_rate",
                "long_term_r2c_ratio",
                "clock_running_time",
                "run_id",
                "summary_path",
            ]
        )
        for metric in metrics:
            writer.writerow(
                [
                    metric.method_key,
                    metric.topology_key,
                    metric.scenario_key,
                    metric.seed,
                    metric.k_eval,
                    metric.acceptance_rate,
                    metric.long_term_r2c_ratio,
                    metric.clock_running_time,
                    metric.run_id,
                    metric.summary_path,
                ]
            )


def _group_metrics(metrics: list[RunMetric]) -> dict[str, list[RunMetric]]:
    grouped: dict[str, list[RunMetric]] = {}
    for metric in metrics:
        grouped.setdefault(metric.method_key, []).append(metric)
    return grouped


def _write_report(
    path: Path,
    metrics: list[RunMetric],
    methods: list[str],
    missing: list[str],
    comparison_mode: str,
) -> None:
    grouped = _group_metrics(metrics)
    description = (
        "Trainable methods trained and evaluated on the harder Waxman request trace; "
        "nontrainable baselines are evaluated on the same hard test trace."
        if comparison_mode == "indomain"
        else "Nominally trained models evaluated on the harder Waxman request trace."
    )
    lines = [
        "# Hard Waxman-100 Comparison",
        "",
        description,
        "",
        "| method | seeds | mean acceptance | std acceptance | mean R/C | mean runtime (s) |",
        "| --- | ---: | ---: | ---: | ---: | ---: |",
    ]
    for method in methods:
        rows = grouped.get(method, [])
        acceptance = [row.acceptance_rate for row in rows]
        r2c = [row.long_term_r2c_ratio for row in rows]
        runtime = [row.clock_running_time for row in rows]
        lines.append(
            f"| {METHOD_DISPLAY.get(method, method)} | {len(rows)} | "
            f"{_fmt(_mean(acceptance))} | {_fmt(_std(acceptance))} | "
            f"{_fmt(_mean(r2c))} | {_fmt_time(_mean(runtime))} |"
        )
    if missing:
        lines.extend(["", "## Missing Runs", ""])
        lines.extend(f"- {item}" for item in missing)
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text("\n".join(lines) + "\n")


def _write_latex_table(
    path: Path,
    metrics: list[RunMetric],
    methods: list[str],
    hard_scenario_key: str,
    k_eval: int,
    comparison_mode: str,
) -> None:
    grouped = _group_metrics(metrics)
    means = {
        method: _mean([row.acceptance_rate for row in grouped.get(method, [])])
        for method in methods
    }
    best = max((value for value in means.values() if not math.isnan(value)), default=math.nan)
    label = (
        "tab:waxman_hard_indomain_comparison"
        if comparison_mode == "indomain"
        else "tab:waxman_hard_comparison"
    )
    caption = (
        "Hard Waxman-100 in-domain comparison under increased request pressure."
        if comparison_mode == "indomain"
        else "Hard Waxman-100 zero-shot comparison under increased request pressure."
    )
    footnote = (
        f"All trainable methods are trained and evaluated on scenario \\texttt{{{_latex_text(hard_scenario_key)}}}; "
        f"nontrainable baselines use the same hard test traces; all methods use $k={k_eval}$."
        if comparison_mode == "indomain"
        else f"All trainable methods use nominally trained checkpoints, evaluate on scenario "
        f"\\texttt{{{_latex_text(hard_scenario_key)}}}, and use $k={k_eval}$."
    )
    lines = [
        "% Auto-generated by tools/aggregate_waxman_hard_results.py",
        "\\begin{table}[t]",
        "  \\centering",
        f"  \\caption{{{caption}}}",
        f"  \\label{{{label}}}",
        "  \\resizebox{\\columnwidth}{!}{%",
        "  \\begin{tabular}{lrrrr}",
        "    \\toprule",
        "    Method & Seeds & Acceptance & R/C & Runtime (s) \\\\",
        "    \\midrule",
    ]
    for method in methods:
        rows = grouped.get(method, [])
        acceptance_values = [row.acceptance_rate for row in rows]
        r2c_values = [row.long_term_r2c_ratio for row in rows]
        runtime_values = [row.clock_running_time for row in rows]
        mean_acc = _mean(acceptance_values)
        std_acc = _std(acceptance_values)
        acc_text = f"{_fmt(mean_acc)} $\\pm$ {_fmt(std_acc)}"
        if not math.isnan(best) and abs(mean_acc - best) < 1e-12:
            acc_text = f"\\textbf{{{acc_text}}}"
        lines.append(
            "    "
            f"{METHOD_DISPLAY.get(method, method)} & {len(rows)} & {acc_text} & "
            f"{_fmt(_mean(r2c_values))} & {_fmt_time(_mean(runtime_values))} \\\\"
        )
    lines.extend(
        [
            "    \\bottomrule",
            "  \\end{tabular}",
            "  }",
            "  \\vspace{0.25em}",
            f"  \\footnotesize{{{footnote}}}",
            "\\end{table}",
            "",
        ]
    )
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text("\n".join(lines))


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--results-root", default="results/journal_suite/results")
    parser.add_argument("--analysis-root", required=True)
    parser.add_argument("--paper-table", default="paperjournal/current/tables/waxman_hard_comparison.tex")
    parser.add_argument("--topology-key", default="wx100")
    parser.add_argument("--hard-scenario-key", default="wx100_hard_compare")
    parser.add_argument(
        "--comparison-mode",
        choices=("zero_shot", "indomain"),
        default="zero_shot",
    )
    parser.add_argument("--scenario-token", default="")
    parser.add_argument("--methods", default="alpha_zero_sfc grc_rank mcts ppo_dual_gcn_plus ppo_mlp_plus pso_meta")
    parser.add_argument("--seeds", default="0 1 2")
    parser.add_argument("--k-eval", type=int, default=10)
    args = parser.parse_args()

    analysis_root = Path(args.analysis_root)
    methods = _parse_items(args.methods)
    seeds = [int(seed) for seed in _parse_items(args.seeds)]
    scenario_token = args.scenario_token.strip()
    if not scenario_token:
        scenario_token = (
            args.hard_scenario_key
            if args.comparison_mode == "indomain"
            else f"nominal_to_{args.hard_scenario_key}"
        )
    metrics, missing = _load_metrics(
        results_root=Path(args.results_root),
        methods=methods,
        topology_key=args.topology_key,
        hard_scenario_key=args.hard_scenario_key,
        scenario_token=scenario_token,
        seeds=seeds,
        k_eval=args.k_eval,
        allow_nontrainable_zero_shot_fallback=args.comparison_mode == "indomain",
    )

    summary_csv = analysis_root / "eval_summary.csv"
    report_md = analysis_root / "report.md"
    paper_table = Path(args.paper_table)
    _write_summary_csv(summary_csv, metrics)
    _write_report(report_md, metrics, methods, missing, args.comparison_mode)
    _write_latex_table(
        paper_table,
        metrics,
        methods,
        args.hard_scenario_key,
        args.k_eval,
        args.comparison_mode,
    )

    print(f"wrote {summary_csv}")
    print(f"wrote {report_md}")
    print(f"wrote {paper_table}")
    if missing:
        print("missing runs:")
        for item in missing:
            print(f"  {item}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
