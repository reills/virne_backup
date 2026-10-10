from __future__ import annotations

import importlib.util
import csv
import json
from pathlib import Path
import sys

import yaml


REPO_ROOT = Path(__file__).resolve().parents[2]
MODULE_PATH = REPO_ROOT / "tools" / "publish_infocom_benchmark_tables.py"
_SPEC = importlib.util.spec_from_file_location("publish_infocom_benchmark_tables", MODULE_PATH)
assert _SPEC is not None and _SPEC.loader is not None
publisher = importlib.util.module_from_spec(_SPEC)
sys.modules[_SPEC.name] = publisher
_SPEC.loader.exec_module(publisher)


def _gpp_aggregates(brain_acceptance: float = 0.4) -> list[dict[str, object]]:
    return [
        {
            "topology": "brain",
            "seeds": 5,
            "acceptance_mean": brain_acceptance,
            "acceptance_sample_std": 0.01,
            "long_term_r2c_mean": 0.7,
            "runtime_mean_seconds": 12.3,
        },
        {
            "topology": "geant",
            "seeds": 5,
            "acceptance_mean": 0.4,
            "acceptance_sample_std": 0.02,
            "long_term_r2c_mean": 0.7,
            "runtime_mean_seconds": 11.2,
        },
    ]


def test_master_runner_schedules_only_missing_reachability_variant() -> None:
    runner = (REPO_ROOT / "tools/run_infocom_benchmark_additions.sh").read_text()

    assert 'VARIANTS="no_reachability"' in runner
    assert 'VARIANTS="full no_reachability"' not in runner
    assert '--full-reference-analysis-root "$FULL_REFERENCE_ROOT"' in runner
    assert '--full-reference-stamp "$FULL_REFERENCE_STAMP"' in runner


def test_inject_gpp_rows_is_idempotent_and_preserves_existing_alpha_row() -> None:
    source = (
        REPO_ROOT
        / "paperjournal/versions/overleaf_7.17.2026/tables/main_comparison.tex"
    ).read_text()
    once = publisher.inject_gpp_rows(source, _gpp_aggregates())
    twice = publisher.inject_gpp_rows(once, _gpp_aggregates())

    assert once == twice
    assert once.count("BRAIN & GPPVNE-R &") == 1
    assert once.count("GEANT & GPPVNE-R &") == 1
    assert "BRAIN & \\textbf{\\alphavne} & 10 & \\(\\mathbf{0.600 \\pm 0.045}\\)" in once
    assert "GPPVNE-R denotes our independent reproduction" in once


def test_assess_publication_blocks_when_gpp_becomes_strongest_baseline() -> None:
    source = (
        REPO_ROOT
        / "paperjournal/versions/overleaf_7.17.2026/tables/main_comparison.tex"
    ).read_text()
    candidate = publisher.inject_gpp_rows(source, _gpp_aggregates(brain_acceptance=0.55))
    _warnings, blockers = publisher.assess_publication(
        candidate_main=candidate,
        canonical_alpha_per_seed=REPO_ROOT / "paperjournal/results_data/new_alpha_per_seed.csv",
    )

    assert any("BRAIN" in blocker and "strongest baseline" in blocker for blocker in blockers)


def test_assess_publication_warns_when_gpp_only_leads_secondary_r2c() -> None:
    source = (
        REPO_ROOT
        / "paperjournal/versions/overleaf_7.17.2026/tables/main_comparison.tex"
    ).read_text()
    aggregates = _gpp_aggregates()
    aggregates[0]["long_term_r2c_mean"] = 0.8
    candidate = publisher.inject_gpp_rows(source, aggregates)
    warnings, blockers = publisher.assess_publication(
        candidate_main=candidate,
        canonical_alpha_per_seed=REPO_ROOT / "does-not-exist.csv",
    )

    assert not blockers
    assert any("Secondary-metric note for BRAIN" in warning for warning in warnings)


