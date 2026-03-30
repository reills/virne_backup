#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

MODEL_PT="${MODEL_PT:-$ROOT_DIR/results/journal_suite/results/alpha_zero_sfc/journal_suite__alpha_zero_sfc__wx500__nominal__seed0__train__ktrain10__attempt1/models/policy_latest.pt}"
RESULT_ROOT="${RESULT_ROOT:-$ROOT_DIR/results/manual_wx500_seed0ckpt_eval}"
SEEDS="${SEEDS:-0 1 2}"
K_EVAL="${K_EVAL:-10}"
BUDGET="${BUDGET:-96}"
C_PUCT="${C_PUCT:-1.4}"
NUM_VNETS="${NUM_VNETS:-1000}"
CPP_EVAL_BATCH_SIZE="${CPP_EVAL_BATCH_SIZE:-32}"
ALPHA_ZERO_BACKBONE="${ALPHA_ZERO_BACKBONE:-transformer}"
NN_HIDDEN_DIM="${NN_HIDDEN_DIM:-96}"
NN_EMBEDDING_DIM="${NN_EMBEDDING_DIM:-96}"
NN_NUM_GNN_LAYERS="${NN_NUM_GNN_LAYERS:-2}"
NN_N_HEADS="${NN_N_HEADS:-6}"
NN_TRANSFORMER_LAYERS="${NN_TRANSFORMER_LAYERS:-2}"

if [[ ! -f "$MODEL_PT" ]]; then
  echo "Missing checkpoint: $MODEL_PT" >&2
  exit 1
fi

mkdir -p "$RESULT_ROOT"

echo "Using checkpoint:"
echo "  $MODEL_PT"
echo "Saving eval runs under:"
echo "  $RESULT_ROOT"
echo

for seed in $SEEDS; do
  DATASET_DIR="$ROOT_DIR/datasets/generated/journal/nominal/wx500/seed_${seed}/test"
  if [[ ! -d "$DATASET_DIR" ]]; then
    echo "Missing dataset: $DATASET_DIR" >&2
    exit 1
  fi

  RUN_ID="wx500_seed0ckpt_on_seed${seed}_eval_k${K_EVAL}"
  HYDRA_DIR="$RESULT_ROOT/alpha_zero_sfc/$RUN_ID/hydra"

  echo "=== Evaluating seed $seed ==="
  echo "dataset: $DATASET_DIR"
  echo "run_id:  $RUN_ID"

  conda run -n virne python main.py \
    solver.solver_name=alpha_zero_sfc \
    solver.shortest_method=k_shortest \
    solver.k_shortest="$K_EVAL" \
    solver.allow_rejection=false \
    use_fixed_dataset=true \
    experiment.if_load_p_net=true \
    experiment.if_load_v_nets=true \
    experiment.seed="$seed" \
    experiment.num_simulations=1 \
    experiment.run_id="$RUN_ID" \
    experiment.save_root_dir="$RESULT_ROOT" \
    hydra.run.dir="$HYDRA_DIR" \
    simulation.p_net_dataset_dir="$DATASET_DIR" \
    simulation.v_nets_dataset_dir="$DATASET_DIR" \
    v_sim_setting.num_v_nets="$NUM_VNETS" \
    training.inference_only=true \
    training.enable_async_learner=false \
    training.disable_trajectory_writing=true \
    training.resume_training=false \
    training.num_train_epochs=0 \
    training.max_training_steps=0 \
    training.distributed_training=false \
    training.num_workers=1 \
    training.pure_cpp=true \
    training.use_cpp_mcts=true \
    training.use_cuda=true \
    training.use_batched_gpu=false \
    +training.cpp_eval_batch_size="$CPP_EVAL_BATCH_SIZE" \
    training.alpha_zero_backbone="$ALPHA_ZERO_BACKBONE" \
    training.computation_budget="$BUDGET" \
    training.c_puct="$C_PUCT" \
    nn.hidden_dim="$NN_HIDDEN_DIM" \
    nn.embedding_dim="$NN_EMBEDDING_DIM" \
    nn.num_gnn_layers="$NN_NUM_GNN_LAYERS" \
    nn.n_heads="$NN_N_HEADS" \
    nn.transformer_layers="$NN_TRANSFORMER_LAYERS" \
    training.alphazero_model_path="$MODEL_PT" \
    solver.pretrained_model_path="$MODEL_PT"

  SUMMARY_PATH="$RESULT_ROOT/alpha_zero_sfc/$RUN_ID/summary.csv"
  if [[ -f "$SUMMARY_PATH" ]]; then
    echo "summary: $SUMMARY_PATH"
  else
    echo "warning: summary not found yet for $RUN_ID" >&2
  fi
  echo
done

echo "Evaluation runs completed."
