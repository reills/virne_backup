#!/usr/bin/env python3
"""Validate the GPPVNE/reachability runs and publish paper-ready tables.

Only complete five-seed result matrices are accepted. New no-reachability runs
must carry immutable provenance; the previously completed Full matrix is
revalidated from its configs, checkpoints, summaries, and displayed paper row.
The script always writes candidate tables and machine-readable source data to
its analysis directory. With ``--publish``, those candidates are copied into
the selected paper version only when they do not invalidate the paper's
acceptance-based best-baseline statements.
"""

from __future__ import annotations

import argparse
import csv
import hashlib
import json
import math
import os
import re
import shutil
import statistics
import sys
from dataclasses import asdict, dataclass
from datetime import datetime, timezone
from pathlib import Path
from typing import Any, Iterable, Mapping, Sequence

import yaml


ROOT = Path(__file__).resolve().parents[1]
TOPOLOGIES = ("brain", "geant")
SEEDS = (0, 1, 2, 3, 4)
GPP_METHOD_KEY = "gpp_vne_infocom"
GPP_RUN_NAMESPACE = "gpp_vne_infocom"
GPP_SOLVER_NAME = "gpp_vne"
SCENARIO = "nominal"
K_MAIN = 10
K_ABLATION = 1
MCTS_BUDGET = 96
NUM_REQUESTS = 1000
T_975 = {1: 12.706, 2: 4.303, 3: 3.182, 4: 2.776}


class ValidationError(RuntimeError):
    pass


class PublicationBlocked(RuntimeError):
    pass


@dataclass(frozen=True)
class GppResult:
    topology: str
    seed: int
    acceptance_rate: float
    long_term_r2c_ratio: float
    clock_running_time: float
    success_count: int
    run_id: str
    train_run_id: str
    summary_path: str
    eval_config_path: str
    train_config_path: str
    model_path: str
    model_sha256: str
    checkpoint_token: str


@dataclass(frozen=True)
class AblationResult:
    topology: str
    seed: int
    variant: str
    acceptance_rate: float
    long_term_r2c_ratio: float
    clock_running_time: float
    success_count: int
    run_id: str
    train_run_id: str
    model_path: str
    summary_path: str
    eval_provenance_path: str
    train_provenance_path: str


def read_csv(path: Path) -> list[dict[str, str]]:
    if not path.is_file():
        raise ValidationError(f"missing CSV: {path}")
    with path.open(newline="", encoding="utf-8") as handle:
        return list(csv.DictReader(handle))


def read_single_csv_row(path: Path) -> dict[str, str]:
    rows = read_csv(path)
    if len(rows) != 1:
        raise ValidationError(f"expected one aggregate row in {path}, found {len(rows)}")
    return rows[0]


def read_yaml(path: Path) -> dict[str, Any]:
    if not path.is_file():
        raise ValidationError(f"missing run config: {path}")
    data = yaml.safe_load(path.read_text())
    if not isinstance(data, dict):
        raise ValidationError(f"run config is not a mapping: {path}")
    return data


def nested(data: Mapping[str, Any], dotted: str) -> Any:
    value: Any = data
    for key in dotted.split("."):
        if not isinstance(value, Mapping) or key not in value:
            raise ValidationError(f"missing config key {dotted}")
        value = value[key]
    return value


def as_bool(value: Any) -> bool:
    if isinstance(value, bool):
        return value
    text = str(value).strip().lower()
    if text in {"1", "true", "yes", "on"}:
        return True
    if text in {"0", "false", "no", "off", ""}:
        return False
    raise ValidationError(f"cannot interpret boolean value {value!r}")


def require_equal(name: str, actual: Any, expected: Any) -> None:
    if actual != expected:
        raise ValidationError(f"{name}: expected {expected!r}, got {actual!r}")


def require_close(name: str, actual: float, expected: float, tolerance: float = 1e-9) -> None:
    if not math.isclose(actual, expected, rel_tol=0.0, abs_tol=tolerance):
        raise ValidationError(f"{name}: expected {expected}, got {actual}")


def require_resolved_path(name: str, actual: Any, expected: Path) -> None:
    actual_path = Path(str(actual)).expanduser().resolve()
    expected_path = expected.expanduser().resolve()
    if actual_path != expected_path:
        raise ValidationError(f"{name}: expected {expected_path}, got {actual_path}")


