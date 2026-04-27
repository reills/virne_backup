#!/usr/bin/env bash
# Single-arm overnight on codex that re-creates 84453e5's hard-coded C++ behavior
# via env flags, then trains + evals across {geant, brain, wx100} x {0,1,2}.
#
# Intended flow:
#   git switch codex/create-sfc-solver-with-alphazero-approach
#   # rebuild the C++ extension so env flags take effect
#   conda run -n virne pip install -e . --no-build-isolation  OR your usual build step
#   bash tools/run_codex_lock_in.sh
#
# The env flags below re-create the hard-coded behavior that gave 84453e5 the best
# brain performance. The one remaining codex-only change that is NOT gated by an
# env flag is `curr_v_node_override = step_index` in mcts_engine.cpp::expand()
# (commit 8503911). If brain underperforms vs the 84453e5 numbers, that line is
# the next suspect.

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

STAMP="${STAMP:-$(date -u +%Y%m%dT%H%M%SZ)}"
ARM="${ARM:-match_84453e5}"
TOPOLOGIES="${TOPOLOGIES:-geant brain wx100}"
SEEDS="${SEEDS:-0 1 2}"

RESULTS_ROOT="${RESULTS_ROOT:-$ROOT_DIR/results/journal_suite/results}"
SOLVER_RESULTS_ROOT="${SOLVER_RESULTS_ROOT:-$RESULTS_ROOT/alpha_zero_sfc}"
LOCK_IN_ROOT="${LOCK_IN_ROOT:-$ROOT_DIR/results/codex_lock_in/$STAMP}"
EXTRACTED_MODELS_DIR="$LOCK_IN_ROOT/extracted_models"
RUN_LOG="$LOCK_IN_ROOT/run.log"
EVAL_SUMMARY_CSV="$LOCK_IN_ROOT/eval_summary.csv"
REPORT_MD="$LOCK_IN_ROOT/report.md"

RESUME_COMPLETED="${RESUME_COMPLETED:-1}"
DRY_RUN="${DRY_RUN:-0}"
SWEEP_BRAIN_CHECKPOINTS="${SWEEP_BRAIN_CHECKPOINTS:-1}"
BRAIN_SWEEP_STEP_STRIDE="${BRAIN_SWEEP_STEP_STRIDE:-1024}"
BRAIN_SWEEP_INCLUDE_GUARANTEED="${BRAIN_SWEEP_INCLUDE_GUARANTEED:-1}"

NUM_V_NETS="${NUM_V_NETS:-1000}"
COMPUTATION_BUDGET="${COMPUTATION_BUDGET:-96}"
TRAIN_NUM_WORKERS="${TRAIN_NUM_WORKERS:-8}"
TRAIN_NUM_EPOCHS="${TRAIN_NUM_EPOCHS:-16}"
TRAIN_MAX_STEPS="${TRAIN_MAX_STEPS:-3000}"
TRAIN_MIN_BUFFER_SIZE="${TRAIN_MIN_BUFFER_SIZE:-128}"
TRAIN_STEPS_PER_EPOCH="${TRAIN_STEPS_PER_EPOCH:-128}"
TRAIN_MAX_EMPTY_BATCHES="${TRAIN_MAX_EMPTY_BATCHES:-5400}"
BRAIN_SAVE_INTERVAL="${BRAIN_SAVE_INTERVAL:-256}"
NON_BRAIN_SAVE_INTERVAL="${NON_BRAIN_SAVE_INTERVAL:-2000}"
GUARANTEED_SAVE_STEP="${GUARANTEED_SAVE_STEP:-50}"

NN_EMBED_DIM="${NN_EMBED_DIM:-96}"
NN_HIDDEN_DIM="${NN_HIDDEN_DIM:-96}"
NN_GNN_LAYERS="${NN_GNN_LAYERS:-2}"
NN_HEADS="${NN_HEADS:-6}"
NN_TRANSFORMER_LAYERS="${NN_TRANSFORMER_LAYERS:-2}"

# Exported once here and used for both train and eval. Defaults match the
# 84453e5-style lock-in recipe, but remain overridable from the shell.
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

mkdir -p "$LOCK_IN_ROOT" "$EXTRACTED_MODELS_DIR"

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

dataset_dir() { echo "$ROOT_DIR/datasets/generated/journal/nominal/$1/seed_$2/$3"; }
train_run_id() { echo "journal_suite__alpha_zero_sfc__$1__${ARM}__seed$2__train__ktrain10__${STAMP}"; }
eval_run_id()  { echo "journal_suite__alpha_zero_sfc__$1__${ARM}_$4__seed$2__eval__keval10__${STAMP}"; }
solver_run_dir() { echo "$SOLVER_RESULTS_ROOT/$1"; }

