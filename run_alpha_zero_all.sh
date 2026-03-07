#!/usr/bin/env bash
set -euo pipefail

# One-shot runner for AlphaZero-only experiment batches.
# Runs: preflight -> generate-datasets -> train -> eval for each profile.
#
# Usage:
#   bash run_alpha_zero_all.sh
#   RESUME=1 bash run_alpha_zero_all.sh
#   CLEAN_ALPHA_ARTIFACTS=1 bash run_alpha_zero_all.sh
#   CONFIG=settings/experiments/journal_suite_alpha_only.yaml bash run_alpha_zero_all.sh

CONFIG="${CONFIG:-settings/experiments/journal_suite_alpha_only.yaml}"
RESUME="${RESUME:-0}"
FORCE_DATASETS="${FORCE_DATASETS:-0}"
CLEAN_ALPHA_ARTIFACTS="${CLEAN_ALPHA_ARTIFACTS:-0}"

PROFILES=(
  core
  alpha_core_seed3_budget64
  alpha_core_seed3_budget96
  alpha_core_seed3_budget128
)

run_stage() {
  local profile="$1"
  local stage="$2"
  shift 2
  echo "=== profile=${profile} stage=${stage} ==="
  conda run -n virne python tools/journal_experiments.py \
    --config "${CONFIG}" \
    --profile "${profile}" \
    --stage "${stage}" \
    "$@"
}

cleanup_alpha_artifacts() {
  local alpha_root="results/journal_suite/results/alpha_zero_sfc"
  if [[ ! -d "${alpha_root}" ]]; then
    echo "No prior AlphaZero result directory found at ${alpha_root}; skipping cleanup."
    return
  fi
  echo "Cleaning old AlphaZero training artifacts under ${alpha_root} (models + replay_buffer)..."
  find "${alpha_root}" -type d \( -name models -o -name replay_buffer \) -prune -exec rm -rf {} +
}

if [[ "${CLEAN_ALPHA_ARTIFACTS}" == "1" ]]; then
  cleanup_alpha_artifacts
fi

for profile in "${PROFILES[@]}"; do
  run_stage "${profile}" preflight

  if [[ "${FORCE_DATASETS}" == "1" ]]; then
    run_stage "${profile}" generate-datasets --force
  else
    run_stage "${profile}" generate-datasets
  fi

  if [[ "${RESUME}" == "1" ]]; then
    run_stage "${profile}" train --resume
    run_stage "${profile}" eval --resume
  else
    run_stage "${profile}" train
    run_stage "${profile}" eval
  fi
done

echo "All AlphaZero-only profiles completed."
