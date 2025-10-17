#!/usr/bin/env python3
"""
K-Shortest Ablation Runner for AlphaZero-SFC
============================================

Runs controlled evaluations across different `solver.k_shortest` values to
measure acceptance rate sensitivity. By default, uses a fixed test dataset,
constant random seed(s), and a fixed trained checkpoint to isolate the effect
of K on inference-time routing/feasibility and MCTS guidance.

Usage examples:

1) Evaluate a single trained checkpoint across K in {1,2,3,5,7,10,14}:
   python tools/k_shortest_ablation.py \
     --ks 1,2,3,5,7,10,14 \
     --seeds 42,43,44 \
     --num-instances 500 \
     --checkpoint results/alpha_zero_sfc/YOUR_RUN/models/policy_latest.pt

2) Auto-detect the latest AlphaZero checkpoint:
   python tools/k_shortest_ablation.py --auto-checkpoint --ks 1,2,3,5,7

Outputs: CSV at results/k_ablation/k_ablation_TIMESTAMP.csv with per-(k,seed)
metrics plus an aggregated summary.
"""
from __future__ import annotations

import argparse
import csv
import os
import time
from pathlib import Path
from typing import List, Optional

import hydra
from omegaconf import DictConfig, open_dict

from virne.system import BaseSystem
from virne.utils.config import add_simulation_into_config


def find_latest_checkpoint() -> Optional[Path]:
    base = Path("results/alpha_zero_sfc")
    if not base.exists():
        return None
    cks = list(base.glob('*/models/policy_latest.pt'))
    if not cks:
        return None
    return max(cks, key=lambda p: p.stat().st_mtime)


def run_eval_once(cfg: DictConfig) -> dict:
    """Execute a single evaluation run and return metrics dict."""
    system = BaseSystem.from_config(cfg)
    solver = system.solver
    env = system.env

    results = {
        'accepted': 0,
        'rejected': 0,
        'total_revenue': 0.0,
        'total_cost': 0.0,
        'runtimes': []
    }

    instance = env.reset(cfg.experiment.seed)
    while True:
        t0 = time.time()
        solution = solver.solve(instance)
        results['runtimes'].append(time.time() - t0)

        if solution.get('result', False):
            results['accepted'] += 1
            v_net = instance['v_net']
            revenue = system.counter.calculate_v_net_revenue(v_net)
            cost = system.counter.calculate_v_net_cost(v_net, solution)
            results['total_revenue'] += revenue
            results['total_cost'] += cost
        else:
            results['rejected'] += 1

        next_instance, _, done, _ = env.step(solution)
        if done:
            break
        instance = next_instance

    total = results['accepted'] + results['rejected']
    results['acceptance_rate'] = results['accepted'] / total if total > 0 else 0.0
    results['avg_revenue'] = results['total_revenue'] / results['accepted'] if results['accepted'] > 0 else 0.0
    results['avg_cost'] = results['total_cost'] / results['accepted'] if results['accepted'] > 0 else 0.0
    results['revenue_cost_ratio'] = results['avg_revenue'] / results['avg_cost'] if results['avg_cost'] > 0 else 0.0
    results['avg_runtime_per_instance'] = sum(results['runtimes']) / len(results['runtimes']) if results['runtimes'] else 0.0
    return results


def main():
    parser = argparse.ArgumentParser(description="AlphaZero-SFC k-shortest ablation")
    parser.add_argument('--ks', type=str, default='1,2,3,5,7,10,14',
                        help='Comma-separated list of k values to evaluate')
    parser.add_argument('--seeds', type=str, default='42,43,44',
                        help='Comma-separated list of seeds (per-k replicates)')
    parser.add_argument('--num-instances', type=int, default=300,
                        help='Number of test VNRs per run')
    parser.add_argument('--checkpoint', type=str, default='',
                        help='Path to trained policy_latest.pt (required unless --auto-checkpoint)')
    parser.add_argument('--auto-checkpoint', action='store_true', default=False,
                        help='Auto-detect latest results/alpha_zero_sfc/*/models/policy_latest.pt')
    parser.add_argument('--eval-budget', type=int, default=128,
                        help='MCTS computation_budget during evaluation')
    parser.add_argument('--gpu-batch', type=int, default=32,
                        help='GPU batch size for batched inference during eval')
    parser.add_argument('--outdir', type=str, default='results/k_ablation',
                        help='Output directory')

    args = parser.parse_args()
    ks: List[int] = [int(x) for x in args.ks.split(',') if x.strip()]
    seeds: List[int] = [int(x) for x in args.seeds.split(',') if x.strip()]

    ckpt = None
    if args.auto_checkpoint:
        ckpt = find_latest_checkpoint()
    elif args.checkpoint:
        p = Path(args.checkpoint)
        if p.exists():
            ckpt = p
    if ckpt is None:
        raise SystemExit("No checkpoint provided/found. Use --checkpoint or --auto-checkpoint.")

    outdir = Path(args.outdir)
    outdir.mkdir(parents=True, exist_ok=True)
    stamp = time.strftime('%Y%m%d_%H%M%S')
    csv_path = outdir / f'k_ablation_{stamp}.csv'

    # Write header
    with open(csv_path, 'w', newline='') as f:
        writer = csv.writer(f)
        writer.writerow(['k', 'seed', 'acceptance_rate', 'avg_revenue', 'avg_cost',
                         'revenue_cost_ratio', 'avg_runtime_per_instance', 'accepted', 'rejected'])

    # Hydrate Hydra config once and reuse
    with hydra.initialize(config_path="settings", version_base=None):
        base_cfg = hydra.compose(config_name="main")

    for k in ks:
        for seed in seeds:
            cfg = base_cfg.copy()
            with open_dict(cfg):
                cfg.solver.solver_name = 'alpha_zero_sfc'
                cfg.solver.k_shortest = k
                cfg.solver.shortest_method = 'k_shortest'
                cfg.experiment.seed = seed
                cfg.experiment.run_id = f'k_ablation_k{k}_seed{seed}'
                cfg.experiment.num_simulations = 1
                # Fix test size for fair comparison
                try:
                    cfg.v_sim_setting.num_v_nets = args.num_instances
                except Exception:
                    pass
                # Evaluation-only settings
                cfg.training.num_train_epochs = 0
                cfg.training.disable_trajectory_writing = True
                cfg.training.use_batched_gpu = True
                cfg.training.gpu_batch_size = args.gpu_batch
                cfg.training.computation_budget = args.eval_budget
                cfg.training.alphazero_model_path = str(ckpt)

                add_simulation_into_config(cfg)

            results = run_eval_once(cfg)

            with open(csv_path, 'a', newline='') as f:
                writer = csv.writer(f)
                writer.writerow([
                    k, seed,
                    f"{results['acceptance_rate']:.6f}",
                    f"{results['avg_revenue']:.6f}",
                    f"{results['avg_cost']:.6f}",
                    f"{results['revenue_cost_ratio']:.6f}",
                    f"{results['avg_runtime_per_instance']:.6f}",
                    results['accepted'], results['rejected']
                ])

    print(f"Saved ablation results to {csv_path}")


if __name__ == '__main__':
    main()
