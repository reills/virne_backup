#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

RESULTS_ROOT="$ROOT_DIR/results/journal_suite/results"
SOLVER_RESULTS_ROOT="$RESULTS_ROOT/alpha_zero_sfc"
STAMP="${STAMP:-$(date -u +%Y%m%dT%H%M%SZ)}"

SEEDS="${SEEDS:-0 1 2}"
VARIANTS="${VARIANTS:-baseline no_persistent no_mix_seed no_both}"
STAGES="${STAGES:-train eval}"
MAX_PARALLEL="${MAX_PARALLEL:-3}"

TRAIN_NUM_WORKERS="${TRAIN_NUM_WORKERS:-4}"
TRAIN_MAX_STEPS="${TRAIN_MAX_STEPS:-50}"
TRAIN_NUM_V_NETS="${TRAIN_NUM_V_NETS:-1000}"
EVAL_NUM_V_NETS="${EVAL_NUM_V_NETS:-1000}"
COMPUTATION_BUDGET="${COMPUTATION_BUDGET:-96}"
THREADS_PER_PROCESS="${THREADS_PER_PROCESS:-1}"

NN_EMBED_DIM="${NN_EMBED_DIM:-96}"
NN_HIDDEN_DIM="${NN_HIDDEN_DIM:-96}"
NN_GNN_LAYERS="${NN_GNN_LAYERS:-2}"
NN_HEADS="${NN_HEADS:-6}"
NN_TRANSFORMER_LAYERS="${NN_TRANSFORMER_LAYERS:-2}"

variant_env_args() {
  local variant="$1"
  case "$variant" in
    baseline)
      printf '%s\n' \
        "AZSFC_CPP_PERSISTENT_TREE=1" \
        "AZSFC_CPP_MIX_STEP_SEED=1" \
        "AZSFC_CPP_AVAILABLE_SHORTEST_FALLBACK=1" \
        "AZSFC_CPP_SHARE_REVERSE_EDGE_CAPACITY=1" \
        "AZSFC_CPP_USE_MEAN_Q_ROOT_VALUE=1"
      ;;
    no_persistent)
      printf '%s\n' \
        "AZSFC_CPP_PERSISTENT_TREE=0" \
        "AZSFC_CPP_MIX_STEP_SEED=1" \
        "AZSFC_CPP_AVAILABLE_SHORTEST_FALLBACK=1" \
        "AZSFC_CPP_SHARE_REVERSE_EDGE_CAPACITY=1" \
        "AZSFC_CPP_USE_MEAN_Q_ROOT_VALUE=1"
      ;;
    no_mix_seed)
      printf '%s\n' \
        "AZSFC_CPP_PERSISTENT_TREE=1" \
        "AZSFC_CPP_MIX_STEP_SEED=0" \
        "AZSFC_CPP_AVAILABLE_SHORTEST_FALLBACK=1" \
        "AZSFC_CPP_SHARE_REVERSE_EDGE_CAPACITY=1" \
        "AZSFC_CPP_USE_MEAN_Q_ROOT_VALUE=1"
      ;;
    no_both)
      printf '%s\n' \
        "AZSFC_CPP_PERSISTENT_TREE=0" \
        "AZSFC_CPP_MIX_STEP_SEED=0" \
        "AZSFC_CPP_AVAILABLE_SHORTEST_FALLBACK=1" \
        "AZSFC_CPP_SHARE_REVERSE_EDGE_CAPACITY=1" \
        "AZSFC_CPP_USE_MEAN_Q_ROOT_VALUE=1"
      ;;
    no_fallback)
      printf '%s\n' \
        "AZSFC_CPP_PERSISTENT_TREE=1" \
        "AZSFC_CPP_MIX_STEP_SEED=1" \
        "AZSFC_CPP_AVAILABLE_SHORTEST_FALLBACK=0" \
        "AZSFC_CPP_SHARE_REVERSE_EDGE_CAPACITY=1" \
        "AZSFC_CPP_USE_MEAN_Q_ROOT_VALUE=1"
      ;;
    no_shared_capacity)
      printf '%s\n' \
        "AZSFC_CPP_PERSISTENT_TREE=1" \
        "AZSFC_CPP_MIX_STEP_SEED=1" \
        "AZSFC_CPP_AVAILABLE_SHORTEST_FALLBACK=1" \
        "AZSFC_CPP_SHARE_REVERSE_EDGE_CAPACITY=0" \
        "AZSFC_CPP_USE_MEAN_Q_ROOT_VALUE=1"
      ;;
    no_routing_both)
      printf '%s\n' \
        "AZSFC_CPP_PERSISTENT_TREE=1" \
        "AZSFC_CPP_MIX_STEP_SEED=1" \
        "AZSFC_CPP_AVAILABLE_SHORTEST_FALLBACK=0" \
        "AZSFC_CPP_SHARE_REVERSE_EDGE_CAPACITY=0" \
        "AZSFC_CPP_USE_MEAN_Q_ROOT_VALUE=1"
      ;;
    all_off)
      printf '%s\n' \
        "AZSFC_CPP_PERSISTENT_TREE=0" \
        "AZSFC_CPP_MIX_STEP_SEED=0" \
        "AZSFC_CPP_AVAILABLE_SHORTEST_FALLBACK=0" \
        "AZSFC_CPP_SHARE_REVERSE_EDGE_CAPACITY=0" \
        "AZSFC_CPP_USE_MEAN_Q_ROOT_VALUE=0"
      ;;
    legacy_root_value)
      printf '%s\n' \
        "AZSFC_CPP_PERSISTENT_TREE=1" \
        "AZSFC_CPP_MIX_STEP_SEED=1" \
        "AZSFC_CPP_AVAILABLE_SHORTEST_FALLBACK=1" \
        "AZSFC_CPP_SHARE_REVERSE_EDGE_CAPACITY=1" \
        "AZSFC_CPP_USE_MEAN_Q_ROOT_VALUE=0"
      ;;
    legacy_root_value_no_fallback)
      printf '%s\n' \
        "AZSFC_CPP_PERSISTENT_TREE=1" \
        "AZSFC_CPP_MIX_STEP_SEED=1" \
        "AZSFC_CPP_AVAILABLE_SHORTEST_FALLBACK=0" \
        "AZSFC_CPP_SHARE_REVERSE_EDGE_CAPACITY=1" \
        "AZSFC_CPP_USE_MEAN_Q_ROOT_VALUE=0"
      ;;
    *)
      echo "Unknown variant: $variant" >&2
      return 1
      ;;
  esac
}

