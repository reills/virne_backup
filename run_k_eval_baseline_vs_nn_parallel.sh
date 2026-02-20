#!/bin/bash

# Parallel evaluator for AlphaZero SFC models with optional NN and baseline modes.
# Keeps the physical/virtual network datasets fixed and writes Hydra outputs under
# results/baseline_vs_nn_comparison by default.

set -euo pipefail

ROOT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
cd "$ROOT_DIR"

MODEL_ROOT="${MODEL_ROOT:-${ROOT_DIR}/results/alpha_zero_sfc}"
DATASET_DIR="${DATASET_DIR:-${ROOT_DIR}/datasets/generated/1000_vnets}"
RESULTS_DIR="${RESULTS_DIR:-${ROOT_DIR}/results/baseline_vs_nn_comparison}"

GPU_ID="${GPU_ID:-0}"
CPU_THREADS="${CPU_THREADS:-1}"
GPU_BATCH_SIZE="${GPU_BATCH_SIZE:-16}"
COMPUTATION_BUDGET="${COMPUTATION_BUDGET:-64}"
EXPLORATION_CONSTANT="${EXPLORATION_CONSTANT:-1.4}"
EVAL_SEED="${EVAL_SEED:-0}"
NUM_VNETS="${NUM_VNETS:-1000}"

MODE="nn"
K_SPEC=""
CLI_DATASET_DIR=""
MAX_PARALLEL="${MAX_PARALLEL:-2}"
TASKSET_CORES="${TASKSET_CORES:-}"
IFS=' ' read -r -a TASKSET_CORES_ARR <<< "$TASKSET_CORES"
NUM_TASKSET_CORES=${#TASKSET_CORES_ARR[@]}

usage() {
  cat <<'EOF'
Usage: run_k_eval_baseline_vs_nn_parallel.sh [options]

Options:
  --mode {nn|baseline}      Evaluation mode (default: nn)
  --k-values SPEC           Comma/range list like "13-15" or "4,6,8" (required)
  --cpu-threads N           Threads per process for BLAS/OMP (default: env CPU_THREADS or 1)
  --dataset-dir PATH        Override dataset directory (default: DATASET_DIR env or datasets/generated/1000_vnets)
  --max-parallel N          Max concurrent jobs (default: MAX_PARALLEL env or 2)
  --taskset CORES           Space-separated CPU cores to pin jobs (optional)
  -h, --help                Show this help

Environment overrides:
  MODEL_ROOT, DATASET_DIR, RESULTS_DIR, GPU_ID, CPU_THREADS, GPU_BATCH_SIZE,
  COMPUTATION_BUDGET, EXPLORATION_CONSTANT, EVAL_SEED, NUM_VNETS.
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --mode)
      MODE="$2"; shift 2 ;;
    --k-values)
      K_SPEC="$2"; shift 2 ;;
    --cpu-threads)
      CPU_THREADS="$2"; shift 2 ;;
    --max-parallel)
      MAX_PARALLEL="$2"; shift 2 ;;
    --dataset-dir)
      CLI_DATASET_DIR="$2"; shift 2 ;;
    --taskset)
      TASKSET_CORES="$2"; shift 2
      IFS=' ' read -r -a TASKSET_CORES_ARR <<< "$TASKSET_CORES"
      NUM_TASKSET_CORES=${#TASKSET_CORES_ARR[@]}
      ;;
    -h|--help)
      usage
      exit 0 ;;
    *)
      echo "Unknown option: $1" >&2
      usage >&2
      exit 1 ;;
  esac
done

if [[ -z "$K_SPEC" ]]; then
  echo "ERROR: --k-values is required" >&2
  usage >&2
  exit 1
fi

if [[ "$MODE" != "nn" && "$MODE" != "baseline" ]]; then
  echo "ERROR: --mode must be 'nn' or 'baseline'" >&2
  exit 1
fi

if ! [[ "$MAX_PARALLEL" =~ ^[0-9]+$ ]] || (( MAX_PARALLEL < 1 )); then
  echo "ERROR: --max-parallel must be a positive integer" >&2
  exit 1
fi

if ! [[ "$CPU_THREADS" =~ ^[0-9]+$ ]] || (( CPU_THREADS < 1 )); then
  echo "ERROR: --cpu-threads must be a positive integer" >&2
  exit 1
fi

