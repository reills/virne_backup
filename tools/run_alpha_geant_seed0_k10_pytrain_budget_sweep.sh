#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

CONFIG_PATH="results/journal_suite/alpha_geant_seed0_k10_pytrain_budget_sweep.yaml"
BASE_SCENARIO="nominal"
TOPOLOGY="geant"
SEED="0"
TRAIN_DATASET="$ROOT_DIR/datasets/generated/journal/${BASE_SCENARIO}/${TOPOLOGY}/seed_${SEED}/train"
TEST_DATASET="$ROOT_DIR/datasets/generated/journal/${BASE_SCENARIO}/${TOPOLOGY}/seed_${SEED}/test"

PROFILES=(
  baseline_b64
  baseline_b96
  baseline_b128
  longer800_b64
  longer800_b96
  longer800_b128
  longer1000_b64
  longer1000_b96
  longer1000_b128
)

mkdir -p results/journal_suite
cp settings/experiments/journal_suite_alpha_only.yaml "$CONFIG_PATH"

conda run -n virne python -c "
from omegaconf import OmegaConf

cfg = OmegaConf.load('$CONFIG_PATH')
cfg.journal_suite.default_profile = 'baseline_b64'

base_scenario = OmegaConf.to_container(cfg.journal_suite.scenarios.nominal, resolve=True)

common_overrides = [
    'training.pure_cpp=false',
    'training.use_cpp_mcts=false',
    'training.use_cuda=true',
    'training.use_batched_gpu=false',
    'training.distributed_training=true',
    'training.enable_async_learner=true',
    'training.num_workers=4',
    'training.resume_training=false',
    'training.signal_stop_event_on_learner_complete=true',
    'training.alpha_zero_backbone=transformer',
    'nn.embedding_dim=96',
    'nn.hidden_dim=96',
    'nn.num_gnn_layers=2',
    'nn.n_heads=6',
    'nn.transformer_layers=2',
]

profile_specs = {
    'baseline_b64': {'scenario': 'nominal_budget_baseline_b64', 'budget': 64, 'steps': 500},
    'baseline_b96': {'scenario': 'nominal_budget_baseline_b96', 'budget': 96, 'steps': 500},
    'baseline_b128': {'scenario': 'nominal_budget_baseline_b128', 'budget': 128, 'steps': 500},
    'longer800_b64': {'scenario': 'nominal_budget_longer800_b64', 'budget': 64, 'steps': 800},
    'longer800_b96': {'scenario': 'nominal_budget_longer800_b96', 'budget': 96, 'steps': 800},
    'longer800_b128': {'scenario': 'nominal_budget_longer800_b128', 'budget': 128, 'steps': 800},
    'longer1000_b64': {'scenario': 'nominal_budget_longer1000_b64', 'budget': 64, 'steps': 1000},
    'longer1000_b96': {'scenario': 'nominal_budget_longer1000_b96', 'budget': 96, 'steps': 1000},
    'longer1000_b128': {'scenario': 'nominal_budget_longer1000_b128', 'budget': 128, 'steps': 1000},
}

for profile_name, spec in profile_specs.items():
    cfg.journal_suite.scenarios[spec['scenario']] = OmegaConf.create(base_scenario)
    cfg.journal_suite.profiles[profile_name] = OmegaConf.create({
        'seeds': [0],
        'topologies': ['geant'],
        'scenarios': [spec['scenario']],
        'methods': ['alpha_zero_sfc'],
        'k_eval_values': [10],
        'generalization_cells': [],
        'overrides': {
            'common': list(common_overrides) + [
                f'training.computation_budget={spec[\"budget\"]}',
            ],
            'train': [
                'training.num_train_epochs=12',
                'training.c_puct=1.4',
                f'training.max_training_steps={spec[\"steps\"]}',
                'training.min_buffer_size=128',
                'training.num_train_steps_per_epoch=128',
                'training.max_empty_batches=1800',
                'training.save_interval=256',
            ],
        },
    })

OmegaConf.save(cfg, '$CONFIG_PATH')
print('wrote $CONFIG_PATH')
for profile_name, spec in profile_specs.items():
    print(f'{profile_name} -> {spec[\"scenario\"]} budget={spec[\"budget\"]} steps={spec[\"steps\"]}')
"

for profile in "${PROFILES[@]}"; do
  scenario="nominal_budget_${profile}"
  mkdir -p "$(dirname "$ROOT_DIR/datasets/generated/journal/${scenario}/${TOPOLOGY}/seed_${SEED}/train")"
  ln -sfn "$TRAIN_DATASET" "$ROOT_DIR/datasets/generated/journal/${scenario}/${TOPOLOGY}/seed_${SEED}/train"
  ln -sfn "$TEST_DATASET" "$ROOT_DIR/datasets/generated/journal/${scenario}/${TOPOLOGY}/seed_${SEED}/test"