def test_inject_reachability_rows_reuses_completed_full_rows() -> None:
    source = (
        REPO_ROOT
        / "paperjournal/versions/overleaf_7.17.2026/tables/component_ablation.tex"
    ).read_text()
    full = {
        "brain": (0.578, 0.014, 0.842, 978.2),
        "geant": (0.677, 0.028, 0.849, 345.6),
    }
    aggregates = []
    for topology in publisher.TOPOLOGIES:
        acceptance, deviation, r2c, runtime = full[topology]
        aggregates.extend(
            [
                {
                    "topology": topology,
                    "variant": "full",
                    "seeds": 5,
                    "acceptance_mean": acceptance,
                    "acceptance_sample_std": deviation,
                    "long_term_r2c_mean": r2c,
                    "runtime_mean_seconds": runtime,
                },
                {
                    "topology": topology,
                    "variant": "no_reachability",
                    "seeds": 5,
                    "acceptance_mean": 0.5,
                    "acceptance_sample_std": 0.01,
                    "long_term_r2c_mean": 0.8,
                    "runtime_mean_seconds": 10.0,
                },
            ]
        )
    paired = [
        {
            "topology": topology,
            "matched_seeds": 5,
            "full_minus_ablation_mean": 0.1,
            "ci95_low": 0.05,
            "ci95_high": 0.15,
        }
        for topology in publisher.TOPOLOGIES
    ]

    once = publisher.inject_reachability_rows(source, aggregates, paired)
    twice = publisher.inject_reachability_rows(once, aggregates, paired)

    assert once == twice
    assert once.count("& No reachability filter &") == 2
    assert "\\(+0.100\\ [+0.050,\\,+0.150]\\)" in once
    assert once.count("Full \\alphavne{}") == 2
    assert "\\label{tab:component_ablation}" in once
    assert once.index("BRAIN & Deferred routing") < once.index(
        "BRAIN & No reachability filter"
    ) < once.index("BRAIN & No candidate features")
    assert "incremental routing and reservation remain enabled" in once


def _write_csv(path: Path, rows: list[dict[str, object]]) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    with path.open("w", newline="") as handle:
        writer = csv.DictWriter(handle, fieldnames=list(rows[0]))
        writer.writeheader()
        writer.writerows(rows)


def _make_dataset(repo_root: Path, topology: str, seed: int, split: str) -> Path:
    path = publisher.expected_dataset(repo_root, topology, seed, split)
    path.mkdir(parents=True, exist_ok=True)
    for name in ("p_net.gml", "events.yaml", "v_sim_setting.yaml", "generation_metadata.json"):
        (path / name).write_text("{}\n")
    return path


def _summary_row(
    *, run_id: str, solver_name: str, seed: int, dataset: Path, acceptance: float
) -> dict[str, object]:
    return {
        "num_arrival_requests": 1000,
        "acceptance_rate": acceptance,
        "success_count": int(1000 * acceptance),
        "long_term_r2c_ratio": 0.7,
        "clock_running_time": 10.0,
        "request_timeout_count": 0,
        "run_timeout": False,
        "solver_name": solver_name,
        "seed": seed,
        "p_net_dataset_dir": str(dataset),
        "v_nets_dataset_dir": str(dataset),
        "run_id": run_id,
    }


def _gpp_config(
    *, run_id: str, seed: int, dataset: Path, stage: str, model: Path | None
) -> dict[str, object]:
    return {
        "solver": {
            "solver_name": "gpp_vne",
            "k_shortest": 10,
            "pretrained_model_path": "" if model is None else str(model),
        },
        "experiment": {"run_id": run_id, "seed": seed},
        "training": {
            "seed": seed,
            "batch_size": 64,
            "use_cuda": True,
            "inference_only": stage == "eval",
            "num_train_epochs": 0 if stage == "eval" else 25,
        },
        "nn": {"embedding_dim": 64, "hidden_dim": 64, "num_layers": 2},
        "rl": {
            "target_steps": 500,
            "repeat_times": 10,
            "gpp_vne": {"link_embedding_interval": 3},
        },
        "simulation": {
            "p_net_dataset_dir": str(dataset),
            "v_nets_dataset_dir": str(dataset),
        },
        "v_sim_setting": {"num_v_nets": 1000},
    }


