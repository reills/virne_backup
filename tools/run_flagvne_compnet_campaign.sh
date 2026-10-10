#!/usr/bin/env bash
# Run the official FlagVNE baseline on the fixed Computer Networks datasets.
#
# The author repository is cloned at a pinned revision and remains unmodified.
# All Python entry points use the project `virne` Conda environment.

set -Eeuo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

readonly FLAGVNE_REPOSITORY="https://github.com/GeminiLight/flag-vne.git"
readonly FLAGVNE_REVISION="06c65225a6bd42ffaa85c1046196b90b096b6ac1"
SOURCE_DIR="${SOURCE_DIR:-$ROOT_DIR/third_party/flag-vne}"

RUN_TAG="${RUN_TAG:-flagvne_compnet_nominal_v1}"
STAGES="${STAGES:-source preflight cells summarize publish validate}"
FORCE_STAGES="${FORCE_STAGES:-}"
PLAN_ONLY="${PLAN_ONLY:-0}"
CUDA_DEVICE="${CUDA_DEVICE:-0}"
AUTO_INSTALL_FLAGVNE_DEPS="${AUTO_INSTALL_FLAGVNE_DEPS:-1}"
ALLOW_GPU_SHARING="${ALLOW_GPU_SHARING:-0}"
WAIT_FOR_GPU="${WAIT_FOR_GPU:-1}"

# These values define the matched main-comparison matrix. Changing them would
# produce a different experiment rather than resume this campaign.
TOPOLOGIES="brain geant"
SEEDS="0 1 2 3 4"
TRAIN_EPOCHS=100
META_TRAIN_EPOCHS=0
K_SHORTEST=10
SCENARIO=nominal

ADAPTER="$ROOT_DIR/tools/flagvne_official_adapter.py"
SUMMARIZER="$ROOT_DIR/tools/summarize_compnet_flagvne.py"
DATASET_ROOT="$ROOT_DIR/datasets/generated/journal/$SCENARIO"
STATE_ROOT="${STATE_ROOT:-$ROOT_DIR/results/flagvne_campaign/$RUN_TAG}"
STAGE_DIR="$STATE_ROOT/stages"
CELLS_ROOT="$STATE_ROOT/cells"
ANALYSIS_ROOT="$STATE_ROOT/analysis"
RUN_LOG="$STATE_ROOT/campaign.log"
RUN_MANIFEST="$STATE_ROOT/run_manifest.txt"
SOURCE_MANIFEST="$STATE_ROOT/official_source_manifest.txt"
PAPER_OUTPUT="${PAPER_OUTPUT:-$ROOT_DIR/paperjournal/compnet/generated/flagvne_official}"

section() { printf '\n=== %s ===\n' "$*"; }
has_word() { [[ " $1 " == *" $2 "* ]]; }
has_stage() { has_word "$STAGES" "$1"; }
force_stage() { has_word "$FORCE_STAGES" "$1"; }
stage_marker() { printf '%s/%s.done\n' "$STAGE_DIR" "$1"; }

run_cmd() {
  printf '+'
  printf ' %q' "$@"
  printf '\n'
  if [[ "$PLAN_ONLY" != "1" ]]; then
    "$@"
  fi
}

require_command() {
  command -v "$1" >/dev/null 2>&1 || {
    echo "missing required command: $1" >&2
    return 1
  }
}

require_file() {
  [[ -f "$1" ]] || {
    echo "missing required file: $1" >&2
    return 1
  }
}

