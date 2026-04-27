#!/usr/bin/env bash
# Brain-only alpha_zero_sfc test for the remaining 84453e5 suspect:
# non-root curr_v_node_override assignment in the C++ MCTS tree.
#
# This uses the same fixed-dataset alpha_zero_sfc pure-C++ harness as the
# codex lock-in run, so the outputs are directly comparable to:
#   - codex_lock_in match_84453e5
#   - current_all_on / legacyroot_nofallback

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

STAMP="${STAMP:-$(date -u +%Y%m%dT%H%M%SZ)}"
ARM="${ARM:-match_84453e5_plus_no_override}"
SEEDS="${SEEDS:-0 1 2}"

RESULTS_ROOT="${RESULTS_ROOT:-$ROOT_DIR/results/journal_suite/results}"
SOLVER_RESULTS_ROOT="${SOLVER_RESULTS_ROOT:-$RESULTS_ROOT/alpha_zero_sfc}"
ANALYSIS_ROOT="${ANALYSIS_ROOT:-$ROOT_DIR/results/brain_override_test/$STAMP}"
EXTRACTED_MODELS_DIR="$ANALYSIS_ROOT/extracted_models"
RUN_LOG="$ANALYSIS_ROOT/run.log"
EVAL_SUMMARY_CSV="$ANALYSIS_ROOT/eval_summary.csv"
REPORT_MD="$ANALYSIS_ROOT/report.md"
INIT_MODEL_PATH="${INIT_MODEL_PATH:-}"

RESUME_COMPLETED="${RESUME_COMPLETED:-1}"
DRY_RUN="${DRY_RUN:-0}"
RUN_EVAL="${RUN_EVAL:-1}"
SWEEP_BRAIN_CHECKPOINTS="${SWEEP_BRAIN_CHECKPOINTS:-1}"
BRAIN_SWEEP_STEP_STRIDE="${BRAIN_SWEEP_STEP_STRIDE:-1024}"
BRAIN_SWEEP_INCLUDE_GUARANTEED="${BRAIN_SWEEP_INCLUDE_GUARANTEED:-1}"
SIGNAL_SAMPLE_FILES="${SIGNAL_SAMPLE_FILES:-300}"
SIGNAL_POLICY_WINDOW="${SIGNAL_POLICY_WINDOW:-100}"

NUM_V_NETS="${NUM_V_NETS:-1000}"
COMPUTATION_BUDGET="${COMPUTATION_BUDGET:-96}"
TRAIN_NUM_WORKERS="${TRAIN_NUM_WORKERS:-8}"
TRAIN_NUM_EPOCHS="${TRAIN_NUM_EPOCHS:-16}"
TRAIN_MAX_STEPS="${TRAIN_MAX_STEPS:-3000}"
TRAIN_MIN_BUFFER_SIZE="${TRAIN_MIN_BUFFER_SIZE:-128}"
TRAIN_STEPS_PER_EPOCH="${TRAIN_STEPS_PER_EPOCH:-128}"
TRAIN_MAX_EMPTY_BATCHES="${TRAIN_MAX_EMPTY_BATCHES:-5400}"
BRAIN_SAVE_INTERVAL="${BRAIN_SAVE_INTERVAL:-256}"
GUARANTEED_SAVE_STEP="${GUARANTEED_SAVE_STEP:-50}"

NN_EMBED_DIM="${NN_EMBED_DIM:-96}"
NN_HIDDEN_DIM="${NN_HIDDEN_DIM:-96}"
NN_GNN_LAYERS="${NN_GNN_LAYERS:-2}"
NN_HEADS="${NN_HEADS:-6}"
NN_TRANSFORMER_LAYERS="${NN_TRANSFORMER_LAYERS:-2}"

