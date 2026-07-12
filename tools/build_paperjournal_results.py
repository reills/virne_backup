#!/usr/bin/env python3
"""Build paper-ready result tables from existing journal-suite outputs."""

from __future__ import annotations

import csv
import math
import shutil
from dataclasses import dataclass
from pathlib import Path
from typing import Iterable


ROOT = Path(__file__).resolve().parents[1]
OUT = ROOT / "paperjournal/results_data"
MAIN_METRICS = ROOT / "results/journal_suite/tables/main_metrics.csv"
RESULTS_ROOT = ROOT / "results/journal_suite/results/alpha_zero_sfc"


@dataclass(frozen=True)
class EvalRun:
    topology: str
    seed: int
    acceptance_rate: float
    long_term_r2c_ratio: float
    clock_running_time: float
    run_id: str
    source_path: Path


NEW_ALPHA_SOURCES = {
    "brain": {
        "kind": "eval_summary",
        "path": ROOT / "results/brain_override_test/20260423T101342Z/eval_summary.csv",
    },
    "geant": {
        "kind": "summary_glob",
        "pattern": "journal_suite__alpha_zero_sfc__geant__topo_replay_move_fix_3k_latest__seed*__eval__keval10__20260423T225501Z/summary.csv",
    },
    "wx100": {
        "kind": "summary_glob",
        "pattern": "journal_suite__alpha_zero_sfc__wx100__topo_replay_move_fix_3k_latest__seed*__eval__keval10__20260424T063801Z/summary.csv",
    },
}

EXTRA_ALPHA_SUMMARY = ROOT / "results/journal_insurance/20260426T232029Z/alpha_extra/eval_summary.csv"
GENERALIZATION_ALPHA_SUMMARY = ROOT / "results/journal_insurance/20260426T232029Z/generalization_alpha_vne/eval_summary.csv"


def read_csv(path: Path) -> list[dict[str, str]]:
    with path.open(newline="") as f:
        return list(csv.DictReader(f))


def write_csv(path: Path, rows: Iterable[dict[str, object]], fieldnames: list[str]) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    with path.open("w", newline="") as f:
        writer = csv.DictWriter(f, fieldnames=fieldnames)
        writer.writeheader()
        for row in rows:
            writer.writerow({key: row.get(key, "") for key in fieldnames})


def mean(values: list[float]) -> float:
    return sum(values) / len(values)


def sample_std(values: list[float]) -> float:
    if len(values) < 2:
        return 0.0
    m = mean(values)
    return math.sqrt(sum((v - m) ** 2 for v in values) / (len(values) - 1))


def fmt(value: object, digits: int = 3) -> str:
    if value == "" or value is None:
        return ""
    if isinstance(value, str):
        try:
            value = float(value)
        except ValueError:
            return value
    return f"{float(value):.{digits}f}"


def markdown_table(rows: list[dict[str, object]], columns: list[tuple[str, str]]) -> str:
    lines = []
    headers = [label for _, label in columns]
    lines.append("| " + " | ".join(headers) + " |")
    lines.append("| " + " | ".join(["---"] * len(headers)) + " |")
    for row in rows:
        cells = [str(row.get(key, "")) for key, _ in columns]
        lines.append("| " + " | ".join(cells) + " |")
    return "\n".join(lines)


def load_new_alpha_runs() -> list[EvalRun]:
    runs: list[EvalRun] = []
    for topology, spec in NEW_ALPHA_SOURCES.items():
        if spec["kind"] == "eval_summary":
            path = Path(spec["path"])
            for row in read_csv(path):
                if row["checkpoint"] != "latest":
                    continue
                runs.append(
                    EvalRun(
                        topology=topology,
                        seed=int(row["seed"]),
                        acceptance_rate=float(row["acceptance_rate"]),
                        long_term_r2c_ratio=float(row["long_term_r2c_ratio"]),
                        clock_running_time=float(row["clock_running_time"]),
                        run_id=row["run_id"],
                        source_path=path,
                    )
                )
        else:
            for path in sorted(RESULTS_ROOT.glob(str(spec["pattern"]))):
                row = read_csv(path)[0]
                runs.append(
                    EvalRun(
                        topology=topology,
                        seed=int(row["seed"]),
                        acceptance_rate=float(row["acceptance_rate"]),
                        long_term_r2c_ratio=float(row["long_term_r2c_ratio"]),
                        clock_running_time=float(row["clock_running_time"]),
                        run_id=row["run_id"],
                        source_path=path,
                    )
                )
    if EXTRA_ALPHA_SUMMARY.exists():
        for row in read_csv(EXTRA_ALPHA_SUMMARY):
            if row.get("status") != "ok":
                continue
            runs.append(
                EvalRun(
                    topology=row["topology"],
                    seed=int(row["seed"]),
                    acceptance_rate=float(row["acceptance_rate"]),
                    long_term_r2c_ratio=float(row["long_term_r2c_ratio"]),
                    clock_running_time=float(row["clock_running_time"]),
                    run_id=row["run_id"],
                    source_path=EXTRA_ALPHA_SUMMARY,
                )
            )
    return sorted(runs, key=lambda r: (r.topology, r.seed))


