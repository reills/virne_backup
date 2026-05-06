#!/usr/bin/env bash
# Train AlphaVNE/AlphaZero-SFC at matching k-shortest-path budgets and evaluate
# each checkpoint at the same k. This is the clean diagonal test for claims like:
# "training with a larger routing candidate budget is not required when inference
# also uses a small budget."
#
# Defaults intentionally match the journal k-sensitivity grid:
#   k = 1, 3, 5, 7, 9, 11
#
# Example:
#   bash tools/run_alpha_k_train_eval_diagonal.sh
#   TOPOLOGY=brain bash tools/run_alpha_k_train_eval_diagonal.sh
#   SEEDS="0" K_VALUES="1 3" TRAIN_NUM_EPOCHS=2 TRAIN_MAX_STEPS=200 bash tools/run_alpha_k_train_eval_diagonal.sh

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

STAMP="${STAMP:-$(date -u +%Y%m%dT%H%M%SZ)}"
TOPOLOGY="${TOPOLOGY:-geant}"
ARM="${ARM:-k_train_eval_diagonal}"
SEEDS="${SEEDS:-0 1 2}"
K_VALUES="${K_VALUES:-1 3 5 7 9 11}"

RESULTS_ROOT="${RESULTS_ROOT:-$ROOT_DIR/results/journal_suite/results}"
SOLVER_RESULTS_ROOT="${SOLVER_RESULTS_ROOT:-$RESULTS_ROOT/alpha_zero_sfc}"
ANALYSIS_ROOT="${ANALYSIS_ROOT:-$ROOT_DIR/results/${TOPOLOGY}_k_train_eval_diagonal/$STAMP}"
EXTRACTED_MODELS_DIR="$ANALYSIS_ROOT/extracted_models"
RUN_LOG="$ANALYSIS_ROOT/run.log"
EVAL_SUMMARY_CSV="$ANALYSIS_ROOT/eval_summary.csv"
REPORT_MD="$ANALYSIS_ROOT/report.md"

RESUME_COMPLETED="${RESUME_COMPLETED:-1}"
DRY_RUN="${DRY_RUN:-0}"
TRAIN_ONLY="${TRAIN_ONLY:-0}"
EVAL_ONLY="${EVAL_ONLY:-0}"

NUM_V_NETS="${NUM_V_NETS:-1000}"
COMPUTATION_BUDGET="${COMPUTATION_BUDGET:-96}"
TRAIN_NUM_WORKERS="${TRAIN_NUM_WORKERS:-8}"
TRAIN_NUM_EPOCHS="${TRAIN_NUM_EPOCHS:-16}"
TRAIN_MAX_STEPS="${TRAIN_MAX_STEPS:-3000}"
TRAIN_MIN_BUFFER_SIZE="${TRAIN_MIN_BUFFER_SIZE:-128}"
TRAIN_STEPS_PER_EPOCH="${TRAIN_STEPS_PER_EPOCH:-128}"
TRAIN_MAX_EMPTY_BATCHES="${TRAIN_MAX_EMPTY_BATCHES:-5400}"
SAVE_INTERVAL="${SAVE_INTERVAL:-2000}"
SAVE_CHECKPOINT_HISTORY="${SAVE_CHECKPOINT_HISTORY:-false}"
GUARANTEED_SAVE_STEP="${GUARANTEED_SAVE_STEP:-50}"

NN_EMBED_DIM="${NN_EMBED_DIM:-96}"
NN_HIDDEN_DIM="${NN_HIDDEN_DIM:-96}"
NN_GNN_LAYERS="${NN_GNN_LAYERS:-2}"
NN_HEADS="${NN_HEADS:-6}"
NN_TRANSFORMER_LAYERS="${NN_TRANSFORMER_LAYERS:-2}"

# Match the fixed-code recipe used by the recovered journal AlphaVNE runs.
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
run_cmd() {
  printf '+' >&2
  printf ' %q' "$@" >&2
  printf '\n' >&2
  if [[ "$DRY_RUN" == "1" ]]; then return 0; fi
  "$@"
}
require_dir()  { [[ -d "$1" ]] || { echo "missing dir: $1"  >&2; exit 1; }; }
require_file() { [[ -f "$1" ]] || { echo "missing file: $1" >&2; exit 1; }; }

