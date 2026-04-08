#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

RESULTS_ROOT="$ROOT_DIR/results/journal_suite/results"
SOLVER_RESULTS_ROOT="$RESULTS_ROOT/alpha_zero_sfc"

TRAIN_DATASET_DIR="${TRAIN_DATASET_DIR:-$ROOT_DIR/datasets/generated/journal/nominal/wx100/seed_1/train}"
EVAL_DATASET_DIR="${EVAL_DATASET_DIR:-$ROOT_DIR/datasets/generated/journal/nominal/wx100/seed_1/test}"
BAD_SUMMARY="${BAD_SUMMARY:-$ROOT_DIR/results/journal_suite/results/alpha_zero_sfc/journal_suite__alpha_zero_sfc__wx100__nominal__seed1__eval__keval10__ckpt43c25dc2a7/summary.csv}"

RUN_TAG="${RUN_TAG:-cppfix_$(date -u +%Y%m%dT%H%M%SZ)}"
STAGES="${STAGES:-train eval}"

TRAIN_RUN_ID="journal_suite__alpha_zero_sfc__wx100__nominal_cppfix__seed1__train__ktrain10__${RUN_TAG}"
EVAL_RUN_ID="journal_suite__alpha_zero_sfc__wx100__nominal_cppfix__seed1__eval__keval10__${RUN_TAG}"

TRAIN_HYDRA_DIR="$SOLVER_RESULTS_ROOT/$TRAIN_RUN_ID/hydra"
EVAL_HYDRA_DIR="$SOLVER_RESULTS_ROOT/$EVAL_RUN_ID/hydra"
MODEL_PATH="${MODEL_PATH_OVERRIDE:-$SOLVER_RESULTS_ROOT/$TRAIN_RUN_ID/models/policy_latest.pt}"
NEW_SUMMARY_PATH="$SOLVER_RESULTS_ROOT/$EVAL_RUN_ID/summary.csv"

if [[ ! -d "$TRAIN_DATASET_DIR" ]]; then
  echo "Missing train dataset dir: $TRAIN_DATASET_DIR" >&2
  exit 1
fi
if [[ ! -d "$EVAL_DATASET_DIR" ]]; then
  echo "Missing eval dataset dir: $EVAL_DATASET_DIR" >&2
  exit 1
fi

echo "Train dataset: $TRAIN_DATASET_DIR"
echo "Eval dataset:  $EVAL_DATASET_DIR"
echo "Run tag:       $RUN_TAG"
echo "Stages:        $STAGES"
echo

run_train() {
  echo "=== train: $TRAIN_RUN_ID ==="
  conda run -n virne python main.py \
    solver.shortest_method=k_shortest \
    solver.allow_rejection=false \
    solver.solver_name=alpha_zero_sfc \
    solver.k_shortest=10 \
    solver.pretrained_model_path='' \
    training.if_use_random_training_seed=false \
    training.seed=1 \
    training.num_workers=4 \
    training.inference_only=false \
    training.num_train_epochs=12 \
    experiment.num_simulations=0 \
    training.enable_async_learner=true \
    training.disable_trajectory_writing=false \
    training.computation_budget=96 \
    training.c_puct=1.4 \
    training.max_training_steps=1000 \
    training.min_buffer_size=128 \
    training.num_train_steps_per_epoch=128 \
    training.max_empty_batches=1800 \
    training.save_interval=256 \
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
    experiment.seed=1 \
    experiment.run_id="$TRAIN_RUN_ID" \
    experiment.save_root_dir="$RESULTS_ROOT" \
    experiment.request_timeout_sec=0.0 \
    experiment.run_watchdog_timeout_sec=0.0 \
    experiment.record_arrival_solve_time=true \
    experiment.gpu_synchronize_timing=true \
    hydra.run.dir="$TRAIN_HYDRA_DIR" \
    simulation.p_net_dataset_dir="$TRAIN_DATASET_DIR" \
    simulation.v_nets_dataset_dir="$TRAIN_DATASET_DIR" \
    v_sim_setting.num_v_nets=1000 \
    nn.embedding_dim=96 \
    nn.hidden_dim=96 \
    nn.num_gnn_layers=2 \
    nn.n_heads=6 \
    nn.transformer_layers=2
}