def aggregate_new_alpha(runs: list[EvalRun]) -> list[dict[str, object]]:
    rows = []
    for topology in ["brain", "geant", "wx100"]:
        subset = [r for r in runs if r.topology == topology]
        if not subset:
            raise RuntimeError(f"No new AlphaZero runs found for {topology}")
        rows.append(
            {
                "method": "alpha_vne",
                "topology": topology,
                "scenario": "nominal",
                "k_eval": 10,
                "seeds_n": len(subset),
                "runs_n": len(subset),
                "rac_mean": mean([r.acceptance_rate for r in subset]),
                "rac_std": sample_std([r.acceptance_rate for r in subset]),
                "lrc_mean": mean([r.long_term_r2c_ratio for r in subset]),
                "lrc_std": sample_std([r.long_term_r2c_ratio for r in subset]),
                "ast_run_mean": mean([r.clock_running_time for r in subset]),
                "training_cost": "",
            }
        )
    return rows


def load_baseline_k10_nominal() -> list[dict[str, object]]:
    rows = []
    for row in read_csv(MAIN_METRICS):
        if row["topology"] not in {"brain", "geant", "wx100"}:
            continue
        if row["scenario"] != "nominal":
            continue
        if not row["k_eval"]:
            continue
        if float(row["k_eval"]) != 10.0:
            continue
        out = {key: row[key] for key in [
            "method",
            "topology",
            "scenario",
            "k_eval",
            "seeds_n",
            "runs_n",
            "rac_mean",
            "rac_std",
            "lrc_mean",
            "lrc_std",
            "ast_run_mean",
            "training_cost",
        ]}
        if out["method"] == "alpha_zero_sfc":
            continue
        rows.append(out)
    return rows


def load_generalization_rows() -> list[dict[str, object]]:
    rows: list[dict[str, object]] = []
    for row in read_csv(MAIN_METRICS):
        if row["topology"] != "brain":
            continue
        if row["k_eval"] and float(row["k_eval"]) != 10.0:
            continue
        scenario = row["scenario"]
        if scenario == "final_alpha_vne_nominal_to_generalization":
            method = "alpha_vne"
        elif scenario == "nominal_to_generalization" and row["method"] != "alpha_zero_sfc":
            method = row["method"]
        else:
            continue
        rows.append({
            "method": method,
            "topology": "brain",
            "scenario": "nominal_to_generalization",
            "k_eval": 10,
            "seeds_n": row["seeds_n"],
            "runs_n": row["runs_n"],
            "rac_mean": row["rac_mean"],
            "rac_std": row["rac_std"],
            "lrc_mean": row["lrc_mean"],
            "lrc_std": row["lrc_std"],
            "ast_run_mean": row["ast_run_mean"],
            "training_cost": row["training_cost"],
        })
    return sorted(rows, key=lambda r: (0 if r["method"] == "alpha_vne" else 1, str(r["method"])))


def add_improvements(rows: list[dict[str, object]]) -> list[dict[str, object]]:
    output = []
    for topology in ["brain", "geant", "wx100"]:
        subset = [r for r in rows if r["topology"] == topology]
        repaired = next(r for r in subset if r["method"] == "alpha_vne")
        benchmarks = [r for r in subset if r["method"] != "alpha_vne"]
        best = max(benchmarks, key=lambda r: float(r["rac_mean"]))
        gain_abs = float(repaired["rac_mean"]) - float(best["rac_mean"])
        gain_rel = gain_abs / float(best["rac_mean"]) if float(best["rac_mean"]) else 0.0
        output.append(
            {
                "topology": topology,
                "new_alpha_rac": repaired["rac_mean"],
                "best_prior_method": best["method"],
                "best_prior_rac": best["rac_mean"],
                "absolute_gain": gain_abs,
                "relative_gain_pct": gain_rel * 100.0,
            }
        )
    return output


