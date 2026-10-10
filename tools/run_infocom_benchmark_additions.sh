#!/usr/bin/env bash
# One resumable experimental run for two candidate InfoCom additions:
#   1. GPPVNE-R on matched BRAIN/GEANT traces at k=10 (five seeds), and
#   2. The missing no-reachability AlphaVNE cells at k=1 (five seeds), paired
#      against the already-completed Full AlphaVNE component-ablation cells.
#
# This pipeline deliberately has no smoke stage. It validates every result
# cell and writes candidate LaTeX under results/. Paper publication is disabled
# by default because these experiments are not part of the July 17 manuscript.
#
# Start:
#   bash tools/run_infocom_benchmark_additions.sh
#
# Resume (use the stamp printed by the first invocation):
#   STAMP=YYYYMMDDTHHMMSSZ bash tools/run_infocom_benchmark_additions.sh

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

STAMP="${STAMP:-$(date -u +%Y%m%dT%H%M%SZ)}"
PIPELINE_STAGES="${PIPELINE_STAGES:-preflight gpp_vne reachability tables}"
DRY_RUN="${DRY_RUN:-0}"
PUBLISH_TABLES="${PUBLISH_TABLES:-0}"

GPP_PROFILE="gpp_vne_main"
GPP_CONFIG="settings/experiments/journal_suite.yaml"
TOPOLOGIES="brain geant"
SEEDS="0 1 2 3 4"
VARIANTS="no_reachability"
FULL_REFERENCE_STAMP="${FULL_REFERENCE_STAMP:-20260714Tjournal_components_5seed_v1}"

ANALYSIS_ROOT="${ANALYSIS_ROOT:-$ROOT_DIR/results/infocom_benchmark_additions/$STAMP}"
ABLATION_ANALYSIS_ROOT="${ABLATION_ANALYSIS_ROOT:-$ROOT_DIR/results/alpha_journal_component_ablation_k1/$STAMP}"
FULL_REFERENCE_ROOT="${FULL_REFERENCE_ROOT:-$ROOT_DIR/results/alpha_journal_component_ablation_k1/$FULL_REFERENCE_STAMP}"
PAPER_DIR="${PAPER_DIR:-$ROOT_DIR/paperjournal/versions/overleaf_7.17.2026}"
RUN_LOG="$ANALYSIS_ROOT/run.log"

mkdir -p "$ANALYSIS_ROOT"
if [[ "$DRY_RUN" != "1" ]]; then
  exec > >(tee -a "$RUN_LOG") 2>&1
fi

section() { echo; echo "=== $* ==="; }
has_stage() { [[ " $PIPELINE_STAGES " == *" $1 "* ]]; }
require_file() { [[ -f "$1" ]] || { echo "missing file: $1" >&2; exit 1; }; }

run_cmd() {
  printf '+'
  printf ' %q' "$@"
  printf '\n'
  if [[ "$DRY_RUN" != "1" ]]; then "$@"; fi
}

print_plan() {
  section "InfoCom benchmark additions"
  echo "stamp:                    $STAMP"
  echo "pipeline stages:          $PIPELINE_STAGES"
  echo "GPPVNE profile:           $GPP_PROFILE (production only; no smoke)"
  echo "topologies:               $TOPOLOGIES"
  echo "seeds:                    $SEEDS"
  echo "new ablation variant:     $VARIANTS"
  echo "reuse completed Full:     $FULL_REFERENCE_ROOT"
  echo "GPPVNE protocol:          k=10, 25 epochs, 1000 test requests/cell"
  echo "reachability protocol:    k=1, 96 MCTS simulations, 3000 train steps"
  echo "master analysis:          $ANALYSIS_ROOT"
  echo "ablation analysis:        $ABLATION_ANALYSIS_ROOT"
  echo "paper target:             $PAPER_DIR"
  echo "publish tables:           $PUBLISH_TABLES"
  echo "git branch:               $(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo unknown)"
  echo "git commit:               $(git rev-parse HEAD 2>/dev/null || echo unknown)"
  echo
  echo "Resume this exact run with:"
  echo "  STAMP=$STAMP bash tools/run_infocom_benchmark_additions.sh"
}

