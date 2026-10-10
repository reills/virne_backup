#!/usr/bin/env bash
# Re-evaluate the completed five-seed MLP/Transformer checkpoints at k=1.
#
# This script is evaluation-only. TRAIN_K identifies how the source checkpoint
# was trained; EVAL_K controls only the routing candidate count used here.

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

SOURCE_STAMP="${SOURCE_STAMP:-20260712T033646Z}"
SOURCE_ARM="${SOURCE_ARM:-architecture_5seed_v1}"
TRAIN_K="${TRAIN_K:-10}"

STAMP="${STAMP:-$(date -u +%Y%m%dT%H%M%SZ)_architecture_k1_eval}"
ARM="${ARM:-architecture_k1_eval}"
EVAL_K="${EVAL_K:-1}"
TOPOLOGIES="${TOPOLOGIES:-brain geant}"
SEEDS="${SEEDS:-0 1 2 3 4}"
BACKBONES="${BACKBONES:-mlp transformer}"

RESULTS_ROOT="${RESULTS_ROOT:-$ROOT_DIR/results/journal_suite/results}"
SOLVER_RESULTS_ROOT="${SOLVER_RESULTS_ROOT:-$RESULTS_ROOT/alpha_zero_sfc}"
ANALYSIS_ROOT="${ANALYSIS_ROOT:-$ROOT_DIR/results/alpha_neural_guide_k1_eval/$STAMP}"
EXTRACTED_MODELS_DIR="$ANALYSIS_ROOT/extracted_models"
RUN_LOG="$ANALYSIS_ROOT/run.log"

RESUME_COMPLETED="${RESUME_COMPLETED:-1}"
DRY_RUN="${DRY_RUN:-0}"
ALLOW_PARTIAL_SUMMARY="${ALLOW_PARTIAL_SUMMARY:-0}"
NUM_V_NETS="${NUM_V_NETS:-1000}"
COMPUTATION_BUDGET="${COMPUTATION_BUDGET:-96}"

NN_EMBED_DIM="${NN_EMBED_DIM:-96}"
NN_HIDDEN_DIM="${NN_HIDDEN_DIM:-96}"
NN_GNN_LAYERS="${NN_GNN_LAYERS:-2}"
NN_HEADS="${NN_HEADS:-6}"
NN_TRANSFORMER_LAYERS="${NN_TRANSFORMER_LAYERS:-2}"

# Freeze the search settings used by the completed architecture experiment.
export AZSFC_CPP_USE_MEAN_Q_ROOT_VALUE="${AZSFC_CPP_USE_MEAN_Q_ROOT_VALUE:-0}"
export AZSFC_CPP_AVAILABLE_SHORTEST_FALLBACK="${AZSFC_CPP_AVAILABLE_SHORTEST_FALLBACK:-0}"
export AZSFC_CPP_MIX_STEP_SEED="${AZSFC_CPP_MIX_STEP_SEED:-0}"
export AZSFC_CPP_SHARE_REVERSE_EDGE_CAPACITY="${AZSFC_CPP_SHARE_REVERSE_EDGE_CAPACITY:-0}"
export AZSFC_CPP_PERSISTENT_TREE="${AZSFC_CPP_PERSISTENT_TREE:-1}"
export AZSFC_CPP_SET_V_NODE_OVERRIDE="${AZSFC_CPP_SET_V_NODE_OVERRIDE:-0}"
export AZSFC_CPP_USE_CANDIDATE_FEATURES="${AZSFC_CPP_USE_CANDIDATE_FEATURES:-1}"
export AZSFC_CPP_USE_REACHABILITY_FILTER="${AZSFC_CPP_USE_REACHABILITY_FILTER:-1}"
export AZSFC_CPP_VIRTUAL_NODE_ORDER="${AZSFC_CPP_VIRTUAL_NODE_ORDER:-demand}"

export OMP_NUM_THREADS="${OMP_NUM_THREADS:-1}"
export MKL_NUM_THREADS="${MKL_NUM_THREADS:-1}"
export OPENBLAS_NUM_THREADS="${OPENBLAS_NUM_THREADS:-1}"

mkdir -p "$ANALYSIS_ROOT" "$EXTRACTED_MODELS_DIR"

if [[ "$DRY_RUN" != "1" ]]; then
  exec > >(tee -a "$RUN_LOG") 2>&1
fi

section() { echo; echo "=== $* ==="; }
run_cmd() {
  printf '+' >&2
  printf ' %q' "$@" >&2
  printf '\n' >&2
  if [[ "$DRY_RUN" == "1" ]]; then return 0; fi
  "$@"
}
require_dir() { [[ -d "$1" ]] || { echo "missing dir: $1" >&2; exit 1; }; }
require_file() { [[ -f "$1" ]] || { echo "missing file: $1" >&2; exit 1; }; }

normalize_topology() {
  case "$1" in
    brain|geant) echo "$1" ;;
    *) echo "unsupported topology '$1'; expected brain or geant" >&2; exit 1 ;;
  esac
}

