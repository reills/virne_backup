#!/usr/bin/env bash
# One resumable entry point for the Computer Networks journal evidence package.
#
# This script intentionally orchestrates existing, reviewed experiment runners.
# It does not claim to implement experiments for which the repository has no
# faithful runner. See docs/compnet_pipeline.md and the generated
# evidence_status.md for those gaps.

set -Eeuo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

RUN_TAG="${RUN_TAG:-compnet_journal_v1}"
STAGES="${STAGES:-preflight benchmark_additions matched_search hard_stress generalization aggregate publish paper validate}"
FORCE_STAGES="${FORCE_STAGES:-}"
PLAN_ONLY="${PLAN_ONLY:-0}"
BUILD_PAPER="${BUILD_PAPER:-1}"

# Stable campaign IDs make every underlying runner resumable across invocations.
# The defaults point at complete, validated campaigns already present locally.
INFOCOM_STAMP="${INFOCOM_STAMP:-20260717T222704Z}"
MATCHED_STAMP="${MATCHED_STAMP:-20260711Tmatched_nn_no_nn_5seed}"
GENERALIZATION_STAMP="${GENERALIZATION_STAMP:-compnet_generalization_v1}"

STATE_ROOT="${STATE_ROOT:-$ROOT_DIR/results/compnet_pipeline/$RUN_TAG}"
STATE_DIR="$STATE_ROOT/stages"
RUN_LOG="$STATE_ROOT/pipeline.log"
HARD_STRESS_ROOT="$STATE_ROOT/hard_waxman"
GENERALIZATION_ROOT="$STATE_ROOT/generalization"

PAPER_DIR="${PAPER_DIR:-$ROOT_DIR/paperjournal/compnet}"
GENERATED_DIR="${GENERATED_DIR:-$PAPER_DIR/generated}"
INFOCOM_SOURCE_PAPER="${INFOCOM_SOURCE_PAPER:-$ROOT_DIR/paperjournal/versions/overleaf_7.17.2026}"

INFOCOM_ANALYSIS="$ROOT_DIR/results/infocom_benchmark_additions/$INFOCOM_STAMP"
REACHABILITY_ANALYSIS="$ROOT_DIR/results/alpha_journal_component_ablation_k1/$INFOCOM_STAMP"
FULL_ABLATION_REFERENCE="${FULL_ABLATION_REFERENCE:-$ROOT_DIR/results/alpha_journal_component_ablation_k1/20260714Tjournal_components_5seed_v1}"
MATCHED_ANALYSIS="$ROOT_DIR/results/alpha_matched_nn_vs_no_nn_k1/$MATCHED_STAMP"

METHODS="alpha_zero_sfc grc_rank mcts ppo_dual_gcn_plus ppo_mlp_plus pso_meta"

mkdir -p "$STATE_DIR" "$STATE_ROOT" "$GENERATED_DIR"
if [[ "$PLAN_ONLY" != "1" ]]; then
  exec > >(tee -a "$RUN_LOG") 2>&1
fi

section() { printf '\n=== %s ===\n' "$*"; }
has_word() { [[ " $1 " == *" $2 "* ]]; }
has_stage() { has_word "$STAGES" "$1"; }
force_stage() { has_word "$FORCE_STAGES" "$1"; }
require_file() { [[ -f "$1" ]] || { echo "missing file: $1" >&2; return 1; }; }
require_dir() { [[ -d "$1" ]] || { echo "missing directory: $1" >&2; return 1; }; }

run_cmd() {
  printf '+'
  printf ' %q' "$@"
  printf '\n'
  if [[ "$PLAN_ONLY" != "1" ]]; then
    "$@"
  fi
}

stage_marker() { printf '%s/%s.done\n' "$STATE_DIR" "$1"; }

run_stage() {
  local name="$1"
  shift
  if ! has_stage "$name"; then
    echo "skip stage $name (not selected)"
    return 0
  fi
  local marker
  marker="$(stage_marker "$name")"
  if [[ -f "$marker" ]] && ! force_stage "$name"; then
    echo "skip stage $name (completed marker: $marker)"
    return 0
  fi
  section "Stage: $name"
  "$@"
  if [[ "$PLAN_ONLY" != "1" ]]; then
    {
      printf 'stage=%s\n' "$name"
      printf 'completed_utc=%s\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)"
      printf 'git_commit=%s\n' "$(git rev-parse HEAD 2>/dev/null || echo unknown)"
    } > "$marker"
  fi
}