def _alpha_config(
    *, run_id: str, seed: int, dataset: Path, stage: str, model: Path | None
) -> dict[str, object]:
    training = {
        "seed": seed,
        "computation_budget": 96,
        "use_cuda": True,
        "pure_cpp": True,
        "use_cpp_mcts": True,
        "use_neural_network": True,
        "inference_only": stage == "eval",
        "num_train_epochs": 0 if stage == "eval" else 16,
        "max_training_steps": 0 if stage == "eval" else 3000,
        "alphazero_model_path": "" if model is None else str(model),
    }
    if stage == "train":
        training.update({"min_buffer_size": 128, "num_train_steps_per_epoch": 128})
    return {
        "solver": {
            "solver_name": "alpha_zero_sfc",
            "k_shortest": 1,
            "pretrained_model_path": "" if model is None else str(model),
        },
        "experiment": {"run_id": run_id, "seed": seed},
        "training": training,
        "nn": {
            "embedding_dim": 96,
            "hidden_dim": 96,
            "num_gnn_layers": 2,
            "n_heads": 6,
            "transformer_layers": 2,
        },
        "simulation": {
            "p_net_dataset_dir": str(dataset),
            "v_nets_dataset_dir": str(dataset),
        },
        "v_sim_setting": {"num_v_nets": 1000},
    }