dataset_dir() { echo "$ROOT_DIR/datasets/generated/journal/nominal/${TOPOLOGY}/seed_$1/$2"; }
train_run_id() { echo "journal_suite__alpha_zero_sfc__${TOPOLOGY}__${ARM}__seed$1__train__ktrain$2__${STAMP}"; }
eval_run_id() { echo "journal_suite__alpha_zero_sfc__${TOPOLOGY}__${ARM}__seed$1__ktrain$2__eval__keval$2__${STAMP}"; }
solver_run_dir() { echo "$SOLVER_RESULTS_ROOT/$1"; }

print_plan() {
  section "${TOPOLOGY} k-train/k-eval diagonal"
  echo "stamp:                $STAMP"
  echo "topology:             $TOPOLOGY"
  echo "arm:                  $ARM"
  echo "seeds:                $SEEDS"
  echo "k_values:             $K_VALUES"
  echo "analysis_root:        $ANALYSIS_ROOT"
  echo "results_root:         $RESULTS_ROOT"
  echo "train:                epochs=$TRAIN_NUM_EPOCHS max_steps=$TRAIN_MAX_STEPS steps/epoch=$TRAIN_STEPS_PER_EPOCH workers=$TRAIN_NUM_WORKERS"
  echo "eval:                 num_v_nets=$NUM_V_NETS computation_budget=$COMPUTATION_BUDGET"
  echo "resume_completed:     $RESUME_COMPLETED"
  echo "train_only/eval_only: $TRAIN_ONLY/$EVAL_ONLY"
  echo
  echo "env flags:"
  echo "  AZSFC_CPP_USE_MEAN_Q_ROOT_VALUE=$AZSFC_CPP_USE_MEAN_Q_ROOT_VALUE"
  echo "  AZSFC_CPP_AVAILABLE_SHORTEST_FALLBACK=$AZSFC_CPP_AVAILABLE_SHORTEST_FALLBACK"
  echo "  AZSFC_CPP_MIX_STEP_SEED=$AZSFC_CPP_MIX_STEP_SEED"
  echo "  AZSFC_CPP_SHARE_REVERSE_EDGE_CAPACITY=$AZSFC_CPP_SHARE_REVERSE_EDGE_CAPACITY"
  echo "  AZSFC_CPP_PERSISTENT_TREE=$AZSFC_CPP_PERSISTENT_TREE"
  echo "  AZSFC_CPP_SET_V_NODE_OVERRIDE=$AZSFC_CPP_SET_V_NODE_OVERRIDE"
  echo "  AZSFC_CPP_USE_CANDIDATE_FEATURES=$AZSFC_CPP_USE_CANDIDATE_FEATURES"
  echo
  echo "branch:               $(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo unknown)"
  echo "HEAD:                 $(git rev-parse HEAD 2>/dev/null || echo unknown)"
}