copy_artifact() {
  local source="$1" destination="$2"
  require_file "$source"
  run_cmd mkdir -p "$(dirname "$destination")"
  run_cmd cp -f "$source" "$destination"
}

csv_rows() {
  local path="$1"
  require_file "$path"
  awk 'END { print (NR > 0 ? NR - 1 : 0) }' "$path"
}

require_csv_rows() {
  local path="$1" expected="$2" actual
  actual="$(csv_rows "$path")"
  [[ "$actual" == "$expected" ]] || {
    echo "unexpected row count: $path (expected $expected, found $actual)" >&2
    return 1
  }
}

write_run_manifest() {
  local manifest="$STATE_ROOT/run_manifest.txt"
  {
    printf 'run_tag=%s\n' "$RUN_TAG"
    printf 'started_utc=%s\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)"
    printf 'root=%s\n' "$ROOT_DIR"
    printf 'paper_dir=%s\n' "$PAPER_DIR"
    printf 'generated_dir=%s\n' "$GENERATED_DIR"
    printf 'stages=%s\n' "$STAGES"
    printf 'git_branch=%s\n' "$(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo unknown)"
    printf 'git_commit=%s\n' "$(git rev-parse HEAD 2>/dev/null || echo unknown)"
    printf 'worktree_dirty=%s\n' "$(git status --porcelain 2>/dev/null | awk 'END { print NR > 0 ? "yes" : "no" }')"
  } > "$manifest"
  echo "run manifest: $manifest"
}

preflight() {
  local command
  for command in conda git awk find sha256sum sort xargs; do
    command -v "$command" >/dev/null || { echo "missing command: $command" >&2; return 1; }
  done

  require_file tools/run_infocom_benchmark_additions.sh
  require_file tools/run_alpha_matched_nn_vs_no_nn_k1.sh
  require_file tools/run_alpha_vne_generalization_eval.py
  require_file tools/aggregate_waxman_hard_results.py
  require_file tools/aggregate_journal_results.py
  require_file "$INFOCOM_SOURCE_PAPER/main.tex"
  require_file "$INFOCOM_SOURCE_PAPER/tables/main_comparison.tex"
  require_file "$INFOCOM_SOURCE_PAPER/tables/component_ablation.tex"
  require_file "$FULL_ABLATION_REFERENCE/eval_summary.csv"
  require_file "$FULL_ABLATION_REFERENCE/aggregate_summary.csv"
  if has_stage paper && [[ "$BUILD_PAPER" == "1" ]]; then
    require_file "$PAPER_DIR/main.tex"
  fi

  write_run_manifest
  run_cmd conda run -n virne python -c \
    "import torch; assert torch.cuda.is_available(), 'CUDA is required'; print(torch.cuda.get_device_name(0))"
  run_cmd conda run -n virne python -c \
    "from virne.solver.learning.reinforcement_learning.alpha_vne import alpha_zero_cpp_core as m; print(m.__file__)"
}

benchmark_additions() {
  # Avoid even entering the training runners when the complete result matrices
  # are already present. The publisher revalidates their datasets, checkpoints,
  # provenance, metrics, and expected five-seed matrices before rendering.
  if [[ -f "$INFOCOM_ANALYSIS/gpp_vne_infocom_per_seed.csv" \
        && -f "$INFOCOM_ANALYSIS/reachability_ablation_per_seed.csv" \
        && "$(csv_rows "$INFOCOM_ANALYSIS/gpp_vne_infocom_per_seed.csv")" == "10" \
        && "$(csv_rows "$INFOCOM_ANALYSIS/reachability_ablation_per_seed.csv")" == "20" ]]; then
    echo "complete reviewer-addition matrices found; validating without rerunning cells"
    run_cmd conda run -n virne python tools/publish_infocom_benchmark_tables.py \
      --ablation-analysis-root "$REACHABILITY_ANALYSIS" \
      --ablation-stamp "$INFOCOM_STAMP" \
      --full-reference-analysis-root "$FULL_ABLATION_REFERENCE" \
      --full-reference-stamp "$(basename "$FULL_ABLATION_REFERENCE")" \
      --analysis-root "$INFOCOM_ANALYSIS" \
      --paper-dir "$INFOCOM_SOURCE_PAPER"
  else
    # The production runner uses --resume internally for GPPVNE and explicit
    # completion checks for every AlphaVNE train/eval cell. PUBLISH_TABLES stays
    # disabled: candidate tables are copied into compnet/generated later.
    run_cmd env \
      STAMP="$INFOCOM_STAMP" \
      PIPELINE_STAGES="preflight gpp_vne reachability tables" \
      FULL_REFERENCE_ROOT="$FULL_ABLATION_REFERENCE" \
      PAPER_DIR="$INFOCOM_SOURCE_PAPER" \
      PUBLISH_TABLES=0 \
      DRY_RUN="$PLAN_ONLY" \
      bash tools/run_infocom_benchmark_additions.sh
  fi

  if [[ "$PLAN_ONLY" != "1" ]]; then
    require_csv_rows "$INFOCOM_ANALYSIS/gpp_vne_infocom_per_seed.csv" 10
    require_csv_rows "$INFOCOM_ANALYSIS/reachability_ablation_per_seed.csv" 20
    require_file "$INFOCOM_ANALYSIS/source_manifest.json"
  fi
}

