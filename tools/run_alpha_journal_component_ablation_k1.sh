#!/usr/bin/env bash
# End-to-end AlphaVNE component ablation for the journal paper.
#
# One command rebuilds the C++ core, trains every neural variant with k=1,
# evaluates all variants (including no-NN MCTS) on matched BRAIN/GEANT traces,
# and writes CSV, Markdown, and LaTeX summaries:
#
#   bash tools/run_alpha_journal_component_ablation_k1.sh
#
# Resume an interrupted run using the STAMP printed at startup:
#
#   STAMP=YYYYMMDDTHHMMSSZ bash tools/run_alpha_journal_component_ablation_k1.sh
#
# Quick pipeline validation (one topology/seed and short training):
#
#   TOPOLOGIES=brain SEEDS=0 TRAIN_MAX_STEPS=50 \
#     bash tools/run_alpha_journal_component_ablation_k1.sh

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

STAMP="${STAMP:-$(date -u +%Y%m%dT%H%M%SZ)}"
TOPOLOGIES="${TOPOLOGIES:-brain geant}"
SEEDS="${SEEDS:-0 1 2}"
VARIANTS="${VARIANTS:-full no_candidate_features no_reachability fixed_order no_nn}"
STAGES="${STAGES:-build preflight train eval summarize}"

# Deliberately fixed: larger k was found to increase runtime without improving
# acceptance for this solver. Training and evaluation both use k=1.
K_SHORT=1
COMPUTATION_BUDGET="${COMPUTATION_BUDGET:-96}"
NUM_V_NETS=1000
ROLLOUT_DEPTH_LIMIT="${ROLLOUT_DEPTH_LIMIT:-100}"

RESULTS_ROOT="${RESULTS_ROOT:-$ROOT_DIR/results/journal_suite/results}"
SOLVER_RESULTS_ROOT="${SOLVER_RESULTS_ROOT:-$RESULTS_ROOT/alpha_zero_sfc}"
ANALYSIS_ROOT="${ANALYSIS_ROOT:-$ROOT_DIR/results/alpha_journal_component_ablation_k1/$STAMP}"
EXTRACTED_MODELS_DIR="$ANALYSIS_ROOT/extracted_models"
RUN_LOG="$ANALYSIS_ROOT/run.log"

DRY_RUN="${DRY_RUN:-0}"
RESUME_COMPLETED="${RESUME_COMPLETED:-1}"
ALLOW_PARTIAL_SUMMARY="${ALLOW_PARTIAL_SUMMARY:-0}"

TRAIN_NUM_WORKERS="${TRAIN_NUM_WORKERS:-8}"
TRAIN_NUM_EPOCHS="${TRAIN_NUM_EPOCHS:-16}"
TRAIN_MAX_STEPS="${TRAIN_MAX_STEPS:-3000}"
TRAIN_MIN_BUFFER_SIZE="${TRAIN_MIN_BUFFER_SIZE:-128}"
TRAIN_STEPS_PER_EPOCH="${TRAIN_STEPS_PER_EPOCH:-128}"
TRAIN_MAX_EMPTY_BATCHES="${TRAIN_MAX_EMPTY_BATCHES:-5400}"
SAVE_INTERVAL="${SAVE_INTERVAL:-2000}"
SAVE_CHECKPOINT_HISTORY="${SAVE_CHECKPOINT_HISTORY:-false}"
GUARANTEED_SAVE_STEP="${GUARANTEED_SAVE_STEP:-50}"

NN_BACKBONE="${NN_BACKBONE:-transformer}"
NN_EMBED_DIM="${NN_EMBED_DIM:-96}"
NN_HIDDEN_DIM="${NN_HIDDEN_DIM:-96}"
NN_GNN_LAYERS="${NN_GNN_LAYERS:-2}"
NN_HEADS="${NN_HEADS:-6}"
NN_TRANSFORMER_LAYERS="${NN_TRANSFORMER_LAYERS:-2}"

