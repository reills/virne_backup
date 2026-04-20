#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

STAMP="${STAMP:-$(date -u +%Y%m%dT%H%M%SZ)}"
RESULTS_ROOT="${RESULTS_ROOT:-$ROOT_DIR/results/journal_suite/results}"
SOLVER_RESULTS_ROOT="${SOLVER_RESULTS_ROOT:-$RESULTS_ROOT/alpha_zero_sfc}"
ANALYSIS_ROOT="${ANALYSIS_ROOT:-$ROOT_DIR/results/manual_alpha_candidate_overnight/$STAMP}"
ENV_ROOT="$ANALYSIS_ROOT/env"
EXTRACTED_MODELS_DIR="$ANALYSIS_ROOT/extracted_models"
RUN_LOG="$ANALYSIS_ROOT/run.log"
TRAIN_MANIFEST_CSV="$ANALYSIS_ROOT/train_manifest.csv"
EVAL_MANIFEST_CSV="$ANALYSIS_ROOT/eval_manifest.csv"
EVAL_SUMMARY_CSV="$ANALYSIS_ROOT/eval_summary.csv"
BRAIN_DIAGNOSTIC_BEST_CSV="$ANALYSIS_ROOT/brain_diagnostic_best_checkpoints.csv"
REPORT_MD="$ANALYSIS_ROOT/report.md"

ARM_NAMES="${ARM_NAMES:-current_all_on legacyroot_nofallback}"
EVAL_ENV_NAME="${EVAL_ENV_NAME:-canonical_current_eval}"

RUN_GEANT="${RUN_GEANT:-1}"
RUN_BRAIN="${RUN_BRAIN:-1}"
RUN_WX100_SPOT="${RUN_WX100_SPOT:-1}"
PREP_DATASETS="${PREP_DATASETS:-1}"
SWEEP_BRAIN_CHECKPOINTS="${SWEEP_BRAIN_CHECKPOINTS:-1}"
DRY_RUN="${DRY_RUN:-0}"
RESUME_COMPLETED="${RESUME_COMPLETED:-1}"
SIMULATE_PIPELINE="${SIMULATE_PIPELINE:-0}"

GEANT_SEEDS="${GEANT_SEEDS:-0 1 2}"
BRAIN_SEEDS="${BRAIN_SEEDS:-0 1 2}"
WX100_SEEDS="${WX100_SEEDS:-0 1 2}"

LATEST_EVAL_SPLIT="${LATEST_EVAL_SPLIT:-test}"
BRAIN_SWEEP_SPLIT="${BRAIN_SWEEP_SPLIT:-test}"
BRAIN_SWEEP_STEP_STRIDE="${BRAIN_SWEEP_STEP_STRIDE:-512}"
BRAIN_SWEEP_INCLUDE_GUARANTEED="${BRAIN_SWEEP_INCLUDE_GUARANTEED:-1}"

BRAIN_ADOPT_DELTA="${BRAIN_ADOPT_DELTA:-0.02}"
GENERALIZATION_REGRESSION_DELTA="${GENERALIZATION_REGRESSION_DELTA:-0.01}"
CANDIDATE_ARM="${CANDIDATE_ARM:-legacyroot_nofallback}"
CURRENT_ARM="${CURRENT_ARM:-current_all_on}"

NUM_V_NETS="${NUM_V_NETS:-1000}"
COMPUTATION_BUDGET="${COMPUTATION_BUDGET:-96}"
THREADS_PER_PROCESS="${THREADS_PER_PROCESS:-1}"
TRAIN_NUM_WORKERS="${TRAIN_NUM_WORKERS:-8}"
TRAIN_NUM_EPOCHS="${TRAIN_NUM_EPOCHS:-16}"
TRAIN_MAX_STEPS="${TRAIN_MAX_STEPS:-3000}"
TRAIN_MIN_BUFFER_SIZE="${TRAIN_MIN_BUFFER_SIZE:-128}"
TRAIN_STEPS_PER_EPOCH="${TRAIN_STEPS_PER_EPOCH:-128}"
TRAIN_MAX_EMPTY_BATCHES="${TRAIN_MAX_EMPTY_BATCHES:-5400}"
BRAIN_SAVE_INTERVAL="${BRAIN_SAVE_INTERVAL:-256}"
GEANT_SAVE_INTERVAL="${GEANT_SAVE_INTERVAL:-2000}"
GUARANTEED_SAVE_STEP="${GUARANTEED_SAVE_STEP:-50}"
LAST_TRAIN_RUN_ID=""

NN_EMBED_DIM="${NN_EMBED_DIM:-96}"
NN_HIDDEN_DIM="${NN_HIDDEN_DIM:-96}"
NN_GNN_LAYERS="${NN_GNN_LAYERS:-2}"
NN_HEADS="${NN_HEADS:-6}"
NN_TRANSFORMER_LAYERS="${NN_TRANSFORMER_LAYERS:-2}"

EVAL_AZSFC_CPP_AVAILABLE_SHORTEST_FALLBACK="${EVAL_AZSFC_CPP_AVAILABLE_SHORTEST_FALLBACK:-1}"
EVAL_AZSFC_CPP_USE_MEAN_Q_ROOT_VALUE="${EVAL_AZSFC_CPP_USE_MEAN_Q_ROOT_VALUE:-1}"
EVAL_AZSFC_CPP_PERSISTENT_TREE="${EVAL_AZSFC_CPP_PERSISTENT_TREE:-1}"
EVAL_AZSFC_CPP_MIX_STEP_SEED="${EVAL_AZSFC_CPP_MIX_STEP_SEED:-1}"
EVAL_AZSFC_CPP_SHARE_REVERSE_EDGE_CAPACITY="${EVAL_AZSFC_CPP_SHARE_REVERSE_EDGE_CAPACITY:-1}"

export OMP_NUM_THREADS="${OMP_NUM_THREADS:-$THREADS_PER_PROCESS}"
export MKL_NUM_THREADS="${MKL_NUM_THREADS:-$THREADS_PER_PROCESS}"
export OPENBLAS_NUM_THREADS="${OPENBLAS_NUM_THREADS:-$THREADS_PER_PROCESS}"
export NUMEXPR_NUM_THREADS="${NUMEXPR_NUM_THREADS:-$THREADS_PER_PROCESS}"
export TORCH_NUM_THREADS="${TORCH_NUM_THREADS:-$THREADS_PER_PROCESS}"

mkdir -p "$ANALYSIS_ROOT" "$ENV_ROOT" "$EXTRACTED_MODELS_DIR"

if [[ "$DRY_RUN" != "1" ]]; then
  exec > >(tee -a "$RUN_LOG") 2>&1
fi

on_error() {
  echo
  echo "FAILED. See $RUN_LOG"
}
trap on_error ERR

run_cmd() {
  printf '+' >&2
  printf ' %q' "$@" >&2
  printf '\n' >&2
  if [[ "$DRY_RUN" == "1" ]]; then
    return 0
  fi
  "$@"
}

