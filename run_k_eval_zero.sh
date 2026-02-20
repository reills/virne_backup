#!/bin/bash

# Run AlphaZero SFC solver in inference mode for a sweep of k-shortest settings.
# The script reuses pre-trained models (policy_latest.pt) produced by the training sweep.
#
# Usage:
#   ./run_k_eval_zero.sh                # evaluate default k range (1-12)
#   K_VALUES="3 5 7" ./run_k_eval_zero.sh   # evaluate specific ks
#
# Prerequisites:
#   - conda activate virne
#   - build the code base (`python main.py` should already work)
#   - policy checkpoints exist under $MODEL_ROOT in directories named az_k_sweep-kXX-*

set -euo pipefail

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
PROJECT_ROOT="$SCRIPT_DIR"

# ----------------------- Configuration --------------------------------------

# Range of k values to evaluate (space separated). Override via env K_VALUES.
# Limited to k1-11 (k12+ didn't generate models in training)
: "${K_VALUES:="2 3"}"

# Base directory where training runs (with models/policy_latest.pt) are stored.
MODEL_ROOT="${MODEL_ROOT:-${PROJECT_ROOT}/results/alpha_zero_sfc_resweep/alpha_zero_sfc}"

# Maximum parallel jobs to run at once
MAX_PARALLEL="${MAX_PARALLEL:-5}"

# Number of CPU threads each Python process may use (controls BLAS/torch pools).
THREADS_PER_PROCESS="${THREADS_PER_PROCESS:-1}"

# Number of virtual networks to evaluate from the fixed dataset.
NUM_VNETS="${NUM_VNETS:-1000}"

# Dataset directories (physical network + virtual requests) used for evaluation.
DATASET_DIR="${DATASET_DIR:-${PROJECT_ROOT}/datasets/generated/1000_vnets}"

# Where to store evaluation outputs.
RESULTS_BASE_DIR="${RESULTS_BASE_DIR:-${PROJECT_ROOT}/results/alpha_zero_sfc_eval}"

# Monte Carlo parameters to mirror during inference.
COMPUTATION_BUDGET="${COMPUTATION_BUDGET:-64}"
EXPLORATION_CONSTANT="${EXPLORATION_CONSTANT:-1.4}"

# Seed for deterministic replay (matches training artifact by default).
EVAL_SEED="${EVAL_SEED:-0}"

