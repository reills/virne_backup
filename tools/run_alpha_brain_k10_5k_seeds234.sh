#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

STAMP="${STAMP:-20260513T224921Z}"
MAX_TRAINING_STEPS="${MAX_TRAINING_STEPS:-5000}"
SEEDS="${SEEDS:-2 3}"

echo "=== AlphaVNE Brain k=10 5k sequential seeds ==="
echo "stamp:              $STAMP"
echo "max_training_steps: $MAX_TRAINING_STEPS"
echo "seeds:              $SEEDS"
echo

for seed in $SEEDS; do
  echo
  echo "=== Brain seed $seed ==="
  STAMP="$STAMP" \
  MAX_TRAINING_STEPS="$MAX_TRAINING_STEPS" \
  SEEDS_CSV="$seed" \
  CONFIG_PATH="results/journal_suite/alpha_brain_k10_5k_seed${seed}.yaml" \
  bash tools/run_alpha_brain_k10_long_matched.sh
done

echo
echo "=== Done: seeds $SEEDS ==="
