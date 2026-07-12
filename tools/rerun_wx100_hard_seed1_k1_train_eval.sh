#!/usr/bin/env bash
set -euo pipefail

# Convenience wrapper for the hard-Waxman diagonal k=1 test:
# train AlphaVNE with k_train=1, then evaluate the same checkpoint with k_eval=1.
export SEED="${SEED:-1}"
export K_TRAIN_VALUES="${K_TRAIN_VALUES:-1}"
export K_EVAL_VALUES="${K_EVAL_VALUES:-1}"
export MAX_TRAINING_STEPS="${MAX_TRAINING_STEPS:-5000}"

exec bash tools/rerun_wx100_hard_seed1_train_eval.sh