preflight() {
  section "Preflight"
  if (( TRAIN_NUM_EPOCHS % TRAIN_NUM_WORKERS != 0 )); then
    echo "TRAIN_NUM_EPOCHS=$TRAIN_NUM_EPOCHS must be divisible by TRAIN_NUM_WORKERS=$TRAIN_NUM_WORKERS" >&2
    exit 1
  fi

  local flag missing=0 seed
  for flag in AZSFC_CPP_USE_MEAN_Q_ROOT_VALUE AZSFC_CPP_AVAILABLE_SHORTEST_FALLBACK \
              AZSFC_CPP_MIX_STEP_SEED AZSFC_CPP_PERSISTENT_TREE \
              AZSFC_CPP_SHARE_REVERSE_EDGE_CAPACITY AZSFC_CPP_SET_V_NODE_OVERRIDE \
              AZSFC_CPP_USE_CANDIDATE_FEATURES; do
    if ! grep -q "$flag" virne/solver/learning/reinforcement_learning/alpha_vne/cpp_core/src/*.cpp \
                       virne/solver/learning/reinforcement_learning/alpha_vne/*.py 2>/dev/null; then
      echo "ERROR: required flag $flag not found in C++/adapter sources." >&2
      missing=1
    fi
  done
  (( missing == 0 )) || exit 1

  run_cmd conda run -n virne python -c "from virne.solver.learning.reinforcement_learning.alpha_vne import alpha_zero_cpp_core as m; print(m.__file__)"

  for seed in $SEEDS; do
    require_dir "$(dataset_dir "$seed" train)"
    require_dir "$(dataset_dir "$seed" test)"
  done
  echo "All required $TOPOLOGY train/test datasets present."
}

find_completed_train() {
  local seed="$1" k_train="$2"
  local run_id dir
  run_id="$(train_run_id "$seed" "$k_train")"
  dir="$SOLVER_RESULTS_ROOT/$run_id"
  [[ -d "$dir" && -f "$dir/models/policy_latest.pt" && -f "$dir/summary.csv" ]] && echo "$run_id"
}

find_completed_eval() {
  local seed="$1" k_train="$2"
  local run_id dir
  run_id="$(eval_run_id "$seed" "$k_train")"
  dir="$SOLVER_RESULTS_ROOT/$run_id"
  [[ -d "$dir" && -f "$dir/summary.csv" ]] && echo "$run_id"
}

run_train() {
  local seed="$1" k_train="$2"
  local train_dir run_id run_dir existing
  train_dir="$(dataset_dir "$seed" train)"
  run_id="$(train_run_id "$seed" "$k_train")"
  run_dir="$(solver_run_dir "$run_id")"

  if [[ "$RESUME_COMPLETED" == "1" ]]; then
    existing="$(find_completed_train "$seed" "$k_train" || true)"
    if [[ -n "$existing" ]]; then
      section "Train $TOPOLOGY seed=$seed k_train=$k_train"
      echo "reusing completed train: $existing"
      LAST_TRAIN_RUN_ID="$existing"
      return 0
    fi
  fi

  section "Train $TOPOLOGY seed=$seed k_train=$k_train"
  run_cmd conda run -n virne python main.py \
    solver.shortest_method=k_shortest \
    solver.allow_rejection=false \
    solver.solver_name=alpha_zero_sfc \
    solver.k_shortest="$k_train" \
    solver.pretrained_model_path= \
    training.if_use_random_training_seed=false \
    training.seed="$seed" \
    training.num_workers="$TRAIN_NUM_WORKERS" \
    training.inference_only=false \
    training.num_train_epochs="$TRAIN_NUM_EPOCHS" \
    experiment.num_simulations=0 \
    training.enable_async_learner=true \
    training.disable_trajectory_writing=false \
    training.computation_budget="$COMPUTATION_BUDGET" \
    training.c_puct=1.4 \
    training.pure_cpp=true \
    training.use_cpp_mcts=true \
    training.use_cuda=true \
    training.use_batched_gpu=true \
    training.distributed_training=true \
    training.alpha_zero_backbone=transformer \
    training.max_training_steps="$TRAIN_MAX_STEPS" \
    training.min_buffer_size="$TRAIN_MIN_BUFFER_SIZE" \
    training.max_empty_batches="$TRAIN_MAX_EMPTY_BATCHES" \
    training.num_train_steps_per_epoch="$TRAIN_STEPS_PER_EPOCH" \
    training.save_interval="$SAVE_INTERVAL" \
    training.save_checkpoint_history="$SAVE_CHECKPOINT_HISTORY" \
    training.guaranteed_save_step="$GUARANTEED_SAVE_STEP" \
    training.signal_stop_event_on_learner_complete=true \
    training.resume_training=false \
    use_fixed_dataset=true \
    experiment.if_load_p_net=true \
    experiment.if_load_v_nets=true \
    experiment.seed="$seed" \
    experiment.run_id="$run_id" \
    experiment.save_root_dir="$RESULTS_ROOT" \
    experiment.request_timeout_sec=0.0 \
    experiment.run_watchdog_timeout_sec=0.0 \
    experiment.record_arrival_solve_time=true \
    experiment.gpu_synchronize_timing=true \
    hydra.run.dir="$run_dir/hydra" \
    simulation.p_net_dataset_dir="$train_dir" \
    simulation.v_nets_dataset_dir="$train_dir" \
    v_sim_setting.num_v_nets="$NUM_V_NETS" \
    nn.embedding_dim="$NN_EMBED_DIM" \
    nn.hidden_dim="$NN_HIDDEN_DIM" \
    nn.num_gnn_layers="$NN_GNN_LAYERS" \
    nn.n_heads="$NN_HEADS" \
    nn.transformer_layers="$NN_TRANSFORMER_LAYERS"

  [[ "$DRY_RUN" == "1" ]] || require_file "$run_dir/models/policy_latest.pt"
  LAST_TRAIN_RUN_ID="$run_id"
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
assert all(torch.is_tensor(v) for v in state.values()), f'extracted object is not a pure tensor state_dict in {src}'
dst.parent.mkdir(parents=True, exist_ok=True)
torch.save(state, dst)
" "$src" "$dst"
  [[ "$DRY_RUN" == "1" ]] || require_file "$dst"
}

run_eval() {
  local seed="$1" k_train="$2" train_id="$3"
  local existing model_path weights_path run_id run_dir test_dir
  if [[ "$RESUME_COMPLETED" == "1" ]]; then
    existing="$(find_completed_eval "$seed" "$k_train" || true)"
    if [[ -n "$existing" ]]; then
      section "Eval $TOPOLOGY seed=$seed k_train=$k_train k_eval=$k_train"
      echo "reusing completed eval: $existing"
      return 0
    fi
  fi

  model_path="$(solver_run_dir "$train_id")/models/policy_latest.pt"
  weights_path="$EXTRACTED_MODELS_DIR/${TOPOLOGY}_seed${seed}_ktrain${k_train}_latest_weights.pt"
  extract_weights "$model_path" "$weights_path"

  run_id="$(eval_run_id "$seed" "$k_train")"
  run_dir="$(solver_run_dir "$run_id")"
  test_dir="$(dataset_dir "$seed" test)"

  section "Eval $TOPOLOGY seed=$seed k_train=$k_train k_eval=$k_train"
  run_cmd conda run -n virne python main.py \
    solver.shortest_method=k_shortest \
    solver.allow_rejection=false \
    solver.solver_name=alpha_zero_sfc \
    solver.k_shortest="$k_train" \
    solver.pretrained_model_path="$weights_path" \
    training.if_use_random_training_seed=false \
    training.num_workers=1 \
    training.inference_only=true \
    training.num_train_epochs=0 \
    training.max_training_steps=0 \
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
    training.alphazero_model_path="$weights_path" \
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

generate_report() {
  section "Generate Report"
  if [[ "$DRY_RUN" == "1" ]]; then
    echo "dry-run: skipping report"
    return 0
  fi

  run_cmd conda run -n virne python -c "
import csv, pathlib, re, statistics, sys

solver_root = pathlib.Path(sys.argv[1])
arm = sys.argv[2]
summary_csv = pathlib.Path(sys.argv[3])
report_md = pathlib.Path(sys.argv[4])
topology = sys.argv[5]
stamp = sys.argv[6]

pattern = re.compile(
    r'^journal_suite__alpha_zero_sfc__'
    + re.escape(topology)
    + r'__'
    + re.escape(arm)
    + r'__seed(?P<seed>\\d+)__ktrain(?P<k_train>\\d+)__eval__keval(?P<k_eval>\\d+)__'
    + re.escape(stamp)
    + r'$'
)

rows = []
for summary_path in sorted(solver_root.glob(f'journal_suite__alpha_zero_sfc__{topology}__{arm}__seed*__ktrain*__eval__keval*__{stamp}/summary.csv')):
    run_id = summary_path.parent.name
    match = pattern.match(run_id)
    if not match:
        continue
    with summary_path.open() as handle:
        data = list(csv.DictReader(handle))
    if not data:
        continue
    row = data[-1]
    rows.append({
        'topology': topology,
        'seed': match.group('seed'),
        'k_train': match.group('k_train'),
        'k_eval': match.group('k_eval'),
        'acceptance_rate': row.get('acceptance_rate', ''),
        'long_term_r2c_ratio': row.get('long_term_r2c_ratio', ''),
        'clock_running_time': row.get('clock_running_time', ''),
        'run_id': run_id,
    })

rows = sorted(rows, key=lambda r: (int(r['k_train']), int(r['seed'])))
summary_csv.parent.mkdir(parents=True, exist_ok=True)
with summary_csv.open('w', newline='') as handle:
    writer = csv.DictWriter(handle, fieldnames=['topology','seed','k_train','k_eval','acceptance_rate','long_term_r2c_ratio','clock_running_time','run_id'])
    writer.writeheader()
    writer.writerows(rows)

by_k = {}
for row in rows:
    if row['acceptance_rate']:
        by_k.setdefault(row['k_train'], []).append(float(row['acceptance_rate']))

with report_md.open('w') as handle:
    handle.write(f'# {topology} k-train/k-eval diagonal ({arm})\\n\\n')
    handle.write('Each row trains with k_train and evaluates the resulting policy_latest.pt with the same k_eval.\\n\\n')
    handle.write('## Mean acceptance by matched k\\n\\n')
    handle.write('| k_train = k_eval | seeds | mean acceptance | std acceptance |\\n')
    handle.write('| ---: | ---: | ---: | ---: |\\n')
    for k in sorted(by_k, key=lambda x: int(x)):
        vals = by_k[k]
        std = statistics.pstdev(vals) if len(vals) > 1 else 0.0
        handle.write(f'| {k} | {len(vals)} | {statistics.mean(vals):.3f} | {std:.3f} |\\n')
    handle.write('\\n## Per-seed results\\n\\n')
    handle.write('| k_train | k_eval | seed | acceptance | lrc | clock | run |\\n')
    handle.write('| ---: | ---: | ---: | ---: | ---: | ---: | --- |\\n')
    for row in rows:
        handle.write(f\"| {row['k_train']} | {row['k_eval']} | {row['seed']} | {row['acceptance_rate']} | {row['long_term_r2c_ratio']} | {row['clock_running_time']} | {row['run_id']} |\\n\")

print(f'wrote {summary_csv}')
print(f'wrote {report_md}')
" "$SOLVER_RESULTS_ROOT" "$ARM" "$EVAL_SUMMARY_CSV" "$REPORT_MD" "$TOPOLOGY" "$STAMP"

  echo
  cat "$REPORT_MD"
}

print_plan
preflight

if [[ "$DRY_RUN" == "1" ]]; then
  echo
  echo "dry-run only. preflight passed; no train/eval commands executed."
  exit 0
fi

if [[ "$TRAIN_ONLY" == "1" && "$EVAL_ONLY" == "1" ]]; then
  echo "TRAIN_ONLY=1 and EVAL_ONLY=1 are mutually exclusive." >&2
  exit 1
fi

for k in $K_VALUES; do
  for seed in $SEEDS; do
    if [[ "$EVAL_ONLY" == "1" ]]; then
      if [[ -n "$(find_completed_eval "$seed" "$k" || true)" ]]; then
        LAST_TRAIN_RUN_ID=""
      else
        LAST_TRAIN_RUN_ID="$(find_completed_train "$seed" "$k" || true)"
        [[ -n "$LAST_TRAIN_RUN_ID" ]] || { echo "missing completed train for seed=$seed k_train=$k" >&2; exit 1; }
      fi
    else
      run_train "$seed" "$k"
    fi

    if [[ "$TRAIN_ONLY" != "1" ]]; then
      run_eval "$seed" "$k" "$LAST_TRAIN_RUN_ID"
    fi
  done
done

if [[ "$TRAIN_ONLY" != "1" ]]; then
  generate_report
fi

section "Done"
echo "analysis_root:  $ANALYSIS_ROOT"
echo "eval summary:   $EVAL_SUMMARY_CSV"
echo "report:         $REPORT_MD"
