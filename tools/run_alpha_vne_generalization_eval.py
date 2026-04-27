#!/usr/bin/env python3
"""Evaluate final fixed AlphaVNE nominal-trained checkpoints on generalization data."""

from __future__ import annotations

import argparse
import csv
import os
import subprocess
import sys
from pathlib import Path

import torch


REPO_ROOT = Path(__file__).resolve().parents[1]
RESULTS_ROOT = REPO_ROOT / "results/journal_suite/results"
SOLVER_ROOT = RESULTS_ROOT / "alpha_zero_sfc"

FINAL_TRAIN = {
    "brain": ("brain_replay_move_fix_3k", "20260423T101342Z"),
    "geant": ("topo_replay_move_fix_3k", "20260423T225501Z"),
    "wx100": ("topo_replay_move_fix_3k", "20260424T063801Z"),
}


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--topology", default="brain", choices=sorted(FINAL_TRAIN))
    parser.add_argument("--seeds", default="0,1,2", help="Comma-separated seeds.")
    parser.add_argument("--stamp", required=True)
    parser.add_argument("--output-root", required=True)
    parser.add_argument("--num-v-nets", type=int, default=1000)
    parser.add_argument("--computation-budget", type=int, default=96)
    parser.add_argument("--resume-completed", action=argparse.BooleanOptionalAction, default=True)
    parser.add_argument("--dry-run", action="store_true")
    return parser.parse_args()


def extract_weights(src: Path, dst: Path) -> None:
    if dst.exists():
        return
    obj = torch.load(src, map_location="cpu")
    if isinstance(obj, dict):
        state = (
            obj.get("model")
            or obj.get("state_dict")
            or obj.get("model_state_dict")
            or (obj if obj and all(torch.is_tensor(v) for v in obj.values()) else None)
        )
    else:
        state = None
    if not isinstance(state, dict) or not state:
        raise RuntimeError(f"unsupported checkpoint format in {src}")
    if not all(torch.is_tensor(v) for v in state.values()):
        raise RuntimeError(f"extracted object is not a pure tensor state_dict in {src}")
    dst.parent.mkdir(parents=True, exist_ok=True)
    torch.save(state, dst)


def source_model(topology: str, seed: int) -> Path:
    arm, train_stamp = FINAL_TRAIN[topology]
    return (
        SOLVER_ROOT
        / f"journal_suite__alpha_zero_sfc__{topology}__{arm}__seed{seed}__train__ktrain10__{train_stamp}"
        / "models/policy_latest.pt"
    )


