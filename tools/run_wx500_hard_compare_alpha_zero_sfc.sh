#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

METHOD_KEY="alpha_zero_sfc"
CONFIG_PATH="results/journal_suite/wx500_hard_compare_alpha_zero_sfc.yaml"
TRAIN_PROFILE="wx500_hard_compare_alpha_zero_sfc_train"
EVAL_PROFILE="wx500_hard_compare_alpha_zero_sfc_eval"

mkdir -p results/journal_suite

TRAIN_SEEDS="$(conda run -n virne python -c "
import csv
from pathlib import Path

registry = Path('results/journal_suite/model_registry.csv')
present = set()
if registry.exists():
    with registry.open(newline='') as f:
        for row in csv.DictReader(f):
            if row.get('method') != 'alpha_zero_sfc':
                continue
            if row.get('topology') != 'wx500':
                continue
            if row.get('scenario') != 'nominal':
                continue
            if row.get('k_train') != '10':
                continue
            present.add(int(row['seed']))
missing = [str(seed) for seed in (0, 1, 2) if seed not in present]
print(','.join(missing))
")"

conda run -n virne python tools/build_wx500_hard_compare_config.py \
  --config-path "$CONFIG_PATH" \
  --method-key "$METHOD_KEY" \
  --train-profile "$TRAIN_PROFILE" \
  --eval-profile "$EVAL_PROFILE" \
  --train-seeds "$TRAIN_SEEDS"

echo "Nominal train datasets:"
for seed in 0 1 2; do
  echo "  $ROOT_DIR/datasets/generated/journal/nominal/wx500/seed_$seed/train"
done
echo "Hard eval datasets:"
for seed in 0 1 2; do
  echo "  $ROOT_DIR/datasets/generated/journal/wx500_hard_compare/wx500/seed_$seed/test"
done

if [[ -n "$TRAIN_SEEDS" ]]; then
  echo "Missing nominal AlphaZero checkpoints for seeds: $TRAIN_SEEDS"
  conda run -n virne python tools/journal_experiments.py --config "$CONFIG_PATH" --profile "$TRAIN_PROFILE" --stage preflight
else
  echo "Nominal AlphaZero checkpoints already present for seeds 0,1,2; skipping train preflight."
fi

conda run -n virne python tools/journal_experiments.py --config "$CONFIG_PATH" --profile "$EVAL_PROFILE" --stage preflight
conda run -n virne python tools/journal_experiments.py --config "$CONFIG_PATH" --profile "$EVAL_PROFILE" --stage generate-datasets

if [[ -n "$TRAIN_SEEDS" ]]; then
  conda run -n virne python tools/journal_experiments.py --config "$CONFIG_PATH" --profile "$TRAIN_PROFILE" --stage train
fi

conda run -n virne python tools/journal_experiments.py --config "$CONFIG_PATH" --profile "$EVAL_PROFILE" --stage eval
