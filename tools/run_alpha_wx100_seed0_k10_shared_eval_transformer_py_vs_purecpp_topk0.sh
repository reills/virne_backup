#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

RESULTS_ROOT="$ROOT_DIR/results/journal_suite/results"
SOLVER_RESULTS_ROOT="$RESULTS_ROOT/alpha_zero_sfc"
SHARED_TEST_DIR="$ROOT_DIR/datasets/generated/journal/nominal_legacy_pytrain_transformer/wx100/seed_0/test"

PY_MODEL="$SOLVER_RESULTS_ROOT/journal_suite__alpha_zero_sfc__wx100__nominal_legacy_pytrain_transformer__seed0__train__ktrain10__attempt1/models/policy_latest.pt"
CPP_MODEL="$SOLVER_RESULTS_ROOT/journal_suite__alpha_zero_sfc__wx100__nominal_legacy_purecpp_transformer_topk0__seed0__train__ktrain10/models/policy_latest.pt"

if [[ ! -d "$SHARED_TEST_DIR" ]]; then
  echo "Missing shared test dataset: $SHARED_TEST_DIR" >&2
  exit 1
fi
if [[ ! -f "$PY_MODEL" ]]; then
  echo "Missing Python model checkpoint: $PY_MODEL" >&2
  exit 1
fi
if [[ ! -f "$CPP_MODEL" ]]; then
  echo "Missing pure_cpp model checkpoint: $CPP_MODEL" >&2
  exit 1
fi

STAMP="$(date -u +%Y%m%dT%H%M%SZ)"

PY_RUN_ID="journal_suite__alpha_zero_sfc__wx100__shared_eval_pytrain_transformer__seed0__eval__keval10__${STAMP}"
CPP_RUN_ID="journal_suite__alpha_zero_sfc__wx100__shared_eval_purecpp_transformer_topk0__seed0__eval__keval10__${STAMP}"

PY_HYDRA_DIR="$SOLVER_RESULTS_ROOT/$PY_RUN_ID/hydra"
CPP_HYDRA_DIR="$SOLVER_RESULTS_ROOT/$CPP_RUN_ID/hydra"

echo "Using shared test dataset: $SHARED_TEST_DIR"
echo "Python model: $PY_MODEL"
echo "C++ model: $CPP_MODEL"

conda run -n virne python main.py \
  solver.shortest_method=k_shortest \
  solver.allow_rejection=false \
  solver.solver_name=alpha_zero_sfc \
  solver.k_shortest=10 \
  solver.pretrained_model_path="$PY_MODEL" \
  training.if_use_random_training_seed=false \
  training.num_workers=1 \
  training.inference_only=true \
  training.num_train_epochs=0 \
  training.enable_async_learner=false \
  training.disable_trajectory_writing=true \
  training.computation_budget=64 \
  training.pure_cpp=false \
  training.use_cpp_mcts=false \
  training.use_cuda=true \
  training.use_batched_gpu=false \
  training.distributed_training=false \
  training.alpha_zero_backbone=transformer \
  training.signal_stop_event_on_learner_complete=true \
  training.alphazero_model_path="$PY_MODEL" \
  training.resume_training=false \
  use_fixed_dataset=true \
  experiment.if_load_p_net=true \
  experiment.if_load_v_nets=true \
  experiment.seed=0 \
  experiment.run_id="$PY_RUN_ID" \
  experiment.save_root_dir="$RESULTS_ROOT" \
  experiment.request_timeout_sec=0.0 \
  experiment.run_watchdog_timeout_sec=0.0 \
  experiment.record_arrival_solve_time=true \
  experiment.gpu_synchronize_timing=true \
  hydra.run.dir="$PY_HYDRA_DIR" \
  simulation.p_net_dataset_dir="$SHARED_TEST_DIR" \
  simulation.v_nets_dataset_dir="$SHARED_TEST_DIR" \
  v_sim_setting.num_v_nets=2000 \
  nn.embedding_dim=96 \
  nn.hidden_dim=96 \
  nn.num_gnn_layers=2 \
  nn.n_heads=6 \
  nn.transformer_layers=2

conda run -n virne python main.py \
  solver.shortest_method=k_shortest \
  solver.allow_rejection=false \
  solver.solver_name=alpha_zero_sfc \
  solver.k_shortest=10 \
  solver.pretrained_model_path="$CPP_MODEL" \
  training.if_use_random_training_seed=false \
  training.num_workers=1 \
  training.inference_only=true \
  training.num_train_epochs=0 \
  training.enable_async_learner=false \
  training.disable_trajectory_writing=true \
  training.computation_budget=64 \
  training.pure_cpp=true \
  training.use_cpp_mcts=true \
  training.use_cuda=true \
  training.use_batched_gpu=false \
  training.distributed_training=false \
  training.alpha_zero_backbone=transformer \
  training.signal_stop_event_on_learner_complete=true \
  training.alphazero_model_path="$CPP_MODEL" \
  training.resume_training=false \
  training.top_k_candidates=0 \
  training.value_target_mode=tanh \
  training.value_normalization=tanh \
  use_fixed_dataset=true \
  experiment.if_load_p_net=true \
  experiment.if_load_v_nets=true \
  experiment.seed=0 \
  experiment.run_id="$CPP_RUN_ID" \
  experiment.save_root_dir="$RESULTS_ROOT" \
  experiment.request_timeout_sec=0.0 \
  experiment.run_watchdog_timeout_sec=0.0 \
  experiment.record_arrival_solve_time=true \
  experiment.gpu_synchronize_timing=true \
  hydra.run.dir="$CPP_HYDRA_DIR" \
  simulation.p_net_dataset_dir="$SHARED_TEST_DIR" \
  simulation.v_nets_dataset_dir="$SHARED_TEST_DIR" \
  v_sim_setting.num_v_nets=2000 \
  nn.embedding_dim=96 \
  nn.hidden_dim=96 \
  nn.num_gnn_layers=2 \
  nn.n_heads=6 \
  nn.transformer_layers=2