def build_results_draft(comparison_rows: list[dict[str, object]], improvement_rows: list[dict[str, object]]) -> str:
    compact = []
    preferred_methods = {
        "alpha_vne",
        "ppo_mlp+",
        "ppo_dual_gcn+",
        "mcts",
        "grc_rank",
        "pso_meta",
    }
    for row in comparison_rows:
        if row["method"] not in preferred_methods:
            continue
        compact.append(
            {
                "Topology": row["topology"],
                "Method": row["method"],
                "RAC": f"{fmt(row['rac_mean'])} +/- {fmt(row['rac_std'])}",
                "LRC": fmt(row["lrc_mean"]),
                "Eval time (s)": fmt(row["ast_run_mean"], 1),
            }
        )

    improvements = [
        {
            "Topology": r["topology"],
            "Ours RAC": fmt(r["new_alpha_rac"]),
            "Best prior": r["best_prior_method"],
            "Best prior RAC": fmt(r["best_prior_rac"]),
            "Abs. gain": fmt(r["absolute_gain"]),
            "Rel. gain": f"{fmt(r['relative_gain_pct'], 1)}%",
        }
        for r in improvement_rows
    ]

    lines = [
        "# Journal Results Draft",
        "",
        "This folder compiles the existing journal-suite benchmark outputs and the repaired AlphaVNE runs after the replay-policy corruption fix.",
        "",
        "## Headline Result",
        "",
        markdown_table(improvements, [
            ("Topology", "Topology"),
            ("Ours RAC", "Ours RAC"),
            ("Best prior", "Best prior method"),
            ("Best prior RAC", "Best prior RAC"),
            ("Abs. gain", "Abs. gain"),
            ("Rel. gain", "Rel. gain"),
        ]),
        "",
        "## Main Nominal k=10 Comparison",
        "",
        markdown_table(compact, [
            ("Topology", "Topology"),
            ("Method", "Method"),
            ("RAC", "Acceptance rate"),
            ("LRC", "Long-term R/C"),
            ("Eval time (s)", "Eval time (s)"),
        ]),
        "",
        "## Draft Text",
        "",
        "Across the three nominal topologies, AlphaVNE improves request acceptance over the strongest prior benchmark. The largest non-saturated gains occur on Brain and Geant. On Waxman100, the environment is close to saturated for several methods, but AlphaVNE remains at the top of the comparison.",
        "",
        "The Brain result is the key evidence that the transformer-guided MCTS policy is learning a substantially stronger placement policy than the previous learned and heuristic baselines. The paper-facing final method row is `alpha_vne`; raw internal folders may still use the historical solver key `alpha_zero_sfc`.",
        "",
        "## Files",
        "",
        "- `main_comparison_k10_nominal.csv`: benchmark rows plus final AlphaVNE rows.",
        "- `main_comparison_k10_nominal.md`: Markdown version of the main comparison.",
        "- `new_alpha_per_seed.csv`: per-seed final AlphaVNE results and source run IDs.",
        "- `headline_improvements.csv`: best-prior comparison by topology.",
        "- `source_manifest.md`: source files used to build these tables.",
        "",
        "## Caveats",
        "",
        "- `wx100` is near saturation; use it as a sanity-check topology rather than the headline claim.",
        "- Brain and Geant now use five seeds for AlphaVNE and the listed baselines; Wx100 remains a saturated three-seed sanity check.",
        "- The Brain/Geant k-sweeps should be reported as sensitivity/runtime tradeoff experiments.",
        "",
    ]
    return "\n".join(lines)


