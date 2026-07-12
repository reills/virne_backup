#!/usr/bin/env bash
# Matched evaluation of AlphaVNE neural-guided MCTS against the same
# feasibility-aware MCTS transition with neural policy/value guidance disabled.
#
# Both arms use identical test files, seeds, k, MCTS simulation budget, PUCT
# constant, constraints, and C++ search implementation. The defaults evaluate
# the five final paper checkpoints for BRAIN and GEANT at k=1 and 96 MCTS
# simulations per placement decision.
#
# Full run:
#   bash tools/run_alpha_matched_nn_vs_no_nn_k1.sh
#
# Resume a prior run by reusing its printed STAMP:
#   STAMP=YYYYMMDDTHHMMSSZ bash tools/run_alpha_matched_nn_vs_no_nn_k1.sh

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

STAMP="${STAMP:-$(date -u +%Y%m%dT%H%M%SZ)}"
TOPOLOGIES="${TOPOLOGIES:-brain geant}"
SEEDS="${SEEDS:-0 1 2 3 4}"
ARMS="${ARMS:-no_nn nn}"
K_SHORT="${K_SHORT:-1}"
COMPUTATION_BUDGET="${COMPUTATION_BUDGET:-96}"
# Fixed journal datasets contain 1,000 requests and are not truncated by the
# framework's num_v_nets setting.
NUM_V_NETS=1000
ROLLOUT_DEPTH_LIMIT="${ROLLOUT_DEPTH_LIMIT:-100}"
STAGES="${STAGES:-preflight eval summarize}"
DRY_RUN="${DRY_RUN:-0}"
RESUME_COMPLETED="${RESUME_COMPLETED:-1}"
ALLOW_PARTIAL_SUMMARY="${ALLOW_PARTIAL_SUMMARY:-0}"

RESULTS_ROOT="${RESULTS_ROOT:-$ROOT_DIR/results/journal_suite/results}"
SOLVER_RESULTS_ROOT="${SOLVER_RESULTS_ROOT:-$RESULTS_ROOT/alpha_zero_sfc}"
ANALYSIS_ROOT="${ANALYSIS_ROOT:-$ROOT_DIR/results/alpha_matched_nn_vs_no_nn_k1/$STAMP}"
EXTRACTED_MODELS_DIR="$ANALYSIS_ROOT/extracted_models"
RUN_LOG="$ANALYSIS_ROOT/run.log"

NN_EMBED_DIM="${NN_EMBED_DIM:-96}"
NN_HIDDEN_DIM="${NN_HIDDEN_DIM:-96}"
NN_GNN_LAYERS="${NN_GNN_LAYERS:-2}"
NN_HEADS="${NN_HEADS:-6}"
NN_TRANSFORMER_LAYERS="${NN_TRANSFORMER_LAYERS:-2}"

# Match the fixed-code journal evaluation recipe.
export AZSFC_CPP_USE_MEAN_Q_ROOT_VALUE="${AZSFC_CPP_USE_MEAN_Q_ROOT_VALUE:-0}"
export AZSFC_CPP_AVAILABLE_SHORTEST_FALLBACK="${AZSFC_CPP_AVAILABLE_SHORTEST_FALLBACK:-0}"
export AZSFC_CPP_MIX_STEP_SEED="${AZSFC_CPP_MIX_STEP_SEED:-0}"
export AZSFC_CPP_SHARE_REVERSE_EDGE_CAPACITY="${AZSFC_CPP_SHARE_REVERSE_EDGE_CAPACITY:-0}"
export AZSFC_CPP_PERSISTENT_TREE="${AZSFC_CPP_PERSISTENT_TREE:-1}"
export AZSFC_CPP_SET_V_NODE_OVERRIDE="${AZSFC_CPP_SET_V_NODE_OVERRIDE:-0}"
export AZSFC_CPP_USE_CANDIDATE_FEATURES="${AZSFC_CPP_USE_CANDIDATE_FEATURES:-1}"

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
  if [[ "$DRY_RUN" == "1" ]]; then
    return 0
  fi
  "$@"
}