section() {
  echo
  echo "=== $* ==="
}

seed_words_to_csv() {
  local words="$1"
  echo "${words// /,}"
}

dataset_dir() {
  local topology="$1"
  local seed="$2"
  local split="$3"
  printf '%s\n' "$ROOT_DIR/datasets/generated/journal/nominal/$topology/seed_${seed}/$split"
}

train_run_id() {
  local arm="$1"
  local topology="$2"
  local seed="$3"
  printf '%s\n' "journal_suite__alpha_zero_sfc__${topology}__${arm}__seed${seed}__train__ktrain10__${STAMP}"
}

eval_run_id() {
  local arm="$1"
  local topology="$2"
  local seed="$3"
  local checkpoint_label="$4"
  printf '%s\n' "journal_suite__alpha_zero_sfc__${topology}__${arm}_${checkpoint_label}__seed${seed}__eval__keval10__${STAMP}"
}

solver_run_dir() {
  local run_id="$1"
  printf '%s\n' "$SOLVER_RESULTS_ROOT/$run_id"
}

require_dir() {
  local path="$1"
  if [[ ! -d "$path" ]]; then
    echo "Missing directory: $path" >&2
    exit 1
  fi
}

require_file() {
  local path="$1"
  if [[ ! -f "$path" ]]; then
    echo "Missing file: $path" >&2
    exit 1
  fi
}

arm_env_args() {
  local arm="$1"
  case "$arm" in
    current_all_on|baseline_current)
      cat <<'EOF'
AZSFC_CPP_AVAILABLE_SHORTEST_FALLBACK=1
AZSFC_CPP_USE_MEAN_Q_ROOT_VALUE=1
AZSFC_CPP_PERSISTENT_TREE=1
AZSFC_CPP_MIX_STEP_SEED=1
AZSFC_CPP_SHARE_REVERSE_EDGE_CAPACITY=1
EOF
      ;;
    legacyroot_nofallback|candidate_rootcause)
      cat <<'EOF'
AZSFC_CPP_AVAILABLE_SHORTEST_FALLBACK=0
AZSFC_CPP_USE_MEAN_Q_ROOT_VALUE=0
AZSFC_CPP_PERSISTENT_TREE=1
AZSFC_CPP_MIX_STEP_SEED=1
AZSFC_CPP_SHARE_REVERSE_EDGE_CAPACITY=1
EOF
      ;;
    *)
      echo "Unknown arm: $arm" >&2
      return 1
      ;;
  esac
}

eval_env_args() {
  cat <<EOF
AZSFC_CPP_AVAILABLE_SHORTEST_FALLBACK=$EVAL_AZSFC_CPP_AVAILABLE_SHORTEST_FALLBACK
AZSFC_CPP_USE_MEAN_Q_ROOT_VALUE=$EVAL_AZSFC_CPP_USE_MEAN_Q_ROOT_VALUE
AZSFC_CPP_PERSISTENT_TREE=$EVAL_AZSFC_CPP_PERSISTENT_TREE
AZSFC_CPP_MIX_STEP_SEED=$EVAL_AZSFC_CPP_MIX_STEP_SEED
AZSFC_CPP_SHARE_REVERSE_EDGE_CAPACITY=$EVAL_AZSFC_CPP_SHARE_REVERSE_EDGE_CAPACITY
EOF
}

write_headers() {
  cat > "$TRAIN_MANIFEST_CSV" <<'EOF'
arm,topology,seed,run_id,models_dir,policy_latest_path,train_summary_path
EOF
  cat > "$EVAL_MANIFEST_CSV" <<'EOF'
arm,topology,seed,kind,selection_mode,eval_split,checkpoint_label,checkpoint_source,weights_path,run_id,summary_path
EOF
}

write_env_snapshots() {
  local arm
  for arm in $ARM_NAMES; do
    arm_env_args "$arm" > "$ENV_ROOT/train_${arm}.sh"
  done
  eval_env_args > "$ENV_ROOT/eval_${EVAL_ENV_NAME}.sh"
  if [[ "$DRY_RUN" != "1" ]]; then
    cp "$0" "$ANALYSIS_ROOT/$(basename "$0")"
  fi
}

print_plan() {
  section "AlphaZero Candidate Overnight"
  echo "stamp:                      $STAMP"
  echo "analysis_root:              $ANALYSIS_ROOT"
  echo "results_root:               $RESULTS_ROOT"
  echo "arms:                       $ARM_NAMES"
  echo "eval_env_name:              $EVAL_ENV_NAME"
  echo "run_geant:                  $RUN_GEANT"
  echo "run_brain:                  $RUN_BRAIN"
  echo "run_wx100_spot:             $RUN_WX100_SPOT"
  echo "prep_datasets:              $PREP_DATASETS"
  echo "sweep_brain_checkpoints:    $SWEEP_BRAIN_CHECKPOINTS"
  echo "resume_completed:           $RESUME_COMPLETED"
  echo "simulate_pipeline:          $SIMULATE_PIPELINE"
  echo "dry_run:                    $DRY_RUN"
  echo
  echo "geant_seeds:                $GEANT_SEEDS"
  echo "brain_seeds:                $BRAIN_SEEDS"
  echo "wx100_seeds:                $WX100_SEEDS"
  echo "latest_eval_split:          $LATEST_EVAL_SPLIT"
  echo "brain_sweep_split:          $BRAIN_SWEEP_SPLIT"
  echo "brain_sweep_step_stride:    $BRAIN_SWEEP_STEP_STRIDE"
  echo "brain_include_guaranteed:   $BRAIN_SWEEP_INCLUDE_GUARANTEED"
  echo "num_v_nets:                 $NUM_V_NETS"
  echo "computation_budget:         $COMPUTATION_BUDGET"
  echo "train_num_workers:          $TRAIN_NUM_WORKERS"
  echo "train_num_epochs:           $TRAIN_NUM_EPOCHS"
  echo "train_max_steps:            $TRAIN_MAX_STEPS"
  echo "brain_save_interval:        $BRAIN_SAVE_INTERVAL"
  echo "geant_save_interval:        $GEANT_SAVE_INTERVAL"
  echo "guaranteed_save_step:       $GUARANTEED_SAVE_STEP"
  echo
  echo "decision thresholds (paired latest, mean across seeds):"
  echo "  candidate arm:                $CANDIDATE_ARM"
  echo "  current arm:                  $CURRENT_ARM"
  echo "  brain adopt min delta:        +$BRAIN_ADOPT_DELTA  (candidate must beat current by this much on brain)"
  echo "  generalization max regress:   -$GENERALIZATION_REGRESSION_DELTA  (geant/wx100 deltas must not drop below this)"
  echo
  echo "train_envs:"
  local arm
  for arm in $ARM_NAMES; do
    echo "  [$arm]"
    arm_env_args "$arm" | sed 's/^/    /'
  done
  echo
  echo "eval_env:"
  eval_env_args | sed 's/^/  /'
  echo
  if [[ "$LATEST_EVAL_SPLIT" == "test" ]]; then
    echo "warning: latest paired evals still default to the test split; this is fine for debugging, not pristine final benchmarking."
  fi
  if [[ "$RUN_WX100_SPOT" == "1" ]]; then
    echo "note: wx100 dataset prep is not automated here; wx100 spot checks require existing datasets under datasets/generated/journal/nominal/wx100/."
  fi
}