def main() -> None:
    OUT.mkdir(parents=True, exist_ok=True)

    new_runs = load_new_alpha_runs()
    new_rows = aggregate_new_alpha(new_runs)
    baseline_rows = load_baseline_k10_nominal()
    comparison_rows = baseline_rows + new_rows
    comparison_rows.sort(key=lambda r: (str(r["topology"]), 0 if r["method"] == "alpha_vne" else 1, str(r["method"])))
    improvement_rows = add_improvements(comparison_rows)
    generalization_rows = load_generalization_rows()

    comparison_fields = [
        "method", "topology", "scenario", "k_eval", "seeds_n", "runs_n",
        "rac_mean", "rac_std", "lrc_mean", "lrc_std", "ast_run_mean", "training_cost",
    ]
    write_csv(OUT / "main_comparison_k10_nominal.csv", comparison_rows, comparison_fields)
    write_csv(OUT / "headline_improvements.csv", improvement_rows, [
        "topology", "new_alpha_rac", "best_prior_method", "best_prior_rac", "absolute_gain", "relative_gain_pct",
    ])
    write_csv(OUT / "brain_generalization_comparison.csv", generalization_rows, comparison_fields)
    write_csv(OUT / "new_alpha_per_seed.csv", [
        {
            "method": "alpha_vne",
            "topology": r.topology,
            "seed": r.seed,
            "k_eval": 10,
            "acceptance_rate": r.acceptance_rate,
            "long_term_r2c_ratio": r.long_term_r2c_ratio,
            "clock_running_time": r.clock_running_time,
            "run_id": r.run_id,
            "source_path": r.source_path.relative_to(ROOT),
        }
        for r in new_runs
    ], [
        "method", "topology", "seed", "k_eval", "acceptance_rate", "long_term_r2c_ratio",
        "clock_running_time", "run_id", "source_path",
    ])
    shutil.copyfile(MAIN_METRICS, OUT / "baseline_reference_main_metrics.csv")

    md_rows = [
        {
            "method": r["method"],
            "topology": r["topology"],
            "rac": f"{fmt(r['rac_mean'])} +/- {fmt(r['rac_std'])}",
            "lrc": fmt(r["lrc_mean"]),
            "eval_time": fmt(r["ast_run_mean"], 1),
        }
        for r in comparison_rows
    ]
    (OUT / "main_comparison_k10_nominal.md").write_text(
        "# Main Comparison: Nominal k=10\n\n"
        + markdown_table(md_rows, [
            ("topology", "Topology"),
            ("method", "Method"),
            ("rac", "Acceptance rate"),
            ("lrc", "Long-term R/C"),
            ("eval_time", "Eval time (s)"),
        ])
        + "\n",
        encoding="utf-8",
    )

    gen_md_rows = [
        {
            "method": r["method"],
            "rac": f"{fmt(r['rac_mean'])} +/- {fmt(r['rac_std'])}",
            "lrc": fmt(r["lrc_mean"]),
            "eval_time": fmt(r["ast_run_mean"], 1),
        }
        for r in generalization_rows
    ]
    (OUT / "brain_generalization_comparison.md").write_text(
        "# Brain Nominal-to-Generalization Comparison\n\n"
        + markdown_table(gen_md_rows, [
            ("method", "Method"),
            ("rac", "Acceptance rate"),
            ("lrc", "Long-term R/C"),
            ("eval_time", "Eval time (s)"),
        ])
        + "\n",
        encoding="utf-8",
    )

    source_lines = [
        "# Source Manifest",
        "",
        f"- Baseline benchmark table: `{MAIN_METRICS.relative_to(ROOT)}`",
        "- Final AlphaVNE nominal source runs:",
    ]
    for r in new_runs:
        source_lines.append(f"- `{r.topology}` seed `{r.seed}`: `{r.source_path.relative_to(ROOT)}` (`{r.run_id}`)")
    if GENERALIZATION_ALPHA_SUMMARY.exists():
        source_lines.extend([
            "",
            f"- Final AlphaVNE Brain generalization summary: `{GENERALIZATION_ALPHA_SUMMARY.relative_to(ROOT)}`",
        ])
    (OUT / "source_manifest.md").write_text("\n".join(source_lines) + "\n", encoding="utf-8")
    (OUT / "results_section_draft.md").write_text(build_results_draft(comparison_rows, improvement_rows), encoding="utf-8")
    (OUT / "README.md").write_text(
        "# Paper Journal Results\n\n"
        "This folder contains the paper-facing result bundle for the repaired AlphaVNE journal comparison.\n\n"
        "Start with `results.md` for the source map, then `results_section_draft.md` for prose and headline tables.\n\n"
        "Core tables:\n"
        "- `results.md`: canonical index of final model checkpoints, eval outputs, k-sweeps, and benchmark folders.\n"
        "- `main_comparison_k10_nominal.csv`: nominal k=10 benchmark table with final AlphaVNE added.\n"
        "- `main_comparison_k10_nominal.md`: Markdown rendering of the same table.\n"
        "- `brain_generalization_comparison.csv`: Brain nominal-to-generalization comparison.\n"
        "- `headline_improvements.csv`: acceptance-rate gain over the strongest prior row per topology.\n"
        "- `new_alpha_per_seed.csv`: final AlphaVNE per-seed source results.\n"
        "- `baseline_reference_main_metrics.csv`: raw existing benchmark aggregate copied from `results/journal_suite/tables/main_metrics.csv`.\n"
        "- `source_manifest.md`: exact result files used for the AlphaVNE rows.\n\n"
        "Regenerate with:\n\n"
        "```bash\n"
        "conda run -n virne python tools/build_paperjournal_results.py\n"
        "```\n",
        encoding="utf-8",
    )

    print(f"Wrote {OUT.relative_to(ROOT)}")
    for path in sorted(OUT.iterdir()):
        print(path.relative_to(ROOT))


if __name__ == "__main__":
    main()
