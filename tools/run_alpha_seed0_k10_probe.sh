#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

CONFIG="results/journal_suite/seed0_k10_probe_tmp.yaml"
PROFILE="seed0_k10_probe"

mkdir -p results/journal_suite
cp settings/experiments/journal_suite_alpha_only.yaml "$CONFIG"

conda run -n virne python -c "
from omegaconf import OmegaConf

cfg = OmegaConf.load('$CONFIG')
train_overrides = list(cfg.journal_suite.methods.alpha_zero_sfc.overrides.train)
if 'training.signal_stop_event_on_learner_complete=true' not in train_overrides:
    train_overrides.append('training.signal_stop_event_on_learner_complete=true')  # Keep enabled: once the learner stops, more actor rollouts do not improve the model.
cfg.journal_suite.methods.alpha_zero_sfc.overrides.train = train_overrides
OmegaConf.save(cfg, '$CONFIG')
print('wrote $CONFIG')
"

conda run -n virne python tools/journal_experiments.py --config "$CONFIG" --profile "$PROFILE" --stage generate-datasets
conda run -n virne python tools/journal_experiments.py --config "$CONFIG" --profile "$PROFILE" --stage train
conda run -n virne python tools/journal_experiments.py --config "$CONFIG" --profile "$PROFILE" --stage eval
conda run -n virne python tools/journal_experiments.py --config "$CONFIG" --profile "$PROFILE" --stage aggregate
