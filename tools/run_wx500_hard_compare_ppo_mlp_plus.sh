#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

METHOD_KEY="ppo_mlp_plus"
CONFIG_PATH="results/journal_suite/wx500_hard_compare_ppo_mlp_plus.yaml"
TRAIN_PROFILE="wx500_hard_compare_ppo_mlp_plus_train"
EVAL_PROFILE="wx500_hard_compare_ppo_mlp_plus_eval"

mkdir -p results/journal_suite

conda run -n virne python tools/build_wx500_hard_compare_config.py \
  --config-path "$CONFIG_PATH" \
  --method-key "$METHOD_KEY" \
  --train-profile "$TRAIN_PROFILE" \
  --eval-profile "$EVAL_PROFILE" \
  --train-seeds "0,1,2"

echo "Nominal train datasets:"
for seed in 0 1 2; do
  echo "  $ROOT_DIR/datasets/generated/journal/nominal/wx500/seed_$seed/train"
done
echo "Hard eval datasets:"
for seed in 0 1 2; do
  echo "  $ROOT_DIR/datasets/generated/journal/wx500_hard_compare/wx500/seed_$seed/test"
done

conda run -n virne python tools/journal_experiments.py --config "$CONFIG_PATH" --profile "$TRAIN_PROFILE" --stage preflight
conda run -n virne python tools/journal_experiments.py --config "$CONFIG_PATH" --profile "$EVAL_PROFILE" --stage preflight
conda run -n virne python tools/journal_experiments.py --config "$CONFIG_PATH" --profile "$EVAL_PROFILE" --stage generate-datasets
conda run -n virne python tools/journal_experiments.py --config "$CONFIG_PATH" --profile "$TRAIN_PROFILE" --stage train
conda run -n virne python tools/journal_experiments.py --config "$CONFIG_PATH" --profile "$EVAL_PROFILE" --stage eval
