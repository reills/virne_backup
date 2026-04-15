#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

GEANT_STAGES="${GEANT_STAGES:-preflight generate-datasets train eval}"
BRAIN_STAGES="${BRAIN_STAGES:-preflight generate-datasets train eval}"
WX500_STAGES="${WX500_STAGES:-preflight generate-datasets train eval}"

WX500_NUM_VNETS="${WX500_NUM_VNETS:-1000}"
WX500_VNET_SIZE_LOW="${WX500_VNET_SIZE_LOW:-3}"
WX500_VNET_SIZE_HIGH="${WX500_VNET_SIZE_HIGH:-13}"
WX500_NODE_DEMAND_HIGH="${WX500_NODE_DEMAND_HIGH:-26}"
WX500_LINK_DEMAND_HIGH="${WX500_LINK_DEMAND_HIGH:-65}"

echo "=== GEANT pure C++ seeds 0,1,2 ==="
STAGES="$GEANT_STAGES" \
bash tools/run_alpha_geant_k10_purecpp_seeds012.sh

echo
echo "=== Brain pure C++ seeds 0,1,2 ==="
STAGES="$BRAIN_STAGES" \
SEEDS_CSV="0,1,2" \
bash tools/run_alpha_brain_k10_long_matched.sh

echo
echo "=== WX500 moderated compare cell seeds 0,1,2 ==="
WX500_NUM_VNETS="$WX500_NUM_VNETS" \
WX500_VNET_SIZE_LOW="$WX500_VNET_SIZE_LOW" \
WX500_VNET_SIZE_HIGH="$WX500_VNET_SIZE_HIGH" \
WX500_NODE_DEMAND_HIGH="$WX500_NODE_DEMAND_HIGH" \
WX500_LINK_DEMAND_HIGH="$WX500_LINK_DEMAND_HIGH" \
bash tools/run_wx500_hard_compare_alpha_zero_sfc.sh