run_eval() {
  if [[ ! -f "$MODEL_PATH" ]]; then
    echo "Missing model checkpoint for eval: $MODEL_PATH" >&2
    echo "Run with STAGES=train eval or set MODEL_PATH_OVERRIDE=/abs/path/to/policy_latest.pt" >&2
    exit 1
  fi

  echo
  echo "=== eval: $EVAL_RUN_ID ==="
  echo "Model: $MODEL_PATH"
  conda run -n virne python main.py \
    solver.shortest_method=k_shortest \
    solver.allow_rejection=false \
    solver.solver_name=alpha_zero_sfc \
    solver.k_shortest=10 \
    solver.pretrained_model_path="$MODEL_PATH" \
    training.if_use_random_training_seed=false \
    training.seed=1 \
    training.num_workers=1 \
    training.inference_only=true \
    training.num_train_epochs=0 \
    training.enable_async_learner=false \
    training.disable_trajectory_writing=true \
    training.computation_budget=96 \
    training.pure_cpp=true \
    training.use_cpp_mcts=true \
    training.use_cuda=true \
    training.use_batched_gpu=false \
    training.distributed_training=false \
    training.resume_training=false \
    training.alpha_zero_backbone=transformer \
    training.signal_stop_event_on_learner_complete=true \
    training.alphazero_model_path="$MODEL_PATH" \
    training.top_k_candidates=24 \
    training.value_target_mode=tanh \
    training.value_normalization=tanh \
    use_fixed_dataset=true \
    experiment.if_load_p_net=true \
    experiment.if_load_v_nets=true \
    experiment.num_simulations=1 \
    experiment.seed=1 \
    experiment.run_id="$EVAL_RUN_ID" \
    experiment.save_root_dir="$RESULTS_ROOT" \
    experiment.request_timeout_sec=0.0 \
    experiment.run_watchdog_timeout_sec=0.0 \
    experiment.record_arrival_solve_time=true \
    experiment.gpu_synchronize_timing=true \
    hydra.run.dir="$EVAL_HYDRA_DIR" \
    simulation.p_net_dataset_dir="$EVAL_DATASET_DIR" \
    simulation.v_nets_dataset_dir="$EVAL_DATASET_DIR" \
    v_sim_setting.num_v_nets=1000 \
    nn.embedding_dim=96 \
    nn.hidden_dim=96 \
    nn.num_gnn_layers=2 \
    nn.n_heads=6 \
    nn.transformer_layers=2
}

for stage in $STAGES; do
  case "$stage" in
    train) run_train ;;
    eval) run_eval ;;
    *)
      echo "Unknown stage: $stage" >&2
      echo "Supported stages: train eval" >&2
      exit 1
      ;;
  esac
done

if [[ -f "$NEW_SUMMARY_PATH" ]]; then
  echo
  echo "=== acceptance summary ==="
  conda run -n virne python -c "
from pathlib import Path
import csv

old_path = Path(r'''$BAD_SUMMARY''')
new_path = Path(r'''$NEW_SUMMARY_PATH''')

def load_acceptance(path: Path):
    if not path.exists():
        return None
    rows = list(csv.DictReader(path.open()))
    if not rows:
        return None
    row = rows[-1]
    for key in ('acceptance_rate', 'acceptance'):
        if key in row and row[key] not in ('', None):
            return float(row[key])
    return None

old_value = load_acceptance(old_path)
new_value = load_acceptance(new_path)
print(f'old_summary={old_path}')
print(f'old_acceptance={old_value}')
print(f'new_summary={new_path}')
print(f'new_acceptance={new_value}')
if old_value is not None and new_value is not None:
    print(f'delta={new_value - old_value:+.3f}')
"
fi

