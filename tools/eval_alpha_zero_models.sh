#!/bin/bash

# Evaluate AlphaZero SFC models for a given list of k-shortest path settings.
# This script mirrors the evaluation command from run_k_eval_zero.sh but allows
# pointing directly to frozen checkpoints such as policy_latest_kXX.pt.
#
# Usage:
#   ./tools/eval_alpha_zero_models.sh                   # evaluates default K set
#   K_VALUES="1 4 5" ./tools/eval_alpha_zero_models.sh  # override ks
#
# Environment variables you may override:
#   DATASET_DIR          Dataset used for evaluation (default: datasets/generated/1000_vnets)
#   RESULTS_BASE_DIR     Directory where evaluation outputs are stored
#   MODEL_ROOT           Base directory containing az_k_sweep-kXX-* run folders
#   MAX_PARALLEL         Max concurrent eval jobs (default: 2)
#   THREADS_PER_PROCESS  BLAS/torch thread cap per process (default: 1)
#
# Requirements:
#   - conda environment with project dependencies activated
#   - checkpoints named policy_latest_kXX.pt exist under $MODEL_ROOT/az_k_sweep-kXX-*/

set -euo pipefail

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
PROJECT_ROOT=$( cd "$SCRIPT_DIR/.." && pwd )

: "${K_VALUES:="1 4 5 6 7 8 9 10 11 12 13 14 15"}"
: "${MODEL_ROOT:="${PROJECT_ROOT}/results/alpha_zero_sfc"}"
: "${DATASET_DIR:="${PROJECT_ROOT}/datasets/generated/1000_vnets"}"
: "${RESULTS_BASE_DIR:="${PROJECT_ROOT}/results/alpha_zero_sfc_eval"}"
: "${MAX_PARALLEL:=2}"
: "${THREADS_PER_PROCESS:=1}"

timestamp() {
  date +"%Y%m%dT%H%M%S"
}

find_frozen_model_for_k() {
  local k="$1"
  local k_tag
  printf -v k_tag "k%02d" "$k"
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
  local frozen_model="${run_dir}/models/policy_latest_${k_tag}.pt"
  if [[ -f "$frozen_model" ]]; then
    echo "$frozen_model"
  else
    echo ""
  fi
}

mkdir -p "$RESULTS_BASE_DIR"

echo "INFO: AlphaZero evaluation"
echo "INFO: Model root        : $MODEL_ROOT"
echo "INFO: Dataset directory : $DATASET_DIR"
echo "INFO: Results directory : $RESULTS_BASE_DIR"
echo "INFO: Evaluating ks     : $K_VALUES"
echo "INFO: Max parallel jobs : $MAX_PARALLEL"

run_eval() {
  local k="$1"
  if ! [[ "$k" =~ ^[0-9]+$ ]]; then
    echo "[k=${k}] WARN: skipping non-integer value."
    return 0
  fi

  local model_path
  model_path=$(find_frozen_model_for_k "$k")
  if [[ -z "$model_path" ]]; then
    printf "[k=%s] ERROR: checkpoint policy_latest_k%02d.pt not found under %s\n" "$k" "$k" "$MODEL_ROOT" >&2
    return 1
  fi

  local stamp
  stamp=$(timestamp)
  local k_tag
  printf -v k_tag "k%02d" "$k"
  local output_dir="${RESULTS_BASE_DIR}/alpha_zero_eval_${k_tag}_${stamp}"
  mkdir -p "$output_dir"

  echo "[k=${k}] INFO: evaluating model $model_path"
  OMP_NUM_THREADS="$THREADS_PER_PROCESS" \
  MKL_NUM_THREADS="$THREADS_PER_PROCESS" \
  OPENBLAS_NUM_THREADS="$THREADS_PER_PROCESS" \
  NUMEXPR_NUM_THREADS="$THREADS_PER_PROCESS" \
  TORCH_NUM_THREADS="$THREADS_PER_PROCESS" \
    python "$PROJECT_ROOT/main.py" \
      solver.solver_name=alpha_zero_sfc \
      solver.k_shortest="$k" \
      experiment.save_root_dir="$RESULTS_BASE_DIR" \
      experiment.run_id="eval-${k_tag}-${stamp}" \
      experiment.num_simulations=1 \
      experiment.seed=0 \
      experiment.if_load_p_net=true \
      experiment.if_load_v_nets=true \
      "+simulation.p_net_dataset_dir=$DATASET_DIR" \
      "+simulation.v_nets_dataset_dir=$DATASET_DIR" \
      "+dir_save_dataset=$DATASET_DIR" \
      use_fixed_dataset=true \
      v_sim_setting.num_v_nets=1000 \
      training.inference_only=true \
      training.enable_async_learner=false \
      training.num_train_epochs=0 \
      training.max_training_steps=0 \
      training.disable_trajectory_writing=true \
      training.resume_training=false \
      training.if_use_random_training_seed=false \
      training.computation_budget=64 \
      training.c_puct=1.4 \
      training.use_cpp_mcts=true \
      training.alphazero_model_path="$model_path" \
      solver.pretrained_model_path="$model_path" \
      hydra.run.dir="$output_dir"

  echo "[k=${k}] INFO: evaluation complete. Results in $output_dir"
}

export -f run_eval
export -f find_frozen_model_for_k
export -f timestamp
export PROJECT_ROOT MODEL_ROOT DATASET_DIR RESULTS_BASE_DIR THREADS_PER_PROCESS

printf '%s\n' $K_VALUES | xargs -n1 -P "$MAX_PARALLEL" bash -c 'run_eval "$0"'

echo "INFO: All evaluations dispatched."