matched_search() {
  # Same test trace, transition model, k=1, and 96 MCTS simulations for both
  # arms. This addresses the compute-budget fairness issue at equal simulation
  # count. It does not claim equal wall-clock cost.
  run_cmd env \
    STAMP="$MATCHED_STAMP" \
    STAGES="preflight eval summarize" \
    TOPOLOGIES="brain geant" \
    SEEDS="0 1 2 3 4" \
    ARMS="no_nn nn" \
    K_SHORT=1 \
    COMPUTATION_BUDGET=96 \
    RESUME_COMPLETED=1 \
    ALLOW_PARTIAL_SUMMARY=0 \
    DRY_RUN="$PLAN_ONLY" \
    bash tools/run_alpha_matched_nn_vs_no_nn_k1.sh

  if [[ "$PLAN_ONLY" != "1" ]]; then
    require_csv_rows "$MATCHED_ANALYSIS/eval_summary.csv" 20
    require_csv_rows "$MATCHED_ANALYSIS/paired_summary.csv" 2
  fi
}

hard_stress() {
  # A complete five-seed, in-domain hard Waxman campaign is already stored in
  # results. Re-aggregate and validate it without rerunning completed training.
  # The stress regime raises node and link pressure together; it is not an
  # isolated node-bottleneck/link-bottleneck factorial experiment.
  run_cmd mkdir -p "$HARD_STRESS_ROOT"
  run_cmd conda run -n virne python tools/aggregate_waxman_hard_results.py \
    --results-root results/journal_suite/results \
    --analysis-root "$HARD_STRESS_ROOT" \
    --paper-table "$HARD_STRESS_ROOT/waxman_hard_indomain_comparison.tex" \
    --topology-key wx100 \
    --hard-scenario-key wx100_hard_compare \
    --comparison-mode indomain \
    --methods "$METHODS" \
    --seeds "0 1 2 3 4" \
    --k-eval 10

  if [[ "$PLAN_ONLY" != "1" ]]; then
    require_csv_rows "$HARD_STRESS_ROOT/eval_summary.csv" 30
    require_file "$HARD_STRESS_ROOT/waxman_hard_indomain_comparison.tex"
  fi
}

generalization() {
  # Evaluate fixed nominal-trained AlphaVNE checkpoints on shifted request
  # distributions. Each topology runner resumes from summary.csv.
  local topology output
  for topology in brain geant wx100; do
    output="$GENERALIZATION_ROOT/$topology"
    run_cmd conda run -n virne python tools/run_alpha_vne_generalization_eval.py \
      --topology "$topology" \
      --seeds 0,1,2 \
      --stamp "$GENERALIZATION_STAMP" \
      --output-root "$output" \
      --resume-completed
    if [[ "$PLAN_ONLY" != "1" ]]; then
      require_csv_rows "$output/eval_summary.csv" 3
    fi
  done
}

aggregate() {
  run_cmd conda run -n virne python tools/aggregate_journal_results.py \
    --suite-root results/journal_suite \
    --bootstrap-samples 200 \
    --latest-per-cell
  if [[ "$PLAN_ONLY" != "1" ]]; then
    require_file results/journal_suite/tables/main_metrics.csv
    require_file results/journal_suite/tables/runtime_metrics.csv
    require_file results/journal_suite/tables/significance.csv
  fi
}