if (( NUM_TASKSET_CORES > 0 )) && (( NUM_TASKSET_CORES < MAX_PARALLEL )); then
  echo "WARN: Provided fewer taskset cores (${NUM_TASKSET_CORES}) than max parallel jobs (${MAX_PARALLEL}); cores will repeat." >&2
fi

if [[ -n "$CLI_DATASET_DIR" ]]; then
  DATASET_DIR="$CLI_DATASET_DIR"
fi

read -ra K_VALUES <<< "$(python - "$K_SPEC" <<'PY'
import sys
spec = sys.argv[1]
vals = set()
for part in spec.split(','):
    part = part.strip()
    if not part:
        continue
    if '-' in part:
        lo, hi = part.split('-', 1)
        lo = int(lo); hi = int(hi)
        if lo > hi:
            lo, hi = hi, lo
        vals.update(range(lo, hi + 1))
    else:
        vals.add(int(part))
if not vals:
    raise SystemExit("no k values parsed")
print(' '.join(str(v) for v in sorted(vals)))
PY
)"

if [[ ${#K_VALUES[@]} -eq 0 ]]; then
  echo "ERROR: no valid k values parsed from '${K_SPEC}'" >&2
  exit 1
fi

timestamp() { date +"%Y%m%dT%H%M%S"; }

find_model() {
  local k="$1"
  local tag
  printf -v tag "k%02d" "$k"
  local direct_path="${MODEL_ROOT}/policy_latest_${tag}.pt"
  if [[ -f "$direct_path" ]]; then
    echo "$direct_path"
    return
  fi
  local latest
  latest=$(ls -dt "${MODEL_ROOT}/az_k_sweep-${tag}-"* 2>/dev/null | head -n1 || true)
  if [[ -n "$latest" ]]; then
    local candidate
    for candidate in \
      "${latest}/models/policy_latest_${tag}.pt" \
      "${latest}/models/policy_latest.pt"
    do
      if [[ -f "$candidate" ]]; then
        echo "$candidate"
        return
      fi
    done
  fi
}

echo "=== AlphaZero evaluations (${MODE}) ==="
echo "Models root:    ${MODEL_ROOT}"
echo "Dataset dir:    ${DATASET_DIR}"
echo "Results dir:    ${RESULTS_DIR}"
echo "k values:       ${K_VALUES[*]}"
echo "Max parallel:   ${MAX_PARALLEL}"
echo "GPU id (NN):    ${GPU_ID}"
echo "CPU threads:    ${CPU_THREADS}"
if (( NUM_TASKSET_CORES > 0 )); then
  echo "Taskset cores:  ${TASKSET_CORES}"
fi
echo ""

mkdir -p "$RESULTS_DIR"

run_stamp=$(timestamp)

declare -a ACTIVE_PIDS=()
declare -A PID_LABEL=()

launch_job() {
  local k="$1"
  local core_binding="${2:-}"
  printf -v k_tag "k%02d" "$k"
  local run_id mode_flag out_dir model_path=""

  if [[ "$MODE" == "nn" ]]; then
    model_path=$(find_model "$k")
    if [[ -z "$model_path" ]]; then
      echo "[WARN] Skipping k=${k}: no model found under ${MODEL_ROOT}" >&2
      return
    fi
    run_id="nn-${k_tag}-${run_stamp}"
    mode_flag="nn"
  else
    run_id="baseline-${k_tag}-${run_stamp}"
    mode_flag="baseline"
  fi

  out_dir="${RESULTS_DIR}/alpha_zero_sfc/${run_id}"
  mkdir -p "$out_dir"

  echo "Launching k=${k} (${mode_flag}) → ${out_dir}"

  if [[ -n "$core_binding" ]]; then
    echo "  ↳ pinning to CPU core(s): ${core_binding}"
  fi

  local env_cuda
  if [[ "$MODE" == "nn" ]]; then
    env_cuda="${GPU_ID}"
  else
    env_cuda=""
  fi

  (
    export CUDA_VISIBLE_DEVICES="$env_cuda"
    export OMP_NUM_THREADS="$CPU_THREADS"
    export MKL_NUM_THREADS="$CPU_THREADS"
    export OPENBLAS_NUM_THREADS="$CPU_THREADS"
    export NUMEXPR_NUM_THREADS="$CPU_THREADS"

    local cmd=(
      python main.py
      solver.solver_name=alpha_zero_sfc
      solver.k_shortest="$k"
      experiment.save_root_dir="$RESULTS_DIR"
      experiment.run_id="$run_id"
      experiment.num_simulations=1
      experiment.seed="$EVAL_SEED"
      experiment.if_load_p_net=true
      experiment.if_load_v_nets=true
      +simulation.p_net_dataset_dir="$DATASET_DIR"
      +simulation.v_nets_dataset_dir="$DATASET_DIR"
      use_fixed_dataset=true
      +dir_save_dataset="$DATASET_DIR"
      v_sim_setting.num_v_nets="$NUM_VNETS"
      training.inference_only=true
      training.enable_async_learner=false
      training.num_train_epochs=0
      training.max_training_steps=0
      training.disable_trajectory_writing=true
      training.if_use_random_training_seed=false
      training.num_workers=1
      training.computation_budget="$COMPUTATION_BUDGET"
      training.c_puct="$EXPLORATION_CONSTANT"
      training.use_cpp_mcts=true
      training.uniform_prior=$([[ "$MODE" == "baseline" ]] && echo true || echo false)
      training.use_cuda=$([[ "$MODE" == "nn" ]] && echo true || echo false)
      training.use_batched_gpu=$([[ "$MODE" == "nn" ]] && echo true || echo false)
      training.gpu_batch_size="$GPU_BATCH_SIZE"
      training.resume_training=false
      training.use_neural_network=$([[ "$MODE" == "nn" ]] && echo true || echo false)
      training.use_nn_policy=$([[ "$MODE" == "nn" ]] && echo true || echo false)
      training.use_nn_value=$([[ "$MODE" == "nn" ]] && echo true || echo false)
      training.alphazero_model_path="$model_path"
      solver.pretrained_model_path="$model_path"
      hydra.run.dir="$out_dir"
    )
    if [[ "$MODE" == "baseline" ]]; then
      cmd+=(
        +training.dirichlet_epsilon=0
        +training.dirichlet_alpha=0
        +training.temperature_train=0
        +training.temperature_eval=0
        training.uniform_prior=true
        training.use_neural_network=false
        training.use_nn_policy=false
        training.use_nn_value=false
        training.use_cuda=false
        training.use_batched_gpu=false
      )
    fi

    if [[ -n "$core_binding" ]]; then
      cmd=(taskset -c "$core_binding" "${cmd[@]}")
    fi

    "${cmd[@]}" > "${out_dir}/stdout.log" 2>&1
  ) &

  local pid=$!
  ACTIVE_PIDS+=($pid)
  PID_LABEL[$pid]="k=${k} (${mode_flag})"
}

wait_for_pid() {
  local pid=$1
  local label=${PID_LABEL[$pid]:-PID${pid}}
  if wait "$pid"; then
    echo "  ${label} finished ✓"
  else
    echo "  ${label} failed ✗" >&2
  fi
  unset PID_LABEL[$pid]
}

prune_completed() {
  local remaining=()
  for pid in "${ACTIVE_PIDS[@]}"; do
    if kill -0 "$pid" 2>/dev/null; then
      remaining+=($pid)
    else
      wait_for_pid "$pid"
    fi
  done
  ACTIVE_PIDS=("${remaining[@]}")
}

for k in "${K_VALUES[@]}"; do
  if ! [[ "$k" =~ ^[0-9]+$ ]]; then
    echo "[WARN] Skipping non-integer k='${k}'" >&2
    continue
  fi
  core_binding=""
  if (( NUM_TASKSET_CORES > 0 )); then
    core_binding="${TASKSET_CORES_ARR[0]}"
    TASKSET_CORES_ARR=("${TASKSET_CORES_ARR[@]:1}" "$core_binding")
  fi

  prune_completed

  while (( ${#ACTIVE_PIDS[@]} >= MAX_PARALLEL )); do
    wait_for_pid "${ACTIVE_PIDS[0]}"
    ACTIVE_PIDS=(${ACTIVE_PIDS[@]:1})
  done

  launch_job "$k" "$core_binding"
done

for pid in "${ACTIVE_PIDS[@]}"; do
  wait_for_pid "$pid"
done

echo ""
echo "All ${MODE} evaluations completed. Outputs under ${RESULTS_DIR}."