# Match 84453e5 as closely as possible on codex. Individual knobs remain
# overridable from the shell so we can isolate single suspects cheaply.
export AZSFC_CPP_USE_MEAN_Q_ROOT_VALUE="${AZSFC_CPP_USE_MEAN_Q_ROOT_VALUE:-0}"
export AZSFC_CPP_AVAILABLE_SHORTEST_FALLBACK="${AZSFC_CPP_AVAILABLE_SHORTEST_FALLBACK:-0}"
export AZSFC_CPP_MIX_STEP_SEED="${AZSFC_CPP_MIX_STEP_SEED:-0}"
export AZSFC_CPP_SHARE_REVERSE_EDGE_CAPACITY="${AZSFC_CPP_SHARE_REVERSE_EDGE_CAPACITY:-0}"
export AZSFC_CPP_PERSISTENT_TREE="${AZSFC_CPP_PERSISTENT_TREE:-1}"
export AZSFC_CPP_SET_V_NODE_OVERRIDE="${AZSFC_CPP_SET_V_NODE_OVERRIDE:-0}"
export AZSFC_CPP_DISABLE_ADVANCE_ROOT="${AZSFC_CPP_DISABLE_ADVANCE_ROOT:-0}"
export AZSFC_CPP_FORCE_TREE_RESET_EACH_STEP="${AZSFC_CPP_FORCE_TREE_RESET_EACH_STEP:-0}"
export AZSFC_PY_LEGACY_BRIDGE_84453E5="${AZSFC_PY_LEGACY_BRIDGE_84453E5:-0}"
export AZSFC_CPP_USE_CANDIDATE_FEATURES="${AZSFC_CPP_USE_CANDIDATE_FEATURES:-1}"
export AZSFC_DISABLE_LEARNER_RNG_SEED="${AZSFC_DISABLE_LEARNER_RNG_SEED:-0}"
export AZSFC_LEARNER_RNG_SEED="${AZSFC_LEARNER_RNG_SEED:-}"

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

TRAIN_SAVE_INTERVAL="$BRAIN_SAVE_INTERVAL"
TRAIN_GUARANTEED_SAVE_STEP="$GUARANTEED_SAVE_STEP"
if [[ "$SWEEP_BRAIN_CHECKPOINTS" != "1" ]]; then
  TRAIN_SAVE_INTERVAL="$((TRAIN_MAX_STEPS + TRAIN_STEPS_PER_EPOCH + 1024))"
  TRAIN_GUARANTEED_SAVE_STEP="$((TRAIN_MAX_STEPS + TRAIN_STEPS_PER_EPOCH + 1024))"
fi

dataset_dir() { echo "$ROOT_DIR/datasets/generated/journal/nominal/brain/seed_$1/$2"; }
train_run_id() { echo "journal_suite__alpha_zero_sfc__brain__${ARM}__seed$1__train__ktrain10__${STAMP}"; }
eval_run_id()  { echo "journal_suite__alpha_zero_sfc__brain__${ARM}_$2__seed$1__eval__keval10__${STAMP}"; }
solver_run_dir() { echo "$SOLVER_RESULTS_ROOT/$1"; }