def sha256_file(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as handle:
        for chunk in iter(lambda: handle.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def checkpoint_token(path: Path) -> str:
    stat = path.stat()
    payload = f"{path.resolve()}:{stat.st_size}:{stat.st_mtime_ns}".encode()
    return hashlib.sha256(payload).hexdigest()[:10]


def write_text_atomic(path: Path, text: str) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    temporary = path.with_name(f".{path.name}.tmp.{os.getpid()}")
    temporary.write_text(text, encoding="utf-8")
    os.replace(temporary, path)


def write_csv_atomic(path: Path, rows: Iterable[Mapping[str, Any]], fields: Sequence[str]) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    temporary = path.with_name(f".{path.name}.tmp.{os.getpid()}")
    with temporary.open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(handle, fieldnames=list(fields))
        writer.writeheader()
        for row in rows:
            writer.writerow({field: row.get(field, "") for field in fields})
    os.replace(temporary, path)


def copy_atomic(source: Path, destination: Path) -> None:
    destination.parent.mkdir(parents=True, exist_ok=True)
    temporary = destination.with_name(f".{destination.name}.tmp.{os.getpid()}")
    shutil.copy2(source, temporary)
    os.replace(temporary, destination)


def mean(values: Sequence[float]) -> float:
    return sum(values) / len(values)


def sample_std(values: Sequence[float]) -> float:
    return statistics.stdev(values) if len(values) > 1 else 0.0


def ci95(values: Sequence[float]) -> tuple[float, float]:
    center = mean(values)
    if len(values) < 2:
        return center, center
    dof = len(values) - 1
    critical = T_975.get(dof, 1.960)
    margin = critical * sample_std(values) / math.sqrt(len(values))
    return center - margin, center + margin


def aggregate(rows: Sequence[Any], topology: str) -> dict[str, float | int | str]:
    subset = [row for row in rows if row.topology == topology]
    if len(subset) != len(SEEDS):
        raise ValidationError(f"{topology}: expected {len(SEEDS)} rows, found {len(subset)}")
    return {
        "topology": topology,
        "seeds": len(subset),
        "acceptance_mean": mean([row.acceptance_rate for row in subset]),
        "acceptance_sample_std": sample_std([row.acceptance_rate for row in subset]),
        "long_term_r2c_mean": mean([row.long_term_r2c_ratio for row in subset]),
        "runtime_mean_seconds": mean([row.clock_running_time for row in subset]),
    }


def expected_dataset(repo_root: Path, topology: str, seed: int, split: str) -> Path:
    return repo_root / "datasets/generated/journal/nominal" / topology / f"seed_{seed}" / split


def validate_dataset(path: Path) -> None:
    for name in ("p_net.gml", "events.yaml", "v_sim_setting.yaml", "generation_metadata.json"):
        if not (path / name).is_file():
            raise ValidationError(f"dataset is incomplete; missing {path / name}")


def validate_summary(
    summary: Mapping[str, str],
    *,
    path: Path,
    run_id: str,
    solver_name: str,
    topology: str,
    seed: int,
    dataset_dir: Path,
) -> tuple[float, float, float, int]:
    require_equal(f"{path}: run_id", summary.get("run_id", ""), run_id)
    require_equal(f"{path}: solver_name", summary.get("solver_name", ""), solver_name)
    require_equal(f"{path}: seed", int(summary["seed"]), seed)
    require_resolved_path(f"{path}: p_net_dataset_dir", summary["p_net_dataset_dir"], dataset_dir)
    require_resolved_path(f"{path}: v_nets_dataset_dir", summary["v_nets_dataset_dir"], dataset_dir)
    num_arrivals = int(float(summary["num_arrival_requests"]))
    require_equal(f"{path}: num_arrival_requests", num_arrivals, NUM_REQUESTS)
    require_equal(f"{path}: request_timeout_count", int(float(summary.get("request_timeout_count", 0))), 0)
    require_equal(f"{path}: run_timeout", as_bool(summary.get("run_timeout", False)), False)
    acceptance = float(summary["acceptance_rate"])
    r2c = float(summary["long_term_r2c_ratio"])
    runtime = float(summary["clock_running_time"])
    successes = int(float(summary["success_count"]))
    if not 0.0 <= acceptance <= 1.0:
        raise ValidationError(f"{path}: acceptance outside [0,1]: {acceptance}")
    if not math.isfinite(r2c) or r2c < 0.0:
        raise ValidationError(f"{path}: invalid long-term R/C: {r2c}")
    if not math.isfinite(runtime) or runtime <= 0.0:
        raise ValidationError(f"{path}: invalid runtime: {runtime}")
    require_close(f"{path}: acceptance vs success count", acceptance, successes / NUM_REQUESTS)
    return acceptance, r2c, runtime, successes


def validate_gpp_config(
    config: Mapping[str, Any],
    *,
    path: Path,
    stage: str,
    run_id: str,
    topology: str,
    seed: int,
    dataset_dir: Path,
    model_path: Path | None,
) -> None:
    expected = {
        "solver.solver_name": GPP_SOLVER_NAME,
        "solver.k_shortest": K_MAIN,
        "experiment.run_id": run_id,
        "experiment.seed": seed,
        "training.seed": seed,
        "training.batch_size": 64,
        "training.use_cuda": True,
        "nn.embedding_dim": 64,
        "nn.hidden_dim": 64,
        "nn.num_layers": 2,
        "rl.target_steps": 500,
        "rl.repeat_times": 10,
        "rl.gpp_vne.link_embedding_interval": 3,
        "v_sim_setting.num_v_nets": NUM_REQUESTS,
    }
    if stage == "train":
        expected.update({"training.inference_only": False, "training.num_train_epochs": 25})
    else:
        expected.update({"training.inference_only": True, "training.num_train_epochs": 0})
    for key, wanted in expected.items():
        require_equal(f"{path}: {key}", nested(config, key), wanted)
    require_resolved_path(f"{path}: simulation.p_net_dataset_dir", nested(config, "simulation.p_net_dataset_dir"), dataset_dir)
    require_resolved_path(f"{path}: simulation.v_nets_dataset_dir", nested(config, "simulation.v_nets_dataset_dir"), dataset_dir)
    if stage == "eval":
        assert model_path is not None
        require_resolved_path(f"{path}: solver.pretrained_model_path", nested(config, "solver.pretrained_model_path"), model_path)


def collect_gpp(
    *,
    repo_root: Path,
    results_root: Path,
    registry_path: Path,
) -> list[GppResult]:
    registry = read_csv(registry_path)
    collected: list[GppResult] = []
    for topology in TOPOLOGIES:
        for seed in SEEDS:
            train_run_id = (
                f"journal_suite__{GPP_RUN_NAMESPACE}__{topology}__{SCENARIO}"
                f"__seed{seed}__train__ktrain{K_MAIN}"
            )
            candidates = [
                row
                for row in registry
                if row.get("method") == GPP_METHOD_KEY
                and row.get("topology") == topology
                and row.get("scenario") == SCENARIO
                and int(row.get("seed", -1)) == seed
                and int(row.get("k_train", -1)) == K_MAIN
                and row.get("run_id") == train_run_id
            ]
            if len(candidates) != 1:
                raise ValidationError(
                    f"expected one production registry row for {topology}/seed{seed}, "
                    f"found {len(candidates)}"
                )
            registry_row = candidates[0]
            model_path = Path(registry_row["model_path"]).expanduser()
            if not model_path.is_absolute():
                model_path = repo_root / model_path
            model_path = model_path.resolve()
            if not model_path.is_file() or model_path.stat().st_size <= 0:
                raise ValidationError(f"missing production checkpoint: {model_path}")

            train_dir = (results_root / train_run_id).resolve()
            if model_path.parent.parent != train_dir:
                raise ValidationError(
                    f"registry checkpoint is outside expected production run: {model_path}"
                )
            train_config_path = train_dir / "config.yaml"
            train_dataset = expected_dataset(repo_root, topology, seed, "train")
            validate_dataset(train_dataset)
            validate_gpp_config(
                read_yaml(train_config_path),
                path=train_config_path,
                stage="train",
                run_id=train_run_id,
                topology=topology,
                seed=seed,
                dataset_dir=train_dataset,
                model_path=None,
            )

            token = checkpoint_token(model_path)
            eval_run_id = (
                f"journal_suite__{GPP_RUN_NAMESPACE}__{topology}__{SCENARIO}"
                f"__seed{seed}__eval__keval{K_MAIN}__ckpt{token}"
            )
            eval_dir = (results_root / eval_run_id).resolve()
            eval_config_path = eval_dir / "config.yaml"
            summary_path = eval_dir / "summary.csv"
            test_dataset = expected_dataset(repo_root, topology, seed, "test")
            validate_dataset(test_dataset)
            validate_gpp_config(
                read_yaml(eval_config_path),
                path=eval_config_path,
                stage="eval",
                run_id=eval_run_id,
                topology=topology,
                seed=seed,
                dataset_dir=test_dataset,
                model_path=model_path,
            )
            summary = read_single_csv_row(summary_path)
            acceptance, r2c, runtime, successes = validate_summary(
                summary,
                path=summary_path,
                run_id=eval_run_id,
                solver_name=GPP_SOLVER_NAME,
                topology=topology,
                seed=seed,
                dataset_dir=test_dataset,
            )
            collected.append(
                GppResult(
                    topology=topology,
                    seed=seed,
                    acceptance_rate=acceptance,
                    long_term_r2c_ratio=r2c,
                    clock_running_time=runtime,
                    success_count=successes,
                    run_id=eval_run_id,
                    train_run_id=train_run_id,
                    summary_path=str(summary_path),
                    eval_config_path=str(eval_config_path),
                    train_config_path=str(train_config_path),
                    model_path=str(model_path),
                    model_sha256=sha256_file(model_path),
                    checkpoint_token=token,
                )
            )
    return collected


EXPECTED_ABLATION_FLAGS = {
    "full": {
        "candidate_features": True,
        "reachability_filter": True,
        "defer_link_routing": False,
        "virtual_node_order": "demand",
        "use_neural_network": True,
    },
    "no_reachability": {
        "candidate_features": True,
        "reachability_filter": False,
        "defer_link_routing": False,
        "virtual_node_order": "demand",
        "use_neural_network": True,
    },
}


def load_provenance(
    path: Path,
    *,
    stage: str,
    run_id: str,
    topology: str,
    seed: int,
    variant: str,
    dataset_dir: Path,
) -> dict[str, Any]:
    if not path.is_file():
        raise ValidationError(f"missing immutable ablation provenance: {path}")
    payload = json.loads(path.read_text())
    expected = {
        "schema_version": 1,
        "experiment": "alpha_vne_reachability_ablation",
        "stage": stage,
        "run_id": run_id,
        "topology": topology,
        "seed": seed,
        "variant": variant,
        "k_shortest": K_ABLATION,
        "mcts_simulations": MCTS_BUDGET,
        "num_v_nets": NUM_REQUESTS,
    }
    for key, wanted in expected.items():
        require_equal(f"{path}: {key}", payload.get(key), wanted)
    require_resolved_path(f"{path}: dataset_dir", payload.get("dataset_dir"), dataset_dir)
    require_equal(f"{path}: flags", payload.get("flags"), EXPECTED_ABLATION_FLAGS[variant])
    source_hashes = payload.get("source_sha256")
    if not isinstance(source_hashes, dict) or not source_hashes:
        raise ValidationError(f"{path}: source hashes are missing")
    return payload


def validate_alpha_config(
    config: Mapping[str, Any],
    *,
    path: Path,
    stage: str,
    run_id: str,
    seed: int,
    dataset_dir: Path,
    model_path: Path | None,
) -> None:
    expected = {
        "solver.solver_name": "alpha_zero_sfc",
        "solver.k_shortest": K_ABLATION,
        "experiment.run_id": run_id,
        "experiment.seed": seed,
        "training.seed": seed,
        "training.computation_budget": MCTS_BUDGET,
        "training.use_cuda": True,
        "training.pure_cpp": True,
        "training.use_cpp_mcts": True,
        "training.use_neural_network": True,
        "nn.embedding_dim": 96,
        "nn.hidden_dim": 96,
        "nn.num_gnn_layers": 2,
        "nn.n_heads": 6,
        "nn.transformer_layers": 2,
        "v_sim_setting.num_v_nets": NUM_REQUESTS,
    }
    if stage == "train":
        expected.update(
            {
                "training.inference_only": False,
                "training.num_train_epochs": 16,
                "training.max_training_steps": 3000,
                "training.min_buffer_size": 128,
                "training.num_train_steps_per_epoch": 128,
            }
        )
    else:
        expected.update(
            {
                "training.inference_only": True,
                "training.num_train_epochs": 0,
                "training.max_training_steps": 0,
            }
        )
    for key, wanted in expected.items():
        require_equal(f"{path}: {key}", nested(config, key), wanted)
    require_resolved_path(f"{path}: simulation.p_net_dataset_dir", nested(config, "simulation.p_net_dataset_dir"), dataset_dir)
    require_resolved_path(f"{path}: simulation.v_nets_dataset_dir", nested(config, "simulation.v_nets_dataset_dir"), dataset_dir)
    if stage == "eval":
        assert model_path is not None
        require_resolved_path(
            f"{path}: solver.pretrained_model_path",
            nested(config, "solver.pretrained_model_path"),
            model_path,
        )
        require_resolved_path(
            f"{path}: training.alphazero_model_path",
            nested(config, "training.alphazero_model_path"),
            model_path,
        )


def collect_ablation_variant(
    *,
    repo_root: Path,
    solver_results_root: Path,
    analysis_root: Path,
    stamp: str,
    variant: str,
    require_provenance: bool,
) -> list[AblationResult]:
    if variant not in EXPECTED_ABLATION_FLAGS:
        raise ValidationError(f"unsupported ablation variant: {variant}")
    raw_path = analysis_root / "eval_summary.csv"
    raw_rows = read_csv(raw_path)
    by_key: dict[tuple[str, int], dict[str, str]] = {}
    for row in (item for item in raw_rows if item["variant"] == variant):
        key = (row["topology"], int(row["seed"]))
        if key in by_key:
            raise ValidationError(f"duplicate ablation cell in {raw_path}: {key}")
        by_key[key] = row
    expected_keys = {
        (topology, seed)
        for topology in TOPOLOGIES
        for seed in SEEDS
    }
    if set(by_key) != expected_keys:
        missing = sorted(expected_keys - set(by_key))
        extra = sorted(set(by_key) - expected_keys)
        raise ValidationError(
            f"{variant} ablation cell mismatch in {raw_path}; missing={missing}, extra={extra}"
        )

    results: list[AblationResult] = []
    for topology, seed in sorted(expected_keys):
        row = by_key[(topology, seed)]
        require_equal("ablation k_eval", int(row["k_eval"]), K_ABLATION)
        require_equal("ablation mcts_simulations", int(row["mcts_simulations"]), MCTS_BUDGET)
        eval_run_id = (
            f"journal_suite__alpha_zero_sfc__{topology}__journal_components_k1"
            f"__{variant}__budget{MCTS_BUDGET}__seed{seed}__eval__{stamp}"
        )
        train_run_id = eval_run_id.replace("__eval__", "__train__")
        require_equal("ablation run_id", row["run_id"], eval_run_id)
        eval_dir = (solver_results_root / eval_run_id).resolve()
        train_dir = (solver_results_root / train_run_id).resolve()
        summary_path = Path(row["summary_path"]).expanduser().resolve()
        require_equal("ablation summary path", summary_path, eval_dir / "summary.csv")
        train_dataset = expected_dataset(repo_root, topology, seed, "train")
        test_dataset = expected_dataset(repo_root, topology, seed, "test")
        validate_dataset(train_dataset)
        validate_dataset(test_dataset)

        train_provenance_path = train_dir / "ablation_provenance.json"
        eval_provenance_path = eval_dir / "ablation_provenance.json"
        if require_provenance:
            train_provenance = load_provenance(
                train_provenance_path,
                stage="train",
                run_id=train_run_id,
                topology=topology,
                seed=seed,
                variant=variant,
                dataset_dir=train_dataset,
            )
            eval_provenance = load_provenance(
                eval_provenance_path,
                stage="eval",
                run_id=eval_run_id,
                topology=topology,
                seed=seed,
                variant=variant,
                dataset_dir=test_dataset,
            )
            require_equal(
                f"{topology}/seed{seed}/{variant}: train/eval source hashes",
                train_provenance["source_sha256"],
                eval_provenance["source_sha256"],
            )
            require_equal(
                f"{topology}/seed{seed}/{variant}: train/eval git commit",
                train_provenance["git_commit"],
                eval_provenance["git_commit"],
            )
        checkpoint = train_dir / "models/policy_latest.pt"
        if not checkpoint.is_file() or checkpoint.stat().st_size <= 0:
            raise ValidationError(f"missing ablation checkpoint: {checkpoint}")
        train_config_path = train_dir / "config.yaml"
        eval_config_path = eval_dir / "config.yaml"
        validate_alpha_config(
            read_yaml(train_config_path),
            path=train_config_path,
            stage="train",
            run_id=train_run_id,
            seed=seed,
            dataset_dir=train_dataset,
            model_path=None,
        )
        eval_model_path = (
            analysis_root / "extracted_models" / f"{topology}_{variant}_seed{seed}_weights.pt"
        ).resolve()
        if not eval_model_path.is_file() or eval_model_path.stat().st_size <= 0:
            raise ValidationError(f"missing ablation evaluation weights: {eval_model_path}")
        validate_alpha_config(
            read_yaml(eval_config_path),
            path=eval_config_path,
            stage="eval",
            run_id=eval_run_id,
            seed=seed,
            dataset_dir=test_dataset,
            model_path=eval_model_path,
        )
        summary = read_single_csv_row(summary_path)
        acceptance, r2c, runtime, successes = validate_summary(
            summary,
            path=summary_path,
            run_id=eval_run_id,
            solver_name="alpha_zero_sfc",
            topology=topology,
            seed=seed,
            dataset_dir=test_dataset,
        )
        require_close("ablation raw acceptance", float(row["acceptance_rate"]), acceptance)
        require_close("ablation raw R/C", float(row["long_term_r2c_ratio"]), r2c)
        require_close("ablation raw runtime", float(row["clock_running_time"]), runtime)
        require_equal("ablation raw success_count", int(row["success_count"]), successes)
        results.append(
            AblationResult(
                topology=topology,
                seed=seed,
                variant=variant,
                acceptance_rate=acceptance,
                long_term_r2c_ratio=r2c,
                clock_running_time=runtime,
                success_count=successes,
                run_id=eval_run_id,
                train_run_id=train_run_id,
                model_path=str(eval_model_path),
                summary_path=str(summary_path),
                eval_provenance_path=(str(eval_provenance_path) if require_provenance else ""),
                train_provenance_path=(str(train_provenance_path) if require_provenance else ""),
            )
        )
    return results


def aggregate_ablation(rows: Sequence[AblationResult]) -> tuple[list[dict[str, Any]], list[dict[str, Any]]]:
    aggregates: list[dict[str, Any]] = []
    paired: list[dict[str, Any]] = []
    for topology in TOPOLOGIES:
        for variant in EXPECTED_ABLATION_FLAGS:
            group = [r for r in rows if r.topology == topology and r.variant == variant]
            if len(group) != len(SEEDS):
                raise ValidationError(f"incomplete {topology}/{variant} aggregate")
            aggregates.append(
                {
                    "topology": topology,
                    "variant": variant,
                    "seeds": len(group),
                    "acceptance_mean": mean([r.acceptance_rate for r in group]),
                    "acceptance_sample_std": sample_std([r.acceptance_rate for r in group]),
                    "long_term_r2c_mean": mean([r.long_term_r2c_ratio for r in group]),
                    "runtime_mean_seconds": mean([r.clock_running_time for r in group]),
                }
            )
        by_key = {(r.seed, r.variant): r for r in rows if r.topology == topology}
        differences = [
            by_key[(seed, "full")].acceptance_rate
            - by_key[(seed, "no_reachability")].acceptance_rate
            for seed in SEEDS
        ]
        low, high = ci95(differences)
        paired.append(
            {
                "topology": topology,
                "ablation_variant": "no_reachability",
                "matched_seeds": len(differences),
                "full_minus_ablation_mean": mean(differences),
                "paired_difference_sample_std": sample_std(differences),
                "ci95_low": low,
                "ci95_high": high,
            }
        )
    return aggregates, paired


def render_reachability_table(
    aggregates: Sequence[Mapping[str, Any]], paired: Sequence[Mapping[str, Any]]
) -> str:
    aggregate_map = {(row["topology"], row["variant"]): row for row in aggregates}
    paired_map = {row["topology"]: row for row in paired}
    lines = [
        r"\begin{table*}[!t]",
        r"\centering",
        r"\small",
        r"\caption{Five-seed reachability-filter ablation at $k=1$ and $96$ MCTS simulations per placement decision. Both variants are retrained under their evaluated configuration. No reachability filter disables only the residual-bandwidth connectivity screen before expansion; incremental link routing, reservation, and all other components remain enabled. The final column is the matched-seed acceptance difference with a $95\%$ $t$-interval.}",
        r"\label{tab:reachability_ablation}",
        r"\begin{tabular}{llcccc}",
        r"\toprule",
        "Topology & Variant & Acceptance & Long-term R/C & Runtime (s) & "
        "Full minus variant $[95\\%\\ \\mathrm{CI}]$ \\\\",
        r"\midrule",
    ]
    for topology_index, topology in enumerate(TOPOLOGIES):
        full = aggregate_map[(topology, "full")]
        no_reach = aggregate_map[(topology, "no_reachability")]
        delta = paired_map[topology]
        lines.append(
            f"{topology.upper()} & Full \\alphavne{{}} & "
            f"$\\mathbf{{{float(full['acceptance_mean']):.3f} \\pm {float(full['acceptance_sample_std']):.3f}}}$ & "
            f"{float(full['long_term_r2c_mean']):.3f} & {float(full['runtime_mean_seconds']):.1f} & -- \\\\"
        )
        lines.append(
            f"{topology.upper()} & No reachability filter & "
            f"${float(no_reach['acceptance_mean']):.3f} \\pm {float(no_reach['acceptance_sample_std']):.3f}$ & "
            f"{float(no_reach['long_term_r2c_mean']):.3f} & {float(no_reach['runtime_mean_seconds']):.1f} & "
            f"${float(delta['full_minus_ablation_mean']):+.3f} "
            f"[{float(delta['ci95_low']):+.3f},\\,{float(delta['ci95_high']):+.3f}]$ \\\\"
        )
        if topology_index == 0:
            lines.append(r"\midrule")
    lines.extend([r"\bottomrule", r"\end{tabular}", r"\end{table*}", ""])
    return "\n".join(lines)


def render_reachability_row(
    topology: str,
    aggregates: Sequence[Mapping[str, Any]],
    paired: Sequence[Mapping[str, Any]],
) -> str:
    aggregate_map = {(row["topology"], row["variant"]): row for row in aggregates}
    paired_map = {row["topology"]: row for row in paired}
    no_reach = aggregate_map[(topology, "no_reachability")]
    delta = paired_map[topology]
    return (
        f"{topology.upper()} & No reachability filter & "
        f"\\({float(no_reach['acceptance_mean']):.3f} "
        f"\\pm {float(no_reach['acceptance_sample_std']):.3f}\\) & "
        f"{float(no_reach['long_term_r2c_mean']):.3f} & "
        f"{float(no_reach['runtime_mean_seconds']):.1f} & "
        f"\\({float(delta['full_minus_ablation_mean']):+.3f}\\ "
        f"[{float(delta['ci95_low']):+.3f},\\,{float(delta['ci95_high']):+.3f}]\\) \\\\"
    )


def validate_completed_full_rows(
    component_table: str,
    aggregates: Sequence[Mapping[str, Any]],
) -> None:
    """Verify that the reused Full artifacts are the rows already in the paper."""
    full_map = {
        row["topology"]: row
        for row in aggregates
        if row["variant"] == "full"
    }
    if set(full_map) != set(TOPOLOGIES):
        raise ValidationError("the reused Full aggregate is incomplete")

    for topology in TOPOLOGIES:
        prefix = f"{topology.upper()} & Full \\alphavne{{}} &"
        matches = [
            line
            for line in component_table.splitlines()
            if not line.lstrip().startswith("%") and line.startswith(prefix)
        ]
        if len(matches) != 1:
            raise ValidationError(
                f"expected one active completed Full row for {topology.upper()}, "
                f"found {len(matches)}"
            )
        cells = [cell.strip() for cell in matches[0].split("&")]
        if len(cells) != 6:
            raise ValidationError(f"cannot parse completed Full row: {matches[0]}")
        acceptance = [float(value) for value in re.findall(r"(?:0|1)\.\d+", cells[2])]
        if len(acceptance) < 2:
            raise ValidationError(f"cannot parse completed Full acceptance: {matches[0]}")
        expected = full_map[topology]
        require_close(
            f"{topology} completed Full acceptance mean",
            acceptance[0],
            float(expected["acceptance_mean"]),
            tolerance=0.000500001,
        )
        require_close(
            f"{topology} completed Full acceptance standard deviation",
            acceptance[1],
            float(expected["acceptance_sample_std"]),
            tolerance=0.000500001,
        )
        require_close(
            f"{topology} completed Full long-term R/C",
            float(cells[3]),
            float(expected["long_term_r2c_mean"]),
            tolerance=0.000500001,
        )
        require_close(
            f"{topology} completed Full runtime",
            float(cells[4]),
            float(expected["runtime_mean_seconds"]),
            tolerance=0.050001,
        )


def inject_reachability_rows(
    component_table: str,
    aggregates: Sequence[Mapping[str, Any]],
    paired: Sequence[Mapping[str, Any]],
) -> str:
    """Append only the missing no-reachability rows to the current ablation table."""
    validate_completed_full_rows(component_table, aggregates)
    lines = [
        line
        for line in component_table.splitlines()
        if line.lstrip().startswith("%") or "& No reachability filter &" not in line
    ]
    caption_note = (
        " The no-reachability variant disables only the residual-bandwidth "
        "connectivity screen before expansion; incremental routing and reservation "
        "remain enabled."
    )
    for index, line in enumerate(lines):
        if line.startswith(r"\caption{") and "The no-reachability variant" not in line:
            if not line.rstrip().endswith("}"):
                raise ValidationError("the component-ablation caption is not single-line")
            lines[index] = line.rstrip()[:-1] + caption_note + "}"
            break
    else:
        if not any("The no-reachability variant" in line for line in lines):
            raise ValidationError("could not locate the component-ablation caption")

    output: list[str] = []
    inserted: set[str] = set()
    for line in lines:
        output.append(line)
        if line.lstrip().startswith("%"):
            continue
        for topology in TOPOLOGIES:
            if line.startswith(f"{topology.upper()} & Deferred routing &"):
                output.append(render_reachability_row(topology, aggregates, paired))
                inserted.add(topology)
    if inserted != set(TOPOLOGIES):
        raise ValidationError(
            "could not place no-reachability rows for "
            f"{sorted(set(TOPOLOGIES) - inserted)}"
        )
    return "\n".join(output) + "\n"


def render_gpp_row(topology: str, row: Mapping[str, Any]) -> str:
    return (
        f"{topology.upper()} & GPPVNE-R & {K_MAIN} & "
        f"\\({float(row['acceptance_mean']):.3f} \\pm {float(row['acceptance_sample_std']):.3f}\\) & "
        f"{float(row['long_term_r2c_mean']):.3f} & {float(row['runtime_mean_seconds']):.1f} \\\\"
    )


def inject_gpp_rows(main_table: str, gpp_aggregates: Sequence[Mapping[str, Any]]) -> str:
    aggregate_map = {row["topology"]: row for row in gpp_aggregates}
    lines = [
        line
        for line in main_table.splitlines()
        if line.lstrip().startswith("%") or "& GPPVNE-R &" not in line
    ]
    caption_note = (
        r" GPPVNE-R denotes our independent reproduction of GPPVNE~\cite{ali2025gatppo} "
        r"under the same datasets and evaluation protocol; implementation choices not "
        r"specified by the source paper are disclosed with the artifact."
    )
    for index, line in enumerate(lines):
        if line.startswith(r"\caption{") and "GPPVNE-R denotes" not in line:
            if not line.rstrip().endswith("}"):
                raise ValidationError("the active main-comparison caption is not single-line")
            lines[index] = line.rstrip()[:-1] + caption_note + "}"
            break
    else:
        if not any("GPPVNE-R denotes" in line for line in lines):
            raise ValidationError("could not locate active main-comparison caption")

    inserted: set[str] = set()
    output: list[str] = []
    for line in lines:
        output.append(line)
        if line.lstrip().startswith("%"):
            continue
        for topology in TOPOLOGIES:
            if line.startswith(topology.upper() + " & PPO-Dual-GCN+"):
                output.append(render_gpp_row(topology, aggregate_map[topology]))
                inserted.add(topology)
    if inserted != set(TOPOLOGIES):
        raise ValidationError(f"could not place GPPVNE rows for {sorted(set(TOPOLOGIES) - inserted)}")
    return "\n".join(output) + "\n"


def parse_active_main_rows(table: str) -> list[dict[str, Any]]:
    rows: list[dict[str, Any]] = []
    for line in table.splitlines():
        if line.lstrip().startswith("%") or not line.startswith(("BRAIN &", "GEANT &")):
            continue
        cells = [cell.strip() for cell in line.split("&")]
        if len(cells) < 6 or cells[2] != str(K_MAIN):
            continue
        acceptance_match = re.search(r"(?:0|1)\.\d+", cells[3])
        r2c_match = re.search(r"(?:0|1)\.\d+", cells[4])
        if not acceptance_match or not r2c_match:
            raise ValidationError(f"cannot parse active main-comparison row: {line}")
        rows.append(
            {
                "topology": cells[0].lower(),
                "method_tex": cells[1],
                "acceptance": float(acceptance_match.group()),
                "r2c": float(r2c_match.group()),
            }
        )
    if len(rows) < 2:
        raise ValidationError("no active rows parsed from the main comparison table")
    return rows


def assess_publication(
    *,
    candidate_main: str,
    canonical_alpha_per_seed: Path,
) -> tuple[list[str], list[str]]:
    rows = parse_active_main_rows(candidate_main)
    warnings: list[str] = []
    blockers: list[str] = []
    for topology in TOPOLOGIES:
        subset = [row for row in rows if row["topology"] == topology]
        alpha = next((row for row in subset if r"\alphavne" in row["method_tex"]), None)
        gpp = next((row for row in subset if "GPPVNE-R" in row["method_tex"]), None)
        if alpha is None or gpp is None:
            raise ValidationError(f"missing AlphaVNE/GPPVNE-R row for {topology}")
        prior = [
            row
            for row in subset
            if row is not alpha and row is not gpp
        ]
        best_prior = max(prior, key=lambda row: row["acceptance"])
        if gpp["acceptance"] > best_prior["acceptance"] + 0.0005:
            blockers.append(
                f"{topology.upper()}: GPPVNE-R ({gpp['acceptance']:.3f}) becomes the strongest "
                f"baseline, replacing {best_prior['method_tex']} ({best_prior['acceptance']:.3f}); "
                "headline and paired-best-baseline tables must be regenerated from matching "
                "AlphaVNE per-seed provenance before publication."
            )
        if gpp["r2c"] > alpha["r2c"] + 0.0005:
            warnings.append(
                f"Secondary-metric note for {topology.upper()}: GPPVNE-R R/C "
                f"({gpp['r2c']:.3f}) exceeds the displayed AlphaVNE R/C "
                f"({alpha['r2c']:.3f}). This does not change the acceptance ranking, but "
                "the paper must not claim that AlphaVNE has the highest R/C on this topology."
            )

    if canonical_alpha_per_seed.is_file():
        canonical = read_csv(canonical_alpha_per_seed)
        for topology in TOPOLOGIES:
            values = [
                float(row["acceptance_rate"])
                for row in canonical
                if row.get("topology") == topology
            ]
            if not values:
                continue
            canonical_mean = mean(values)
            active_alpha = next(
                row["acceptance"]
                for row in rows
                if row["topology"] == topology and r"\alphavne" in row["method_tex"]
            )
            if not math.isclose(canonical_mean, active_alpha, abs_tol=0.0005, rel_tol=0.0):
                warnings.append(
                    f"Existing paper provenance mismatch for {topology.upper()}: the active "
                    f"AlphaVNE row is {active_alpha:.3f}, while {canonical_alpha_per_seed} "
                    f"aggregates to {canonical_mean:.3f}. The publisher preserves the active "
                    "row but cannot certify it."
                )
    return warnings, blockers


def backup_once(source: Path, backup: Path) -> None:
    if source.exists() and not backup.exists():
        backup.parent.mkdir(parents=True, exist_ok=True)
        shutil.copy2(source, backup)


def render_report(
    *,
    gpp_aggregates: Sequence[Mapping[str, Any]],
    ablation_aggregates: Sequence[Mapping[str, Any]],
    paired: Sequence[Mapping[str, Any]],
    warnings: Sequence[str],
    blockers: Sequence[str],
    published: bool,
    paper_dir: Path,
    full_reference_stamp: str,
    no_reachability_stamp: str,
) -> str:
    lines = [
        "# InfoCom benchmark additions",
        "",
        f"- Validation time (UTC): `{datetime.now(timezone.utc).isoformat()}`",
        f"- Paper target: `{paper_dir}`",
        f"- Paper files published: `{'yes' if published else 'no'}`",
        "- GPPVNE-R is an independent reproduction, not the authors' implementation.",
        f"- Reused completed Full AlphaVNE cells: `{full_reference_stamp}` (no rerun).",
        f"- Newly computed no-reachability cells: `{no_reachability_stamp}`.",
        "- Both sides of the reachability comparison use five matched seeds and exactly "
        "1,000 test requests per seed.",
        "",
        "## GPPVNE-R matched benchmark (k=10)",
        "",
        "| Topology | Seeds | Acceptance | Long-term R/C | Runtime (s) |",
        "| --- | ---: | ---: | ---: | ---: |",
    ]
    for row in gpp_aggregates:
        lines.append(
            f"| {str(row['topology']).upper()} | {row['seeds']} | "
            f"{float(row['acceptance_mean']):.3f} ± {float(row['acceptance_sample_std']):.3f} | "
            f"{float(row['long_term_r2c_mean']):.3f} | {float(row['runtime_mean_seconds']):.1f} |"
        )
    lines.extend(
        [
            "",
            "## Reachability-filter ablation (k=1, 96 MCTS simulations)",
            "",
            "| Topology | Variant | Seeds | Acceptance | Long-term R/C | Runtime (s) |",
            "| --- | --- | ---: | ---: | ---: | ---: |",
        ]
    )
    for row in ablation_aggregates:
        label = "Full AlphaVNE" if row["variant"] == "full" else "No reachability filter"
        lines.append(
            f"| {str(row['topology']).upper()} | {label} | {row['seeds']} | "
            f"{float(row['acceptance_mean']):.3f} ± {float(row['acceptance_sample_std']):.3f} | "
            f"{float(row['long_term_r2c_mean']):.3f} | {float(row['runtime_mean_seconds']):.1f} |"
        )
    lines.extend(
        [
            "",
            "## Matched Full minus no-reachability effect",
            "",
            "| Topology | Seeds | Difference | 95% CI |",
            "| --- | ---: | ---: | ---: |",
        ]
    )
    for row in paired:
        lines.append(
            f"| {str(row['topology']).upper()} | {row['matched_seeds']} | "
            f"{float(row['full_minus_ablation_mean']):+.3f} | "
            f"[{float(row['ci95_low']):+.3f}, {float(row['ci95_high']):+.3f}] |"
        )
    if warnings:
        lines.extend(["", "## Warnings", ""])
        lines.extend(f"- {item}" for item in warnings)
    if blockers:
        lines.extend(["", "## Publication blockers", ""])
        lines.extend(f"- {item}" for item in blockers)
    lines.extend(
        [
            "",
            "## Paper consistency requirements",
            "",
            "Keep the narrative synchronized with these tables: identify GPPVNE-R as an "
            "independent reproduction, treat R/C as secondary, and distinguish the null "
            "reachability-screen acceptance result from the significant incremental-routing "
            "ablation.",
            "",
        ]
    )
    return "\n".join(lines)


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--gpp-results-root",
        type=Path,
        default=ROOT / "results/journal_suite/results/gpp_vne",
    )
    parser.add_argument(
        "--model-registry",
        type=Path,
        default=ROOT / "results/journal_suite/model_registry.csv",
    )
    parser.add_argument(
        "--alpha-solver-results-root",
        type=Path,
        default=ROOT / "results/journal_suite/results/alpha_zero_sfc",
    )
    parser.add_argument("--ablation-analysis-root", type=Path, required=True)
    parser.add_argument("--ablation-stamp", required=True)
    parser.add_argument("--full-reference-analysis-root", type=Path, required=True)
    parser.add_argument("--full-reference-stamp", required=True)
    parser.add_argument("--analysis-root", type=Path, required=True)
    parser.add_argument(
        "--paper-dir",
        type=Path,
        default=ROOT / "paperjournal/versions/overleaf_7.17.2026",
    )
    parser.add_argument(
        "--paper-results-data-dir",
        type=Path,
        default=ROOT / "paperjournal/results_data",
    )
    parser.add_argument("--publish", action="store_true")
    args = parser.parse_args()

    analysis_root = args.analysis_root.resolve()
    candidates_dir = analysis_root / "paper_candidates"
    candidates_dir.mkdir(parents=True, exist_ok=True)
    paper_dir = args.paper_dir.resolve()
    paper_results_data_dir = args.paper_results_data_dir.resolve()
    main_table_path = paper_dir / "tables/main_comparison.tex"
    component_table_path = paper_dir / "tables/component_ablation.tex"
    if not main_table_path.is_file() or not component_table_path.is_file():
        raise ValidationError(f"paper target is incomplete: {paper_dir}")

    gpp_rows = collect_gpp(
        repo_root=ROOT,
        results_root=args.gpp_results_root.resolve(),
        registry_path=args.model_registry.resolve(),
    )
    gpp_aggregates = [aggregate(gpp_rows, topology) for topology in TOPOLOGIES]
    full_rows = collect_ablation_variant(
        repo_root=ROOT,
        solver_results_root=args.alpha_solver_results_root.resolve(),
        analysis_root=args.full_reference_analysis_root.resolve(),
        stamp=args.full_reference_stamp,
        variant="full",
        require_provenance=False,
    )
    no_reachability_rows = collect_ablation_variant(
        repo_root=ROOT,
        solver_results_root=args.alpha_solver_results_root.resolve(),
        analysis_root=args.ablation_analysis_root.resolve(),
        stamp=args.ablation_stamp,
        variant="no_reachability",
        require_provenance=True,
    )
    ablation_rows = full_rows + no_reachability_rows
    ablation_aggregates, paired = aggregate_ablation(ablation_rows)

    gpp_per_seed_path = analysis_root / "gpp_vne_infocom_per_seed.csv"
    gpp_aggregate_path = analysis_root / "gpp_vne_infocom_aggregate.csv"
    ablation_per_seed_path = analysis_root / "reachability_ablation_per_seed.csv"
    ablation_aggregate_path = analysis_root / "reachability_ablation_aggregate.csv"
    ablation_paired_path = analysis_root / "reachability_ablation_paired.csv"
    write_csv_atomic(gpp_per_seed_path, [asdict(row) for row in gpp_rows], list(asdict(gpp_rows[0])))
    write_csv_atomic(gpp_aggregate_path, gpp_aggregates, list(gpp_aggregates[0]))
    write_csv_atomic(ablation_per_seed_path, [asdict(row) for row in ablation_rows], list(asdict(ablation_rows[0])))
    write_csv_atomic(ablation_aggregate_path, ablation_aggregates, list(ablation_aggregates[0]))
    write_csv_atomic(ablation_paired_path, paired, list(paired[0]))

    candidate_main_text = inject_gpp_rows(main_table_path.read_text(), gpp_aggregates)
    candidate_main = candidates_dir / "main_comparison.tex"
    write_text_atomic(candidate_main, candidate_main_text)
    candidate_component_text = inject_reachability_rows(
        component_table_path.read_text(),
        ablation_aggregates,
        paired,
    )
    candidate_component = candidates_dir / "component_ablation.tex"
    write_text_atomic(candidate_component, candidate_component_text)

    warnings, blockers = assess_publication(
        candidate_main=candidate_main_text,
        canonical_alpha_per_seed=ROOT / "paperjournal/results_data/new_alpha_per_seed.csv",
    )

    manifest = {
        "schema_version": 1,
        "generated_at_utc": datetime.now(timezone.utc).isoformat(),
        "gpp_method_key": GPP_METHOD_KEY,
        "gpp_run_namespace": GPP_RUN_NAMESPACE,
        "no_reachability_stamp": args.ablation_stamp,
        "full_reference_stamp": args.full_reference_stamp,
        "paper_dir": str(paper_dir),
        "gpp_rows": [asdict(row) for row in gpp_rows],
        "ablation_rows": [asdict(row) for row in ablation_rows],
        "warnings": warnings,
        "publication_blockers": blockers,
    }
    write_text_atomic(
        analysis_root / "source_manifest.json",
        json.dumps(manifest, indent=2, sort_keys=True) + "\n",
    )

    published = False
    if args.publish and not blockers:
        backup_root = analysis_root / "paper_backups"
        publish_targets = {
            candidate_main: main_table_path,
            candidate_component: component_table_path,
            gpp_per_seed_path: paper_results_data_dir / "gpp_vne_infocom_per_seed.csv",
            gpp_aggregate_path: paper_results_data_dir / "gpp_vne_infocom_aggregate.csv",
            ablation_per_seed_path: paper_results_data_dir / "reachability_ablation_per_seed.csv",
            ablation_aggregate_path: paper_results_data_dir / "reachability_ablation_aggregate.csv",
            ablation_paired_path: paper_results_data_dir / "reachability_ablation_paired.csv",
        }
        for source, destination in publish_targets.items():
            if destination.is_relative_to(paper_dir):
                relative = Path("paper") / destination.relative_to(paper_dir)
            else:
                relative = Path("results_data") / destination.name
            backup_once(destination, backup_root / relative)
            copy_atomic(source, destination)
        published = True

    report = render_report(
        gpp_aggregates=gpp_aggregates,
        ablation_aggregates=ablation_aggregates,
        paired=paired,
        warnings=warnings,
        blockers=blockers,
        published=published,
        paper_dir=paper_dir,
        full_reference_stamp=args.full_reference_stamp,
        no_reachability_stamp=args.ablation_stamp,
    )
    report_path = analysis_root / "report.md"
    write_text_atomic(report_path, report)
    if published:
        destination = paper_results_data_dir / "infocom_benchmark_update_report.md"
        backup_once(destination, analysis_root / "paper_backups/results_data" / destination.name)
        copy_atomic(report_path, destination)

    print(f"validated GPPVNE-R cells: {len(gpp_rows)}")
    print(f"validated completed Full reference cells (reused): {len(full_rows)}")
    print(f"validated new no-reachability cells: {len(no_reachability_rows)}")
    print(f"candidate tables: {candidates_dir}")
    print(f"report: {report_path}")
    if blockers:
        for blocker in blockers:
            print(f"PUBLICATION BLOCKER: {blocker}", file=sys.stderr)
        if args.publish:
            raise PublicationBlocked(
                "validated candidates were written, but paper files were not changed"
            )
    elif args.publish:
        print(f"published tables to: {paper_dir}")
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except (ValidationError, PublicationBlocked) as exc:
        print(f"error: {exc}", file=sys.stderr)
        raise SystemExit(2)
