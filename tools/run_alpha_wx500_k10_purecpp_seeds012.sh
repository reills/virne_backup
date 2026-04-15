#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

CONFIG_PATH="results/journal_suite/alpha_wx500_k10_purecpp_seeds012.yaml"
PROFILE="alpha_wx500_k10_purecpp_seeds012"
STAGES="${STAGES:-preflight generate-datasets train eval}"

mkdir -p results/journal_suite
cp settings/experiments/journal_suite_alpha_only.yaml "$CONFIG_PATH"

conda run -n virne python -c "
from omegaconf import OmegaConf

cfg = OmegaConf.load('$CONFIG_PATH')
cfg.journal_suite.default_profile = '$PROFILE'
cfg.journal_suite.profiles.$PROFILE = OmegaConf.create({
    'seeds': [0, 1, 2],
    'topologies': ['wx500'],
    'scenarios': ['nominal'],
    'methods': ['alpha_zero_sfc'],
    'k_eval_values': [10],
    'generalization_cells': [],
    'overrides': {
        'common': [
            'training.pure_cpp=true',
            'training.use_cpp_mcts=true',
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
            'experiment.num_simulations=0',
            'training.c_puct=1.4',
            'training.max_training_steps=1000',
            'training.min_buffer_size=128',
            'training.num_train_steps_per_epoch=128',
            'training.max_empty_batches=1800',
            'training.save_interval=2000',
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
for seed in 0 1 2; do
  echo "  $ROOT_DIR/datasets/generated/journal/nominal/wx500/seed_$seed/train"
done

echo "Using eval datasets:"
for seed in 0 1 2; do
  echo "  $ROOT_DIR/datasets/generated/journal/nominal/wx500/seed_$seed/test"
done

for stage in $STAGES; do
  conda run -n virne python tools/journal_experiments.py --config "$CONFIG_PATH" --profile "$PROFILE" --stage "$stage"
done

if [[ " $STAGES " == *" eval "* ]]; then
echo
echo "=== AlphaZero Pure C++ Summary (wx500, k=10, seeds 0/1/2) ==="
conda run -n virne python -c "
from pathlib import Path
import csv

root = Path('$ROOT_DIR/results/journal_suite/results')
alpha_root = root / 'alpha_zero_sfc'
topology = 'wx500'
k = 10
seeds = [0, 1, 2]

def latest_summary(method_root: Path, method_label: str, topology: str, seed: int, k: int):
    matches = sorted(
        method_root.glob(f'journal_suite__{method_label}__{topology}__nominal__seed{seed}__eval__keval{k}__ckpt*/summary.csv'),
        key=lambda p: p.stat().st_mtime,
    )
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

vals = []
for seed in seeds:
    alpha_path = latest_summary(alpha_root, 'alpha_zero_sfc', topology, seed, k)
    value = load_acceptance(alpha_path) if alpha_path is not None else None
    print(f'seed={seed}: summary={alpha_path} acceptance={value}')
    if value is not None:
        vals.append(value)

avg = 'n/a' if not vals else f'{sum(vals)/len(vals):.3f}'
print(f'wx500 k=10 mean acceptance across seeds 0/1/2: {avg}')
"
fi