print_plan() {
  section "Brain Override Test"
  echo "stamp:                $STAMP"
  echo "arm:                  $ARM"
  echo "seeds:                $SEEDS"
  echo "results_root:         $RESULTS_ROOT"
  echo "analysis_root:        $ANALYSIS_ROOT"
  echo "init_model_path:      ${INIT_MODEL_PATH:-<none>}"
  echo
  echo "env flags (applied to both train and eval):"
  echo "  AZSFC_CPP_USE_MEAN_Q_ROOT_VALUE=$AZSFC_CPP_USE_MEAN_Q_ROOT_VALUE"
  echo "  AZSFC_CPP_AVAILABLE_SHORTEST_FALLBACK=$AZSFC_CPP_AVAILABLE_SHORTEST_FALLBACK"
  echo "  AZSFC_CPP_MIX_STEP_SEED=$AZSFC_CPP_MIX_STEP_SEED"
  echo "  AZSFC_CPP_SHARE_REVERSE_EDGE_CAPACITY=$AZSFC_CPP_SHARE_REVERSE_EDGE_CAPACITY"
  echo "  AZSFC_CPP_PERSISTENT_TREE=$AZSFC_CPP_PERSISTENT_TREE"
  echo "  AZSFC_CPP_SET_V_NODE_OVERRIDE=$AZSFC_CPP_SET_V_NODE_OVERRIDE"
  echo "  AZSFC_CPP_DISABLE_ADVANCE_ROOT=$AZSFC_CPP_DISABLE_ADVANCE_ROOT"
  echo "  AZSFC_CPP_FORCE_TREE_RESET_EACH_STEP=$AZSFC_CPP_FORCE_TREE_RESET_EACH_STEP"
  echo "  AZSFC_PY_LEGACY_BRIDGE_84453E5=$AZSFC_PY_LEGACY_BRIDGE_84453E5"
  echo "  AZSFC_CPP_USE_CANDIDATE_FEATURES=$AZSFC_CPP_USE_CANDIDATE_FEATURES"
  echo "  AZSFC_DISABLE_LEARNER_RNG_SEED=$AZSFC_DISABLE_LEARNER_RNG_SEED"
  echo "  AZSFC_LEARNER_RNG_SEED=${AZSFC_LEARNER_RNG_SEED:-<config default>}"
  echo
  echo "train: $TRAIN_NUM_EPOCHS epochs, max_steps=$TRAIN_MAX_STEPS, steps/epoch=$TRAIN_STEPS_PER_EPOCH, workers=$TRAIN_NUM_WORKERS"
  echo "run_eval=$RUN_EVAL"
  echo "checkpoint_history=$SWEEP_BRAIN_CHECKPOINTS, save_interval=$TRAIN_SAVE_INTERVAL, guaranteed_save_step=$TRAIN_GUARANTEED_SAVE_STEP"
  echo "brain sweep: stride=$BRAIN_SWEEP_STEP_STRIDE, include_guaranteed=$BRAIN_SWEEP_INCLUDE_GUARANTEED"
  echo "num_v_nets=$NUM_V_NETS, computation_budget=$COMPUTATION_BUDGET"
  echo
  echo "branch:  $(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo unknown)"
  echo "HEAD:    $(git rev-parse HEAD 2>/dev/null || echo unknown)"
}

