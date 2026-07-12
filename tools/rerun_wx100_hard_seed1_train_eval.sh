#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

CONFIG_PATH="${CONFIG_PATH:-results/waxman_hard_indomain_sweep/20260511T073528Z/configs/wx100_hard_compare_indomain_alpha_zero_sfc.yaml}"
TRAIN_PROFILE="${TRAIN_PROFILE:-wx100_hard_compare_indomain_alpha_zero_sfc_train}"
EVAL_PROFILE="${EVAL_PROFILE:-wx100_hard_compare_indomain_alpha_zero_sfc_eval}"

SEED="${SEED:-1}"
MAX_TRAINING_STEPS="${MAX_TRAINING_STEPS:-5000}"
K_TRAIN_VALUES="${K_TRAIN_VALUES:-10}"
K_EVAL_VALUES="${K_EVAL_VALUES:-$K_TRAIN_VALUES}"
STAMP="${STAMP:-$(date -u +%Y%m%dT%H%M%SZ)}"
K_TOKEN="$(printf '%s' "${K_TRAIN_VALUES}_to_${K_EVAL_VALUES}" | tr ' ,' '__')"
ONEOFF_CONFIG_PATH="${ONEOFF_CONFIG_PATH:-results/waxman_hard_indomain_sweep/oneoff_seed${SEED}_${K_TOKEN}_steps${MAX_TRAINING_STEPS}_${STAMP}.yaml}"

echo "=== AlphaVNE hard-Waxman seed rerun ==="
echo "config:             $CONFIG_PATH"
echo "train_profile:      $TRAIN_PROFILE"
echo "eval_profile:       $EVAL_PROFILE"
echo "seed:               $SEED"
echo "k_train_values:     $K_TRAIN_VALUES"
echo "k_eval_values:      $K_EVAL_VALUES"
echo "max_training_steps: $MAX_TRAINING_STEPS"
echo "oneoff_config:      $ONEOFF_CONFIG_PATH"
echo

echo "=== Build one-off config (single seed + max steps) ==="
conda run -n virne python tools/make_oneoff_journal_config.py \
  --config "$CONFIG_PATH" \
  --out "$ONEOFF_CONFIG_PATH" \
  --train-profile "$TRAIN_PROFILE" \
  --eval-profile "$EVAL_PROFILE" \
  --seed "$SEED" \
  --max-training-steps "$MAX_TRAINING_STEPS" \
  --train-k-values "$K_TRAIN_VALUES" \
  --eval-k-values "$K_EVAL_VALUES" \
  --stamp "$STAMP"

echo "=== Train (force rerun via new attempt run_id) ==="
conda run -n virne python tools/journal_experiments.py \
  --config "$ONEOFF_CONFIG_PATH" \
  --profile "$TRAIN_PROFILE" \
  --stage train \
  --resume

echo
echo "=== Eval (force rerun via new attempt run_id) ==="
conda run -n virne python tools/journal_experiments.py \
  --config "$ONEOFF_CONFIG_PATH" \
  --profile "$EVAL_PROFILE" \
  --stage eval \
  --resume

echo
echo "=== Done ==="