preflight() {
  section "Production preflight"
  require_file "$PAPER_DIR/main.tex"
  require_file "$PAPER_DIR/tables/main_comparison.tex"
  require_file "$PAPER_DIR/tables/component_ablation.tex"
  require_file "$GPP_CONFIG"
  require_file "$FULL_REFERENCE_ROOT/eval_summary.csv"
  require_file "$FULL_REFERENCE_ROOT/aggregate_summary.csv"

  run_cmd conda run -n virne python -c \
    "import torch; assert torch.cuda.is_available(), 'CUDA is required for the production GPPVNE and AlphaVNE runs'; print(torch.cuda.get_device_name(0))"

  run_cmd conda run -n virne python tools/journal_experiments.py \
    --config "$GPP_CONFIG" --profile "$GPP_PROFILE" --stage preflight

  if [[ "$DRY_RUN" != "1" ]]; then
    conda run -n virne python -c '
import json, pathlib
path = pathlib.Path("results/journal_suite/preflight_manifest.json")
data = json.loads(path.read_text())
assert data["profile"] == "gpp_vne_main"
assert data["job_count"] == 20
assert all("__gpp_vne_infocom__" in job["run_id"] for job in data["jobs"])
assert all(job["method_key"] == "gpp_vne_infocom" for job in data["jobs"])
print("verified 10 isolated production train jobs and 10 matched eval jobs")
'
  fi
}

run_gpp_vne() {
  section "GPPVNE-R production benchmark"
  run_cmd env \
    PROFILE="$GPP_PROFILE" \
    CONFIG="$GPP_CONFIG" \
    STAGES="generate-datasets train eval" \
    RESUME=1 \
    FORCE_DATASETS=0 \
    DRY_RUN="$DRY_RUN" \
    bash tools/run_gpp_vne_benchmark.sh
}

run_reachability() {
  section "No-reachability-only production ablation"
  run_cmd env \
    STAMP="$STAMP" \
    TOPOLOGIES="$TOPOLOGIES" \
    SEEDS="$SEEDS" \
    VARIANTS="$VARIANTS" \
    STAGES="build preflight train eval summarize" \
    COMPUTATION_BUDGET=96 \
    NUM_V_NETS=1000 \
    ROLLOUT_DEPTH_LIMIT=100 \
    TRAIN_NUM_WORKERS=8 \
    TRAIN_NUM_EPOCHS=16 \
    TRAIN_MAX_STEPS=3000 \
    TRAIN_MIN_BUFFER_SIZE=128 \
    TRAIN_STEPS_PER_EPOCH=128 \
    TRAIN_MAX_EMPTY_BATCHES=5400 \
    SAVE_INTERVAL=2000 \
    SAVE_CHECKPOINT_HISTORY=false \
    GUARANTEED_SAVE_STEP=50 \
    NN_BACKBONE=transformer \
    NN_EMBED_DIM=96 \
    NN_HIDDEN_DIM=96 \
    NN_GNN_LAYERS=2 \
    NN_HEADS=6 \
    NN_TRANSFORMER_LAYERS=2 \
    ANALYSIS_ROOT="$ABLATION_ANALYSIS_ROOT" \
    DRY_RUN="$DRY_RUN" \
    RESUME_COMPLETED=1 \
    ALLOW_PARTIAL_SUMMARY=0 \
    bash tools/run_alpha_journal_component_ablation_k1.sh
}

publish_tables() {
  section "Validate cells and render candidate paper tables"
  local command=(
    conda run -n virne python tools/publish_infocom_benchmark_tables.py
    --ablation-analysis-root "$ABLATION_ANALYSIS_ROOT"
    --ablation-stamp "$STAMP"
    --full-reference-analysis-root "$FULL_REFERENCE_ROOT"
    --full-reference-stamp "$FULL_REFERENCE_STAMP"
    --analysis-root "$ANALYSIS_ROOT"
    --paper-dir "$PAPER_DIR"
  )
  if [[ "$PUBLISH_TABLES" == "1" ]]; then command+=(--publish); fi
  run_cmd "${command[@]}"
}

main() {
  print_plan
  if has_stage preflight; then preflight; fi
  if has_stage gpp_vne; then run_gpp_vne; fi
  if has_stage reachability; then run_reachability; fi
  if has_stage tables && [[ "$DRY_RUN" != "1" ]]; then publish_tables; fi

  section "Done"
  echo "master log:              $RUN_LOG"
  echo "validated report:        $ANALYSIS_ROOT/report.md"
  echo "source manifest:         $ANALYSIS_ROOT/source_manifest.json"
  echo "GPPVNE per-seed CSV:     $ANALYSIS_ROOT/gpp_vne_infocom_per_seed.csv"
  echo "reachability CSV:        $ANALYSIS_ROOT/reachability_ablation_per_seed.csv"
  echo "candidate/published TeX: $ANALYSIS_ROOT/paper_candidates"
}

main "$@"