preflight() {
  section "Preflight"
  if (( TRAIN_NUM_EPOCHS % TRAIN_NUM_WORKERS != 0 )); then
    echo "TRAIN_NUM_EPOCHS=$TRAIN_NUM_EPOCHS must be divisible by TRAIN_NUM_WORKERS=$TRAIN_NUM_WORKERS" >&2
    exit 1
  fi

  local src_dir="virne/solver/learning/reinforcement_learning/alpha_vne/cpp_core/src"
  local py_dir="virne/solver/learning/reinforcement_learning/alpha_vne"
  local flag missing=0
  local required_flags=(
    AZSFC_CPP_USE_MEAN_Q_ROOT_VALUE \
    AZSFC_CPP_AVAILABLE_SHORTEST_FALLBACK \
    AZSFC_CPP_MIX_STEP_SEED \
    AZSFC_CPP_SHARE_REVERSE_EDGE_CAPACITY \
    AZSFC_CPP_PERSISTENT_TREE \
    AZSFC_CPP_SET_V_NODE_OVERRIDE \
    AZSFC_CPP_USE_CANDIDATE_FEATURES
  )
  local optional_flags=(
    AZSFC_CPP_DISABLE_ADVANCE_ROOT
    AZSFC_CPP_FORCE_TREE_RESET_EACH_STEP
    AZSFC_PY_LEGACY_BRIDGE_84453E5
  )

  for flag in "${required_flags[@]}"; do
    if ! grep -q "$flag" "$src_dir"/*.cpp "$py_dir"/*.py 2>/dev/null; then
      echo "ERROR: required flag $flag not found in C++/adapter sources." >&2
      missing=1
    fi
  done

  for flag in "${optional_flags[@]}"; do
    if ! grep -q "$flag" "$src_dir"/*.cpp "$py_dir"/*.py 2>/dev/null; then
      if [[ "${!flag:-0}" == "1" ]]; then
        echo "ERROR: optional flag $flag was enabled but is not present in C++/adapter sources." >&2
        missing=1
      else
        echo "note: optional flag $flag not present; ignoring because it is disabled."
      fi
    fi
  done
  (( missing == 0 )) || exit 1

  run_cmd conda run -n virne python -c "from virne.solver.learning.reinforcement_learning.alpha_vne import alpha_zero_cpp_core as m; print(m.__file__)"

  local seed
  if [[ -n "$INIT_MODEL_PATH" ]]; then
    require_file "$INIT_MODEL_PATH"
  fi
  for seed in $SEEDS; do
    require_dir "$(dataset_dir "$seed" train)"
    require_dir "$(dataset_dir "$seed" test)"
  done
  echo "All required brain datasets present."
}

find_completed_train() {
  local seed="$1"
  local pattern="$SOLVER_RESULTS_ROOT/journal_suite__alpha_zero_sfc__brain__${ARM}__seed${seed}__train__ktrain10__*"
  shopt -s nullglob
  local best="" best_ts=-1 dir ts
  for dir in $pattern; do
    [[ -d "$dir" && -f "$dir/models/policy_latest.pt" && -f "$dir/summary.csv" ]] || continue
    ts="$(stat -c %Y "$dir/models/policy_latest.pt" 2>/dev/null || echo 0)"
    (( ts > best_ts )) && { best="$dir"; best_ts="$ts"; }
  done
  shopt -u nullglob
  [[ -n "$best" ]] && basename "$best"
}

find_completed_eval() {
  local seed="$1" ckpt_label="$2"
  local pattern="$SOLVER_RESULTS_ROOT/journal_suite__alpha_zero_sfc__brain__${ARM}_${ckpt_label}__seed${seed}__eval__keval10__*"
  shopt -s nullglob
  local best="" best_ts=-1 dir ts
  for dir in $pattern; do
    [[ -d "$dir" && -f "$dir/summary.csv" ]] || continue
    ts="$(stat -c %Y "$dir/summary.csv" 2>/dev/null || echo 0)"
    (( ts > best_ts )) && { best="$dir"; best_ts="$ts"; }
  done
  shopt -u nullglob
  [[ -n "$best" ]] && basename "$best"
}

run_train() {
  local seed="$1"
  local train_dir run_id run_dir existing
  train_dir="$(dataset_dir "$seed" train)"
  run_id="$(train_run_id "$seed")"
  run_dir="$(solver_run_dir "$run_id")"

  if [[ "$RESUME_COMPLETED" == "1" ]]; then
    existing="$(find_completed_train "$seed" || true)"
    if [[ -n "$existing" ]]; then
      section "Train brain seed=$seed"
      echo "reusing completed train: $existing"
      LAST_TRAIN_RUN_ID="$existing"
      return 0
    fi
  fi

  section "Train brain seed=$seed"
  run_cmd conda run -n virne python main.py \
    solver.shortest_method=k_shortest \
    solver.allow_rejection=false \
    solver.solver_name=alpha_zero_sfc \
    solver.k_shortest=10 \
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
    training.max_training_steps="$TRAIN_MAX_STEPS" \
    training.guaranteed_save_step="$TRAIN_GUARANTEED_SAVE_STEP" \
    training.min_buffer_size="$TRAIN_MIN_BUFFER_SIZE" \
    training.num_train_steps_per_epoch="$TRAIN_STEPS_PER_EPOCH" \
    training.max_empty_batches="$TRAIN_MAX_EMPTY_BATCHES" \
    training.save_interval="$TRAIN_SAVE_INTERVAL" \
    training.save_checkpoint_history="$SWEEP_BRAIN_CHECKPOINTS" \
    training.pure_cpp=true \
    training.use_cpp_mcts=true \
    training.use_cuda=true \
    training.use_batched_gpu=false \
    training.distributed_training=true \
    training.resume_training=false \
    training.alpha_zero_backbone=transformer \
    training.alphazero_model_path="$INIT_MODEL_PATH" \
    training.signal_stop_event_on_learner_complete=true \
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

  require_file "$run_dir/models/policy_latest.pt"
  LAST_TRAIN_RUN_ID="$run_id"
}

extract_weights() {
  local src="$1" dst="$2"
  run_cmd conda run -n virne python -c "
import pathlib, sys, torch
src=pathlib.Path(sys.argv[1]); dst=pathlib.Path(sys.argv[2])
obj=torch.load(src, map_location='cpu')
if isinstance(obj, dict):
    state = obj.get('model') or obj.get('state_dict') or obj.get('model_state_dict') or (obj if obj and all(torch.is_tensor(v) for v in obj.values()) else None)
else:
    state = obj if isinstance(obj, dict) else None
assert isinstance(state, dict) and state, f'unsupported checkpoint format in {src}'
assert all(torch.is_tensor(v) for v in state.values()), f'extracted object is not a pure tensor state_dict in {src}'
dst.parent.mkdir(parents=True, exist_ok=True)
torch.save(state, dst)
" "$src" "$dst"
}

run_eval() {
  local seed="$1" ckpt_src="$2" ckpt_label="$3"
  local test_dir run_id run_dir existing weights_path
  test_dir="$(dataset_dir "$seed" test)"
  require_file "$ckpt_src"

  if [[ "$RESUME_COMPLETED" == "1" ]]; then
    existing="$(find_completed_eval "$seed" "$ckpt_label" || true)"
    if [[ -n "$existing" ]]; then
      section "Eval brain seed=$seed ckpt=$ckpt_label"
      echo "reusing completed eval: $existing"
      return 0
    fi
  fi

  weights_path="$EXTRACTED_MODELS_DIR/brain_seed${seed}_${ckpt_label}_weights.pt"
  extract_weights "$ckpt_src" "$weights_path"
  [[ "$DRY_RUN" == "1" ]] || require_file "$weights_path"

  run_id="$(eval_run_id "$seed" "$ckpt_label")"
  run_dir="$(solver_run_dir "$run_id")"

  section "Eval brain seed=$seed ckpt=$ckpt_label"
  run_cmd conda run -n virne python main.py \
    solver.shortest_method=k_shortest \
    solver.allow_rejection=false \
    solver.solver_name=alpha_zero_sfc \
    solver.k_shortest=10 \
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

analyze_train_signal() {
  local train_id="$1"
  local run_dir
  run_dir="$(solver_run_dir "$train_id")"
  section "Replay/Learner Signal train=$train_id"
  run_cmd conda run -n virne python tools/analyze_alpha_replay_policy.py \
    --sample-files "$SIGNAL_SAMPLE_FILES" \
    --policy-window "$SIGNAL_POLICY_WINDOW" \
    "$run_dir"
}

run_seed() {
  local seed="$1"
  run_train "$seed"

  local train_id models_dir latest_model
  train_id="$LAST_TRAIN_RUN_ID"
  analyze_train_signal "$train_id"

  if [[ "$RUN_EVAL" != "1" ]]; then
    return 0
  fi

  models_dir="$(solver_run_dir "$train_id")/models"
  latest_model="$models_dir/policy_latest.pt"
  [[ "$DRY_RUN" == "1" ]] || require_file "$latest_model"

  if [[ "$SWEEP_BRAIN_CHECKPOINTS" == "1" ]]; then
    local step_ckpts max_step ckpt step should
    mapfile -t step_ckpts < <(find "$models_dir" -maxdepth 1 -type f -name 'policy_step_*.pt' | sort -V)
    if (( ${#step_ckpts[@]} > 0 )); then
      max_step="$((10#$(basename "${step_ckpts[-1]}" .pt | awk -F_ '{print $NF}')))"
      for ckpt in "${step_ckpts[@]}"; do
        step="$((10#$(basename "$ckpt" .pt | awk -F_ '{print $NF}')))"
        if (( step == max_step )); then continue; fi
        should=0
        if [[ "$BRAIN_SWEEP_INCLUDE_GUARANTEED" == "1" ]] && (( step == GUARANTEED_SAVE_STEP )); then should=1; fi
        if (( BRAIN_SWEEP_STEP_STRIDE > 0 )) && (( step % BRAIN_SWEEP_STEP_STRIDE == 0 )); then should=1; fi
        if (( should == 1 )); then
          run_eval "$seed" "$ckpt" "$(basename "$ckpt" .pt)"
        fi
      done
    fi
  fi

  run_eval "$seed" "$latest_model" "latest"
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
stamp = sys.argv[2]
arm = sys.argv[3]
summary_csv = pathlib.Path(sys.argv[4])
report_md = pathlib.Path(sys.argv[5])

pattern = re.compile(
    r'^journal_suite__alpha_zero_sfc__brain__' + re.escape(arm) + r'_(?P<ckpt>.+)__seed(?P<seed>\d+)__eval__keval10__' + re.escape(stamp) + r'$'
)

rows = []
for summary_path in sorted(solver_root.glob(f'journal_suite__alpha_zero_sfc__brain__{arm}_*__seed*__eval__keval10__{stamp}/summary.csv')):
    run_id = summary_path.parent.name
    match = pattern.match(run_id)
    if not match:
        continue
    with summary_path.open() as handle:
        data_rows = list(csv.DictReader(handle))
    if not data_rows:
        continue
    row = data_rows[-1]
    rows.append({
        'arm': arm,
        'topology': 'brain',
        'seed': match.group('seed'),
        'checkpoint': match.group('ckpt'),
        'acceptance_rate': row.get('acceptance_rate', ''),
        'long_term_r2c_ratio': row.get('long_term_r2c_ratio', ''),
        'clock_running_time': row.get('clock_running_time', ''),
        'run_id': run_id,
    })

summary_csv.parent.mkdir(parents=True, exist_ok=True)
with summary_csv.open('w', newline='') as handle:
    writer = csv.DictWriter(handle, fieldnames=['arm','topology','seed','checkpoint','acceptance_rate','long_term_r2c_ratio','clock_running_time','run_id'])
    writer.writeheader()
    writer.writerows(rows)

latest = [row for row in rows if row['checkpoint'] == 'latest']
latest_vals = [float(row['acceptance_rate']) for row in latest if row['acceptance_rate']]
best_by_seed = []
for seed in sorted({row['seed'] for row in rows}):
    seed_rows = [row for row in rows if row['seed'] == seed and row['acceptance_rate']]
    if not seed_rows:
        continue
    best = max(seed_rows, key=lambda item: float(item['acceptance_rate']))
    best_by_seed.append(best)

with report_md.open('w') as handle:
    handle.write(f'# Brain Override Test ({arm}, stamp {stamp})\\n\\n')
    handle.write('## Latest-checkpoint acceptance\\n\\n')
    handle.write('| seed | acceptance | lrc | clock | run |\\n')
    handle.write('| --- | --- | --- | --- | --- |\\n')
    for row in sorted(latest, key=lambda item: int(item['seed'])):
        handle.write(f\"| {row['seed']} | {row['acceptance_rate']} | {row['long_term_r2c_ratio']} | {row['clock_running_time']} | {row['run_id']} |\\n\")
    if latest_vals:
        handle.write(f\"\\nLatest mean acceptance: {statistics.mean(latest_vals):.3f}\\n\")
    if best_by_seed:
        handle.write('\\n## Best checkpoint by seed (diagnostic)\\n\\n')
        handle.write('| seed | checkpoint | acceptance | run |\\n')
        handle.write('| --- | --- | --- | --- |\\n')
        for row in sorted(best_by_seed, key=lambda item: int(item['seed'])):
            handle.write(f\"| {row['seed']} | {row['checkpoint']} | {row['acceptance_rate']} | {row['run_id']} |\\n\")
        handle.write(f\"\\nBest-by-seed mean acceptance: {statistics.mean(float(row['acceptance_rate']) for row in best_by_seed):.3f}\\n\")

print(f'wrote {summary_csv}')
print(f'wrote {report_md}')
" "$SOLVER_RESULTS_ROOT" "$STAMP" "$ARM" "$EVAL_SUMMARY_CSV" "$REPORT_MD"

  echo
  cat "$REPORT_MD"
}

LAST_TRAIN_RUN_ID=""
print_plan

preflight

if [[ "$DRY_RUN" == "1" ]]; then
  echo
  echo "dry-run only. preflight passed; no train/eval commands executed."
  exit 0
fi

for seed in $SEEDS; do
  run_seed "$seed"
done

if [[ "$RUN_EVAL" == "1" ]]; then
  generate_report
else
  section "Generate Report"
  echo "RUN_EVAL=0; skipped acceptance report. Use the replay/learner signal above to decide whether to continue."
fi

section "Done"
echo "analysis_root:  $ANALYSIS_ROOT"
if [[ "$RUN_EVAL" == "1" ]]; then
  echo "eval summary:   $EVAL_SUMMARY_CSV"
  echo "report:         $REPORT_MD"
fi