preflight_checks() {
  section "Preflight"
  if (( TRAIN_NUM_EPOCHS % TRAIN_NUM_WORKERS != 0 )); then
    echo "TRAIN_NUM_EPOCHS=$TRAIN_NUM_EPOCHS must be divisible by TRAIN_NUM_WORKERS=$TRAIN_NUM_WORKERS" >&2
    exit 1
  fi
  if [[ "$LATEST_EVAL_SPLIT" == "test" ]]; then
    echo "WARNING: LATEST_EVAL_SPLIT=test. Paired latest results are suitable for iterative debugging, not pristine held-out benchmarking." >&2
  fi
  if [[ "$RUN_WX100_SPOT" == "1" ]]; then
    local seed
    local missing=0
    for seed in $WX100_SEEDS; do
      if [[ ! -d "$(dataset_dir wx100 "$seed" train)" ]] || [[ ! -d "$(dataset_dir wx100 "$seed" test)" ]]; then
        missing=1
        echo "WARNING: wx100 datasets missing for seed $seed (train or test not found under datasets/generated/journal/nominal/wx100/)" >&2
      fi
    done
    if [[ "$missing" == "1" ]]; then
      echo "WARNING: auto-disabling RUN_WX100_SPOT because at least one seed is missing wx100 datasets. Generate them separately and rerun if you need the guard." >&2
      RUN_WX100_SPOT=0
    else
      echo "WX100 spot-check datasets found for seeds: $WX100_SEEDS"
    fi
  fi
  run_cmd conda run -n virne python -c "from virne.solver.learning.reinforcement_learning.alpha_vne import alpha_zero_cpp_core as m; print(m.__file__)"
  run_cmd conda run -n virne python -c "import torch; print(torch.__version__)"
}

prepare_datasets() {
  [[ "$PREP_DATASETS" == "1" ]] || return 0
  section "Prepare Datasets"
  if [[ "$RUN_GEANT" == "1" ]]; then
    run_cmd env STAGES="preflight generate-datasets" bash tools/run_alpha_geant_k10_purecpp_seeds012.sh
  fi
  if [[ "$RUN_BRAIN" == "1" ]]; then
    run_cmd env STAGES="preflight generate-datasets" SEEDS_CSV="$(seed_words_to_csv "$BRAIN_SEEDS")" bash tools/run_alpha_brain_k10_long_matched.sh
  fi
}

record_train_manifest() {
  local arm="$1"
  local topology="$2"
  local seed="$3"
  local run_id="$4"
  local run_dir
  run_dir="$(solver_run_dir "$run_id")"
  printf '%s,%s,%s,%s,%s,%s,%s\n' \
    "$arm" \
    "$topology" \
    "$seed" \
    "$run_id" \
    "$run_dir/models" \
    "$run_dir/models/policy_latest.pt" \
    "$run_dir/summary.csv" \
    >> "$TRAIN_MANIFEST_CSV"
}

record_eval_manifest() {
  local arm="$1"
  local topology="$2"
  local seed="$3"
  local kind="$4"
  local selection_mode="$5"
  local eval_split="$6"
  local checkpoint_label="$7"
  local checkpoint_source="$8"
  local weights_path="$9"
  local run_id="${10}"
  local summary_path="${11}"
  printf '%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s\n' \
    "$arm" \
    "$topology" \
    "$seed" \
    "$kind" \
    "$selection_mode" \
    "$eval_split" \
    "$checkpoint_label" \
    "$checkpoint_source" \
    "$weights_path" \
    "$run_id" \
    "$summary_path" \
    >> "$EVAL_MANIFEST_CSV"
}

effective_train_steps() {
  printf '%s\n' "$(( ((TRAIN_MAX_STEPS + TRAIN_STEPS_PER_EPOCH - 1) / TRAIN_STEPS_PER_EPOCH) * TRAIN_STEPS_PER_EPOCH ))"
}

simulate_train_artifacts() {
  local arm="$1"
  local topology="$2"
  local seed="$3"
  local run_id="$4"
  local save_interval="$5"
  local save_history="$6"
  local run_dir
  local models_dir
  local effective_steps

  run_dir="$(solver_run_dir "$run_id")"
  models_dir="$run_dir/models"
  effective_steps="$(effective_train_steps)"

  run_cmd conda run -n virne python -c "
import csv
import pathlib
import sys

import torch

arm, topology, seed, run_dir_s, models_dir_s, save_interval_s, save_history_s, guaranteed_s, effective_steps_s = sys.argv[1:]
seed = int(seed)
save_interval = int(save_interval_s)
save_history = save_history_s == 'true'
guaranteed = int(guaranteed_s)
effective_steps = int(effective_steps_s)
run_dir = pathlib.Path(run_dir_s)
models_dir = pathlib.Path(models_dir_s)
(run_dir / 'hydra').mkdir(parents=True, exist_ok=True)
(run_dir / 'logs').mkdir(parents=True, exist_ok=True)
models_dir.mkdir(parents=True, exist_ok=True)

base = 0.40
if topology == 'brain':
    base = 0.36
elif topology == 'wx100':
    base = 0.92
if arm == 'legacyroot_nofallback':
    base += 0.12 if topology == 'brain' else 0.01
base += seed * 0.005

state = {'dummy.weight': torch.tensor([base], dtype=torch.float32)}
torch.save(state, models_dir / 'policy_latest.pt')
torch.save({'model': state, 'meta': {'arm': arm, 'topology': topology, 'seed': seed}}, models_dir / 'policy_latest_full.pt')
for suffix in ('policy_latest.ts', 'policy_latest.ts.mode'):
    (models_dir / suffix).write_text('simulated\\n', encoding='utf-8')

if save_history:
    steps = set()
    if guaranteed > 0 and guaranteed <= effective_steps:
        steps.add(guaranteed)
    if save_interval > 0:
        step = save_interval
        while step <= effective_steps:
            steps.add(step)
            step += save_interval
    steps.add(effective_steps)
    for step in sorted(steps):
        ckpt = {'model': {'dummy.weight': torch.tensor([base + step / 100000.0], dtype=torch.float32)}, 'step': step}
        torch.save(ckpt, models_dir / f'policy_step_{step:05d}.pt')

with (run_dir / 'summary.csv').open('w', newline='', encoding='utf-8') as f:
    writer = csv.DictWriter(f, fieldnames=['acceptance_rate', 'long_term_r2c_ratio', 'clock_running_time'])
    writer.writeheader()
    writer.writerow({
        'acceptance_rate': f'{min(base, 0.999):.3f}',
        'long_term_r2c_ratio': f'{1.0 + seed * 0.01:.3f}',
        'clock_running_time': '0.000',
    })
" "$arm" "$topology" "$seed" "$run_dir" "$models_dir" "$save_interval" "$save_history" "$GUARANTEED_SAVE_STEP" "$effective_steps"
}

