#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

CONFIG_PATH="results/journal_suite/alpha_multitopo_purecpp_final.yaml"
CORE_PROFILE="alpha_core_purecpp_final"
GEN_PROFILE="alpha_generalization_k10_purecpp_final"

CORE_STAGES="${CORE_STAGES:-preflight generate-datasets train eval}"
GEN_STAGES="${GEN_STAGES:-preflight generate-datasets eval}"
FORCE_DATASETS="${FORCE_DATASETS:-0}"
RUN_AGGREGATE="${RUN_AGGREGATE:-1}"
BOOTSTRAP_SAMPLES="${BOOTSTRAP_SAMPLES:-200}"

mkdir -p results/journal_suite
cp settings/experiments/journal_suite_alpha_only.yaml "$CONFIG_PATH"

conda run -n virne python -c "
from omegaconf import OmegaConf

cfg = OmegaConf.load('$CONFIG_PATH')

topologies = ['brain', 'geant', 'wx100']
seeds = [0, 1, 2]

common_overrides = [
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
]

train_overrides = [
    'training.num_train_epochs=12',
    'experiment.num_simulations=0',
    'training.c_puct=1.4',
    'training.max_training_steps=1000',
    'training.min_buffer_size=128',
    'training.num_train_steps_per_epoch=128',
    'training.max_empty_batches=1800',
    'training.save_interval=256',
]

eval_overrides = [
    'training.computation_budget=96',
]

generalization_cells = [
    {
        'train_scenario': 'nominal',
        'eval_scenario': 'generalization',
        'topology': topology,
        'seed': seed,
    }
    for topology in topologies
    for seed in seeds
]

cfg.journal_suite.default_profile = '$CORE_PROFILE'
cfg.journal_suite.profiles['$CORE_PROFILE'] = OmegaConf.create({
    'seeds': seeds,
    'topologies': topologies,
    'scenarios': ['nominal'],
    'methods': ['alpha_zero_sfc'],
    'k_eval_values': [1, 3, 5, 10, 15],
    'generalization_cells': [],
    'overrides': {
        'common': list(common_overrides),
        'train': list(train_overrides),
        'eval': list(eval_overrides),
    },
})

cfg.journal_suite.profiles['$GEN_PROFILE'] = OmegaConf.create({
    'seeds': seeds,
    'topologies': topologies,
    'scenarios': ['nominal'],
    'methods': ['alpha_zero_sfc'],
    'k_eval_values': [10],
    'generalization_cells': generalization_cells,
    'overrides': {
        'common': list(common_overrides),
        'eval': list(eval_overrides),
    },
})

OmegaConf.save(cfg, '$CONFIG_PATH')
print('wrote $CONFIG_PATH')
print('core profile: $CORE_PROFILE')
print('generalization profile: $GEN_PROFILE')
"

run_stage() {
  local profile="$1"
  local stage="$2"
  shift 2
  echo "=== profile=${profile} stage=${stage} ==="
  conda run -n virne python tools/journal_experiments.py \
    --config "$CONFIG_PATH" \
    --profile "$profile" \
    --stage "$stage" \
    "$@"
}

run_stage_list() {
  local profile="$1"
  local stages="$2"
  local stage
  for stage in $stages; do
    if [[ "$stage" == "generate-datasets" && "$FORCE_DATASETS" == "1" ]]; then
      run_stage "$profile" "$stage" --force
    else
      run_stage "$profile" "$stage"
    fi
  done
}

echo "Using nominal train datasets:"
for topology in brain geant wx100; do
  for seed in 0 1 2; do
    echo "  $ROOT_DIR/datasets/generated/journal/nominal/$topology/seed_$seed/train"
  done
done

echo "Using nominal eval datasets:"
for topology in brain geant wx100; do
  for seed in 0 1 2; do
    echo "  $ROOT_DIR/datasets/generated/journal/nominal/$topology/seed_$seed/test"
  done
done

echo "Using generalization eval datasets:"
for topology in brain geant wx100; do
  for seed in 0 1 2; do
    echo "  $ROOT_DIR/datasets/generated/journal/generalization/$topology/seed_$seed/test"
  done
done

run_stage_list "$CORE_PROFILE" "$CORE_STAGES"
run_stage_list "$GEN_PROFILE" "$GEN_STAGES"

if [[ "$RUN_AGGREGATE" == "1" ]]; then
  echo "=== aggregate latest-per-cell tables ==="
  conda run -n virne python tools/aggregate_journal_results.py \
    --suite-root results/journal_suite \
    --bootstrap-samples "$BOOTSTRAP_SAMPLES" \
    --latest-per-cell
fi

echo
echo "=== AlphaZero Pure C++ k=10 Acceptance (latest summaries) ==="
conda run -n virne python -c "
from pathlib import Path
import csv

root = Path('$ROOT_DIR/results/journal_suite/results/alpha_zero_sfc')
for topology in ['brain', 'geant', 'wx100']:
    values = []
    for seed in [0, 1, 2]:
        matches = sorted(
            root.glob(f'journal_suite__alpha_zero_sfc__{topology}__nominal__seed{seed}__eval__keval10__ckpt*/summary.csv'),
            key=lambda p: p.stat().st_mtime,
        )
        if not matches:
            print(f'{topology} seed={seed}: missing nominal k=10 eval summary')
            continue
        path = matches[-1]
        row = next(csv.DictReader(path.open()))
        value = float(row['acceptance_rate'])
        values.append(value)
        print(f'{topology} seed={seed}: {value:.3f}  {path.parent.name}')
    if values:
        print(f'{topology} mean nominal k=10 acceptance: {sum(values)/len(values):.3f}')
    print()
"
