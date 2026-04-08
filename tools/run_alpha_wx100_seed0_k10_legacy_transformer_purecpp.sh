#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

CONFIG_PATH="results/journal_suite/wx100_seed0_k10_legacy_transformer_purecpp.yaml"
PROFILE="wx100_seed0_k10_legacy_transformer_purecpp"

mkdir -p results/journal_suite
cp settings/experiments/journal_suite_alpha_only.yaml "$CONFIG_PATH"

conda run -n virne python -c "
from omegaconf import OmegaConf

cfg = OmegaConf.load('$CONFIG_PATH')
cfg.journal_suite.scenarios.nominal_legacy_purecpp_transformer = OmegaConf.create({
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
    'scenarios': ['nominal_legacy_purecpp_transformer'],
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
            'training.num_workers=4',
            'training.alpha_zero_backbone=transformer',
            'training.signal_stop_event_on_learner_complete=true',  # Keep enabled: once the learner stops, more actor rollouts do not improve the model.
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
