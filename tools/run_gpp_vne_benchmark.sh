#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

PROFILE="${PROFILE:-gpp_vne_main}"
CONFIG="${CONFIG:-settings/experiments/journal_suite.yaml}"
STAGES="${STAGES:-preflight generate-datasets train eval}"
RESUME="${RESUME:-1}"
FORCE_DATASETS="${FORCE_DATASETS:-0}"
DRY_RUN="${DRY_RUN:-0}"

run_cmd() {
  printf '+'
  printf ' %q' "$@"
  printf '\n'
  if [[ "$DRY_RUN" != "1" ]]; then
    "$@"
  fi
}

for stage in $STAGES; do
  cmd=(
    conda run -n virne python tools/journal_experiments.py
    --config "$CONFIG"
    --profile "$PROFILE"
    --stage "$stage"
  )

  if [[ "$stage" == "generate-datasets" && "$FORCE_DATASETS" == "1" ]]; then
    cmd+=(--force)
  fi
  if [[ ( "$stage" == "train" || "$stage" == "eval" ) && "$RESUME" == "1" ]]; then
    cmd+=(--resume)
  fi

  run_cmd "${cmd[@]}"
done