simulate_eval_artifacts() {
  local arm="$1"
  local topology="$2"
  local seed="$3"
  local checkpoint_label="$4"
  local run_dir="$5"
  local eval_split="$6"
  run_cmd conda run -n virne python -c "
import csv
import pathlib
import re
import sys

arm, topology, seed_s, checkpoint_label, run_dir_s, eval_split = sys.argv[1:]
seed = int(seed_s)
run_dir = pathlib.Path(run_dir_s)
(run_dir / 'hydra').mkdir(parents=True, exist_ok=True)

base = 0.42
if topology == 'brain':
    base = 0.37
elif topology == 'wx100':
    base = 0.93
if arm == 'legacyroot_nofallback':
    base += 0.13 if topology == 'brain' else 0.01
base += seed * 0.005
match = re.search(r'policy_step_(\\d+)', checkpoint_label)
if match:
    step = int(match.group(1))
    base += min(step, 4000) / 100000.0

if eval_split != 'test':
    base -= 0.002

with (run_dir / 'summary.csv').open('w', newline='', encoding='utf-8') as f:
    writer = csv.DictWriter(f, fieldnames=['acceptance_rate', 'long_term_r2c_ratio', 'clock_running_time'])
    writer.writeheader()
    writer.writerow({
        'acceptance_rate': f'{min(base, 0.999):.3f}',
        'long_term_r2c_ratio': f'{1.1 + seed * 0.01:.3f}',
        'clock_running_time': '0.000',
    })
" "$arm" "$topology" "$seed" "$checkpoint_label" "$run_dir" "$eval_split"
}

latest_completed_run_id() {
  local pattern="$1"
  local required_relpath_a="$2"
  local required_relpath_b="${3:-}"
  local dir
  local base_name
  local candidate
  local best_dir=""
  local best_ts="-1"
  local ts

  shopt -s nullglob
  for dir in $pattern; do
    [[ -d "$dir" ]] || continue
    base_name="$(basename "$dir")"
    if [[ "$SIMULATE_PIPELINE" != "1" && "$base_name" == *smoke_* ]]; then
      continue
    fi
    if [[ ! -f "$dir/$required_relpath_a" ]]; then
      continue
    fi
    if [[ -n "$required_relpath_b" && ! -f "$dir/$required_relpath_b" ]]; then
      continue
    fi
    candidate="$dir/$required_relpath_a"
    ts="$(stat -c %Y "$candidate" 2>/dev/null || echo 0)"
    if (( ts > best_ts )); then
      best_ts="$ts"
      best_dir="$dir"
    fi
  done
  shopt -u nullglob

  if [[ -n "$best_dir" ]]; then
    basename "$best_dir"
  fi
}

find_completed_train_run_id() {
  local arm="$1"
  local topology="$2"
  local seed="$3"
  latest_completed_run_id \
    "$SOLVER_RESULTS_ROOT/journal_suite__alpha_zero_sfc__${topology}__${arm}__seed${seed}__train__ktrain10__*" \
    "summary.csv" \
    "models/policy_latest.pt"
}

find_completed_eval_run_id() {
  local arm="$1"
  local topology="$2"
  local seed="$3"
  local checkpoint_label="$4"
  latest_completed_run_id \
    "$SOLVER_RESULTS_ROOT/journal_suite__alpha_zero_sfc__${topology}__${arm}_${checkpoint_label}__seed${seed}__eval__keval10__*" \
    "summary.csv"
}

run_train() {
  local arm="$1"
  local topology="$2"
  local seed="$3"
  local save_interval="$4"
  local save_history="$5"
  local train_dir
  local run_id
  local run_dir
  local existing_run_id=""
  local -a train_env=()

  train_dir="$(dataset_dir "$topology" "$seed" train)"
  require_dir "$train_dir"

  run_id="$(train_run_id "$arm" "$topology" "$seed")"
  run_dir="$(solver_run_dir "$run_id")"
  mapfile -t train_env < <(arm_env_args "$arm")

  if [[ "$RESUME_COMPLETED" == "1" ]]; then
    existing_run_id="$(find_completed_train_run_id "$arm" "$topology" "$seed")"
  fi

  if [[ -n "$existing_run_id" ]]; then
    section "Train arm=$arm topology=$topology seed=$seed"
    echo "Reusing completed train run: $existing_run_id"
    LAST_TRAIN_RUN_ID="$existing_run_id"
    record_train_manifest "$arm" "$topology" "$seed" "$existing_run_id"
    return 0
  fi

  if [[ "$SIMULATE_PIPELINE" == "1" ]]; then
    section "Train arm=$arm topology=$topology seed=$seed"
    echo "Simulating train artifacts for: $run_id"
    simulate_train_artifacts "$arm" "$topology" "$seed" "$run_id" "$save_interval" "$save_history"
    require_file "$run_dir/models/policy_latest.pt"
    LAST_TRAIN_RUN_ID="$run_id"
    record_train_manifest "$arm" "$topology" "$seed" "$run_id"
    return 0
  fi

  section "Train arm=$arm topology=$topology seed=$seed"
  run_cmd env "${train_env[@]}" conda run -n virne python main.py \
    solver.shortest_method=k_shortest \
    solver.allow_rejection=false \
    solver.solver_name=alpha_zero_sfc \
    solver.k_shortest=10 \
    solver.pretrained_model_path= \
    training.if_use_random_training_seed=false \
    training.seed="$seed" \
    training.num_workers="$TRAIN_NUM_WORKERS" \
    training.inference_only=false \
    training.num_train_epochs="$TRAIN_NUM_EPOCHS" \
    experiment.num_simulations=0 \
    training.enable_async_learner=true \
    training.disable_trajectory_writing=false \
    training.computation_budget="$COMPUTATION_BUDGET" \
    training.c_puct=1.4 \
    training.max_training_steps="$TRAIN_MAX_STEPS" \
    training.guaranteed_save_step="$GUARANTEED_SAVE_STEP" \
    training.min_buffer_size="$TRAIN_MIN_BUFFER_SIZE" \
    training.num_train_steps_per_epoch="$TRAIN_STEPS_PER_EPOCH" \
    training.max_empty_batches="$TRAIN_MAX_EMPTY_BATCHES" \
    training.save_interval="$save_interval" \
    training.save_checkpoint_history="$save_history" \
    training.pure_cpp=true \
    training.use_cpp_mcts=true \
    training.use_cuda=true \
    training.use_batched_gpu=false \
    training.distributed_training=true \
    training.resume_training=false \
    training.alpha_zero_backbone=transformer \
    training.signal_stop_event_on_learner_complete=true \
    use_fixed_dataset=true \
    experiment.if_load_p_net=true \
    experiment.if_load_v_nets=true \
    experiment.seed="$seed" \
    experiment.run_id="$run_id" \
    experiment.save_root_dir="$RESULTS_ROOT" \
    experiment.request_timeout_sec=0.0 \
    experiment.run_watchdog_timeout_sec=0.0 \
    experiment.record_arrival_solve_time=true \
    experiment.gpu_synchronize_timing=true \
    hydra.run.dir="$run_dir/hydra" \
    simulation.p_net_dataset_dir="$train_dir" \
    simulation.v_nets_dataset_dir="$train_dir" \
    v_sim_setting.num_v_nets="$NUM_V_NETS" \
    nn.embedding_dim="$NN_EMBED_DIM" \
    nn.hidden_dim="$NN_HIDDEN_DIM" \
    nn.num_gnn_layers="$NN_GNN_LAYERS" \
    nn.n_heads="$NN_HEADS" \
    nn.transformer_layers="$NN_TRANSFORMER_LAYERS"

  require_file "$run_dir/models/policy_latest.pt"
  LAST_TRAIN_RUN_ID="$run_id"
  record_train_manifest "$arm" "$topology" "$seed" "$run_id"
}

