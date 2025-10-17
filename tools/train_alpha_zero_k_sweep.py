#!/usr/bin/env python3
"""
Train AlphaZero SFC models for multiple k-shortest-path settings in parallel.

Prerequisites:
    conda activate virne
    python tools/train_alpha_zero_k_sweep.py
"""
from __future__ import annotations

import argparse
import datetime as dt
import shutil
import subprocess
import sys
import time
from collections import deque
import os
from pathlib import Path
from typing import IO, Iterable, List


def parse_k_values(spec: str) -> List[int]:
    """Parse comma and range based k specification like '1-5,7,9'."""
    values: List[int] = []
    for part in spec.split(","):
        part = part.strip()
        if not part:
            continue
        if "-" in part:
            start, end = part.split("-", 1)
            values.extend(range(int(start), int(end) + 1))
        else:
            values.append(int(part))
    return sorted(dict.fromkeys(values))


def build_command(
    python_exe: str,
    main_script: Path,
    run_id: str,
    k_val: int,
    save_root: Path,
    dataset_dir: Path,
    num_epochs: int,
    steps_per_epoch: int,
    max_train_steps: int,
    num_vnets: int | None,
    extra_overrides: List[str],
) -> List[str]:
    """Compose the virne.main command with Hydra overrides."""
    cmd: List[str] = [
        python_exe,
        str(main_script),
        "solver.solver_name=alpha_zero_sfc",
        f"solver.k_shortest={k_val}",
        f"experiment.run_id={run_id}",
        f"experiment.save_root_dir={str(save_root)}",
        f"+dir_save_dataset={str(dataset_dir)}",
        "use_fixed_dataset=true",
        "training.disable_trajectory_writing=false",
        f"training.num_train_epochs={num_epochs}",
        f"training.num_train_steps_per_epoch={steps_per_epoch}",
        f"training.max_training_steps={max_train_steps}",
    ]
    if num_vnets is not None:
        cmd.append(f"v_sim_setting.num_v_nets={num_vnets}")
    cmd.extend(extra_overrides)
    return cmd


def format_run_id(prefix: str, k_val: int) -> str:
    timestamp = dt.datetime.now().strftime("%Y%m%dT%H%M%S")
    return f"{prefix}-k{k_val:02d}-{timestamp}"


def ensure_dir(path: Path) -> None:
    path.mkdir(parents=True, exist_ok=True)


def copy_policy_artifact(run_dir: Path, k_val: int, export_dir: Path | None) -> None:
    models_dir = run_dir / "models"
    src = models_dir / "policy_latest.pt"
    if not src.exists():
        return
    dst_name = f"policy_latest_k{k_val:02d}.pt"
    dst = models_dir / dst_name
    if not dst.exists():
        shutil.copy2(src, dst)
    if export_dir is not None:
        ensure_dir(export_dir)
        export_path = export_dir / dst_name
        shutil.copy2(src, export_path)


def wait_for_processes(
    active: dict[int, tuple[subprocess.Popen, Path, Path, IO[str]]],
    poll_interval: float,
    export_dir: Path | None,
) -> Iterable[tuple[int, int]]:
    """Yield finished k values with return codes."""
    while active:
        finished: List[int] = []
        for k_val, (proc, run_dir, _, log_handle) in active.items():
            ret = proc.poll()
            if ret is None:
                continue
            copy_policy_artifact(run_dir, k_val, export_dir)
            try:
                log_handle.close()
            except Exception:
                pass
            finished.append(k_val)
            yield (k_val, ret)
        for k_val in finished:
            active.pop(k_val, None)
        if active:
            time.sleep(poll_interval)