normalize_backbone() {
  case "$1" in
    mlp|transformer) echo "$1" ;;
    *) echo "unsupported backbone '$1'; expected mlp or transformer" >&2; exit 1 ;;
  esac
}

dataset_dir() {
  local topology="$1" seed="$2"
  echo "$ROOT_DIR/datasets/generated/journal/nominal/${topology}/seed_${seed}/test"
}

source_train_run_id() {
  local topology="$1" seed="$2" backbone="$3"
  echo "journal_suite__alpha_zero_sfc__${topology}__${SOURCE_ARM}_${backbone}__seed${seed}__train__ktrain${TRAIN_K}__${SOURCE_STAMP}"
}

source_eval_run_id() {
  local topology="$1" seed="$2" backbone="$3"
  echo "journal_suite__alpha_zero_sfc__${topology}__${SOURCE_ARM}_${backbone}__seed${seed}__eval__keval${TRAIN_K}__${SOURCE_STAMP}"
}

target_eval_run_id() {
  local topology="$1" seed="$2" backbone="$3"
  echo "journal_suite__alpha_zero_sfc__${topology}__${ARM}_${backbone}__seed${seed}__eval__ktrain${TRAIN_K}__keval${EVAL_K}__${STAMP}"
}

solver_run_dir() {
  echo "$SOLVER_RESULTS_ROOT/$1"
}

print_plan() {
  section "Matched MLP/Transformer k=1 evaluation"
  echo "mode:             evaluation only (no training)"
  echo "source_stamp:     $SOURCE_STAMP"
  echo "source_arm:       $SOURCE_ARM"
  echo "source_train_k:   $TRAIN_K"
  echo "target_stamp:     $STAMP"
  echo "target_arm:       $ARM"
  echo "target_eval_k:    $EVAL_K"
  echo "topologies:       $TOPOLOGIES"
  echo "seeds:            $SEEDS"
  echo "backbones:        $BACKBONES"
  echo "budget:           $COMPUTATION_BUDGET"
  echo "analysis_root:    $ANALYSIS_ROOT"
  echo "results_root:     $RESULTS_ROOT"
  echo "branch:           $(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo unknown)"
  echo "HEAD:             $(git rev-parse HEAD 2>/dev/null || echo unknown)"
  if [[ -n "$(git status --short 2>/dev/null)" ]]; then
    echo "worktree:         dirty (recorded in run log)"
  else
    echo "worktree:         clean"
  fi
}

preflight() {
  section "Preflight"
  conda run -n virne python -c \
    "from virne.solver.learning.reinforcement_learning.alpha_vne import alpha_zero_cpp_core as m; print(m.__file__)"
  conda run -n virne python -c \
    "from virne.solver.learning.reinforcement_learning.alpha_vne.model_factory import normalize_model_name; print([normalize_model_name(x) for x in '$BACKBONES'.split()])"

  local raw_topology topology raw_backbone backbone seed train_id eval_id
  for raw_backbone in $BACKBONES; do
    backbone="$(normalize_backbone "$raw_backbone")"
    for raw_topology in $TOPOLOGIES; do
      topology="$(normalize_topology "$raw_topology")"
      for seed in $SEEDS; do
        require_dir "$(dataset_dir "$topology" "$seed")"
        train_id="$(source_train_run_id "$topology" "$seed" "$backbone")"
        eval_id="$(source_eval_run_id "$topology" "$seed" "$backbone")"
        require_file "$(solver_run_dir "$train_id")/models/policy_latest.pt"
        require_file "$(solver_run_dir "$eval_id")/summary.csv"
      done
      echo "$topology/$backbone checkpoints and k=$TRAIN_K baselines: seeds $SEEDS"
    done
  done
  echo "preflight passed: only solver.k_shortest changes from $TRAIN_K to $EVAL_K"
}

extract_weights() {
  local src="$1" dst="$2"
  if [[ -f "$dst" ]]; then return 0; fi
  run_cmd conda run -n virne python -c "
import pathlib, sys, torch
src = pathlib.Path(sys.argv[1])
dst = pathlib.Path(sys.argv[2])
obj = torch.load(src, map_location='cpu')
if isinstance(obj, dict):
    state = obj.get('model') or obj.get('state_dict') or obj.get('model_state_dict') or (obj if obj and all(torch.is_tensor(v) for v in obj.values()) else None)
else:
    state = None
assert isinstance(state, dict) and state, f'unsupported checkpoint format in {src}'
assert all(torch.is_tensor(v) for v in state.values()), f'extracted object is not a tensor state_dict in {src}'
dst.parent.mkdir(parents=True, exist_ok=True)
torch.save(state, dst)
" "$src" "$dst"
  [[ "$DRY_RUN" == "1" ]] || require_file "$dst"
}