# Fixed-code journal evaluation recipe.
export AZSFC_CPP_USE_MEAN_Q_ROOT_VALUE="${AZSFC_CPP_USE_MEAN_Q_ROOT_VALUE:-0}"
export AZSFC_CPP_AVAILABLE_SHORTEST_FALLBACK="${AZSFC_CPP_AVAILABLE_SHORTEST_FALLBACK:-0}"
export AZSFC_CPP_MIX_STEP_SEED="${AZSFC_CPP_MIX_STEP_SEED:-0}"
export AZSFC_CPP_SHARE_REVERSE_EDGE_CAPACITY="${AZSFC_CPP_SHARE_REVERSE_EDGE_CAPACITY:-0}"
export AZSFC_CPP_PERSISTENT_TREE="${AZSFC_CPP_PERSISTENT_TREE:-1}"
export AZSFC_CPP_SET_V_NODE_OVERRIDE="${AZSFC_CPP_SET_V_NODE_OVERRIDE:-0}"
export OMP_NUM_THREADS="${OMP_NUM_THREADS:-1}"
export MKL_NUM_THREADS="${MKL_NUM_THREADS:-1}"
export OPENBLAS_NUM_THREADS="${OPENBLAS_NUM_THREADS:-1}"

mkdir -p "$ANALYSIS_ROOT" "$EXTRACTED_MODELS_DIR"
if [[ "$DRY_RUN" != "1" ]]; then
  exec > >(tee -a "$RUN_LOG") 2>&1
fi

section() { echo; echo "=== $* ==="; }
has_stage() { [[ " $STAGES " == *" $1 "* ]]; }
require_dir() { [[ -d "$1" ]] || { echo "missing directory: $1" >&2; exit 1; }; }
require_file() { [[ -f "$1" ]] || { echo "missing file: $1" >&2; exit 1; }; }

run_cmd() {
  printf '+' >&2
  printf ' %q' "$@" >&2
  printf '\n' >&2
  if [[ "$DRY_RUN" == "1" ]]; then return 0; fi
  "$@"
}

normalize_topology() {
  case "$1" in
    brain|geant) echo "$1" ;;
    *) echo "unsupported topology '$1'; expected brain or geant" >&2; exit 1 ;;
  esac
}

normalize_variant() {
  case "$1" in
    full|no_candidate_features|no_reachability|fixed_order|no_nn) echo "$1" ;;
    *)
      echo "unsupported variant '$1'; expected full, no_candidate_features, no_reachability, fixed_order, or no_nn" >&2
      exit 1
      ;;
  esac
}

# Sets the process-local C++ ablation flags and neural-guide state.
configure_variant() {
  local variant="$1"
  CANDIDATE_FEATURES=1
  REACHABILITY_FILTER=1
  VIRTUAL_NODE_ORDER=demand
  USE_NN=true
  case "$variant" in
    full) ;;
    no_candidate_features) CANDIDATE_FEATURES=0 ;;
    no_reachability) REACHABILITY_FILTER=0 ;;
    fixed_order) VIRTUAL_NODE_ORDER=fixed ;;
    no_nn) USE_NN=false ;;
  esac
}

dataset_dir() {
  local topology="$1" seed="$2" split="$3"
  echo "$ROOT_DIR/datasets/generated/journal/nominal/${topology}/seed_${seed}/${split}"
}

train_run_id() {
  local topology="$1" seed="$2" variant="$3"
  echo "journal_suite__alpha_zero_sfc__${topology}__journal_components_k${K_SHORT}__${variant}__budget${COMPUTATION_BUDGET}__seed${seed}__train__${STAMP}"
}

eval_run_id() {
  local topology="$1" seed="$2" variant="$3"
  echo "journal_suite__alpha_zero_sfc__${topology}__journal_components_k${K_SHORT}__${variant}__budget${COMPUTATION_BUDGET}__seed${seed}__eval__${STAMP}"
}

solver_run_dir() {
  echo "$SOLVER_RESULTS_ROOT/$1"
}

print_plan() {
  section "AlphaVNE Journal Component Ablation"
  echo "stamp:                 $STAMP"
  echo "topologies:            $TOPOLOGIES"
  echo "seeds:                 $SEEDS"
  echo "variants:              $VARIANTS"
  echo "stages:                $STAGES"
  echo "k (train and eval):    $K_SHORT"
  echo "MCTS simulations:      $COMPUTATION_BUDGET"
  echo "requests per cell:     $NUM_V_NETS"
  echo "training steps:        $TRAIN_MAX_STEPS"
  echo "analysis root:         $ANALYSIS_ROOT"
  echo "solver results root:   $SOLVER_RESULTS_ROOT"
  echo "branch:                 $(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo unknown)"
  echo "HEAD:                   $(git rev-parse HEAD 2>/dev/null || echo unknown)"
  echo
  echo "Neural variants are trained and evaluated with the same component disabled."
  echo "No-NN uses the same transition model and 96-search budget but requires no training."
}