write_evidence_status() {
  local destination="$GENERATED_DIR/evidence_status.md"
  run_cmd mkdir -p "$GENERATED_DIR"
  if [[ "$PLAN_ONLY" == "1" ]]; then
    echo "+ write $destination"
    return 0
  fi
  cat > "$destination" <<'EOF'
# Computer Networks evidence status

## Implemented and validated by this pipeline

- Independent GPPVNE reproduction on matched BRAIN and GEANT traces: five seeds per topology, `k=10`.
- Reachability-filter ablation on BRAIN and GEANT: five matched seeds, `k=1`, 96 MCTS simulations.
- Neural-guided AlphaVNE versus the same feasibility-aware MCTS with neural policy/value guidance disabled: five matched seeds, `k=1`, 96 MCTS simulations.
- Hard Waxman-100 in-domain stress study: five seeds and six methods. Node and link pressure are increased together.
- Nominal-trained AlphaVNE under shifted request distributions on BRAIN, GEANT, and Waxman-100: three seeds per topology.

## Evidence gaps that must not be described as completed

- Equal wall-clock-budget comparison between neural-guided search and classical MCTS. The implemented matched comparison fixes the MCTS simulation count, while neural inference changes elapsed time.
- Faithful PACT or VNE-NNMCTS reproduction. No production runner exists in this repository.
- Separate node-constrained and link-constrained regimes. The implemented hard Waxman regime increases both pressures together.
- Policy-only versus policy-plus-value-head ablation, value calibration, or feasibility-prediction analysis. Existing runners only compare both neural heads enabled against both disabled.
- Unseen-substrate-topology transfer. The implemented generalization stage shifts request distributions on known substrate families.

The paper should scope claims to the implemented rows and state these limitations directly.
EOF
}

publish() {
  local target="$GENERATED_DIR"
  run_cmd mkdir -p \
    "$target/benchmark_additions" \
    "$target/matched_search" \
    "$target/hard_stress" \
    "$target/generalization" \
    "$target/journal_aggregate"

  local name
  for name in \
    gpp_vne_infocom_per_seed.csv \
    gpp_vne_infocom_aggregate.csv \
    reachability_ablation_per_seed.csv \
    reachability_ablation_aggregate.csv \
    reachability_ablation_paired.csv \
    report.md \
    source_manifest.json; do
    copy_artifact "$INFOCOM_ANALYSIS/$name" "$target/benchmark_additions/$name"
  done
  for name in main_comparison.tex component_ablation.tex reachability_ablation.tex; do
    if [[ -f "$INFOCOM_ANALYSIS/paper_candidates/$name" ]]; then
      copy_artifact "$INFOCOM_ANALYSIS/paper_candidates/$name" "$target/benchmark_additions/$name"
    fi
  done

  for name in eval_summary.csv paired_summary.csv report.md matched_nn_vs_no_nn_table.tex; do
    copy_artifact "$MATCHED_ANALYSIS/$name" "$target/matched_search/$name"
  done
  for name in eval_summary.csv report.md waxman_hard_indomain_comparison.tex; do
    copy_artifact "$HARD_STRESS_ROOT/$name" "$target/hard_stress/$name"
  done

  local topology
  for topology in brain geant wx100; do
    copy_artifact "$GENERALIZATION_ROOT/$topology/eval_summary.csv" "$target/generalization/${topology}_eval_summary.csv"
    copy_artifact "$GENERALIZATION_ROOT/$topology/report.md" "$target/generalization/${topology}_report.md"
  done

  for name in main_metrics.csv runtime_metrics.csv k_ablation.csv pairwise_deltas.csv significance.csv ranked_summary.csv; do
    copy_artifact "results/journal_suite/tables/$name" "$target/journal_aggregate/$name"
  done

  copy_artifact "$STATE_ROOT/run_manifest.txt" "$target/pipeline_run_manifest.txt"
  write_evidence_status
}

validate() {
  require_csv_rows "$GENERATED_DIR/benchmark_additions/gpp_vne_infocom_per_seed.csv" 10
  require_csv_rows "$GENERATED_DIR/benchmark_additions/reachability_ablation_per_seed.csv" 20
  require_csv_rows "$GENERATED_DIR/matched_search/eval_summary.csv" 20
  require_csv_rows "$GENERATED_DIR/matched_search/paired_summary.csv" 2
  require_csv_rows "$GENERATED_DIR/hard_stress/eval_summary.csv" 30
  require_csv_rows "$GENERATED_DIR/generalization/brain_eval_summary.csv" 3
  require_csv_rows "$GENERATED_DIR/generalization/geant_eval_summary.csv" 3
  require_csv_rows "$GENERATED_DIR/generalization/wx100_eval_summary.csv" 3
  require_file "$GENERATED_DIR/evidence_status.md"

  if [[ "$PLAN_ONLY" != "1" ]]; then
    find "$GENERATED_DIR" -type f ! -name SHA256SUMS -print0 \
      | sort -z \
      | xargs -0 sha256sum > "$GENERATED_DIR/SHA256SUMS"
    echo "artifact checksums: $GENERATED_DIR/SHA256SUMS"
  fi
}