normalize_topology() {
  case "$1" in
    brain|geant) echo "$1" ;;
    *) echo "unsupported topology '$1'; expected brain or geant" >&2; exit 1 ;;
  esac
}

normalize_arm() {
  case "$1" in
    nn|no_nn) echo "$1" ;;
    *) echo "unsupported arm '$1'; expected nn or no_nn" >&2; exit 1 ;;
  esac
}

dataset_dir() {
  local topology="$1" seed="$2"
  echo "$ROOT_DIR/datasets/generated/journal/nominal/${topology}/seed_${seed}/test"
}

# These are the checkpoints used by the current five-seed paper results.
source_model() {
  local topology="$1" seed="$2"
  case "$topology:$seed" in
    brain:0|brain:1|brain:2|brain:3|brain:4)
      echo "$SOLVER_RESULTS_ROOT/journal_suite__brain_k10_steps5000_20260513T224921Z__alpha_zero_sfc__brain__nominal__seed${seed}__train__ktrain10/models/policy_latest.pt"
      ;;
    geant:0|geant:1|geant:2)
      echo "$SOLVER_RESULTS_ROOT/journal_suite__alpha_zero_sfc__geant__topo_replay_move_fix_3k__seed${seed}__train__ktrain10__20260423T225501Z/models/policy_latest.pt"
      ;;
    geant:3|geant:4)
      echo "$SOLVER_RESULTS_ROOT/journal_suite__alpha_zero_sfc__geant__journal_insurance_replay_move_fix_3k__seed${seed}__train__ktrain10__20260426T232029Z_alpha_extra/models/policy_latest.pt"
      ;;
    *)
      echo "no final paper checkpoint mapping for $topology seed $seed" >&2
      exit 1
      ;;
  esac
}

weights_path() {
  local topology="$1" seed="$2"
  echo "$EXTRACTED_MODELS_DIR/${topology}_seed${seed}_weights.pt"
}

run_id() {
  local topology="$1" seed="$2" arm="$3"
  echo "journal_suite__alpha_zero_sfc__${topology}__matched_nn_vs_no_nn_k${K_SHORT}__${arm}__budget${COMPUTATION_BUDGET}__seed${seed}__eval__${STAMP}"
}

print_plan() {
  section "Matched AlphaVNE vs No-NN MCTS"
  echo "stamp:              $STAMP"
  echo "topologies:         $TOPOLOGIES"
  echo "seeds:              $SEEDS"
  echo "arms:               $ARMS"
  echo "evaluation k:       $K_SHORT"
  echo "MCTS simulations:   $COMPUTATION_BUDGET"
  echo "requests per cell:  $NUM_V_NETS"
  echo "stages:             $STAGES"
  echo "analysis root:      $ANALYSIS_ROOT"
  echo "results root:       $RESULTS_ROOT"
  echo "branch:             $(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo unknown)"
  echo "HEAD:               $(git rev-parse HEAD 2>/dev/null || echo unknown)"
  echo
  echo "Important: checkpoints were trained with k=10; both comparison arms are evaluated at k=$K_SHORT."
}

preflight() {
  section "Preflight"
  run_cmd conda run -n virne python -c \
    "from virne.solver.learning.reinforcement_learning.alpha_vne import alpha_zero_cpp_core as m; print(m.__file__)"

  if [[ " $ARMS " == *" nn "* ]]; then
    run_cmd conda run -n virne python -c \
      "import torch; assert torch.cuda.is_available(), 'CUDA is required for the NN arm'; print(torch.cuda.get_device_name(0))"
  fi

  local raw topology seed arm test_dir model
  for arm in $ARMS; do normalize_arm "$arm" >/dev/null; done
  for raw in $TOPOLOGIES; do
    topology="$(normalize_topology "$raw")"
    for seed in $SEEDS; do
      test_dir="$(dataset_dir "$topology" "$seed")"
      require_dir "$test_dir"
      model="$(source_model "$topology" "$seed")"
      require_file "$model"
      echo "$topology seed=$seed dataset=$test_dir"
      echo "$topology seed=$seed checkpoint=$model"
    done
  done
}