train_dir_for_seed() {
  local seed="$1"
  printf '%s\n' "$ROOT_DIR/datasets/generated/journal/nominal/brain/seed_${seed}/train"
}

test_dir_for_seed() {
  local seed="$1"
  printf '%s\n' "$ROOT_DIR/datasets/generated/journal/nominal/brain/seed_${seed}/test"
}

train_run_id_for() {
  local variant="$1"
  local seed="$2"
  printf '%s\n' "journal_suite__alpha_zero_sfc__brain__step50_ablate_${variant}__seed${seed}__train__ktrain10__${STAMP}"
}

eval_run_id_for() {
  local variant="$1"
  local seed="$2"
  printf '%s\n' "journal_suite__alpha_zero_sfc__brain__step50_ablate_${variant}__seed${seed}__eval__keval10__${STAMP}"
}

step50_model_path_for() {
  local variant="$1"
  local seed="$2"
  printf '%s\n' "$SOLVER_RESULTS_ROOT/$(train_run_id_for "$variant" "$seed")/models/policy_step_$(printf '%05d' "$TRAIN_MAX_STEPS").pt"
}

check_inputs() {
  local missing=0
  local seed
  local variant
  for seed in $SEEDS; do
    if [[ ! -d "$(train_dir_for_seed "$seed")" ]]; then
      echo "Missing brain train dataset for seed $seed: $(train_dir_for_seed "$seed")" >&2
      missing=1
    fi
    if [[ ! -d "$(test_dir_for_seed "$seed")" ]]; then
      echo "Missing brain test dataset for seed $seed: $(test_dir_for_seed "$seed")" >&2
      missing=1
    fi
  done
  for variant in $VARIANTS; do
    variant_env_args "$variant" >/dev/null
  done
  if [[ "$missing" -ne 0 ]]; then
    exit 1
  fi
}

print_plan() {
  echo "=== Brain purecpp step50 ablation ==="
  echo "stamp:              $STAMP"
  echo "seeds:              $SEEDS"
  echo "variants:           $VARIANTS"
  echo "stages:             $STAGES"
  echo "max_parallel:       $MAX_PARALLEL"
  echo "train_num_workers:  $TRAIN_NUM_WORKERS"
  echo "train_max_steps:    $TRAIN_MAX_STEPS"
  echo "train_num_v_nets:   $TRAIN_NUM_V_NETS"
  echo "eval_num_v_nets:    $EVAL_NUM_V_NETS"
  echo "computation_budget: $COMPUTATION_BUDGET"
  echo
  local variant
  for variant in $VARIANTS; do
    echo "variant=$variant"
    variant_env_args "$variant" | sed 's/^/  /'
  done
  echo
}