# Optional CPU core pinning (space-separated list passed via TASKSET_CORES env).
TASKSET_CORES="${TASKSET_CORES:-}"
IFS=' ' read -r -a TASKSET_CORES_ARR <<< "$TASKSET_CORES"
NUM_TASKSET_CORES=${#TASKSET_CORES_ARR[@]}
if (( NUM_TASKSET_CORES > 0 )) && (( NUM_TASKSET_CORES < MAX_PARALLEL )); then
  echo "WARN: TASKSET_CORES count ($NUM_TASKSET_CORES) is smaller than MAX_PARALLEL ($MAX_PARALLEL); cores will repeat across batches."
fi

# ----------------------------------------------------------------------------

timestamp() {
  date +"%Y%m%dT%H%M%S"
}

find_model_for_k() {
  local k_int="$1"
  local k_tag
  printf -v k_tag "k%02d" "$k_int"
  local pattern="${MODEL_ROOT}/az_k_sweep-${k_tag}-"*
  local candidates=()
  while IFS= read -r path; do
    candidates+=("$path")
  done < <(ls -dt ${pattern} 2>/dev/null || true)

  if [[ ${#candidates[@]} -eq 0 ]]; then
    echo ""
    return
  fi
  local run_dir="${candidates[0]}"
  local model_path="${run_dir}/models/policy_latest.pt"
  if [[ -f "$model_path" ]]; then
    echo "$model_path"
  else
    echo ""
  fi
}

mkdir -p "$RESULTS_BASE_DIR"

echo "INFO: Starting AlphaZero inference sweep (parallel mode: max $MAX_PARALLEL jobs)"
echo "INFO: Using dataset at $DATASET_DIR"
echo "INFO: Saving results under $RESULTS_BASE_DIR"
echo "INFO: Model root: $MODEL_ROOT"

# Function to run a single k evaluation
run_eval() {
  local k="$1"
  local core_binding="${2:-}"

  if ! [[ "$k" =~ ^[0-9]+$ ]]; then
    echo "WARN: Skipping non-integer k value '$k'."
    return
  fi

  local model_path=$(find_model_for_k "$k")
  if [[ -z "$model_path" ]]; then
    printf "ERROR: No trained model found for k=%s under %s\n" "$k" "$MODEL_ROOT" >&2
    return 1
  fi

  local run_stamp=$(timestamp)
  local k_padded
  printf -v k_padded "k%02d" "$k"
  local output_dir="${RESULTS_BASE_DIR}/alpha_zero_eval_${k_padded}_${run_stamp}"
  mkdir -p "$output_dir"

  local cmd=(python main.py
    solver.solver_name=alpha_zero_sfc
    solver.k_shortest="$k"
    experiment.save_root_dir="$RESULTS_BASE_DIR"
    experiment.run_id="eval-${k_padded}-${run_stamp}"
    experiment.num_simulations=1
    experiment.seed="$EVAL_SEED"
    experiment.if_load_p_net=true
    experiment.if_load_v_nets=true
    "+simulation.p_net_dataset_dir=$DATASET_DIR"
    "+simulation.v_nets_dataset_dir=$DATASET_DIR"
    "+dir_save_dataset=$DATASET_DIR"
    use_fixed_dataset=true
    v_sim_setting.num_v_nets="$NUM_VNETS"
    training.inference_only=true
    training.enable_async_learner=false
    training.num_train_epochs=0
    training.max_training_steps=0
    training.disable_trajectory_writing=true
    training.resume_training=false
    training.if_use_random_training_seed=false
    training.computation_budget="$COMPUTATION_BUDGET"
    training.c_puct="$EXPLORATION_CONSTANT"
    training.use_cpp_mcts=true
    training.alphazero_model_path="$model_path"
    solver.pretrained_model_path="$model_path"
    hydra.run.dir="$output_dir")

  if [[ -n "$core_binding" ]]; then
    cmd=(taskset -c "$core_binding" "${cmd[@]}")
    echo "[k=${k}] INFO: Pinning process to CPU core(s): $core_binding"
  fi

  echo "[k=${k}] INFO: Starting evaluation using model ${model_path}"
  OMP_NUM_THREADS="$THREADS_PER_PROCESS" \
  MKL_NUM_THREADS="$THREADS_PER_PROCESS" \
  OPENBLAS_NUM_THREADS="$THREADS_PER_PROCESS" \
  NUMEXPR_NUM_THREADS="$THREADS_PER_PROCESS" \
  TORCH_NUM_THREADS="$THREADS_PER_PROCESS" \
    "${cmd[@]}"

  echo "[k=${k}] INFO: Completed evaluation. Output: $output_dir"
}

# Export functions and variables so they're available in subshells
export -f run_eval
export -f find_model_for_k
export -f timestamp
export MODEL_ROOT RESULTS_BASE_DIR DATASET_DIR EVAL_SEED COMPUTATION_BUDGET EXPLORATION_CONSTANT NUM_VNETS

# Run evaluations in parallel with max concurrent jobs
PIDS=()
core_idx=0
for k in $K_VALUES; do
  core_binding=""
  if (( NUM_TASKSET_CORES > 0 )); then
    core_binding="${TASKSET_CORES_ARR[$core_idx]}"
    core_idx=$(( (core_idx + 1) % NUM_TASKSET_CORES ))
  fi

  run_eval "$k" "$core_binding" &
  PIDS+=($!)

  # Wait if we've reached max parallel jobs
  if (( ${#PIDS[@]} >= MAX_PARALLEL )); then
    echo "INFO: Waiting for batch of $MAX_PARALLEL jobs to complete..."
    wait "${PIDS[@]}"
    PIDS=()
    core_idx=0
  fi
done

# Wait for any remaining jobs
if (( ${#PIDS[@]} > 0 )); then
  echo "INFO: Waiting for final batch of ${#PIDS[@]} jobs to complete..."
  wait "${PIDS[@]}"
  core_idx=0
fi

echo "INFO: All evaluations finished."