extract_weights() {
  local source="$1" destination="$2"
  if [[ -f "$destination" ]]; then
    return 0
  fi
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

run_eval() {
  local topology="$1" seed="$2" arm="$3"
  local id run_dir test_dir source weights use_nn use_cuda model_arg
  id="$(run_id "$topology" "$seed" "$arm")"
  run_dir="$SOLVER_RESULTS_ROOT/$id"
  test_dir="$(dataset_dir "$topology" "$seed")"

  if [[ "$RESUME_COMPLETED" == "1" && -f "$run_dir/summary.csv" ]]; then
    section "Reuse $topology seed=$seed arm=$arm"
    echo "$run_dir/summary.csv"
    return 0
  fi

  if [[ "$arm" == "nn" ]]; then
    source="$(source_model "$topology" "$seed")"
    weights="$(weights_path "$topology" "$seed")"
    extract_weights "$source" "$weights"
    use_nn=true
    use_cuda=true
    model_arg="$weights"
  else
    use_nn=false
    use_cuda=false
    model_arg=""
  fi

  section "Eval $topology seed=$seed arm=$arm k=$K_SHORT budget=$COMPUTATION_BUDGET"
  local command=(
    conda run -n virne python main.py
    solver.shortest_method=k_shortest
    solver.allow_rejection=false
    solver.solver_name=alpha_zero_sfc
    solver.k_shortest="$K_SHORT"
    solver.pretrained_model_path="$model_arg"
    training.if_use_random_training_seed=false
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
    training.use_neural_network="$use_nn"
    training.use_nn_policy="$use_nn"
    training.use_nn_value="$use_nn"
    +training.rollout_depth_limit="$ROLLOUT_DEPTH_LIMIT"
    training.use_cuda="$use_cuda"
    training.use_batched_gpu=false
    training.distributed_training=false
    training.alpha_zero_backbone=transformer
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
  run_cmd "${command[@]}"
  if [[ "$DRY_RUN" != "1" ]]; then require_file "$run_dir/summary.csv"; fi
}

summarize() {
  section "Summarize paired results"
  local command=(
    conda run -n virne python tools/summarize_alpha_matched_nn_vs_no_nn.py
    --solver-results-root "$SOLVER_RESULTS_ROOT"
    --analysis-root "$ANALYSIS_ROOT"
    --stamp "$STAMP"
    --k "$K_SHORT"
    --budget "$COMPUTATION_BUDGET"
    --topologies
  )
  local topology seed
  for topology in $TOPOLOGIES; do command+=("$(normalize_topology "$topology")"); done
  command+=(--seeds)
  for seed in $SEEDS; do command+=("$seed"); done
  if [[ "$ALLOW_PARTIAL_SUMMARY" == "1" ]]; then command+=(--allow-partial); fi
  run_cmd "${command[@]}"
}

main() {
  print_plan
  if has_stage preflight; then preflight; fi

  if has_stage eval; then
    local raw topology seed arm
    for raw in $TOPOLOGIES; do
      topology="$(normalize_topology "$raw")"
      for seed in $SEEDS; do
        for arm in $ARMS; do
          arm="$(normalize_arm "$arm")"
          run_eval "$topology" "$seed" "$arm"
        done
      done
    done
  fi

  if has_stage summarize && [[ "$DRY_RUN" != "1" ]]; then summarize; fi

  section "Done"
  echo "analysis root: $ANALYSIS_ROOT"
  echo "report:        $ANALYSIS_ROOT/report.md"
  echo "paired CSV:    $ANALYSIS_ROOT/paired_summary.csv"
  echo "LaTeX table:   $ANALYSIS_ROOT/matched_nn_vs_no_nn_table.tex"
}

main "$@"