build_cpp() {
  section "Rebuild AlphaVNE C++ core"
  run_cmd bash skills/alpha-vne-cpp-build/scripts/rebuild_alpha_vne_cpp.sh
}

preflight() {
  section "Preflight"
  run_cmd conda run -n virne python -c \
    "from virne.solver.learning.reinforcement_learning.alpha_vne import alpha_zero_cpp_core as m; print(m.__file__)"

  if [[ "$VARIANTS" != "no_nn" ]]; then
    run_cmd conda run -n virne python -c \
      "import torch; assert torch.cuda.is_available(), 'CUDA is required to train/evaluate neural variants'; print(torch.cuda.get_device_name(0))"
  fi

  local raw topology seed split variant
  for variant in $VARIANTS; do normalize_variant "$variant" >/dev/null; done
  for raw in $TOPOLOGIES; do
    topology="$(normalize_topology "$raw")"
    for seed in $SEEDS; do
      for split in train test; do
        require_dir "$(dataset_dir "$topology" "$seed" "$split")"
      done
      echo "$topology seed=$seed: train/test datasets present"
    done
  done
}

extract_weights() {
  local source="$1" destination="$2"
  if [[ -f "$destination" ]]; then return 0; fi
  run_cmd conda run -n virne python -c '
import pathlib, sys, torch
source = pathlib.Path(sys.argv[1])
destination = pathlib.Path(sys.argv[2])
obj = torch.load(source, map_location="cpu")
if isinstance(obj, dict):
    state = obj.get("model") or obj.get("state_dict") or obj.get("model_state_dict")
    if state is None and obj and all(torch.is_tensor(value) for value in obj.values()):
        state = obj
else:
    state = None
if not isinstance(state, dict) or not state or not all(torch.is_tensor(value) for value in state.values()):
    raise RuntimeError(f"unsupported checkpoint format: {source}")
destination.parent.mkdir(parents=True, exist_ok=True)
torch.save(state, destination)
print(destination)
' "$source" "$destination"
  if [[ "$DRY_RUN" != "1" ]]; then require_file "$destination"; fi
}

