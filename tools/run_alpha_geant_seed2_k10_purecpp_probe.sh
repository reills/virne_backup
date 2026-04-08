#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

CONFIG_PATH="results/journal_suite/alpha_geant_seed2_k10_purecpp_probe.yaml"
PROFILE="alpha_geant_seed2_k10_purecpp_probe"
HISTORICAL_SUMMARY="results/journal_suite/results/alpha_zero_sfc/historical_v2/journal_suite__alpha_zero_sfc__geant__nominal__seed2__eval__keval10__ckptc5a319c65b/summary.csv"

STAGES="${STAGES:-preflight generate-datasets train eval}"
FORCE_DATASETS="${FORCE_DATASETS:-0}"
RUN_AGGREGATE="${RUN_AGGREGATE:-0}"
BOOTSTRAP_SAMPLES="${BOOTSTRAP_SAMPLES:-200}"

mkdir -p results/journal_suite
cp settings/experiments/journal_suite_alpha_only.yaml "$CONFIG_PATH"

conda run -n virne python -c "
from omegaconf import OmegaConf

cfg = OmegaConf.load('$CONFIG_PATH')

cfg.journal_suite.default_profile = '$PROFILE'
cfg.journal_suite.profiles['$PROFILE'] = OmegaConf.create({
    'seeds': [2],
    'topologies': ['geant'],
    'scenarios': ['nominal'],
    'methods': ['alpha_zero_sfc'],
    'k_eval_values': [10],
    'generalization_cells': [],
    'overrides': {
        'common': [
            'training.use_cuda=true',
            'training.use_batched_gpu=false',
            'training.resume_training=false',
            'training.alpha_zero_backbone=transformer',
            'training.signal_stop_event_on_learner_complete=true',
            'training.computation_budget=96',
            'nn.embedding_dim=96',
            'nn.hidden_dim=96',
            'nn.num_gnn_layers=2',
            'nn.n_heads=6',
            'nn.transformer_layers=2',
            'training.use_cpp_mcts=true',
            'training.pure_cpp=true',
        ],
        'train': [
            'training.distributed_training=true',
            'training.enable_async_learner=true',
            'training.num_workers=4',
            'training.num_train_epochs=12',
            'experiment.num_simulations=0',
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
echo "=== Pure C++ Probe vs Historical Python ==="
conda run -n virne python -c "
from pathlib import Path
import csv

historical_path = Path('$ROOT_DIR/$HISTORICAL_SUMMARY')
probe_root = Path('$ROOT_DIR/results/journal_suite/results/alpha_zero_sfc')

historical_value = None
if historical_path.exists():
    historical_value = float(next(csv.DictReader(historical_path.open()))['acceptance_rate'])
    print(f'historical_python_acceptance={historical_value:.3f}')
    print(f'historical_summary={historical_path}')
else:
    print(f'missing historical summary: {historical_path}')

matches = sorted(
    probe_root.glob('journal_suite__alpha_zero_sfc__geant__nominal__seed2__eval__keval10__ckpt*/summary.csv'),
    key=lambda p: p.stat().st_mtime,
)

if not matches:
    print('probe_result=missing')
    raise SystemExit(0)

probe_path = matches[-1]
probe_value = float(next(csv.DictReader(probe_path.open()))['acceptance_rate'])
print(f'pure_cpp_probe_acceptance={probe_value:.3f}')
print(f'pure_cpp_summary={probe_path}')

if historical_value is not None:
    print(f'acceptance_delta={probe_value - historical_value:+.3f}')
"
