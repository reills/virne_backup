#!/usr/bin/env python3
from __future__ import annotations

import argparse
import json
from datetime import datetime, timezone
from pathlib import Path


METHOD_TO_SOLVER_DIR = {
    "alpha_zero_sfc": "alpha_zero_sfc",
    "ppo_dual_gcn_plus": "ppo_dual_gcn+",
    "ppo_mlp_plus": "ppo_mlp+",
}

METHOD_MODEL_CANDIDATES = {
    "alpha_zero_sfc": ("policy_latest.pt", "policy_latest.ts"),
    "ppo_dual_gcn_plus": ("model.pkl",),
    "ppo_mlp_plus": ("model.pkl",),
}


def _parse_items(raw: str) -> list[str]:
    return [part.strip() for part in raw.replace(",", " ").split() if part.strip()]


def _solver_token(solver_dir: str) -> str:
    return solver_dir.replace("+", "plus")


def _latest_model_for_seed(
    *,
    results_root: Path,
    method: str,
    topology: str,
    scenario: str,
    seed: int,
    k_train: int,
) -> Path | None:
    solver_dir = METHOD_TO_SOLVER_DIR.get(method)
    if solver_dir is None:
        return None
    solver_token = _solver_token(solver_dir)
    run_glob = (
        f"journal_suite__{solver_token}__{topology}__{scenario}__"
        f"seed{seed}__train__ktrain{k_train}*/models"
    )
    candidates: list[Path] = []
    for model_dir in (results_root / solver_dir).glob(run_glob):
        for filename in METHOD_MODEL_CANDIDATES[method]:
            model_path = model_dir / filename
            if model_path.is_file() and model_path.stat().st_size > 0:
                candidates.append(model_path.resolve())
    if not candidates:
        return None
    candidates.sort(key=lambda path: path.stat().st_mtime)
    return candidates[-1]


def _write_shard(
    *,
    shards_dir: Path,
    method: str,
    topology: str,
    scenario: str,
    seed: int,
    k_train: int,
    model_path: Path,
) -> Path:
    solver_dir = METHOD_TO_SOLVER_DIR[method]
    solver_token = _solver_token(solver_dir)
    run_id = (
        f"journal_suite__{solver_token}__{topology}__{scenario}__"
        f"seed{seed}__train__ktrain{k_train}__existing_model"
    )
    row = {
        "method": method,
        "solver_name": solver_dir,
        "topology": topology,
        "scenario": scenario,
        "seed": str(seed),
        "k_train": str(k_train),
        "model_path": str(model_path),
        "run_id": run_id,
        "updated_at_utc": datetime.now(timezone.utc).isoformat(),
    }
    shards_dir.mkdir(parents=True, exist_ok=True)
    shard_path = shards_dir / f"{run_id}.json"
    shard_path.write_text(json.dumps(row, indent=2, sort_keys=True) + "\n")
    return shard_path


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--results-root", default="results/journal_suite/results")
    parser.add_argument("--shards-dir", default="results/journal_suite/model_registry_shards")
    parser.add_argument("--topology-key", default="wx100")
    parser.add_argument("--scenario-key", default="nominal")
    parser.add_argument("--methods", default="alpha_zero_sfc ppo_dual_gcn_plus ppo_mlp_plus")
    parser.add_argument("--seeds", default="0 1 2")
    parser.add_argument("--k-train", type=int, default=10)
    args = parser.parse_args()

    results_root = Path(args.results_root)
    shards_dir = Path(args.shards_dir)
    methods = [
        method for method in _parse_items(args.methods)
        if method in METHOD_TO_SOLVER_DIR
    ]
    seeds = [int(seed) for seed in _parse_items(args.seeds)]

    missing: list[str] = []
    for method in methods:
        for seed in seeds:
            model_path = _latest_model_for_seed(
                results_root=results_root,
                method=method,
                topology=args.topology_key,
                scenario=args.scenario_key,
                seed=seed,
                k_train=args.k_train,
            )
            if model_path is None:
                missing.append(f"{method}/{args.topology_key}/{args.scenario_key}/seed{seed}")
                continue
            shard_path = _write_shard(
                shards_dir=shards_dir,
                method=method,
                topology=args.topology_key,
                scenario=args.scenario_key,
                seed=seed,
                k_train=args.k_train,
                model_path=model_path,
            )
            print(f"registered {method} seed={seed}: {model_path} -> {shard_path}")

    if missing:
        print("missing existing model files:")
        for item in missing:
            print(f"  {item}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