run_train() {
  local variant="$1"
  local seed="$2"
  local train_run_id
  local hydra_dir
  local train_dir
  local -a env_args

  train_run_id="$(train_run_id_for "$variant" "$seed")"
  hydra_dir="$SOLVER_RESULTS_ROOT/$train_run_id/hydra"
  train_dir="$(train_dir_for_seed "$seed")"
  mapfile -t env_args < <(variant_env_args "$variant")

  echo "=== TRAIN variant=$variant seed=$seed run_id=$train_run_id ==="
  env \
    "${env_args[@]}" \
    OMP_NUM_THREADS="$THREADS_PER_PROCESS" \
    MKL_NUM_THREADS="$THREADS_PER_PROCESS" \
    OPENBLAS_NUM_THREADS="$THREADS_PER_PROCESS" \
    NUMEXPR_NUM_THREADS="$THREADS_PER_PROCESS" \
    TORCH_NUM_THREADS="$THREADS_PER_PROCESS" \
    conda run -n virne python main.py \
      solver.shortest_method=k_shortest \
      solver.allow_rejection=false \
      solver.solver_name=alpha_zero_sfc \
      solver.k_shortest=10 \
      solver.pretrained_model_path='' \
      training.if_use_random_training_seed=false \
      training.seed="$seed" \
      training.num_workers="$TRAIN_NUM_WORKERS" \
      training.inference_only=false \
      training.num_train_epochs=16 \
      experiment.num_simulations=0 \
      training.enable_async_learner=true \
      training.disable_trajectory_writing=false \
      training.computation_budget="$COMPUTATION_BUDGET" \
      training.c_puct=1.4 \
      training.max_training_steps="$TRAIN_MAX_STEPS" \
      training.guaranteed_save_step="$TRAIN_MAX_STEPS" \
      training.min_buffer_size=128 \
      training.num_train_steps_per_epoch=128 \
      training.max_empty_batches=5400 \
      training.save_interval="$TRAIN_MAX_STEPS" \
      training.pure_cpp=true \
      training.use_cpp_mcts=true \
      training.use_cuda=true \
      training.use_batched_gpu=false \
      training.distributed_training=true \
      training.resume_training=false \
      training.alpha_zero_backbone=transformer \
      training.signal_stop_event_on_learner_complete=true \
      training.top_k_candidates=24 \
      training.value_target_mode=tanh \
      training.value_normalization=tanh \
      use_fixed_dataset=true \
      experiment.if_load_p_net=true \
      experiment.if_load_v_nets=true \
      experiment.seed="$seed" \
      experiment.run_id="$train_run_id" \
      experiment.save_root_dir="$RESULTS_ROOT" \
      experiment.request_timeout_sec=0.0 \
      experiment.run_watchdog_timeout_sec=0.0 \
      experiment.record_arrival_solve_time=true \
      experiment.gpu_synchronize_timing=true \
      hydra.run.dir="$hydra_dir" \
      simulation.p_net_dataset_dir="$train_dir" \
      simulation.v_nets_dataset_dir="$train_dir" \
      v_sim_setting.num_v_nets="$TRAIN_NUM_V_NETS" \
      nn.embedding_dim="$NN_EMBED_DIM" \
      nn.hidden_dim="$NN_HIDDEN_DIM" \
      nn.num_gnn_layers="$NN_GNN_LAYERS" \
      nn.n_heads="$NN_HEADS" \
      nn.transformer_layers="$NN_TRANSFORMER_LAYERS"
}