run_train() {
  local topology="$1" seed="$2" variant="$3"
  [[ "$variant" == "no_nn" ]] && return 0
  configure_variant "$variant"

  local id run_dir train_dir
  id="$(train_run_id "$topology" "$seed" "$variant")"
  run_dir="$(solver_run_dir "$id")"
  train_dir="$(dataset_dir "$topology" "$seed" train)"

  if [[ "$RESUME_COMPLETED" == "1" && -f "$run_dir/models/policy_latest.pt" && -f "$run_dir/summary.csv" ]]; then
    section "Reuse train $topology seed=$seed variant=$variant"
    echo "$run_dir/models/policy_latest.pt"
    return 0
  fi

  section "Train $topology seed=$seed variant=$variant k=$K_SHORT"
  local command=(
    conda run -n virne python main.py
    solver.shortest_method=k_shortest
    solver.allow_rejection=false
    solver.solver_name=alpha_zero_sfc
    solver.k_shortest="$K_SHORT"
    solver.pretrained_model_path=
    training.if_use_random_training_seed=false
    training.seed="$seed"
    training.num_workers="$TRAIN_NUM_WORKERS"
    training.inference_only=false
    training.num_train_epochs="$TRAIN_NUM_EPOCHS"
    experiment.num_simulations=0
    training.enable_async_learner=true
    training.disable_trajectory_writing=false
    training.computation_budget="$COMPUTATION_BUDGET"
    training.c_puct=1.4
    training.pure_cpp=true
    training.use_cpp_mcts=true
    training.use_neural_network=true
    training.use_nn_policy=true
    training.use_nn_value=true
    training.use_cuda=true
    training.use_batched_gpu=true
    training.distributed_training=true
    training.alpha_zero_backbone="$NN_BACKBONE"
    training.max_training_steps="$TRAIN_MAX_STEPS"
    training.min_buffer_size="$TRAIN_MIN_BUFFER_SIZE"
    training.max_empty_batches="$TRAIN_MAX_EMPTY_BATCHES"
    training.num_train_steps_per_epoch="$TRAIN_STEPS_PER_EPOCH"
    training.save_interval="$SAVE_INTERVAL"
    training.save_checkpoint_history="$SAVE_CHECKPOINT_HISTORY"
    training.guaranteed_save_step="$GUARANTEED_SAVE_STEP"
    training.signal_stop_event_on_learner_complete=true
    training.resume_training=false
    use_fixed_dataset=true
    experiment.if_load_p_net=true
    experiment.if_load_v_nets=true
    experiment.seed="$seed"
    experiment.run_id="$id"
    experiment.save_root_dir="$RESULTS_ROOT"
    experiment.request_timeout_sec=0.0
    experiment.run_watchdog_timeout_sec=0.0
    experiment.record_arrival_solve_time=true
    experiment.gpu_synchronize_timing=true
    hydra.run.dir="$run_dir/hydra"
    simulation.p_net_dataset_dir="$train_dir"
    simulation.v_nets_dataset_dir="$train_dir"
    v_sim_setting.num_v_nets="$NUM_V_NETS"
    nn.embedding_dim="$NN_EMBED_DIM"
    nn.hidden_dim="$NN_HIDDEN_DIM"
    nn.num_gnn_layers="$NN_GNN_LAYERS"
    nn.n_heads="$NN_HEADS"
    nn.transformer_layers="$NN_TRANSFORMER_LAYERS"
  )
  run_cmd env \
    AZSFC_CPP_USE_CANDIDATE_FEATURES="$CANDIDATE_FEATURES" \
    AZSFC_CPP_USE_REACHABILITY_FILTER="$REACHABILITY_FILTER" \
    AZSFC_CPP_VIRTUAL_NODE_ORDER="$VIRTUAL_NODE_ORDER" \
    "${command[@]}"
  if [[ "$DRY_RUN" != "1" ]]; then require_file "$run_dir/models/policy_latest.pt"; fi
}

