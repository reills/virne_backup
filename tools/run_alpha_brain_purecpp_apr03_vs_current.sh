#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

RESULTS_ROOT="$ROOT_DIR/results/journal_suite/results/alpha_zero_sfc"
STAMP="${STAMP:-$(date -u +%Y%m%dT%H%M%SZ)}"

SEEDS="${SEEDS:-0 1 2}"
MODEL_TAGS="${MODEL_TAGS:-good current_step50 current}"
MAX_PARALLEL="${MAX_PARALLEL:-3}"
NUM_V_NETS="${NUM_V_NETS:-1000}"
COMPUTATION_BUDGET="${COMPUTATION_BUDGET:-96}"
THREADS_PER_PROCESS="${THREADS_PER_PROCESS:-1}"

NN_EMBED_DIM="${NN_EMBED_DIM:-96}"
NN_HIDDEN_DIM="${NN_HIDDEN_DIM:-96}"
NN_GNN_LAYERS="${NN_GNN_LAYERS:-2}"
NN_HEADS="${NN_HEADS:-6}"
NN_TRANSFORMER_LAYERS="${NN_TRANSFORMER_LAYERS:-2}"

model_path_for() {
  local model_tag="$1"
  local seed="$2"

  case "$model_tag" in
    good)
      case "$seed" in
        0)
          printf '%s\n' \
            "$RESULTS_ROOT/historical_v3/journal_suite__alpha_zero_sfc__brain__nominal__seed0__train__ktrain10__attempt2/models/policy_latest.pt"
          ;;
        1)
          printf '%s\n' \
            "$RESULTS_ROOT/historical_v3/journal_suite__alpha_zero_sfc__brain__nominal__seed1__train__ktrain10__attempt1/models/policy_latest.pt"
          ;;
        2)
          printf '%s\n' \
            "$RESULTS_ROOT/historical_v3/journal_suite__alpha_zero_sfc__brain__nominal__seed2__train__ktrain10__attempt2/models/policy_latest.pt"
          ;;
        *)
          echo "Unsupported seed for good model tag: $seed" >&2
          return 1
          ;;
      esac
      ;;
    current)
      printf '%s\n' \
        "$RESULTS_ROOT/journal_suite__alpha_zero_sfc__brain__nominal__seed${seed}__train__ktrain10__attempt2/models/policy_latest.pt"
      ;;
    current_step50)
      printf '%s\n' \
        "$RESULTS_ROOT/journal_suite__alpha_zero_sfc__brain__nominal__seed${seed}__train__ktrain10__attempt2/models/policy_step_00050.pt"
      ;;
    *)
      echo "Unknown model tag: $model_tag" >&2
      return 1
      ;;
  esac
}

test_dir_for_seed() {
  local seed="$1"
  printf '%s\n' "$ROOT_DIR/datasets/generated/journal/nominal/brain/seed_${seed}/test"
}

check_inputs() {
  local missing=0
  local seed
  local model_tag
  for seed in $SEEDS; do
    local test_dir
    test_dir="$(test_dir_for_seed "$seed")"
    if [[ ! -d "$test_dir" ]]; then
      echo "Missing brain test dataset for seed $seed: $test_dir" >&2
      missing=1
    fi
    for model_tag in $MODEL_TAGS; do
      local model_path
      model_path="$(model_path_for "$model_tag" "$seed")"
      if [[ ! -f "$model_path" ]]; then
        echo "Missing $model_tag model for seed $seed: $model_path" >&2
        missing=1
      fi
    done
  done

  if [[ "$missing" -ne 0 ]]; then
    exit 1
  fi
}

print_plan() {
  echo "=== Brain purecpp overnight matrix ==="
  echo "stamp:              $STAMP"
  echo "seeds:              $SEEDS"
  echo "model_tags:         $MODEL_TAGS"
  echo "max_parallel:       $MAX_PARALLEL"
  echo "num_v_nets:         $NUM_V_NETS"
  echo "computation_budget: $COMPUTATION_BUDGET"
  echo
  local seed
  local model_tag
  for seed in $SEEDS; do
    for model_tag in $MODEL_TAGS; do
      echo "seed=$seed model_tag=$model_tag model=$(model_path_for "$model_tag" "$seed")"
    done
  done
  echo
}