normalize_checkpoint_for_eval() {
  local checkpoint_source="$1"
  local arm="$2"
  local topology="$3"
  local seed="$4"
  local checkpoint_label="$5"
  local extracted_path

  extracted_path="$EXTRACTED_MODELS_DIR/${arm}_${topology}_seed${seed}_${checkpoint_label}_weights.pt"
  if [[ "$DRY_RUN" == "1" ]]; then
    echo "$extracted_path"
    return 0
  fi

  run_cmd conda run -n virne python -c "
import pathlib
import sys

import torch

src = pathlib.Path(sys.argv[1])
dst = pathlib.Path(sys.argv[2])
obj = torch.load(src, map_location='cpu')

if isinstance(obj, dict):
    if 'model' in obj:
        state = obj['model']
    elif 'state_dict' in obj:
        state = obj['state_dict']
    elif 'model_state_dict' in obj:
        state = obj['model_state_dict']
    elif obj and all(torch.is_tensor(v) for v in obj.values()):
        state = obj
    else:
        state = None
else:
    state = None

assert isinstance(state, dict) and state, f'Unsupported checkpoint format in {src}'
assert all(torch.is_tensor(v) for v in state.values()), f'Extracted object is not a pure tensor state_dict in {src}'

dst.parent.mkdir(parents=True, exist_ok=True)
torch.save(state, dst)
" "$checkpoint_source" "$extracted_path"

  echo "$extracted_path"
}

run_eval() {
  local arm="$1"
  local topology="$2"
  local seed="$3"
  local checkpoint_source="$4"
  local checkpoint_label="$5"
  local kind="$6"
  local selection_mode="$7"
  local eval_split="$8"
  local test_dir
  local eval_model_path
  local run_id
  local run_dir
  local summary_path
  local existing_run_id=""
  local -a eval_env=()

  test_dir="$(dataset_dir "$topology" "$seed" "$eval_split")"
  require_dir "$test_dir"
  require_file "$checkpoint_source"

  if [[ "$RESUME_COMPLETED" == "1" ]]; then
    existing_run_id="$(find_completed_eval_run_id "$arm" "$topology" "$seed" "$checkpoint_label")"
  fi

  if [[ -n "$existing_run_id" ]]; then
    run_id="$existing_run_id"
    run_dir="$(solver_run_dir "$run_id")"
    summary_path="$run_dir/summary.csv"
    section "Eval arm=$arm topology=$topology seed=$seed checkpoint=$checkpoint_label split=$eval_split"
    echo "Reusing completed eval run: $existing_run_id"
    record_eval_manifest "$arm" "$topology" "$seed" "$kind" "$selection_mode" "$eval_split" "$checkpoint_label" "$checkpoint_source" "$checkpoint_source" "$run_id" "$summary_path"
    return 0
  fi

  eval_model_path="$(normalize_checkpoint_for_eval "$checkpoint_source" "$arm" "$topology" "$seed" "$checkpoint_label")"
  if [[ "$DRY_RUN" != "1" ]]; then
    require_file "$eval_model_path"
  fi

  run_id="$(eval_run_id "$arm" "$topology" "$seed" "$checkpoint_label")"
  run_dir="$(solver_run_dir "$run_id")"
  summary_path="$run_dir/summary.csv"
  mapfile -t eval_env < <(eval_env_args)

  if [[ "$SIMULATE_PIPELINE" == "1" ]]; then
    section "Eval arm=$arm topology=$topology seed=$seed checkpoint=$checkpoint_label split=$eval_split"
    echo "Simulating eval artifacts for: $run_id"
    simulate_eval_artifacts "$arm" "$topology" "$seed" "$checkpoint_label" "$run_dir" "$eval_split"
    require_file "$summary_path"
    record_eval_manifest "$arm" "$topology" "$seed" "$kind" "$selection_mode" "$eval_split" "$checkpoint_label" "$checkpoint_source" "$eval_model_path" "$run_id" "$summary_path"
    return 0
  fi

  section "Eval arm=$arm topology=$topology seed=$seed checkpoint=$checkpoint_label split=$eval_split"
  run_cmd env "${eval_env[@]}" conda run -n virne python main.py \
    solver.shortest_method=k_shortest \
    solver.allow_rejection=false \
    solver.solver_name=alpha_zero_sfc \
    solver.k_shortest=10 \
    solver.pretrained_model_path="$eval_model_path" \
    training.if_use_random_training_seed=false \
    training.num_workers=1 \
    training.inference_only=true \
    training.num_train_epochs=0 \
    training.max_training_steps=0 \
    training.enable_async_learner=false \
    training.disable_trajectory_writing=true \
    training.computation_budget="$COMPUTATION_BUDGET" \
    training.pure_cpp=true \
    training.use_cpp_mcts=true \
    training.use_cuda=true \
    training.use_batched_gpu=false \
    training.distributed_training=false \
    training.alpha_zero_backbone=transformer \
    training.signal_stop_event_on_learner_complete=true \
    training.alphazero_model_path="$eval_model_path" \
    training.resume_training=false \
    use_fixed_dataset=true \
    experiment.if_load_p_net=true \
    experiment.if_load_v_nets=true \
    experiment.num_simulations=1 \
    experiment.seed="$seed" \
    experiment.run_id="$run_id" \
    experiment.save_root_dir="$RESULTS_ROOT" \
    experiment.request_timeout_sec=0.0 \
    experiment.run_watchdog_timeout_sec=0.0 \
    experiment.record_arrival_solve_time=true \
    experiment.gpu_synchronize_timing=true \
    hydra.run.dir="$run_dir/hydra" \
    simulation.p_net_dataset_dir="$test_dir" \
    simulation.v_nets_dataset_dir="$test_dir" \
    v_sim_setting.num_v_nets="$NUM_V_NETS" \
    nn.embedding_dim="$NN_EMBED_DIM" \
    nn.hidden_dim="$NN_HIDDEN_DIM" \
    nn.num_gnn_layers="$NN_GNN_LAYERS" \
    nn.n_heads="$NN_HEADS" \
    nn.transformer_layers="$NN_TRANSFORMER_LAYERS"

  if [[ "$DRY_RUN" != "1" ]]; then
    require_file "$summary_path"
  fi
  record_eval_manifest "$arm" "$topology" "$seed" "$kind" "$selection_mode" "$eval_split" "$checkpoint_label" "$checkpoint_source" "$eval_model_path" "$run_id" "$summary_path"
}

