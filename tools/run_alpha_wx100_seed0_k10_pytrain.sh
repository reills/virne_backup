#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

CONFIG_PATH="results/journal_suite/wx100_seed0_k10_legacy_pytrain.yaml"
PROFILE="wx100_seed0_k10_legacy_pytrain"

mkdir -p results/journal_suite
cp settings/experiments/journal_suite_alpha_only.yaml "$CONFIG_PATH"

conda run -n virne python -c "
from omegaconf import OmegaConf

cfg = OmegaConf.load('$CONFIG_PATH')
cfg.journal_suite.scenarios.nominal_legacy_pytrain_gcn = OmegaConf.create({
    'train_split': 'train',
    'eval_split': 'test',
    'v_sim_setting_overrides': {
        'num_v_nets': 2000,
    },
})
cfg.journal_suite.default_profile = '$PROFILE'
cfg.journal_suite.profiles.$PROFILE = OmegaConf.create({
    'seeds': [0],
    'topologies': ['wx100'],
    'scenarios': ['nominal_legacy_pytrain_gcn'],
    'methods': ['alpha_zero_sfc'],
    'k_eval_values': [10],
    'generalization_cells': [],
    'overrides': {
        'common': [
            'training.pure_cpp=false',
            'training.use_cpp_mcts=false',
            'training.use_cuda=true',
            'training.use_batched_gpu=false',
            'training.distributed_training=true',
            'training.num_workers=4',
            'training.signal_stop_event_on_learner_complete=true',  # Keep enabled: once the learner stops, more actor rollouts do not improve the model.
        ],
        'train': [
            'training.num_train_epochs=12',
            'training.c_puct=1.4',
            'training.max_training_steps=500',
            'training.min_buffer_size=128',
            'training.num_train_steps_per_epoch=128',
            'training.max_empty_batches=1800',
            'training.save_interval=256',
        ],
    },
})
OmegaConf.save(cfg, '$CONFIG_PATH')
print('wrote $CONFIG_PATH')
"

conda run -n virne python tools/journal_experiments.py --config "$CONFIG_PATH" --profile "$PROFILE" --stage preflight
conda run -n virne python tools/journal_experiments.py --config "$CONFIG_PATH" --profile "$PROFILE" --stage generate-datasets
conda run -n virne python tools/journal_experiments.py --config "$CONFIG_PATH" --profile "$PROFILE" --stage train
conda run -n virne python tools/journal_experiments.py --config "$CONFIG_PATH" --profile "$PROFILE" --stage eval
