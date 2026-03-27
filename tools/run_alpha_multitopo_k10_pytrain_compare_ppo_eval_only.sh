#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

CONFIG_PATH="results/journal_suite/alpha_multitopo_k10_pytrain_compare_ppo_eval_only.yaml"
PROFILE="alpha_multitopo_k10_pytrain_compare_ppo_eval_only"

mkdir -p results/journal_suite
cp settings/experiments/journal_suite_alpha_only.yaml "$CONFIG_PATH"

conda run -n virne python -c "
from omegaconf import OmegaConf

cfg = OmegaConf.load('$CONFIG_PATH')
cfg.journal_suite.default_profile = '$PROFILE'
cfg.journal_suite.profiles.$PROFILE = OmegaConf.create({
    'seeds': [0, 1, 2],
    'topologies': ['brain', 'geant', 'wx100'],
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

echo "Evaluating AlphaZero-SFC on held-out test datasets:"
for topology in brain geant wx100; do
  for seed in 0 1 2; do
    echo "  $ROOT_DIR/datasets/generated/journal/nominal/$topology/seed_$seed/test"
  done
done

conda run -n virne python tools/journal_experiments.py --config "$CONFIG_PATH" --profile "$PROFILE" --stage preflight
conda run -n virne python tools/journal_experiments.py --config "$CONFIG_PATH" --profile "$PROFILE" --stage eval

echo
echo "=== AlphaZero eval summary (nominal test, seeds 0/1/2) ==="
conda run -n virne python -c "
from pathlib import Path
import csv

root = Path('$ROOT_DIR/results/journal_suite/results/alpha_zero_sfc')
topologies = ['brain', 'geant', 'wx100']
k_values = [1, 3, 5, 10, 15]
seeds = [0, 1, 2]

def latest_summary(topology: str, seed: int, k: int):
    matches = sorted(
        root.glob(f'journal_suite__alpha_zero_sfc__{topology}__nominal__seed{seed}__eval__keval{k}__ckpt*/summary.csv'),
        key=lambda p: p.stat().st_mtime,
    )
    return matches[-1] if matches else None

def load_metric(path: Path, key: str):
    with path.open(newline='') as f:
        rows = list(csv.DictReader(f))
    if not rows:
        return None
    value = rows[-1].get(key)
    return None if value in ('', None) else float(value)

for topology in topologies:
    print(f'[{topology}]')
    for k in k_values:
        acc_vals = []
        r2c_vals = []
        for seed in seeds:
            path = latest_summary(topology, seed, k)
            if path is None:
                continue
            acc = load_metric(path, 'acceptance_rate')
            r2c = load_metric(path, 'long_term_r2c_ratio')
            if acc is not None:
                acc_vals.append(acc)
            if r2c is not None:
                r2c_vals.append(r2c)
        def fmt(values):
            return 'n/a' if not values else f'{sum(values) / len(values):.3f}'
        print(f'  k={k}: acceptance={fmt(acc_vals)} long_term_r2c={fmt(r2c_vals)}')
"