checkpoint_step_from_path() {
  local path="$1"
  local stem
  stem="$(basename "$path" .pt)"
  printf '%s\n' "$((10#${stem##*_}))"
}

should_eval_brain_checkpoint() {
  local step="$1"
  local max_step="$2"

  if (( step == max_step )); then
    return 1
  fi
  if [[ "$BRAIN_SWEEP_INCLUDE_GUARANTEED" == "1" ]] && (( step == GUARANTEED_SAVE_STEP )); then
    return 0
  fi
  if (( BRAIN_SWEEP_STEP_STRIDE <= 0 )); then
    return 0
  fi
  if (( step % BRAIN_SWEEP_STEP_STRIDE == 0 )); then
    return 0
  fi
  return 1
}

run_brain_seed() {
  local arm="$1"
  local seed="$2"
  local train_id
  local models_dir
  local latest_model
  local -a step_checkpoints=()
  local checkpoint_count
  local max_step
  local checkpoint_path
  local checkpoint_label
  local checkpoint_step

  run_train "$arm" brain "$seed" "$BRAIN_SAVE_INTERVAL" true

  train_id="$LAST_TRAIN_RUN_ID"
  models_dir="$(solver_run_dir "$train_id")/models"
  latest_model="$models_dir/policy_latest.pt"
  require_file "$latest_model"

  mapfile -t step_checkpoints < <(find "$models_dir" -maxdepth 1 -type f -name 'policy_step_*.pt' | sort -V)
  checkpoint_count="${#step_checkpoints[@]}"
  if [[ "$checkpoint_count" -gt 0 ]]; then
    max_step="$(checkpoint_step_from_path "${step_checkpoints[$((checkpoint_count - 1))]}")"
  else
    max_step=""
  fi

  if [[ "$SWEEP_BRAIN_CHECKPOINTS" == "1" && "$checkpoint_count" -gt 0 ]]; then
    for checkpoint_path in "${step_checkpoints[@]}"; do
      checkpoint_label="$(basename "$checkpoint_path" .pt)"
      checkpoint_step="$(checkpoint_step_from_path "$checkpoint_path")"
      if should_eval_brain_checkpoint "$checkpoint_step" "$max_step"; then
        run_eval "$arm" brain "$seed" "$checkpoint_path" "$checkpoint_label" checkpoint diagnostic_checkpoint_sweep "$BRAIN_SWEEP_SPLIT"
      fi
    done
  fi

  run_eval "$arm" brain "$seed" "$latest_model" latest latest paired_latest_canonical_eval "$LATEST_EVAL_SPLIT"
}

run_geant_seed() {
  local arm="$1"
  local seed="$2"
  local train_id
  local latest_model

  run_train "$arm" geant "$seed" "$GEANT_SAVE_INTERVAL" false
  train_id="$LAST_TRAIN_RUN_ID"
  latest_model="$(solver_run_dir "$train_id")/models/policy_latest.pt"
  require_file "$latest_model"
  run_eval "$arm" geant "$seed" "$latest_model" latest latest paired_latest_canonical_eval "$LATEST_EVAL_SPLIT"
}

run_wx100_spot_seed() {
  local arm="$1"
  local seed="$2"
  local train_id
  local latest_model

  run_train "$arm" wx100 "$seed" "$GEANT_SAVE_INTERVAL" false
  train_id="$LAST_TRAIN_RUN_ID"
  latest_model="$(solver_run_dir "$train_id")/models/policy_latest.pt"
  require_file "$latest_model"
  run_eval "$arm" wx100 "$seed" "$latest_model" latest latest paired_latest_canonical_eval "$LATEST_EVAL_SPLIT"
}

