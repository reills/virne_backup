#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

CONFIG_PATH="results/journal_suite/alpha_brain_k10_long_matched.yaml"
PROFILE="alpha_brain_k10_long_matched"

STAGES="${STAGES:-preflight generate-datasets train eval}"
SEEDS_CSV="${SEEDS_CSV:-0,1}"
FORCE_DATASETS="${FORCE_DATASETS:-0}"
RUN_AGGREGATE="${RUN_AGGREGATE:-0}"
BOOTSTRAP_SAMPLES="${BOOTSTRAP_SAMPLES:-200}"

mkdir -p results/journal_suite
cp settings/experiments/journal_suite_alpha_only.yaml "$CONFIG_PATH"

conda run -n virne python -c "
from omegaconf import OmegaConf

cfg = OmegaConf.load('$CONFIG_PATH')
seeds = [int(item.strip()) for item in '$SEEDS_CSV'.split(',') if item.strip()]

cfg.journal_suite.default_profile = '$PROFILE'
cfg.journal_suite.profiles['$PROFILE'] = OmegaConf.create({
    'seeds': seeds,
    'topologies': ['brain'],
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
            'training.num_workers=8',
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
            'training.num_train_epochs=16',
            'training.c_puct=1.4',
            'training.max_training_steps=3000',
            'training.min_buffer_size=128',
            'training.num_train_steps_per_epoch=128',
            'training.max_empty_batches=5400',
            'training.save_interval=256',
        ],
        'eval': [
            'training.computation_budget=96',
        ],
    },
})

OmegaConf.save(cfg, '$CONFIG_PATH')
print('wrote $CONFIG_PATH')
print('profile: $PROFILE')
print('seeds:', seeds)
"

run_stage() {
  local stage="$1"
  shift
  echo "=== profile=${PROFILE} stage=${stage} ==="
  conda run -n virne python tools/journal_experiments.py \
    --config "$CONFIG_PATH" \
    --profile "$PROFILE" \
    --stage "$stage" \
    "$@"
}

for stage in $STAGES; do
  if [[ "$stage" == "generate-datasets" && "$FORCE_DATASETS" == "1" ]]; then
    run_stage "$stage" --force
  else
    run_stage "$stage"
  fi
done

if [[ "$RUN_AGGREGATE" == "1" ]]; then
  echo "=== aggregate latest-per-cell tables ==="
  conda run -n virne python tools/aggregate_journal_results.py \
    --suite-root results/journal_suite \
    --bootstrap-samples "$BOOTSTRAP_SAMPLES" \
    --latest-per-cell
fi

echo
echo "=== Brain matched-seed nominal k=10 latest evals ==="
conda run -n virne python -c "
from pathlib import Path
import csv

root = Path('$ROOT_DIR/results/journal_suite/results/alpha_zero_sfc')
seeds = [int(item.strip()) for item in '$SEEDS_CSV'.split(',') if item.strip()]

for seed in seeds:
    matches = sorted(
        root.glob(f'journal_suite__alpha_zero_sfc__brain__nominal__seed{seed}__eval__keval10__ckpt*/summary.csv'),
        key=lambda p: p.stat().st_mtime,
    )
    if not matches:
        print(f'seed={seed}: missing')
        continue
    path = matches[-1]
    row = next(csv.DictReader(path.open()))
    print(
        f\"seed={seed} acceptance_rate={float(row['acceptance_rate']):.3f} \"
        f\"clock_running_time={float(row['clock_running_time']):.3f} \"
        f\"run={path.parent.name}\"
    )
"
