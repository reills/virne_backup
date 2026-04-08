#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

CONFIG_PATH="results/journal_suite/alpha_geant_seed0_k10_pytrain_sweep.yaml"
BASE_SCENARIO="nominal"
TOPOLOGY="geant"
SEED="0"
TRAIN_DATASET="$ROOT_DIR/datasets/generated/journal/${BASE_SCENARIO}/${TOPOLOGY}/seed_${SEED}/train"
TEST_DATASET="$ROOT_DIR/datasets/generated/journal/${BASE_SCENARIO}/${TOPOLOGY}/seed_${SEED}/test"

PROFILES=(
  baseline
  lr5e5
  temp_relaxed
  longer
  cpuct18
  lr5e5_temp_relaxed
)

mkdir -p results/journal_suite
cp settings/experiments/journal_suite_alpha_only.yaml "$CONFIG_PATH"

conda run -n virne python -c "
from omegaconf import OmegaConf

cfg = OmegaConf.load('$CONFIG_PATH')
cfg.journal_suite.default_profile = 'baseline'

base_scenario = OmegaConf.to_container(cfg.journal_suite.scenarios.nominal, resolve=True)

scenario_names = {
    'baseline': 'nominal_sweep_baseline',
    'lr5e5': 'nominal_sweep_lr5e5',
    'temp_relaxed': 'nominal_sweep_temp_relaxed',
    'longer': 'nominal_sweep_longer',
    'cpuct18': 'nominal_sweep_cpuct18',
    'lr5e5_temp_relaxed': 'nominal_sweep_lr5e5_temp_relaxed',
}

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
    'training.computation_budget=64',
    'nn.embedding_dim=96',
    'nn.hidden_dim=96',
    'nn.num_gnn_layers=2',
    'nn.n_heads=6',
    'nn.transformer_layers=2',
]

train_base = [
    'training.num_train_epochs=12',
    'experiment.num_simulations=0',
    'training.c_puct=1.4',
    'training.max_training_steps=500',
    'training.min_buffer_size=128',
    'training.num_train_steps_per_epoch=128',
    'training.max_empty_batches=1800',
    'training.save_interval=256',
]

profile_train_overrides = {
    'baseline': [],
    'lr5e5': [
        'training.policy_learning_rate=5e-5',
    ],
    'temp_relaxed': [
        'training.temperature_move_threshold=-1',
        'training.temperature_end=0.2',
        'training.temperature_anneal_steps=10000',
    ],
    'longer': [
        'training.max_training_steps=800',
    ],
    'cpuct18': [
        'training.c_puct=1.8',
    ],
    'lr5e5_temp_relaxed': [
        'training.policy_learning_rate=5e-5',
        'training.temperature_move_threshold=-1',
        'training.temperature_end=0.2',
        'training.temperature_anneal_steps=10000',
    ],
}

for profile_name, scenario_name in scenario_names.items():
    cfg.journal_suite.scenarios[scenario_name] = OmegaConf.create(base_scenario)
    cfg.journal_suite.profiles[profile_name] = OmegaConf.create({
        'seeds': [0],
        'topologies': ['geant'],
        'scenarios': [scenario_name],
        'methods': ['alpha_zero_sfc'],
        'k_eval_values': [10],
        'generalization_cells': [],
        'overrides': {
            'common': list(common_overrides),
            'train': list(train_base) + list(profile_train_overrides[profile_name]),
        },
    })

OmegaConf.save(cfg, '$CONFIG_PATH')
print('wrote $CONFIG_PATH')
for profile_name, scenario_name in scenario_names.items():
    print(f'{profile_name} -> {scenario_name}')
"

for profile in "${PROFILES[@]}"; do
  scenario="nominal_sweep_${profile}"
  mkdir -p "$(dirname "$ROOT_DIR/datasets/generated/journal/${scenario}/${TOPOLOGY}/seed_${SEED}/train")"
  ln -sfn "$TRAIN_DATASET" "$ROOT_DIR/datasets/generated/journal/${scenario}/${TOPOLOGY}/seed_${SEED}/train"
  ln -sfn "$TEST_DATASET" "$ROOT_DIR/datasets/generated/journal/${scenario}/${TOPOLOGY}/seed_${SEED}/test"
done

echo "All sweep profiles use:"
echo "  train: $TRAIN_DATASET"
echo "  eval:  $TEST_DATASET"
echo "Learner-stop guarantee: training.signal_stop_event_on_learner_complete=true"

for profile in "${PROFILES[@]}"; do
  echo
  echo "=== [$profile] preflight ==="
  conda run -n virne python tools/journal_experiments.py --config "$CONFIG_PATH" --profile "$profile" --stage preflight

  echo "=== [$profile] train ==="
  conda run -n virne python tools/journal_experiments.py --config "$CONFIG_PATH" --profile "$profile" --stage train

  echo "=== [$profile] eval ==="
  conda run -n virne python tools/journal_experiments.py --config "$CONFIG_PATH" --profile "$profile" --stage eval
done

echo
echo "=== Sweep Summary (geant, seed0, k=10) ==="
conda run -n virne python -c "
from pathlib import Path
import csv

root = Path('$ROOT_DIR/results/journal_suite/results/alpha_zero_sfc')
profiles = [
    ('baseline', 'nominal_sweep_baseline'),
    ('lr5e5', 'nominal_sweep_lr5e5'),
    ('temp_relaxed', 'nominal_sweep_temp_relaxed'),
    ('longer', 'nominal_sweep_longer'),
    ('cpuct18', 'nominal_sweep_cpuct18'),
    ('lr5e5_temp_relaxed', 'nominal_sweep_lr5e5_temp_relaxed'),
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