done

check_stop_behavior() {
  local scenario="$1"
  local expected_steps="$2"
  local train_dir
  train_dir="$(find "$ROOT_DIR/results/journal_suite/results/alpha_zero_sfc" -maxdepth 1 -type d -name "journal_suite__alpha_zero_sfc__geant__${scenario}__seed0__train__ktrain10*" -printf '%T@ %p\n' | sort -n | tail -n 1 | cut -d' ' -f2-)"
  if [[ -z "$train_dir" ]]; then
    echo "stop-check: missing train dir for ${scenario}"
    return
  fi

  local log_path=""
  if [[ -f "$train_dir/stderr.log" ]]; then
    log_path="$train_dir/stderr.log"
  elif [[ -f "$train_dir/stdout.log" ]]; then
    log_path="$train_dir/stdout.log"
  fi

  if [[ -z "$log_path" ]]; then
    echo "stop-check: missing stdout/stderr log for ${scenario}"
    return
  fi

  echo "stop-check: ${scenario}"
  local terminated_line=""
  local stop_line=""
  local logged_steps=""
  terminated_line="$(rg -n -m 1 "Learner terminated after" "$log_path" || true)"
  stop_line="$(rg -n -m 1 "Setting stop_event because" "$log_path" || true)"
  logged_steps="$(printf '%s\n' "$terminated_line" | rg -o '[0-9]+(?= training steps)' || true)"

  if [[ -n "$terminated_line" ]]; then
    echo "stop-check: learner_terminated=yes logged_steps=${logged_steps:-unknown}"
    echo "$terminated_line"
  else
    echo "stop-check: learner_terminated=no"
  fi

  if [[ -n "$stop_line" ]]; then
    echo "stop-check: stop_event_set=yes"
    echo "$stop_line"
  else
    echo "stop-check: stop_event_set=no"
  fi

  echo "stop-check: target max_training_steps=${expected_steps} (logged steps may round up to next 128-step chunk)"
}

echo "All sweep profiles use:"
echo "  train: $TRAIN_DATASET"
echo "  eval:  $TEST_DATASET"
echo "Learner-stop is forced on with training.signal_stop_event_on_learner_complete=true"
echo "Note: learner stops on 128-step boundaries, so 500/800/1000 will typically log as 512/896/1024."

for profile in "${PROFILES[@]}"; do
  scenario="nominal_budget_${profile}"
  expected_steps="500"
  if [[ "$profile" == longer800_* ]]; then
    expected_steps="800"
  elif [[ "$profile" == longer1000_* ]]; then
    expected_steps="1000"
  fi

  echo
  echo "=== [$profile] preflight ==="
  conda run -n virne python tools/journal_experiments.py --config "$CONFIG_PATH" --profile "$profile" --stage preflight

  echo "=== [$profile] train ==="
  conda run -n virne python tools/journal_experiments.py --config "$CONFIG_PATH" --profile "$profile" --stage train
  check_stop_behavior "$scenario" "$expected_steps"

  echo "=== [$profile] eval ==="
  conda run -n virne python tools/journal_experiments.py --config "$CONFIG_PATH" --profile "$profile" --stage eval
done

echo
echo "=== Budget Sweep Summary (geant, seed0, k=10) ==="
conda run -n virne python -c "
from pathlib import Path
import csv

root = Path('$ROOT_DIR/results/journal_suite/results/alpha_zero_sfc')
profiles = [
    ('baseline_b64', 'nominal_budget_baseline_b64'),
    ('baseline_b96', 'nominal_budget_baseline_b96'),
    ('baseline_b128', 'nominal_budget_baseline_b128'),
    ('longer800_b64', 'nominal_budget_longer800_b64'),
    ('longer800_b96', 'nominal_budget_longer800_b96'),
    ('longer800_b128', 'nominal_budget_longer800_b128'),
    ('longer1000_b64', 'nominal_budget_longer1000_b64'),
    ('longer1000_b96', 'nominal_budget_longer1000_b96'),
    ('longer1000_b128', 'nominal_budget_longer1000_b128'),
]

for profile_name, scenario_name in profiles:
    candidates = sorted(
        root.glob(f'journal_suite__alpha_zero_sfc__geant__{scenario_name}__seed0__eval__keval10__ckpt*/summary.csv'),
        key=lambda p: p.stat().st_mtime,
    )
    if not candidates:
        print(f'{profile_name}: missing eval summary')
        continue
    path = candidates[-1]
    row = next(csv.DictReader(path.open()))
    print(
        f'{profile_name}: acceptance={float(row[\"acceptance_rate\"]):.3f} '
        f'success={row[\"success_count\"]}/{row[\"num_arrival_requests\"]} '
        f'run_id={row[\"run_id\"]}'
    )
"