run_eval() {
  local model_tag="$1"
  local seed="$2"
  local model_path
  local test_dir
  local run_id
  local hydra_dir

  model_path="$(model_path_for "$model_tag" "$seed")"
  test_dir="$(test_dir_for_seed "$seed")"
  run_id="journal_suite__alpha_zero_sfc__brain__purecpp_reval_${model_tag}__seed${seed}__eval__keval10__${STAMP}"
  hydra_dir="$RESULTS_ROOT/$run_id/hydra"

  echo "=== START seed=$seed model_tag=$model_tag run_id=$run_id ==="

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
    training.alpha_zero_backbone=transformer \
    training.signal_stop_event_on_learner_complete=true \
    training.alphazero_model_path="$model_path" \
    training.resume_training=false \
    use_fixed_dataset=true \
    experiment.if_load_p_net=true \
    experiment.if_load_v_nets=true \
    experiment.num_simulations=1 \
    experiment.seed="$seed" \
    experiment.run_id="$run_id" \
    experiment.save_root_dir="$ROOT_DIR/results/journal_suite/results" \
    experiment.request_timeout_sec=0.0 \
    experiment.run_watchdog_timeout_sec=0.0 \
    experiment.record_arrival_solve_time=true \
    experiment.gpu_synchronize_timing=true \
    hydra.run.dir="$hydra_dir" \
    simulation.p_net_dataset_dir="$test_dir" \
    simulation.v_nets_dataset_dir="$test_dir" \
    v_sim_setting.num_v_nets="$NUM_V_NETS" \
    nn.embedding_dim="$NN_EMBED_DIM" \
    nn.hidden_dim="$NN_HIDDEN_DIM" \
    nn.num_gnn_layers="$NN_GNN_LAYERS" \
    nn.n_heads="$NN_HEADS" \
    nn.transformer_layers="$NN_TRANSFORMER_LAYERS"

  local summary_path="$RESULTS_ROOT/$run_id/summary.csv"
  if [[ -f "$summary_path" ]]; then
    conda run -n virne python -c "
import csv
row = next(csv.DictReader(open('$summary_path')))
print('DONE seed=$seed model_tag=$model_tag acceptance_rate={:.3f} lrc={:.3f} ast_run={:.3f} summary=$summary_path'.format(
    float(row['acceptance_rate']),
    float(row['long_term_r2c_ratio']),
    float(row['clock_running_time']),
))
"
  else
    echo "DONE seed=$seed model_tag=$model_tag summary_missing=$summary_path"
  fi
}

check_inputs
print_plan

running_jobs=0
for seed in $SEEDS; do
  for model_tag in $MODEL_TAGS; do
    run_eval "$model_tag" "$seed" &
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
from pathlib import Path
import csv
from collections import defaultdict

root = Path('$RESULTS_ROOT')
paths = sorted(root.glob('journal_suite__alpha_zero_sfc__brain__purecpp_reval_*__' + '$STAMP' + '/summary.csv'))
by_tag = defaultdict(list)
for path in paths:
    row = next(csv.DictReader(path.open()))
    parts = path.parent.name.split('__')
    model_tag = None
    for idx, part in enumerate(parts):
        if part == 'reval' and idx + 1 < len(parts):
            model_tag = parts[idx + 1]
            break
    if model_tag is not None:
        by_tag[model_tag].append(float(row['acceptance_rate']))
    print('{} acceptance_rate={:.3f} lrc={:.3f} ast_run={:.3f}'.format(
        path.parent.name,
        float(row['acceptance_rate']),
        float(row['long_term_r2c_ratio']),
        float(row['clock_running_time']),
    ))
if by_tag:
    print()
    print('=== Mean acceptance by model_tag ===')
    for model_tag in sorted(by_tag):
        values = by_tag[model_tag]
        print('{} mean_acceptance_rate={:.3f} n={}'.format(
            model_tag,
            sum(values) / len(values),
            len(values),
        ))
"