def test_collectors_accept_only_complete_production_matrix(tmp_path: Path) -> None:
    gpp_root = tmp_path / "gpp-results"
    registry_rows: list[dict[str, object]] = []
    for topology in publisher.TOPOLOGIES:
        for seed in publisher.SEEDS:
            train_dataset = _make_dataset(tmp_path, topology, seed, "train")
            test_dataset = _make_dataset(tmp_path, topology, seed, "test")
            train_id = (
                f"journal_suite__gpp_vne_infocom__{topology}__nominal__seed{seed}"
                "__train__ktrain10"
            )
            train_dir = gpp_root / train_id
            model = train_dir / "models/model.pkl"
            model.parent.mkdir(parents=True, exist_ok=True)
            model.write_bytes(f"model-{topology}-{seed}".encode())
            (train_dir / "config.yaml").write_text(
                yaml.safe_dump(
                    _gpp_config(
                        run_id=train_id,
                        seed=seed,
                        dataset=train_dataset,
                        stage="train",
                        model=None,
                    )
                )
            )
            registry_rows.append(
                {
                    "method": "gpp_vne_infocom",
                    "solver_name": "gpp_vne",
                    "topology": topology,
                    "scenario": "nominal",
                    "seed": seed,
                    "k_train": 10,
                    "model_path": str(model),
                    "run_id": train_id,
                    "updated_at_utc": "2026-07-17T00:00:00+00:00",
                }
            )
            token = publisher.checkpoint_token(model)
            eval_id = (
                f"journal_suite__gpp_vne_infocom__{topology}__nominal__seed{seed}"
                f"__eval__keval10__ckpt{token}"
            )
            eval_dir = gpp_root / eval_id
            eval_dir.mkdir(parents=True, exist_ok=True)
            (eval_dir / "config.yaml").write_text(
                yaml.safe_dump(
                    _gpp_config(
                        run_id=eval_id,
                        seed=seed,
                        dataset=test_dataset,
                        stage="eval",
                        model=model,
                    )
                )
            )
            _write_csv(
                eval_dir / "summary.csv",
                [_summary_row(run_id=eval_id, solver_name="gpp_vne", seed=seed, dataset=test_dataset, acceptance=0.2)],
            )
    registry = tmp_path / "model_registry.csv"
    _write_csv(registry, registry_rows)

    gpp_rows = publisher.collect_gpp(
        repo_root=tmp_path,
        results_root=gpp_root,
        registry_path=registry,
    )
    assert len(gpp_rows) == 10

    full_stamp = "full-unit"
    no_reachability_stamp = "no-reachability-unit"
    alpha_root = tmp_path / "alpha-results"
    full_analysis_root = tmp_path / "alpha-full-analysis"
    no_reachability_analysis_root = tmp_path / "alpha-no-reachability-analysis"
    raw_rows: dict[str, list[dict[str, object]]] = {
        "full": [],
        "no_reachability": [],
    }
    for topology in publisher.TOPOLOGIES:
        for seed in publisher.SEEDS:
            train_dataset = publisher.expected_dataset(tmp_path, topology, seed, "train")
            test_dataset = publisher.expected_dataset(tmp_path, topology, seed, "test")
            for variant in ("full", "no_reachability"):
                stamp = (
                    full_stamp if variant == "full" else no_reachability_stamp
                )
                variant_analysis_root = (
                    full_analysis_root
                    if variant == "full"
                    else no_reachability_analysis_root
                )
                base = (
                    f"journal_suite__alpha_zero_sfc__{topology}__journal_components_k1"
                    f"__{variant}__budget96__seed{seed}"
                )
                train_id = f"{base}__train__{stamp}"
                eval_id = f"{base}__eval__{stamp}"
                train_dir = alpha_root / train_id
                eval_dir = alpha_root / eval_id
                checkpoint = train_dir / "models/policy_latest.pt"
                checkpoint.parent.mkdir(parents=True, exist_ok=True)
                checkpoint.write_bytes(b"checkpoint")
                eval_model = (
                    variant_analysis_root
                    / "extracted_models"
                    / f"{topology}_{variant}_seed{seed}_weights.pt"
                )
                eval_model.parent.mkdir(parents=True, exist_ok=True)
                eval_model.write_bytes(b"weights")
                (train_dir / "config.yaml").write_text(
                    yaml.safe_dump(
                        _alpha_config(
                            run_id=train_id,
                            seed=seed,
                            dataset=train_dataset,
                            stage="train",
                            model=None,
                        )
                    )
                )
                eval_dir.mkdir(parents=True, exist_ok=True)
                (eval_dir / "config.yaml").write_text(
                    yaml.safe_dump(
                        _alpha_config(
                            run_id=eval_id,
                            seed=seed,
                            dataset=test_dataset,
                            stage="eval",
                            model=eval_model,
                        )
                    )
                )
                if variant == "no_reachability":
                    for stage, run_id, run_dir, dataset in (
                        ("train", train_id, train_dir, train_dataset),
                        ("eval", eval_id, eval_dir, test_dataset),
                    ):
                        payload = {
                            "schema_version": 1,
                            "experiment": "alpha_vne_reachability_ablation",
                            "stage": stage,
                            "run_id": run_id,
                            "topology": topology,
                            "seed": seed,
                            "variant": variant,
                            "dataset_dir": str(dataset),
                            "k_shortest": 1,
                            "mcts_simulations": 96,
                            "num_v_nets": 1000,
                            "flags": publisher.EXPECTED_ABLATION_FLAGS[variant],
                            "git_commit": "unit",
                            "source_sha256": {"source.cpp": "abc"},
                            "created_at_utc": "2026-07-17T00:00:00+00:00",
                        }
                        (run_dir / "ablation_provenance.json").write_text(
                            json.dumps(payload)
                        )
                summary = _summary_row(
                    run_id=eval_id,
                    solver_name="alpha_zero_sfc",
                    seed=seed,
                    dataset=test_dataset,
                    acceptance=0.3 if variant == "full" else 0.2,
                )
                _write_csv(eval_dir / "summary.csv", [summary])
                raw_rows[variant].append(
                    {
                        "topology": topology,
                        "seed": seed,
                        "variant": variant,
                        "k_eval": 1,
                        "mcts_simulations": 96,
                        "acceptance_rate": summary["acceptance_rate"],
                        "long_term_r2c_ratio": summary["long_term_r2c_ratio"],
                        "clock_running_time": summary["clock_running_time"],
                        "success_count": summary["success_count"],
                        "run_id": eval_id,
                        "summary_path": str(eval_dir / "summary.csv"),
                    }
                )
    _write_csv(full_analysis_root / "eval_summary.csv", raw_rows["full"])
    _write_csv(
        no_reachability_analysis_root / "eval_summary.csv",
        raw_rows["no_reachability"],
    )

    full_rows = publisher.collect_ablation_variant(
        repo_root=tmp_path,
        solver_results_root=alpha_root,
        analysis_root=full_analysis_root,
        stamp=full_stamp,
        variant="full",
        require_provenance=False,
    )
    no_reachability_rows = publisher.collect_ablation_variant(
        repo_root=tmp_path,
        solver_results_root=alpha_root,
        analysis_root=no_reachability_analysis_root,
        stamp=no_reachability_stamp,
        variant="no_reachability",
        require_provenance=True,
    )
    assert len(full_rows) == 10
    assert len(no_reachability_rows) == 10