require_dir() {
  [[ -d "$1" ]] || {
    echo "missing required directory: $1" >&2
    return 1
  }
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

run_stage() {
  local name="$1"
  shift
  if ! has_stage "$name"; then
    echo "skip stage $name (not selected)"
    return 0
  fi

  local marker
  marker="$(stage_marker "$name")"
  if [[ "$PLAN_ONLY" != "1" && -f "$marker" && "$name" != "preflight" \
      && "$name" != "cells" && "$name" != "validate" ]] \
    && ! force_stage "$name"; then
    echo "skip stage $name (completed marker: $marker)"
    return 0
  fi

  section "Stage: $name"
  "$@"
  if [[ "$PLAN_ONLY" != "1" ]]; then
    mkdir -p "$STAGE_DIR"
    {
      printf 'stage=%s\n' "$name"
      printf 'completed_utc=%s\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)"
      printf 'project_git_commit=%s\n' "$(git rev-parse HEAD 2>/dev/null || echo unknown)"
      printf 'flagvne_revision=%s\n' "$FLAGVNE_REVISION"
    } > "$marker"
  fi
}

check_source() {
  require_dir "$SOURCE_DIR/.git"

  local actual origin status
  actual="$(git -C "$SOURCE_DIR" rev-parse HEAD)"
  [[ "$actual" == "$FLAGVNE_REVISION" ]] || {
    echo "FlagVNE revision mismatch: expected $FLAGVNE_REVISION, found $actual" >&2
    return 1
  }
  origin="$(git -C "$SOURCE_DIR" remote get-url origin)"
  [[ "$origin" == "$FLAGVNE_REPOSITORY" ]] || {
    echo "FlagVNE origin mismatch: expected $FLAGVNE_REPOSITORY, found $origin" >&2
    return 1
  }
  status="$(git -C "$SOURCE_DIR" status --porcelain --untracked-files=all)"
  [[ -z "$status" ]] || {
    echo "official FlagVNE checkout is dirty: $SOURCE_DIR" >&2
    printf '%s\n' "$status" >&2
    return 1
  }
}

source_stage() {
  require_command git

  # Prevent the runtime author checkout from appearing as project source.
  git check-ignore -q "$SOURCE_DIR/.ignore-probe" || {
    echo "FlagVNE source directory must be ignored by the project: $SOURCE_DIR" >&2
    return 1
  }

  if [[ ! -d "$SOURCE_DIR/.git" ]]; then
    run_cmd mkdir -p "$(dirname "$SOURCE_DIR")"
    run_cmd git clone --filter=blob:none --no-checkout "$FLAGVNE_REPOSITORY" "$SOURCE_DIR"
  fi

  run_cmd git -C "$SOURCE_DIR" fetch --depth=1 origin "$FLAGVNE_REVISION"
  run_cmd git -C "$SOURCE_DIR" checkout --detach "$FLAGVNE_REVISION"

  if [[ "$PLAN_ONLY" == "1" ]]; then
    echo "+ verify pinned, clean FlagVNE checkout at $FLAGVNE_REVISION"
    echo "+ write $SOURCE_MANIFEST"
    return 0
  fi

  check_source
  mkdir -p "$STATE_ROOT"
  {
    printf 'repository=%s\n' "$FLAGVNE_REPOSITORY"
    printf 'revision=%s\n' "$FLAGVNE_REVISION"
    printf 'checkout=%s\n' "$SOURCE_DIR"
    printf 'tree_status=clean\n'
    printf 'verified_utc=%s\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)"
    printf 'project_git_commit=%s\n' "$(git rev-parse HEAD 2>/dev/null || echo unknown)"
  } > "$SOURCE_MANIFEST"
}

preflight_stage() {
  local command topology seed split dataset_dir count
  for command in conda git awk find pgrep sha256sum sort xargs; do
    require_command "$command"
  done
  require_file "$ADAPTER"
  require_file "$SUMMARIZER"

  if [[ "$PLAN_ONLY" != "1" ]]; then
    check_source
    while [[ "$ALLOW_GPU_SHARING" != "1" ]] && pgrep -af \
        'run_compnet_journal_pipeline|run_alpha_vne_generalization_eval|journal_experiments.py' \
        >/dev/null; do
      if [[ "$WAIT_FOR_GPU" != "1" ]]; then
        echo "the main Computer Networks campaign is still active on the GPU" >&2
        echo "use WAIT_FOR_GPU=1 to queue, or ALLOW_GPU_SHARING=1 for separate GPUs" >&2
        return 1
      fi
      echo "$(date -u +%Y-%m-%dT%H:%M:%SZ) waiting for the active journal campaign to release the GPU"
      sleep 60
    done
  fi

  for topology in $TOPOLOGIES; do
    for seed in $SEEDS; do
      for split in train test; do
        dataset_dir="$DATASET_ROOT/$topology/seed_$seed/$split"
        require_file "$dataset_dir/p_net.gml"
        require_file "$dataset_dir/v_sim_setting.yaml"
        require_file "$dataset_dir/events.yaml"
        require_file "$dataset_dir/generation_metadata.json"
        require_dir "$dataset_dir/v_nets"
        count="$(find "$dataset_dir/v_nets" -maxdepth 1 -type f -name 'v_net-*.gml' | wc -l)"
        [[ "$count" == "1000" ]] || {
          echo "expected 1000 requests in $dataset_dir, found $count" >&2
          return 1
        }
      done
    done
  done

  if [[ "$PLAN_ONLY" == "1" ]]; then
    echo "+ install torchopt in the virne environment only if its import is missing"
  elif ! conda run -n virne python -c "import torchopt" >/dev/null 2>&1; then
    if [[ "$AUTO_INSTALL_FLAGVNE_DEPS" != "1" ]]; then
      echo "missing FlagVNE dependency: torchopt" >&2
      echo "rerun with AUTO_INSTALL_FLAGVNE_DEPS=1 for automatic installation" >&2
      return 1
    fi
    run_cmd conda run -n virne pip install 'torchopt==0.7.3'
  fi

  run_cmd conda run -n virne python -c \
    "import colorama, gym, higher, matplotlib, networkx, numpy, ortools, pandas, scipy, tensorboard, torch, torch_geometric, torchopt, tqdm, yaml; assert torch.cuda.is_available(), 'CUDA is required'; print(torch.cuda.get_device_name($CUDA_DEVICE))"
}

cell_run_id() {
  local topology="$1" seed="$2"
  printf 'flagvne_official__%s__nominal__seed%s__ktrain10__keval10__%s\n' \
    "$topology" "$seed" "$RUN_TAG"
}

cell_arguments() {
  local topology="$1" seed="$2" output_dir="$3" run_id="$4"
  printf '%s\0' \
    --source-dir "$SOURCE_DIR" \
    --train-dataset "$DATASET_ROOT/$topology/seed_$seed/train" \
    --test-dataset "$DATASET_ROOT/$topology/seed_$seed/test" \
    --output-dir "$output_dir" \
    --topology "$topology" \
    --scenario "$SCENARIO" \
    --seed "$seed" \
    --train-epochs "$TRAIN_EPOCHS" \
    --meta-train-epochs "$META_TRAIN_EPOCHS" \
    --k-shortest "$K_SHORTEST" \
    --cuda-device "$CUDA_DEVICE" \
    --run-id "$run_id"
}

validate_cell() {
  local topology="$1" seed="$2" output_dir="$3" run_id="$4"
  local -a args=()
  mapfile -d '' -t args < <(cell_arguments "$topology" "$seed" "$output_dir" "$run_id")
  run_cmd env PYTHONDONTWRITEBYTECODE=1 \
    conda run -n virne python "$ADAPTER" validate-cell "${args[@]}"
}

cells_stage() {
  local topology seed output_dir marker run_id
  local -a args=()

  if [[ "$PLAN_ONLY" != "1" ]]; then
    check_source
  fi

  for topology in $TOPOLOGIES; do
    for seed in $SEEDS; do
      output_dir="$CELLS_ROOT/$topology/seed_$seed"
      marker="$output_dir/eval/.complete"
      run_id="$(cell_run_id "$topology" "$seed")"

      if [[ "$PLAN_ONLY" != "1" && -f "$marker" ]]; then
        echo "validate completed cell: $topology seed $seed"
        validate_cell "$topology" "$seed" "$output_dir" "$run_id"
        continue
      fi

      mapfile -d '' -t args < <(cell_arguments "$topology" "$seed" "$output_dir" "$run_id")
      run_cmd mkdir -p "$output_dir"
      run_cmd env PYTHONDONTWRITEBYTECODE=1 \
        conda run -n virne python "$ADAPTER" cell "${args[@]}"
      validate_cell "$topology" "$seed" "$output_dir" "$run_id"

      if [[ "$PLAN_ONLY" != "1" ]]; then
        {
          printf 'topology=%s\n' "$topology"
          printf 'seed=%s\n' "$seed"
          printf 'run_id=%s\n' "$run_id"
          printf 'completed_utc=%s\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)"
          printf 'flagvne_revision=%s\n' "$FLAGVNE_REVISION"
        } > "$marker"
      fi
    done
  done
}

summarize_stage() {
  run_cmd conda run -n virne python "$SUMMARIZER" \
    --campaign-root "$STATE_ROOT" \
    --alpha-brain-prefix journal_suite__brain_k10_steps5000_20260513T224921Z \
    --topologies brain geant \
    --seeds 0 1 2 3 4 \
    --output-root "$ANALYSIS_ROOT"
}

write_run_manifest() {
  if [[ "$PLAN_ONLY" == "1" ]]; then
    echo "+ write $RUN_MANIFEST"
    return 0
  fi
  mkdir -p "$STATE_ROOT"
  {
    printf 'run_tag=%s\n' "$RUN_TAG"
    printf 'scenario=%s\n' "$SCENARIO"
    printf 'topologies=%s\n' "$TOPOLOGIES"
    printf 'seeds=%s\n' "$SEEDS"
    printf 'train_epochs=%s\n' "$TRAIN_EPOCHS"
    printf 'meta_train_epochs=%s\n' "$META_TRAIN_EPOCHS"
    printf 'k_shortest=%s\n' "$K_SHORTEST"
    printf 'cuda_device=%s\n' "$CUDA_DEVICE"
    printf 'flagvne_repository=%s\n' "$FLAGVNE_REPOSITORY"
    printf 'flagvne_revision=%s\n' "$FLAGVNE_REVISION"
    printf 'project_git_branch=%s\n' "$(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo unknown)"
    printf 'project_git_commit=%s\n' "$(git rev-parse HEAD 2>/dev/null || echo unknown)"
    printf 'started_utc=%s\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)"
  } > "$RUN_MANIFEST"
}

publish_stage() {
  local name
  local names=(
    per_seed.csv
    aggregate.csv
    paired_alpha.csv
    paired_summary.csv
    manuscript_fragment.tex
    report.md
    source_manifest.json
  )

  run_cmd mkdir -p "$PAPER_OUTPUT"
  for name in "${names[@]}"; do
    if [[ "$PLAN_ONLY" != "1" ]]; then
      require_file "$ANALYSIS_ROOT/$name"
    fi
    run_cmd cp -f "$ANALYSIS_ROOT/$name" "$PAPER_OUTPUT/$name"
  done
  if [[ "$PLAN_ONLY" != "1" ]]; then
    require_file "$SOURCE_MANIFEST"
    require_file "$RUN_MANIFEST"
  fi
  run_cmd cp -f "$SOURCE_MANIFEST" "$PAPER_OUTPUT/official_source_manifest.txt"
  run_cmd cp -f "$RUN_MANIFEST" "$PAPER_OUTPUT/run_manifest.txt"
}

validate_stage() {
  local topology seed output_dir run_id
  if [[ "$PLAN_ONLY" != "1" ]]; then
    check_source
  fi
  for topology in $TOPOLOGIES; do
    for seed in $SEEDS; do
      output_dir="$CELLS_ROOT/$topology/seed_$seed"
      run_id="$(cell_run_id "$topology" "$seed")"
      validate_cell "$topology" "$seed" "$output_dir" "$run_id"
      if [[ "$PLAN_ONLY" != "1" ]]; then
        require_file "$output_dir/eval/.complete"
      fi
    done
  done

  if [[ "$PLAN_ONLY" != "1" ]]; then
    require_csv_rows "$PAPER_OUTPUT/per_seed.csv" 10
    require_csv_rows "$PAPER_OUTPUT/aggregate.csv" 2
    require_csv_rows "$PAPER_OUTPUT/paired_alpha.csv" 10
    require_csv_rows "$PAPER_OUTPUT/paired_summary.csv" 2
    require_file "$PAPER_OUTPUT/manuscript_fragment.tex"
    require_file "$PAPER_OUTPUT/report.md"
    (
      cd "$PAPER_OUTPUT"
      find . -type f ! -name SHA256SUMS -print0 \
        | sort -z \
        | xargs -0 sha256sum > SHA256SUMS
    )
    echo "artifact checksums: $PAPER_OUTPUT/SHA256SUMS"
  else
    echo "+ validate 10 per-seed rows, 2 aggregate rows, and write $PAPER_OUTPUT/SHA256SUMS"
  fi
}

print_plan() {
  section "Official FlagVNE Computer Networks campaign"
  echo "run tag:             $RUN_TAG"
  echo "stages:              $STAGES"
  echo "force stages:        ${FORCE_STAGES:-none}"
  echo "plan only:           $PLAN_ONLY"
  echo "automatic deps:      $AUTO_INSTALL_FLAGVNE_DEPS"
  echo "allow GPU sharing:   $ALLOW_GPU_SHARING"
  echo "wait for busy GPU:   $WAIT_FOR_GPU"
  echo "author source:       $SOURCE_DIR"
  echo "author revision:     $FLAGVNE_REVISION"
  echo "datasets:            $DATASET_ROOT/{brain,geant}/seed_{0..4}/{train,test}"
  echo "training epochs:     $TRAIN_EPOCHS"
  echo "meta-learning epochs:$META_TRAIN_EPOCHS"
  echo "routing:             k_shortest=$K_SHORTEST"
  echo "campaign output:     $STATE_ROOT"
  echo "manuscript output:   $PAPER_OUTPUT"
  echo
  echo "Resume with the same RUN_TAG. Completed cells are revalidated and not retrained."
}

on_error() {
  local status=$? line="${BASH_LINENO[0]:-unknown}" command="${BASH_COMMAND:-unknown}"
  echo "FlagVNE campaign failed at line $line (exit $status): $command" >&2
  echo "resume with: RUN_TAG=$RUN_TAG bash tools/run_flagvne_compnet_campaign.sh" >&2
  exit "$status"
}
trap on_error ERR

main() {
  print_plan
  if [[ "$PLAN_ONLY" != "1" ]]; then
    mkdir -p "$STATE_ROOT" "$STAGE_DIR"
    exec > >(tee -a "$RUN_LOG") 2>&1
  fi
  write_run_manifest
  run_stage source source_stage
  run_stage preflight preflight_stage
  run_stage cells cells_stage
  run_stage summarize summarize_stage
  run_stage publish publish_stage
  run_stage validate validate_stage

  section "FlagVNE campaign complete"
  echo "log:                 $RUN_LOG"
  echo "cell outputs:        $CELLS_ROOT"
  echo "analysis:            $ANALYSIS_ROOT"
  echo "manuscript artifacts:$PAPER_OUTPUT"
}

main "$@"