generate_report() {
  section "Generate Report"
  if [[ "$DRY_RUN" == "1" ]]; then
    echo "Dry-run: skipping report generation."
    return 0
  fi

  run_cmd conda run -n virne python -c "
import csv
import pathlib
import re
import statistics
import sys
from collections import defaultdict

manifest_path = pathlib.Path(sys.argv[1])
eval_summary_path = pathlib.Path(sys.argv[2])
brain_best_path = pathlib.Path(sys.argv[3])
report_path = pathlib.Path(sys.argv[4])
stamp = sys.argv[5]
latest_eval_split = sys.argv[6]
brain_sweep_split = sys.argv[7]
eval_env_name = sys.argv[8]
candidate_arm = sys.argv[9]
current_arm = sys.argv[10]
brain_adopt_delta = float(sys.argv[11])
generalization_regression_delta = float(sys.argv[12])

rows = []
if manifest_path.exists():
    with manifest_path.open(newline='', encoding='utf-8') as f:
        for row in csv.DictReader(f):
            summary_path = pathlib.Path(row['summary_path'])
            metrics = {
                'acceptance_rate': '',
                'long_term_r2c_ratio': '',
                'clock_running_time': '',
                'status': 'missing_summary',
            }
            if summary_path.exists():
                with summary_path.open(newline='', encoding='utf-8') as sf:
                    summary_rows = list(csv.DictReader(sf))
                if summary_rows:
                    summary = summary_rows[-1]
                    metrics = {
                        'acceptance_rate': summary.get('acceptance_rate', ''),
                        'long_term_r2c_ratio': summary.get('long_term_r2c_ratio', ''),
                        'clock_running_time': summary.get('clock_running_time', ''),
                        'status': 'ok',
                    }
            checkpoint_label = row['checkpoint_label']
            match = re.search(r'policy_step_(\\d+)', checkpoint_label)
            checkpoint_step = int(match.group(1)) if match else None
            rows.append({
                **row,
                **metrics,
                'checkpoint_step': '' if checkpoint_step is None else str(checkpoint_step),
            })

fieldnames = [
    'arm',
    'topology',
    'seed',
    'kind',
    'selection_mode',
    'eval_split',
    'checkpoint_label',
    'checkpoint_step',
    'checkpoint_source',
    'weights_path',
    'run_id',
    'summary_path',
    'acceptance_rate',
    'long_term_r2c_ratio',
    'clock_running_time',
    'status',
]

eval_summary_path.parent.mkdir(parents=True, exist_ok=True)
with eval_summary_path.open('w', newline='', encoding='utf-8') as f:
    writer = csv.DictWriter(f, fieldnames=fieldnames)
    writer.writeheader()
    writer.writerows(rows)

brain_diag_rows = [
    row
    for row in rows
    if row['topology'] == 'brain'
    and row['status'] == 'ok'
    and row['selection_mode'] == 'diagnostic_checkpoint_sweep'
]
brain_best_rows = []
brain_keys = sorted({(row['arm'], row['seed']) for row in brain_diag_rows}, key=lambda item: (item[0], int(item[1])))
for arm, seed in brain_keys:
    candidates = []
    for row in brain_diag_rows:
        if row['arm'] != arm or row['seed'] != seed or row['acceptance_rate'] == '':
            continue
        try:
            acc = float(row['acceptance_rate'])
        except ValueError:
            continue
        candidates.append((acc, row))
    if not candidates:
        continue
    candidates.sort(key=lambda item: (
        item[0],
        int(item[1]['checkpoint_step']) if item[1]['checkpoint_step'] else 999999,
        item[1]['checkpoint_label'],
    ))
    brain_best_rows.append(candidates[-1][1])

with brain_best_path.open('w', newline='', encoding='utf-8') as f:
    writer = csv.DictWriter(f, fieldnames=fieldnames)
    writer.writeheader()
    writer.writerows(brain_best_rows)

latest_rows = [
    row
    for row in rows
    if row['kind'] == 'latest'
    and row['selection_mode'] == 'paired_latest_canonical_eval'
    and row['status'] == 'ok'
]

def _to_float(value):
    try:
        return float(value)
    except (TypeError, ValueError):
        return None

latest_by_topology_arm_seed = {}
for row in latest_rows:
    acc = _to_float(row['acceptance_rate'])
    if acc is None:
        continue
    latest_by_topology_arm_seed[(row['topology'], row['arm'], row['seed'])] = {
        'acceptance': acc,
        'long_term_r2c_ratio': _to_float(row['long_term_r2c_ratio']),
        'run_id': row['run_id'],
    }

topologies_seen = sorted({key[0] for key in latest_by_topology_arm_seed})
arms_seen = sorted({key[1] for key in latest_by_topology_arm_seed})

per_topology_arm_acc = defaultdict(list)
for (topology, arm, seed), info in latest_by_topology_arm_seed.items():
    per_topology_arm_acc[(topology, arm)].append((int(seed), info['acceptance']))
for key in per_topology_arm_acc:
    per_topology_arm_acc[key].sort()

paired_deltas = {}
for topology in topologies_seen:
    cur = {seed: acc for seed, acc in per_topology_arm_acc.get((topology, current_arm), [])}
    cand = {seed: acc for seed, acc in per_topology_arm_acc.get((topology, candidate_arm), [])}
    common = sorted(set(cur) & set(cand))
    if not common:
        continue
    per_seed = []
    for seed in common:
        per_seed.append({
            'seed': seed,
            'current': cur[seed],
            'candidate': cand[seed],
            'delta': cand[seed] - cur[seed],
        })
    deltas = [entry['delta'] for entry in per_seed]
    cur_values = [cur[seed] for seed in common]
    cand_values = [cand[seed] for seed in common]
    paired_deltas[topology] = {
        'per_seed': per_seed,
        'mean_delta': statistics.mean(deltas),
        'mean_current': statistics.mean(cur_values),
        'mean_candidate': statistics.mean(cand_values),
        'stdev_delta': statistics.pstdev(deltas) if len(deltas) > 1 else 0.0,
        'wins_candidate': sum(1 for d in deltas if d > 0),
        'wins_current': sum(1 for d in deltas if d < 0),
        'ties': sum(1 for d in deltas if d == 0),
    }

brain_summary = paired_deltas.get('brain')
guard_topologies = [t for t in topologies_seen if t != 'brain']

verdict_lines = []
verdict_state = 'INCONCLUSIVE'
if brain_summary is None:
    verdict_lines.append('no brain latest results for both arms — cannot evaluate primary decision axis')
else:
    brain_delta = brain_summary['mean_delta']
    brain_pass = brain_delta >= brain_adopt_delta
    verdict_lines.append(
        f'brain mean paired delta = {brain_delta:+.3f} '
        f'(threshold >= +{brain_adopt_delta:.3f}) -> {\"PASS\" if brain_pass else \"FAIL\"}'
    )
    guard_failures = []
    guard_passes = []
    for topology in guard_topologies:
        summary = paired_deltas.get(topology)
        if summary is None:
            guard_failures.append(f'{topology}: MISSING (no paired results)')
            continue
        delta = summary['mean_delta']
        regression_floor = -generalization_regression_delta
        if delta >= regression_floor:
            guard_passes.append(
                f'{topology} mean paired delta = {delta:+.3f} '
                f'(floor >= {regression_floor:+.3f}) -> PASS'
            )
        else:
            guard_failures.append(
                f'{topology} mean paired delta = {delta:+.3f} '
                f'(floor >= {regression_floor:+.3f}) -> FAIL (regression)'
            )
    verdict_lines.extend(guard_passes)
    verdict_lines.extend(guard_failures)

    if brain_pass and not guard_failures:
        verdict_state = 'ADOPT_CANDIDATE'
    elif not brain_pass and not guard_failures:
        verdict_state = 'KEEP_CURRENT'
    elif brain_pass and guard_failures:
        verdict_state = 'INCONCLUSIVE_BRAIN_WIN_WITH_REGRESSIONS'
    else:
        verdict_state = 'KEEP_CURRENT'

with report_path.open('w', encoding='utf-8') as f:
    f.write('# AlphaZero Candidate Overnight\\n\\n')
    f.write(f'stamp: {stamp}\\n\\n')

    f.write('## Decision Summary\\n\\n')
    f.write(f'- candidate arm: {candidate_arm}\\n')
    f.write(f'- current arm:   {current_arm}\\n')
    f.write(f'- primary decision axis: brain (must improve by >= +{brain_adopt_delta:.3f})\\n')
    f.write(f'- non-regression guards: {\", \".join(guard_topologies) if guard_topologies else \"(none available)\"} (must not regress beyond -{generalization_regression_delta:.3f})\\n')
    f.write(f'- primary metric: mean seed-paired acceptance under fixed {eval_env_name} on latest checkpoint (split={latest_eval_split})\\n\\n')
    f.write(f'**verdict: {verdict_state}**\\n\\n')
    for line in verdict_lines:
        f.write(f'- {line}\\n')
    f.write('\\n')
    if verdict_state == 'ADOPT_CANDIDATE':
        f.write('Recommendation: adopt candidate arm as new purecpp default.\\n')
    elif verdict_state == 'KEEP_CURRENT':
        f.write('Recommendation: keep current arm; candidate did not clear the brain bar or regressed on guards.\\n')
    elif verdict_state == 'INCONCLUSIVE_BRAIN_WIN_WITH_REGRESSIONS':
        f.write('Recommendation: do not auto-adopt. Candidate helps brain but hurts generalization guards; escalate to a scoped decision (per-topology config, or targeted fix).\\n')
    else:
        f.write('Recommendation: inconclusive; re-run with more seeds or inspect per-seed deltas below.\\n')
    f.write('\\n')

    f.write('## Paired Deltas (candidate - current, per seed, latest checkpoint)\\n\\n')
    if paired_deltas:
        for topology in sorted(paired_deltas):
            summary = paired_deltas[topology]
            f.write(f'### {topology}\\n\\n')
            f.write('| seed | current | candidate | delta |\\n')
            f.write('| ---- | ------- | --------- | ----- |\\n')
            for entry in summary['per_seed']:
                f.write(
                    f\"| {entry['seed']} | {entry['current']:.3f} | {entry['candidate']:.3f} | {entry['delta']:+.3f} |\\n\"
                )
            f.write(
                f\"\\n- mean: current={summary['mean_current']:.3f}  candidate={summary['mean_candidate']:.3f}  \"
                f\"delta={summary['mean_delta']:+.3f}  (stdev delta={summary['stdev_delta']:.3f})\\n\"
            )
            f.write(
                f\"- per-seed wins: candidate={summary['wins_candidate']}, current={summary['wins_current']}, ties={summary['ties']}\\n\\n\"
            )
    else:
        f.write('- no paired latest deltas available\\n\\n')

    f.write('## Method Notes\\n\\n')
    f.write(f'- paired arms were trained under arm-specific train semantics and evaluated under fixed {eval_env_name} semantics\\n')
    f.write(f'- latest paired comparisons use split {latest_eval_split}\\n')
    f.write(f'- brain checkpoint sweep uses split {brain_sweep_split} and is diagnostic only\\n')
    f.write('- brain checkpoint best-of-sweep is NOT model selection (no val split exists in journal datasets); it only characterizes whether brain latest is an unrepresentative dip\\n')
    f.write('- generalization topologies are treated as non-regression guards, not co-equal optimization targets\\n\\n')

    f.write('## Paired Latest Results (raw, per arm)\\n\\n')
    grouped_latest = defaultdict(list)
    for row in latest_rows:
        grouped_latest[(row['topology'], row['arm'])].append(row)
    if grouped_latest:
        for topology, arm in sorted(grouped_latest, key=lambda item: (item[0], item[1])):
            rows_for_group = sorted(grouped_latest[(topology, arm)], key=lambda row: int(row['seed']))
            values = [float(row['acceptance_rate']) for row in rows_for_group if row['acceptance_rate'] != '']
            mean_value = statistics.mean(values) if values else None
            f.write(f'### {topology} / {arm}\\n\\n')
            for row in rows_for_group:
                f.write(
                    f\"- seed {row['seed']}: acceptance={row['acceptance_rate']} \"
                    f\"lrc={row['long_term_r2c_ratio']} clock={row['clock_running_time']} \"
                    f\"run={row['run_id']}\\n\"
                )
            if mean_value is not None:
                f.write(f'- mean acceptance: {mean_value:.3f}\\n')
            f.write('\\n')
    else:
        f.write('- no latest rows recorded\\n\\n')

    f.write('## Brain Diagnostic Checkpoint Sweep\\n\\n')
    f.write('Reports best-of-sweep per (arm, seed) on split ' + brain_sweep_split + '. This is diagnostic, not model selection. Use it only to answer: is brain-latest an unrepresentative dip?\\n\\n')
    if brain_best_rows:
        for row in sorted(brain_best_rows, key=lambda row: (row['arm'], int(row['seed']))):
            f.write(
                f\"- arm {row['arm']} seed {row['seed']}: checkpoint={row['checkpoint_label']} \"
                f\"acceptance={row['acceptance_rate']} run={row['run_id']}\\n\"
            )
        diag_by_arm_seed = defaultdict(list)
        for row in rows:
            if row['topology'] == 'brain' and row['selection_mode'] == 'diagnostic_checkpoint_sweep' and row['status'] == 'ok':
                acc = _to_float(row['acceptance_rate'])
                if acc is not None:
                    diag_by_arm_seed[(row['arm'], row['seed'])].append(acc)
        if diag_by_arm_seed:
            f.write('\\n### Brain sweep distribution (sanity check on instability)\\n\\n')
            for (arm, seed) in sorted(diag_by_arm_seed):
                values = diag_by_arm_seed[(arm, seed)]
                f.write(
                    f\"- arm {arm} seed {seed}: n={len(values)} min={min(values):.3f} \"
                    f\"median={statistics.median(values):.3f} mean={statistics.mean(values):.3f} \"
                    f\"max={max(values):.3f}\\n\"
                )
    else:
        f.write('- no diagnostic brain checkpoint rows recorded\\n')

    f.write('\\n## Files\\n\\n')
    f.write(f'- eval summary: {eval_summary_path}\\n')
    f.write(f'- brain diagnostic best: {brain_best_path}\\n')
    f.write(f'- manifest: {manifest_path}\\n')
" "$EVAL_MANIFEST_CSV" "$EVAL_SUMMARY_CSV" "$BRAIN_DIAGNOSTIC_BEST_CSV" "$REPORT_MD" "$STAMP" "$LATEST_EVAL_SPLIT" "$BRAIN_SWEEP_SPLIT" "$EVAL_ENV_NAME" "$CANDIDATE_ARM" "$CURRENT_ARM" "$BRAIN_ADOPT_DELTA" "$GENERALIZATION_REGRESSION_DELTA"

  cat "$REPORT_MD"
}

write_headers
write_env_snapshots
print_plan

if [[ "$DRY_RUN" == "1" ]]; then
  echo
  echo "Dry-run only. No commands executed."
  exit 0
fi

preflight_checks
prepare_datasets

for arm in $ARM_NAMES; do
  if [[ "$RUN_GEANT" == "1" ]]; then
    for seed in $GEANT_SEEDS; do
      run_geant_seed "$arm" "$seed"
    done
  fi

  if [[ "$RUN_BRAIN" == "1" ]]; then
    for seed in $BRAIN_SEEDS; do
      run_brain_seed "$arm" "$seed"
    done
  fi

  if [[ "$RUN_WX100_SPOT" == "1" ]]; then
    for seed in $WX100_SEEDS; do
      run_wx100_spot_seed "$arm" "$seed"
    done
  fi
done

generate_report

section "Done"
echo "analysis_root:             $ANALYSIS_ROOT"
echo "report:                    $REPORT_MD"
echo "eval_summary:              $EVAL_SUMMARY_CSV"
echo "brain_diagnostic_best:     $BRAIN_DIAGNOSTIC_BEST_CSV"