def run_eval(args: argparse.Namespace, seed: int, output_root: Path) -> dict[str, str]:
    topology = args.topology
    run_id = (
        f"journal_suite__alpha_zero_sfc__{topology}__final_alpha_vne_nominal_to_generalization"
        f"__seed{seed}__eval__keval10__{args.stamp}"
    )
    run_dir = SOLVER_ROOT / run_id
    summary_path = run_dir / "summary.csv"
    if args.resume_completed and summary_path.exists():
        print(f"reusing completed eval: {run_id}")
    else:
        src = source_model(topology, seed)
        if not src.exists():
            raise FileNotFoundError(f"missing final nominal-trained model: {src}")
        weights = output_root / "extracted_models" / f"{topology}_seed{seed}_latest_weights.pt"
        extract_weights(src, weights)

        data_dir = REPO_ROOT / f"datasets/generated/journal/generalization/{topology}/seed_{seed}/test"
        if not data_dir.is_dir():
            raise FileNotFoundError(f"missing generalization dataset: {data_dir}")

        cmd = [
            sys.executable,
            "main.py",
            "solver.shortest_method=k_shortest",
            "solver.allow_rejection=false",
            "solver.solver_name=alpha_zero_sfc",
            "solver.k_shortest=10",
            f"solver.pretrained_model_path={weights}",
            "training.if_use_random_training_seed=false",
            "training.num_workers=1",
            "training.inference_only=true",
            "training.num_train_epochs=0",
            "training.max_training_steps=0",
            "training.enable_async_learner=false",
            "training.disable_trajectory_writing=true",
            f"training.computation_budget={args.computation_budget}",
            "training.pure_cpp=true",
            "training.use_cpp_mcts=true",
            "training.use_cuda=true",
            "training.use_batched_gpu=false",
            "training.distributed_training=false",
            "training.alpha_zero_backbone=transformer",
            "training.signal_stop_event_on_learner_complete=true",
            f"training.alphazero_model_path={weights}",
            "training.resume_training=false",
            "use_fixed_dataset=true",
            "experiment.if_load_p_net=true",
            "experiment.if_load_v_nets=true",
            "experiment.num_simulations=1",
            f"experiment.seed={seed}",
            f"experiment.run_id={run_id}",
            f"experiment.save_root_dir={RESULTS_ROOT}",
            "experiment.request_timeout_sec=0.0",
            "experiment.run_watchdog_timeout_sec=0.0",
            "experiment.record_arrival_solve_time=true",
            "experiment.gpu_synchronize_timing=true",
            f"hydra.run.dir={run_dir / 'hydra'}",
            f"simulation.p_net_dataset_dir={data_dir}",
            f"simulation.v_nets_dataset_dir={data_dir}",
            f"v_sim_setting.num_v_nets={args.num_v_nets}",
            "nn.embedding_dim=96",
            "nn.hidden_dim=96",
            "nn.num_gnn_layers=2",
            "nn.n_heads=6",
            "nn.transformer_layers=2",
        ]
        print("+" + " ".join(str(part) for part in cmd))
        if not args.dry_run:
            subprocess.run(cmd, cwd=REPO_ROOT, check=True, env=os.environ.copy())
            if not summary_path.exists():
                raise FileNotFoundError(f"missing eval summary after run: {summary_path}")

    row = {
        "method": "alpha_vne_final",
        "topology": topology,
        "scenario": "nominal_to_generalization",
        "seed": str(seed),
        "k_eval": "10",
        "acceptance_rate": "",
        "long_term_r2c_ratio": "",
        "clock_running_time": "",
        "run_id": run_id,
        "summary_path": str(summary_path.relative_to(REPO_ROOT)),
    }
    if summary_path.exists():
        with summary_path.open(newline="") as handle:
            rows = list(csv.DictReader(handle))
        if rows:
            data = rows[-1]
            row["acceptance_rate"] = data.get("acceptance_rate", "")
            row["long_term_r2c_ratio"] = data.get("long_term_r2c_ratio", "")
            row["clock_running_time"] = data.get("clock_running_time", "")
    return row


def write_report(output_root: Path, rows: list[dict[str, str]]) -> None:
    summary_csv = output_root / "eval_summary.csv"
    report_md = output_root / "report.md"
    fields = [
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
    summary_csv.parent.mkdir(parents=True, exist_ok=True)
    with summary_csv.open("w", newline="") as handle:
        writer = csv.DictWriter(handle, fieldnames=fields)
        writer.writeheader()
        writer.writerows(rows)

    vals = [float(r["acceptance_rate"]) for r in rows if r["acceptance_rate"]]
    mean_text = "n/a" if not vals else f"{sum(vals) / len(vals):.3f}"
    with report_md.open("w") as handle:
        handle.write("# Final AlphaVNE Nominal-to-Generalization Eval\n\n")
        handle.write(f"Mean acceptance: {mean_text}\n\n")
        handle.write("| seed | acceptance | lrc | clock | run |\n")
        handle.write("| --- | ---: | ---: | ---: | --- |\n")
        for row in rows:
            handle.write(
                f"| {row['seed']} | {row['acceptance_rate']} | {row['long_term_r2c_ratio']} | "
                f"{row['clock_running_time']} | {row['run_id']} |\n"
            )
        handle.write(f"\n- eval summary: `{summary_csv}`\n")
    print(f"wrote {summary_csv}")
    print(f"wrote {report_md}")


def main() -> int:
    args = parse_args()
    seeds = [int(item.strip()) for item in args.seeds.split(",") if item.strip()]
    output_root = Path(args.output_root)
    rows = [run_eval(args, seed, output_root) for seed in seeds]
    if not args.dry_run:
        write_report(output_root, rows)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