print_plan() {
  section "Codex Lock-In"
  echo "stamp:                $STAMP"
  echo "arm:                  $ARM"
  echo "topologies:           $TOPOLOGIES"
  echo "seeds:                $SEEDS"
  echo "results_root:         $RESULTS_ROOT"
  echo "lock_in_root:         $LOCK_IN_ROOT"
  echo
  echo "env flags (applied to both train and eval):"
  echo "  AZSFC_CPP_USE_MEAN_Q_ROOT_VALUE=$AZSFC_CPP_USE_MEAN_Q_ROOT_VALUE"
  echo "  AZSFC_CPP_AVAILABLE_SHORTEST_FALLBACK=$AZSFC_CPP_AVAILABLE_SHORTEST_FALLBACK"
  echo "  AZSFC_CPP_MIX_STEP_SEED=$AZSFC_CPP_MIX_STEP_SEED"
  echo "  AZSFC_CPP_SHARE_REVERSE_EDGE_CAPACITY=$AZSFC_CPP_SHARE_REVERSE_EDGE_CAPACITY"
  echo "  AZSFC_CPP_PERSISTENT_TREE=$AZSFC_CPP_PERSISTENT_TREE"
  echo "  AZSFC_CPP_SET_V_NODE_OVERRIDE=$AZSFC_CPP_SET_V_NODE_OVERRIDE"
  echo "  AZSFC_CPP_USE_CANDIDATE_FEATURES=$AZSFC_CPP_USE_CANDIDATE_FEATURES"
  echo
  echo "train: $TRAIN_NUM_EPOCHS epochs, max_steps=$TRAIN_MAX_STEPS, steps/epoch=$TRAIN_STEPS_PER_EPOCH, workers=$TRAIN_NUM_WORKERS"
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

  # Confirm the env flags actually exist in the C++ code on this branch. If not,
  # we're on the wrong branch (or the .so wasn't rebuilt) and the flags are no-ops.
  local flag
  local missing=0
  for flag in AZSFC_CPP_USE_MEAN_Q_ROOT_VALUE AZSFC_CPP_AVAILABLE_SHORTEST_FALLBACK \
              AZSFC_CPP_MIX_STEP_SEED AZSFC_CPP_PERSISTENT_TREE \
              AZSFC_CPP_SHARE_REVERSE_EDGE_CAPACITY AZSFC_CPP_SET_V_NODE_OVERRIDE \
              AZSFC_CPP_USE_CANDIDATE_FEATURES; do
    if ! grep -q "$flag" virne/solver/learning/reinforcement_learning/alpha_vne/cpp_core/src/*.cpp \
                       virne/solver/learning/reinforcement_learning/alpha_vne/*.py 2>/dev/null; then
      echo "ERROR: $flag not found in C++/adapter sources. You are not on codex, or the branch doesn't support this flag." >&2
      missing=1
    fi
  done
  (( missing == 0 )) || exit 1

  # Verify the compiled extension loads.
  run_cmd conda run -n virne python -c "from virne.solver.learning.reinforcement_learning.alpha_vne import alpha_zero_cpp_core as m; print(m.__file__)"

  # Datasets must exist.
  local topo seed
  for topo in $TOPOLOGIES; do
    for seed in $SEEDS; do
      require_dir "$(dataset_dir "$topo" "$seed" train)"
      require_dir "$(dataset_dir "$topo" "$seed" test)"
    done
  done
  echo "All required datasets present."
}

# Find a prior completed train run we can reuse.
find_completed_train() {
  local topo="$1" seed="$2"
  local pattern="$SOLVER_RESULTS_ROOT/journal_suite__alpha_zero_sfc__${topo}__${ARM}__seed${seed}__train__ktrain10__*"
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
  local topo="$1" seed="$2" ckpt_label="$3"
  local pattern="$SOLVER_RESULTS_ROOT/journal_suite__alpha_zero_sfc__${topo}__${ARM}_${ckpt_label}__seed${seed}__eval__keval10__*"
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
  local topo="$1" seed="$2" save_interval="$3" save_history="$4"
  local train_dir run_id run_dir existing
  train_dir="$(dataset_dir "$topo" "$seed" train)"
  run_id="$(train_run_id "$topo" "$seed")"
  run_dir="$(solver_run_dir "$run_id")"

  if [[ "$RESUME_COMPLETED" == "1" ]]; then
    existing="$(find_completed_train "$topo" "$seed" || true)"
    if [[ -n "$existing" ]]; then
      section "Train $topo seed=$seed"
      echo "reusing completed train: $existing"
      LAST_TRAIN_RUN_ID="$existing"
      return 0
    fi
  fi

  section "Train $topo seed=$seed"
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
    training.guaranteed_save_step="$GUARANTEED_SAVE_STEP" \
    training.min_buffer_size="$TRAIN_MIN_BUFFER_SIZE" \
    training.num_train_steps_per_epoch="$TRAIN_STEPS_PER_EPOCH" \
    training.max_empty_batches="$TRAIN_MAX_EMPTY_BATCHES" \
    training.save_interval="$save_interval" \
    training.save_checkpoint_history="$save_history" \
    training.pure_cpp=true \
    training.use_cpp_mcts=true \
    training.use_cuda=true \
    training.use_batched_gpu=false \
    training.distributed_training=true \
    training.resume_training=false \
    training.alpha_zero_backbone=transformer \
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
    state=None
assert isinstance(state, dict) and state, f'unsupported checkpoint format in {src}'
assert all(torch.is_tensor(v) for v in state.values()), f'extracted object is not a pure tensor state_dict in {src}'
dst.parent.mkdir(parents=True, exist_ok=True)
torch.save(state, dst)
" "$src" "$dst"
}

run_eval() {
  local topo="$1" seed="$2" ckpt_src="$3" ckpt_label="$4"
  local test_dir run_id run_dir existing weights_path
  test_dir="$(dataset_dir "$topo" "$seed" test)"
  require_file "$ckpt_src"

  if [[ "$RESUME_COMPLETED" == "1" ]]; then
    existing="$(find_completed_eval "$topo" "$seed" "$ckpt_label" || true)"
    if [[ -n "$existing" ]]; then
      section "Eval $topo seed=$seed ckpt=$ckpt_label"
      echo "reusing completed eval: $existing"
      return 0
    fi
  fi

  weights_path="$EXTRACTED_MODELS_DIR/${topo}_seed${seed}_${ckpt_label}_weights.pt"
  extract_weights "$ckpt_src" "$weights_path"
  [[ "$DRY_RUN" == "1" ]] || require_file "$weights_path"

  run_id="$(eval_run_id "$topo" "$seed" "" "$ckpt_label")"
  run_dir="$(solver_run_dir "$run_id")"

  section "Eval $topo seed=$seed ckpt=$ckpt_label"
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

run_topology_seed() {
  local topo="$1" seed="$2"
  local save_interval save_history
  if [[ "$topo" == "brain" && "$SWEEP_BRAIN_CHECKPOINTS" == "1" ]]; then
    save_interval="$BRAIN_SAVE_INTERVAL"
    save_history=true
  else
    save_interval="$NON_BRAIN_SAVE_INTERVAL"
    save_history=false
  fi

  run_train "$topo" "$seed" "$save_interval" "$save_history"

  local train_id models_dir latest_model
  train_id="$LAST_TRAIN_RUN_ID"
  models_dir="$(solver_run_dir "$train_id")/models"
  latest_model="$models_dir/policy_latest.pt"
  [[ "$DRY_RUN" == "1" ]] || require_file "$latest_model"

  if [[ "$topo" == "brain" && "$SWEEP_BRAIN_CHECKPOINTS" == "1" ]]; then
    # Evaluate checkpoints at stride + guaranteed step, excluding the final (latest uses policy_latest).
    local step_ckpts max_step ckpt step
    mapfile -t step_ckpts < <(find "$models_dir" -maxdepth 1 -type f -name 'policy_step_*.pt' | sort -V)
    if (( ${#step_ckpts[@]} > 0 )); then
      max_step="$((10#$(basename "${step_ckpts[-1]}" .pt | awk -F_ '{print $NF}')))"
      for ckpt in "${step_ckpts[@]}"; do
        step="$((10#$(basename "$ckpt" .pt | awk -F_ '{print $NF}')))"
        if (( step == max_step )); then continue; fi
        local should=0
        if [[ "$BRAIN_SWEEP_INCLUDE_GUARANTEED" == "1" ]] && (( step == GUARANTEED_SAVE_STEP )); then should=1; fi
        if (( BRAIN_SWEEP_STEP_STRIDE > 0 )) && (( step % BRAIN_SWEEP_STEP_STRIDE == 0 )); then should=1; fi
        if (( should == 1 )); then
          run_eval "$topo" "$seed" "$ckpt" "$(basename "$ckpt" .pt)"
        fi
      done
    fi
  fi

  run_eval "$topo" "$seed" "$latest_model" "latest"
}

generate_report() {
  section "Generate Report"
  if [[ "$DRY_RUN" == "1" ]]; then
    echo "dry-run: skipping report"
    return 0
  fi

  run_cmd conda run -n virne python - "$SOLVER_RESULTS_ROOT" "$STAMP" "$ARM" "$EVAL_SUMMARY_CSV" "$REPORT_MD" <<'PY'
import csv, pathlib, re, statistics, sys
from collections import defaultdict

solver_root, stamp, arm, summary_csv, report_md = sys.argv[1:]
solver_root = pathlib.Path(solver_root)
summary_csv = pathlib.Path(summary_csv)
report_md  = pathlib.Path(report_md)

pat = re.compile(
    rf'^journal_suite__alpha_zero_sfc__(?P<topo>[^_]+)__{re.escape(arm)}_(?P<ckpt>[^_]+(?:_\d+)?)__seed(?P<seed>\d+)__eval__keval10__(?P<stamp>.+)$'
)
rows = []
for d in sorted(solver_root.glob(f'journal_suite__alpha_zero_sfc__*__{arm}_*__seed*__eval__keval10__{stamp}')):
    m = pat.match(d.name)
    if not m:
        continue
    summary_path = d / 'summary.csv'
    row = {'arm': arm, 'topology': m.group('topo'), 'seed': m.group('seed'),
           'checkpoint': m.group('ckpt'), 'run_id': d.name,
           'acceptance_rate': '', 'long_term_r2c_ratio': '', 'clock_running_time': '',
           'status': 'missing_summary'}
    if summary_path.exists():
        with summary_path.open() as f:
            srows = list(csv.DictReader(f))
        if srows:
            s = srows[-1]
            row.update({
                'acceptance_rate': s.get('acceptance_rate', ''),
                'long_term_r2c_ratio': s.get('long_term_r2c_ratio', ''),
                'clock_running_time': s.get('clock_running_time', ''),
                'status': 'ok',
            })
    rows.append(row)

fields = ['arm','topology','seed','checkpoint','acceptance_rate','long_term_r2c_ratio','clock_running_time','status','run_id']
summary_csv.parent.mkdir(parents=True, exist_ok=True)
with summary_csv.open('w', newline='') as f:
    w = csv.DictWriter(f, fieldnames=fields); w.writeheader(); w.writerows(rows)

def _f(x):
    try: return float(x)
    except: return None

latest_rows = [r for r in rows if r['checkpoint'] == 'latest' and r['status']=='ok']
by_topo = defaultdict(list)
for r in latest_rows:
    acc = _f(r['acceptance_rate'])
    if acc is not None:
        by_topo[r['topology']].append((int(r['seed']), acc, r))

with report_md.open('w') as f:
    f.write(f'# Codex Lock-In  ({arm}, stamp {stamp})\n\n')
    f.write('## Latest-checkpoint acceptance by topology\n\n')
    f.write('| topology | seed | acceptance | lrc | clock | run |\n')
    f.write('| --- | --- | --- | --- | --- | --- |\n')
    for topo in sorted(by_topo):
        for seed, acc, r in sorted(by_topo[topo]):
            f.write(f"| {topo} | {seed} | {acc:.3f} | {r['long_term_r2c_ratio']} | {r['clock_running_time']} | {r['run_id']} |\n")
    f.write('\n## Per-topology mean acceptance (latest)\n\n')
    for topo in sorted(by_topo):
        vals = [acc for _, acc, _ in by_topo[topo]]
        f.write(f"- {topo}: n={len(vals)}  mean={statistics.mean(vals):.3f}  min={min(vals):.3f}  max={max(vals):.3f}\n")

    brain_sweep = [r for r in rows if r['topology']=='brain' and r['checkpoint']!='latest' and r['status']=='ok']
    if brain_sweep:
        f.write('\n## Brain checkpoint sweep (diagnostic)\n\n')
        f.write('| seed | checkpoint | acceptance | run |\n')
        f.write('| --- | --- | --- | --- |\n')
        for r in sorted(brain_sweep, key=lambda x: (int(x['seed']), x['checkpoint'])):
            f.write(f"| {r['seed']} | {r['checkpoint']} | {r['acceptance_rate']} | {r['run_id']} |\n")

    f.write(f'\n## Files\n- eval summary csv: {summary_csv}\n')
print(f'wrote {report_md}')
print(f'wrote {summary_csv}')
PY

  echo
  cat "$REPORT_MD"
}

LAST_TRAIN_RUN_ID=""
print_plan
if [[ "$DRY_RUN" == "1" ]]; then
  echo; echo "dry-run only. no commands executed."; exit 0
fi
preflight

for topo in $TOPOLOGIES; do
  for seed in $SEEDS; do
    run_topology_seed "$topo" "$seed"
  done
done

generate_report

section "Done"
echo "lock_in_root:  $LOCK_IN_ROOT"
echo "eval summary:  $EVAL_SUMMARY_CSV"
echo "report:        $REPORT_MD"