run_eval() {
  local topology="$1" seed="$2" backbone="$3"
  local train_id checkpoint weights run_id run_dir test_dir

  run_id="$(target_eval_run_id "$topology" "$seed" "$backbone")"
  run_dir="$(solver_run_dir "$run_id")"
  if [[ "$RESUME_COMPLETED" == "1" && -f "$run_dir/summary.csv" ]]; then
    section "Eval $topology seed=$seed backbone=$backbone k=$EVAL_K"
    echo "reusing completed eval: $run_id"
    return 0
  fi

  train_id="$(source_train_run_id "$topology" "$seed" "$backbone")"
  checkpoint="$(solver_run_dir "$train_id")/models/policy_latest.pt"
  weights="$EXTRACTED_MODELS_DIR/${topology}_${backbone}_seed${seed}_ktrain${TRAIN_K}_weights.pt"
  test_dir="$(dataset_dir "$topology" "$seed")"
  extract_weights "$checkpoint" "$weights"

  section "Eval $topology seed=$seed backbone=$backbone k=$EVAL_K"
  run_cmd conda run -n virne python main.py \
    solver.shortest_method=k_shortest \
    solver.allow_rejection=false \
    solver.solver_name=alpha_zero_sfc \
    solver.k_shortest="$EVAL_K" \
    solver.pretrained_model_path="$weights" \
    training.if_use_random_training_seed=false \
    training.num_workers=1 \
    training.inference_only=true \
    training.num_train_epochs=0 \
    training.max_training_steps=0 \
    training.enable_async_learner=false \
    training.disable_trajectory_writing=true \
    training.computation_budget="$COMPUTATION_BUDGET" \
    training.c_puct=1.4 \
    training.pure_cpp=true \
    training.use_cpp_mcts=true \
    training.use_cuda=true \
    training.use_batched_gpu=false \
    training.distributed_training=false \
    training.alpha_zero_backbone="$backbone" \
    training.signal_stop_event_on_learner_complete=true \
    training.alphazero_model_path="$weights" \
    training.resume_training=false \
    use_fixed_dataset=true \
    experiment.if_load_p_net=true \
    experiment.if_load_v_nets=true \
    experiment.num_simulations=1 \
    experiment.seed="$seed" \
    experiment.run_id="$run_id" \
    experiment.save_root_dir="$RESULTS_ROOT" \
    experiment.request_timeout_sec=0.0 \
    experiment.run_watchdog_timeout_sec=0.0 \
    experiment.record_arrival_solve_time=true \
    experiment.gpu_synchronize_timing=true \
    hydra.run.dir="$run_dir/hydra" \
    simulation.p_net_dataset_dir="$test_dir" \
    simulation.v_nets_dataset_dir="$test_dir" \
    v_sim_setting.num_v_nets="$NUM_V_NETS" \
    nn.embedding_dim="$NN_EMBED_DIM" \
    nn.hidden_dim="$NN_HIDDEN_DIM" \
    nn.num_gnn_layers="$NN_GNN_LAYERS" \
    nn.n_heads="$NN_HEADS" \
    nn.transformer_layers="$NN_TRANSFORMER_LAYERS"

  [[ "$DRY_RUN" == "1" ]] || require_file "$run_dir/summary.csv"
}

summarize() {
  [[ "$DRY_RUN" == "1" ]] && return 0
  local partial_args=()
  if [[ "$ALLOW_PARTIAL_SUMMARY" == "1" ]]; then partial_args+=(--allow-partial); fi
  run_cmd conda run -n virne python tools/summarize_alpha_neural_guide_k1_eval.py \
    --solver-results-root "$SOLVER_RESULTS_ROOT" \
    --analysis-root "$ANALYSIS_ROOT" \
    --stamp "$STAMP" \
    --arm "$ARM" \
    --source-stamp "$SOURCE_STAMP" \
    --source-arm "$SOURCE_ARM" \
    --train-k "$TRAIN_K" \
    --eval-k "$EVAL_K" \
    --budget "$COMPUTATION_BUDGET" \
    --topologies $TOPOLOGIES \
    --seeds $SEEDS \
    --backbones $BACKBONES \
    "${partial_args[@]}"
}

main() {
  print_plan
  preflight

  if [[ "$DRY_RUN" == "1" ]]; then
    section "Dry run complete"
    echo "All requested checkpoints, k=$TRAIN_K baselines, test traces, and Python imports were found."
    echo "No evaluation or training command was executed."
    return 0
  fi

  local raw_backbone backbone raw_topology topology seed
  # Run sequentially so GPU contention does not distort the runtime comparison.
  for raw_backbone in $BACKBONES; do
    backbone="$(normalize_backbone "$raw_backbone")"
    for raw_topology in $TOPOLOGIES; do
      topology="$(normalize_topology "$raw_topology")"
      for seed in $SEEDS; do
        run_eval "$topology" "$seed" "$backbone"
      done
    done
  done

  summarize

  section "Done"
  echo "analysis_root:        $ANALYSIS_ROOT"
  echo "report:               $ANALYSIS_ROOT/report.md"
  echo "architecture summary: $ANALYSIS_ROOT/architecture_k1_summary.csv"
  echo "k comparison:         $ANALYSIS_ROOT/k_comparison_summary.csv"
  echo "LaTeX table:           $ANALYSIS_ROOT/neural_guide_k1_comparison.tex"
}

main "$@"
