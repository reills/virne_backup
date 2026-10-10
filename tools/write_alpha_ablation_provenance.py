#!/usr/bin/env python3
"""Write or verify immutable provenance for an AlphaVNE ablation run."""

from __future__ import annotations

import argparse
import hashlib
import json
import os
import subprocess
from datetime import datetime, timezone
from pathlib import Path
from typing import Any


ROOT = Path(__file__).resolve().parents[1]
ALPHA_ROOT = ROOT / "virne/solver/learning/reinforcement_learning/alpha_vne"
CPP_ROOT = ALPHA_ROOT / "cpp_core"
SOURCE_FILES = (
    ROOT / "tools/run_alpha_journal_component_ablation_k1.sh",
    *sorted(ALPHA_ROOT.glob("*.py")),
    *sorted(CPP_ROOT.rglob("*.cpp")),
    *sorted(CPP_ROOT.rglob("*.h")),
    *sorted(CPP_ROOT.rglob("*.hpp")),
)


def sha256_file(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as handle:
        for chunk in iter(lambda: handle.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def git_commit() -> str:
    result = subprocess.run(
        ["git", "rev-parse", "HEAD"],
        cwd=ROOT,
        check=False,
        capture_output=True,
        text=True,
    )
    return result.stdout.strip() if result.returncode == 0 else "unknown"


def parse_bool(value: str) -> bool:
    normalized = value.strip().lower()
    if normalized in {"1", "true", "yes", "on"}:
        return True
    if normalized in {"0", "false", "no", "off"}:
        return False
    raise argparse.ArgumentTypeError(f"expected a boolean, got {value!r}")


def comparable(payload: dict[str, Any]) -> dict[str, Any]:
    return {key: value for key, value in payload.items() if key != "created_at_utc"}


def write_atomic(path: Path, payload: dict[str, Any]) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    temporary = path.with_name(f".{path.name}.tmp.{os.getpid()}")
    temporary.write_text(json.dumps(payload, indent=2, sort_keys=True) + "\n")
    os.replace(temporary, path)


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--output", type=Path, required=True)
    parser.add_argument("--stage", choices=("train", "eval"), required=True)
    parser.add_argument("--run-id", required=True)
    parser.add_argument("--topology", choices=("brain", "geant"), required=True)
    parser.add_argument("--seed", type=int, required=True)
    parser.add_argument("--variant", required=True)
    parser.add_argument("--dataset-dir", type=Path, required=True)
    parser.add_argument("--k", type=int, required=True)
    parser.add_argument("--budget", type=int, required=True)
    parser.add_argument("--num-v-nets", type=int, required=True)
    parser.add_argument("--candidate-features", type=parse_bool, required=True)
    parser.add_argument("--reachability-filter", type=parse_bool, required=True)
    parser.add_argument("--defer-link-routing", type=parse_bool, required=True)
    parser.add_argument("--virtual-node-order", required=True)
    parser.add_argument("--use-neural-network", type=parse_bool, required=True)
    parser.add_argument("--require-existing", action="store_true")
    args = parser.parse_args()

    source_hashes = {}
    for path in SOURCE_FILES:
        if not path.is_file():
            raise FileNotFoundError(f"required source file is missing: {path}")
        source_hashes[str(path.relative_to(ROOT))] = sha256_file(path)

    payload = {
        "schema_version": 1,
        "experiment": "alpha_vne_reachability_ablation",
        "stage": args.stage,
        "run_id": args.run_id,
        "topology": args.topology,
        "seed": args.seed,
        "variant": args.variant,
        "dataset_dir": str(args.dataset_dir.resolve()),
        "k_shortest": args.k,
        "mcts_simulations": args.budget,
        "num_v_nets": args.num_v_nets,
        "flags": {
            "candidate_features": args.candidate_features,
            "reachability_filter": args.reachability_filter,
            "defer_link_routing": args.defer_link_routing,
            "virtual_node_order": args.virtual_node_order,
            "use_neural_network": args.use_neural_network,
        },
        "git_commit": git_commit(),
        "source_sha256": source_hashes,
        "created_at_utc": datetime.now(timezone.utc).isoformat(),
    }

    output = args.output.resolve()
    if output.exists():
        existing = json.loads(output.read_text())
        if comparable(existing) != comparable(payload):
            raise RuntimeError(
                "existing ablation provenance does not match the requested run; "
                f"use a new STAMP instead of mixing configurations in {output}"
            )
        print(f"verified {output}")
        return

    if args.require_existing:
        raise FileNotFoundError(
            f"completed run has no immutable ablation provenance: {output}; "
            "use a new STAMP to rerun it"
        )
    write_atomic(output, payload)
    print(f"wrote {output}")


if __name__ == "__main__":
    main()