def launch_training_jobs(args: argparse.Namespace, ks: Iterable[int]) -> None:
    repo_root = Path(__file__).resolve().parents[1]
    main_script = repo_root / "main.py"
    save_root = Path(args.save_root_dir).expanduser().resolve()
    dataset_dir = Path(args.dataset_dir).expanduser().resolve()
    if not dataset_dir.exists():
        raise FileNotFoundError(f"Dataset directory not found: {dataset_dir}")
    base_fallback = dataset_dir / "base" if (dataset_dir / "base").exists() else dataset_dir
    log_dir = Path(args.log_dir).expanduser().resolve()
    ensure_dir(log_dir)
    export_dir = Path(args.export_dir).expanduser().resolve() if args.export_dir else None
    queue = deque(ks)
    active: dict[int, tuple[subprocess.Popen, Path, Path, IO[str]]] = {}
    return_codes: dict[int, int] = {}

    base_env = os.environ.copy()
    pythonpath_root = str(repo_root)
    existing_pp = base_env.get("PYTHONPATH")
    base_env["PYTHONPATH"] = f"{pythonpath_root}:{existing_pp}" if existing_pp else pythonpath_root

    while queue or active:
        while queue and len(active) < args.max_workers:
            k_val = queue.popleft()
            k_dataset = dataset_dir / f"k{k_val:02d}"
            dataset_for_run = k_dataset if k_dataset.exists() else base_fallback
            if not dataset_for_run.exists():
                raise FileNotFoundError(f"No dataset found for k={k_val}: {dataset_for_run}")
            run_id = format_run_id(args.run_prefix, k_val)
            run_dir = save_root / "alpha_zero_sfc" / run_id
            ensure_dir(run_dir)
            log_path = log_dir / f"{run_id}.log"
            cmd = build_command(
                args.python,
                main_script,
                run_id,
                k_val,
                save_root,
                dataset_for_run,
                args.num_epochs,
                args.steps_per_epoch,
                args.max_training_steps,
                args.num_vnets,
                args.extra_overrides,
            )
            log_file = log_path.open("w")
            proc = subprocess.Popen(
                cmd,
                cwd=repo_root,
                stdout=log_file,
                stderr=subprocess.STDOUT,
                text=True,
                env=base_env,
            )
            active[k_val] = (proc, run_dir, log_path, log_file)
            print(f"[launch] k={k_val} pid={proc.pid} log={log_path}", flush=True)

        for k_val, ret in wait_for_processes(active, args.poll_interval, export_dir):
            return_codes[k_val] = ret
            status = "ok" if ret == 0 else f"fail({ret})"
            print(f"[done]   k={k_val} status={status}", flush=True)

    failures = {k: rc for k, rc in return_codes.items() if rc != 0}
    if failures:
        for k_val, rc in failures.items():
            print(f"[error] k={k_val} exited with code {rc}", flush=True)
        sys.exit(1)


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(
        description="Parallel training sweep for alpha_zero_sfc across k-shortest values.",
    )
    parser.add_argument(
        "--k-values",
        default="1-15",
        help="Comma separated list or ranges of k values (default: 1-15).",
    )
    parser.add_argument(
        "--max-workers",
        type=int,
        default=2,
        help="Maximum concurrent training jobs.",
    )
    parser.add_argument(
        "--num-epochs",
        type=int,
        default=5,
        help="Override for training.num_epochs.",
    )
    parser.add_argument(
        "--steps-per-epoch",
        type=int,
        default=100,
        help="Override for training.num_train_steps_per_epoch.",
    )
    parser.add_argument(
        "--max-training-steps",
        type=int,
        default=1000,
        help="Override for training.max_training_steps.",
    )
    parser.add_argument(
        "--num-vnets",
        type=int,
        default=None,
        help="Optional override for v_sim_setting.num_v_nets.",
    )
    parser.add_argument(
        "--run-prefix",
        default="az_k_sweep",
        help="Prefix used when constructing experiment.run_id values.",
    )
    parser.add_argument(
        "--save-root-dir",
        default="results",
        help="Root directory for Hydra experiment outputs.",
    )
    parser.add_argument(
        "--dataset-dir",
        required=True,
        help="Directory containing the fixed dataset to reuse across k.",
    )
    parser.add_argument(
        "--log-dir",
        default="results/alpha_zero_k_logs",
        help="Directory where stdout from each job is written.",
    )
    parser.add_argument(
        "--export-dir",
        default=None,
        help="Optional directory where policy_latest.pt snapshots are copied with k-specific names.",
    )
    parser.add_argument(
        "--python",
        default=sys.executable,
        help="Python interpreter to use.",
    )
    parser.add_argument(
        "--poll-interval",
        type=float,
        default=10.0,
        help="Seconds between job status checks.",
    )
    parser.add_argument(
        "--extra-overrides",
        nargs="*",
        default=[],
        help="Additional Hydra overrides passed through verbatim.",
    )
    return parser


def main() -> None:
    parser = build_parser()
    args = parser.parse_args()
    k_values = parse_k_values(args.k_values)
    if not k_values:
        print("No k values provided.", file=sys.stderr)
        sys.exit(1)
    launch_training_jobs(args, k_values)


if __name__ == "__main__":
    main()
