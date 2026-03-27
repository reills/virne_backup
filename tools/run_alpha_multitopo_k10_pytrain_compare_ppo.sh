#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

CONFIG_PATH="results/journal_suite/alpha_multitopo_k10_pytrain_compare_ppo.yaml"
PROFILE="alpha_multitopo_k10_pytrain_compare_ppo"

mkdir -p results/journal_suite
cp settings/experiments/journal_suite_alpha_only.yaml "$CONFIG_PATH"

conda run -n virne python -c "
from omegaconf import OmegaConf

cfg = OmegaConf.load('$CONFIG_PATH')
cfg.journal_suite.default_profile = '$PROFILE'
cfg.journal_suite.profiles.$PROFILE = OmegaConf.create({
    'seeds': [0, 1, 2],
    'topologies': ['brain', 'geant', 'wx100', 'wx500'],
    'scenarios': ['nominal'],
    'methods': ['alpha_zero_sfc'],
    'k_eval_values': [1, 3, 5, 10, 15],
    'generalization_cells': [],
    'overrides': {
        'common': [
            'training.pure_cpp=false',
            'training.use_cpp_mcts=false',
            'training.use_cuda=true',
            'training.use_batched_gpu=false',
            'training.distributed_training=true',
            'training.enable_async_learner=true',
            'training.num_workers=4',
            'training.resume_training=false',
            'training.alpha_zero_backbone=transformer',
            'training.signal_stop_event_on_learner_complete=true',
            'training.computation_budget=96',
            'nn.embedding_dim=96',
            'nn.hidden_dim=96',
            'nn.num_gnn_layers=2',
            'nn.n_heads=6',
            'nn.transformer_layers=2',
        ],
        'train': [
            'training.num_train_epochs=12',
            'training.c_puct=1.4',
            'training.max_training_steps=1000',
            'training.min_buffer_size=128',
            'training.num_train_steps_per_epoch=128',
            'training.max_empty_batches=1800',
            'training.save_interval=256',
        ],
        'eval': [
            'training.computation_budget=96',
        ],
    },
})
OmegaConf.save(cfg, '$CONFIG_PATH')
print('wrote $CONFIG_PATH')
"

echo "Using train datasets:"
for topology in brain geant wx100 wx500; do
  for seed in 0 1 2; do
    echo "  $ROOT_DIR/datasets/generated/journal/nominal/$topology/seed_$seed/train"
  done
done

echo "Using eval datasets:"
for topology in brain geant wx100 wx500; do
  for seed in 0 1 2; do
    echo "  $ROOT_DIR/datasets/generated/journal/nominal/$topology/seed_$seed/test"
  done
done

conda run -n virne python tools/journal_experiments.py --config "$CONFIG_PATH" --profile "$PROFILE" --stage preflight
conda run -n virne python tools/journal_experiments.py --config "$CONFIG_PATH" --profile "$PROFILE" --stage generate-datasets
conda run -n virne python tools/journal_experiments.py --config "$CONFIG_PATH" --profile "$PROFILE" --stage train
conda run -n virne python tools/journal_experiments.py --config "$CONFIG_PATH" --profile "$PROFILE" --stage eval

echo
echo "=== AlphaZero vs PPO Summary (nominal, seeds 0/1/2) ==="
conda run -n virne python -c "
from pathlib import Path
import csv
import re

root = Path('$ROOT_DIR/results/journal_suite/results')
alpha_root = root / 'alpha_zero_sfc'
ppo_dual_root = root / 'ppo_dual_gcn+'
ppo_mlp_root = root / 'ppo_mlp+'

topologies = ['brain', 'geant', 'wx100', 'wx500']
k_values = [1, 3, 5, 10, 15]
seeds = [0, 1, 2]

pattern_cache = {}

def latest_summary(method_root: Path, method_label: str, topology: str, seed: int, k: int):
    key = (str(method_root), topology, seed, k)
    if key not in pattern_cache:
        pattern_cache[key] = sorted(
            method_root.glob(f'journal_suite__{method_label}__{topology}__nominal__seed{seed}__eval__keval{k}__ckpt*/summary.csv'),
            key=lambda p: p.stat().st_mtime,
        )
    matches = pattern_cache[key]
    if not matches:
        return None
    return matches[-1]

def load_acceptance(path: Path):
    with path.open(newline='') as f:
        rows = list(csv.DictReader(f))
    if not rows:
        return None
    row = rows[-1]
    for key in ('acceptance_rate', 'acceptance'):
        if key in row and row[key] not in ('', None):
            return float(row[key])
    return None

for topology in topologies:
    print(f'[{topology}]')
    for k in k_values:
        alpha_vals = []
        dual_vals = []
        mlp_vals = []
        for seed in seeds:
            alpha_path = latest_summary(alpha_root, 'alpha_zero_sfc', topology, seed, k)
            dual_path = latest_summary(ppo_dual_root, 'ppo_dual_gcnplus', topology, seed, k)
            mlp_path = latest_summary(ppo_mlp_root, 'ppo_mlpplus', topology, seed, k)
            if alpha_path is not None:
                value = load_acceptance(alpha_path)
                if value is not None:
                    alpha_vals.append(value)
            if dual_path is not None:
                value = load_acceptance(dual_path)
                if value is not None:
                    dual_vals.append(value)
            if mlp_path is not None:
                value = load_acceptance(mlp_path)
                if value is not None:
                    mlp_vals.append(value)
        def fmt(values):
            return 'n/a' if not values else f'{sum(values)/len(values):.3f}'
        print(f'  k={k}: alpha={fmt(alpha_vals)} ppo_dual_gcn+={fmt(dual_vals)} ppo_mlp+={fmt(mlp_vals)}')
"