run_eval() {
  local topology="$1" seed="$2" variant="$3"
  configure_variant "$variant"

  local id run_dir test_dir model_arg use_cuda train_id source weights
  id="$(eval_run_id "$topology" "$seed" "$variant")"
  run_dir="$(solver_run_dir "$id")"
  test_dir="$(dataset_dir "$topology" "$seed" test)"

  if [[ "$RESUME_COMPLETED" == "1" && -f "$run_dir/summary.csv" ]]; then
    section "Reuse eval $topology seed=$seed variant=$variant"
    echo "$run_dir/summary.csv"
    return 0
  fi

  if [[ "$USE_NN" == "true" ]]; then
    train_id="$(train_run_id "$topology" "$seed" "$variant")"
    source="$(solver_run_dir "$train_id")/models/policy_latest.pt"
    weights="$EXTRACTED_MODELS_DIR/${topology}_${variant}_seed${seed}_weights.pt"
    if [[ "$DRY_RUN" != "1" ]]; then
      require_file "$source"
      extract_weights "$source" "$weights"
    fi
    model_arg="$weights"
    use_cuda=true
  else
    model_arg=""
    use_cuda=false
  fi

  section "Eval $topology seed=$seed variant=$variant k=$K_SHORT budget=$COMPUTATION_BUDGET"
  local command=(
    conda run -n virne python main.py
    solver.shortest_method=k_shortest
    solver.allow_rejection=false
    solver.solver_name=alpha_zero_sfc
    solver.k_shortest="$K_SHORT"
    solver.pretrained_model_path="$model_arg"
    training.if_use_random_training_seed=false
    training.seed="$seed"
    training.num_workers=1
    training.inference_only=true
    training.num_train_epochs=0
    training.max_training_steps=0
    training.enable_async_learner=false
    training.disable_trajectory_writing=true
    training.computation_budget="$COMPUTATION_BUDGET"
    training.c_puct=1.4
    training.pure_cpp=true
    training.use_cpp_mcts=true
    training.use_neural_network="$USE_NN"
    training.use_nn_policy="$USE_NN"
    training.use_nn_value="$USE_NN"
    +training.rollout_depth_limit="$ROLLOUT_DEPTH_LIMIT"
    training.use_cuda="$use_cuda"
    training.use_batched_gpu=false
    training.distributed_training=false
    training.alpha_zero_backbone="$NN_BACKBONE"
    training.signal_stop_event_on_learner_complete=true
    training.alphazero_model_path="$model_arg"
    training.resume_training=false
    use_fixed_dataset=true
    experiment.if_load_p_net=true
    experiment.if_load_v_nets=true
    experiment.num_simulations=1
    experiment.seed="$seed"
    experiment.run_id="$id"
    experiment.save_root_dir="$RESULTS_ROOT"
    experiment.request_timeout_sec=0.0
    experiment.run_watchdog_timeout_sec=0.0
    experiment.record_arrival_solve_time=true
    experiment.gpu_synchronize_timing=true
    hydra.run.dir="$run_dir/hydra"
    simulation.p_net_dataset_dir="$test_dir"
    simulation.v_nets_dataset_dir="$test_dir"
    v_sim_setting.num_v_nets="$NUM_V_NETS"
    nn.embedding_dim="$NN_EMBED_DIM"
    nn.hidden_dim="$NN_HIDDEN_DIM"
    nn.num_gnn_layers="$NN_GNN_LAYERS"
    nn.n_heads="$NN_HEADS"
    nn.transformer_layers="$NN_TRANSFORMER_LAYERS"
  )
  run_cmd env \
    AZSFC_CPP_USE_CANDIDATE_FEATURES="$CANDIDATE_FEATURES" \
    AZSFC_CPP_USE_REACHABILITY_FILTER="$REACHABILITY_FILTER" \
    AZSFC_CPP_VIRTUAL_NODE_ORDER="$VIRTUAL_NODE_ORDER" \
    "${command[@]}"
  if [[ "$DRY_RUN" != "1" ]]; then require_file "$run_dir/summary.csv"; fi
}

summarize() {
  section "Summarize component ablation"
  local command=(
    conda run -n virne python tools/summarize_alpha_journal_component_ablation.py
    --solver-results-root "$SOLVER_RESULTS_ROOT"
    --analysis-root "$ANALYSIS_ROOT"
    --stamp "$STAMP"
    --k "$K_SHORT"
    --budget "$COMPUTATION_BUDGET"
    --topologies
  )
  local raw seed variant
  for raw in $TOPOLOGIES; do command+=("$(normalize_topology "$raw")"); done
  command+=(--seeds)
  for seed in $SEEDS; do command+=("$seed"); done
  command+=(--variants)
  for variant in $VARIANTS; do command+=("$(normalize_variant "$variant")"); done
  if [[ "$ALLOW_PARTIAL_SUMMARY" == "1" ]]; then command+=(--allow-partial); fi
  run_cmd "${command[@]}"
}

main() {
  print_plan
  if has_stage build; then build_cpp; fi
  if has_stage preflight; then preflight; fi

  local raw topology seed raw_variant variant
  for raw_variant in $VARIANTS; do
    variant="$(normalize_variant "$raw_variant")"
    for raw in $TOPOLOGIES; do
      topology="$(normalize_topology "$raw")"
      for seed in $SEEDS; do
        if has_stage train; then run_train "$topology" "$seed" "$variant"; fi
        if has_stage eval; then run_eval "$topology" "$seed" "$variant"; fi
      done
    done
  done

  if has_stage summarize && [[ "$DRY_RUN" != "1" ]]; then summarize; fi

  section "Done"
  echo "analysis root:  $ANALYSIS_ROOT"
  echo "report:         $ANALYSIS_ROOT/report.md"
  echo "raw CSV:        $ANALYSIS_ROOT/eval_summary.csv"
  echo "aggregate CSV:  $ANALYSIS_ROOT/aggregate_summary.csv"
  echo "paired CSV:     $ANALYSIS_ROOT/paired_summary.csv"
  echo "LaTeX table:    $ANALYSIS_ROOT/journal_component_ablation_table.tex"
}

main "$@"
