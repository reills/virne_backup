#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

CONFIG_PATH="results/journal_suite/geant_seed0_k10_tmp.yaml"
PROFILE="geant_seed0_k10"

mkdir -p results/journal_suite
cp settings/experiments/journal_suite_alpha_only.yaml "$CONFIG_PATH"

conda run -n virne python -c "
from omegaconf import OmegaConf

cfg = OmegaConf.load('$CONFIG_PATH')
cfg.journal_suite.default_profile = '$PROFILE'
train_overrides = list(cfg.journal_suite.methods.alpha_zero_sfc.overrides.train)
if 'training.signal_stop_event_on_learner_complete=true' not in train_overrides:
    train_overrides.append('training.signal_stop_event_on_learner_complete=true')  # Keep enabled: once the learner stops, more actor rollouts do not improve the model.
cfg.journal_suite.methods.alpha_zero_sfc.overrides.train = train_overrides
cfg.journal_suite.profiles.$PROFILE = OmegaConf.create({
    'seeds': [0],
    'topologies': ['geant'],
    'scenarios': ['nominal'],
    'methods': ['alpha_zero_sfc'],
    'k_eval_values': [10],
    'generalization_cells': [],
})
OmegaConf.save(cfg, '$CONFIG_PATH')
print('wrote $CONFIG_PATH')
"

conda run -n virne python tools/journal_experiments.py --config "$CONFIG_PATH" --profile "$PROFILE" --stage preflight
conda run -n virne python tools/journal_experiments.py --config "$CONFIG_PATH" --profile "$PROFILE" --stage generate-datasets
conda run -n virne python tools/journal_experiments.py --config "$CONFIG_PATH" --profile "$PROFILE" --stage train
conda run -n virne python tools/journal_experiments.py --config "$CONFIG_PATH" --profile "$PROFILE" --stage eval