paper() {
  if [[ "$BUILD_PAPER" != "1" ]]; then
    echo "paper build disabled (BUILD_PAPER=$BUILD_PAPER)"
    return 0
  fi
  require_file "$PAPER_DIR/main.tex"
  if [[ "$PLAN_ONLY" == "1" ]]; then
    run_cmd latexmk -cd -pdf -interaction=nonstopmode -halt-on-error "$PAPER_DIR/main.tex"
    return 0
  fi
  if command -v latexmk >/dev/null 2>&1; then
    run_cmd latexmk -cd -pdf -interaction=nonstopmode -halt-on-error "$PAPER_DIR/main.tex"
  else
    command -v pdflatex >/dev/null || { echo "missing command: pdflatex" >&2; return 1; }
    command -v bibtex >/dev/null || { echo "missing command: bibtex" >&2; return 1; }
    run_cmd bash -c 'cd "$1" && pdflatex -interaction=nonstopmode -halt-on-error main.tex && bibtex main && pdflatex -interaction=nonstopmode -halt-on-error main.tex && pdflatex -interaction=nonstopmode -halt-on-error main.tex' _ "$PAPER_DIR"
  fi

  if [[ "$PLAN_ONLY" != "1" ]]; then
    require_file "$PAPER_DIR/main.pdf"
    require_file "$PAPER_DIR/main.log"
    if grep -Eq 'There were undefined references|Citation .+ undefined|There were undefined citations' "$PAPER_DIR/main.log"; then
      echo "paper build has undefined references or citations" >&2
      return 1
    fi
    copy_artifact "$PAPER_DIR/main.pdf" "$GENERATED_DIR/compnet_manuscript.pdf"
  fi
}

print_plan() {
  section "Computer Networks journal pipeline"
  echo "run tag:                 $RUN_TAG"
  echo "stages:                  $STAGES"
  echo "force stages:            ${FORCE_STAGES:-none}"
  echo "plan only:               $PLAN_ONLY"
  echo "build paper:             $BUILD_PAPER"
  echo "state root:              $STATE_ROOT"
  echo "paper directory:         $PAPER_DIR"
  echo "generated artifacts:     $GENERATED_DIR"
  echo "review additions stamp:  $INFOCOM_STAMP"
  echo "matched search stamp:    $MATCHED_STAMP"
  echo "generalization stamp:    $GENERALIZATION_STAMP"
  echo
  echo "Resume with the same RUN_TAG. Completed stages are skipped."
  echo "Use FORCE_STAGES=\"stage_name\" only when intentionally invalidating a stage."
}

on_error() {
  local status=$? line="${BASH_LINENO[0]:-unknown}" command="${BASH_COMMAND:-unknown}"
  echo "pipeline failed at line $line (exit $status): $command" >&2
  echo "resume with: RUN_TAG=$RUN_TAG bash tools/run_compnet_journal_pipeline.sh" >&2
  exit "$status"
}
trap on_error ERR

main() {
  print_plan
  run_stage preflight preflight
  run_stage benchmark_additions benchmark_additions
  run_stage matched_search matched_search
  run_stage hard_stress hard_stress
  run_stage generalization generalization
  run_stage aggregate aggregate
  run_stage publish publish
  if has_stage paper && [[ "$BUILD_PAPER" != "1" ]]; then
    echo "skip stage paper (BUILD_PAPER=$BUILD_PAPER)"
  else
    run_stage paper paper
  fi
  run_stage validate validate

  section "Pipeline complete"
  echo "log:                 $RUN_LOG"
  echo "stage markers:       $STATE_DIR"
  echo "paper artifacts:     $GENERATED_DIR"
  echo "evidence status:     $GENERATED_DIR/evidence_status.md"
  echo "The evidence-status file lists the experiments that remain unsupported."
}

main "$@"