run_eval() {
  local variant="$1"
  local seed="$2"
  local eval_run_id
  local hydra_dir
  local test_dir
  local model_path
  local summary_path
  local -a env_args

  eval_run_id="$(eval_run_id_for "$variant" "$seed")"
  hydra_dir="$SOLVER_RESULTS_ROOT/$eval_run_id/hydra"
  test_dir="$(test_dir_for_seed "$seed")"
  model_path="$(step50_model_path_for "$variant" "$seed")"
  summary_path="$SOLVER_RESULTS_ROOT/$eval_run_id/summary.csv"
  mapfile -t env_args < <(variant_env_args "$variant")

  if [[ ! -f "$model_path" ]]; then
    echo "Missing step50 model for variant=$variant seed=$seed: $model_path" >&2
    return 1
  fi

  echo "=== EVAL variant=$variant seed=$seed run_id=$eval_run_id model=$model_path ==="
  env \
    "${env_args[@]}" \
    OMP_NUM_THREADS="$THREADS_PER_PROCESS" \
    MKL_NUM_THREADS="$THREADS_PER_PROCESS" \
    OPENBLAS_NUM_THREADS="$THREADS_PER_PROCESS" \
    NUMEXPR_NUM_THREADS="$THREADS_PER_PROCESS" \
    TORCH_NUM_THREADS="$THREADS_PER_PROCESS" \
    conda run -n virne python main.py \
      solver.shortest_method=k_shortest \
      solver.allow_rejection=false \
      solver.solver_name=alpha_zero_sfc \
      solver.k_shortest=10 \
      solver.pretrained_model_path="$model_path" \
      training.if_use_random_training_seed=false \
      training.seed="$seed" \
      training.num_workers=1 \
      training.inference_only=true \
      training.num_train_epochs=0 \
      training.enable_async_learner=false \
      training.disable_trajectory_writing=true \
      training.computation_budget="$COMPUTATION_BUDGET" \
      training.pure_cpp=true \
      training.use_cpp_mcts=true \
      training.use_cuda=true \
      training.use_batched_gpu=false \
      training.distributed_training=false \
      training.resume_training=false \
      training.alpha_zero_backbone=transformer \
      training.signal_stop_event_on_learner_complete=true \
      training.alphazero_model_path="$model_path" \
      training.top_k_candidates=24 \
      training.value_target_mode=tanh \
      training.value_normalization=tanh \
      use_fixed_dataset=true \
      experiment.if_load_p_net=true \
      experiment.if_load_v_nets=true \
      experiment.num_simulations=1 \
      experiment.seed="$seed" \
      experiment.run_id="$eval_run_id" \
      experiment.save_root_dir="$RESULTS_ROOT" \
      experiment.request_timeout_sec=0.0 \
      experiment.run_watchdog_timeout_sec=0.0 \
      experiment.record_arrival_solve_time=true \
      experiment.gpu_synchronize_timing=true \
      hydra.run.dir="$hydra_dir" \
      simulation.p_net_dataset_dir="$test_dir" \
      simulation.v_nets_dataset_dir="$test_dir" \
      v_sim_setting.num_v_nets="$EVAL_NUM_V_NETS" \
      nn.embedding_dim="$NN_EMBED_DIM" \
      nn.hidden_dim="$NN_HIDDEN_DIM" \
      nn.num_gnn_layers="$NN_GNN_LAYERS" \
      nn.n_heads="$NN_HEADS" \
      nn.transformer_layers="$NN_TRANSFORMER_LAYERS"

  if [[ -f "$summary_path" ]]; then
    conda run -n virne python -c "
import csv
row = next(csv.DictReader(open('$summary_path')))
print('DONE variant=$variant seed=$seed acceptance_rate={:.3f} lrc={:.3f} ast_run={:.3f} summary=$summary_path'.format(
    float(row['acceptance_rate']),
    float(row['long_term_r2c_ratio']),
    float(row['clock_running_time']),
))
"
  else
    echo "DONE variant=$variant seed=$seed summary_missing=$summary_path"
  fi
}

run_job() {
  local variant="$1"
  local seed="$2"
  local stage
  for stage in $STAGES; do
    case "$stage" in
      train) run_train "$variant" "$seed" ;;
      eval) run_eval "$variant" "$seed" ;;
      *)
        echo "Unknown stage: $stage" >&2
        return 1
        ;;
    esac
  done
}

check_inputs
print_plan

running_jobs=0
for seed in $SEEDS; do
  for variant in $VARIANTS; do
    run_job "$variant" "$seed" &
    running_jobs=$((running_jobs + 1))
    if [[ "$running_jobs" -ge "$MAX_PARALLEL" ]]; then
      wait -n
      running_jobs=$((running_jobs - 1))
    fi
  done
done
wait

echo
echo "=== Final summaries for stamp=$STAMP ==="
conda run -n virne python -c "
from collections import defaultdict
from pathlib import Path
import csv

root = Path('$SOLVER_RESULTS_ROOT')
paths = sorted(root.glob('journal_suite__alpha_zero_sfc__brain__step50_ablate_*__eval__keval10__' + '$STAMP' + '/summary.csv'))
by_variant = defaultdict(list)
for path in paths:
    row = next(csv.DictReader(path.open()))
    parts = path.parent.name.split('__')
    variant = None
    for idx, part in enumerate(parts):
        if part == 'ablate' and idx + 1 < len(parts):
            variant = parts[idx + 1]
            break
    if variant is not None:
        by_variant[variant].append(float(row['acceptance_rate']))
    print('{} acceptance_rate={:.3f} lrc={:.3f} ast_run={:.3f}'.format(
        path.parent.name,
        float(row['acceptance_rate']),
        float(row['long_term_r2c_ratio']),
        float(row['clock_running_time']),
    ))
if by_variant:
    print()
    print('=== Mean acceptance by variant ===')
    for variant in sorted(by_variant):
        values = by_variant[variant]
        print('{} mean_acceptance_rate={:.3f} n={}'.format(
            variant,
            sum(values) / len(values),
            len(values),
        ))
"
