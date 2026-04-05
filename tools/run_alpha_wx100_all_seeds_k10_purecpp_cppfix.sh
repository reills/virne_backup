#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

BASE_RUN_TAG="${BASE_RUN_TAG:-cppfix_all_$(date -u +%Y%m%dT%H%M%SZ)}"
STAGES="${STAGES:-train eval}"

for SEED in 0 1 2; do
  echo
  echo "=============================="
  echo "WX100 seed ${SEED}"
  echo "=============================="
  RUN_TAG="${BASE_RUN_TAG}_seed${SEED}" \
  STAGES="$STAGES" \
  SEED="$SEED" \
  bash tools/run_alpha_wx100_seed_k10_purecpp_cppfix.sh
done
