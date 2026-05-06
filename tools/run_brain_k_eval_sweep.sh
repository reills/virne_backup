#!/usr/bin/env bash
# Eval-only k-shortest sweep for the recovered AlphaZero-SFC models.
# Reuses trained checkpoints and varies only solver.k_shortest.

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

STAMP="${STAMP:-$(date -u +%Y%m%dT%H%M%SZ)}"
TOPOLOGY="${TOPOLOGY:-brain}"
case "$TOPOLOGY" in
  brain)
    DEFAULT_SOURCE_STAMP="20260423T101342Z"
    DEFAULT_SOURCE_ARM="brain_replay_move_fix_3k"
    ;;
  geant)
    DEFAULT_SOURCE_STAMP="20260423T225501Z"
    DEFAULT_SOURCE_ARM="topo_replay_move_fix_3k"
    ;;
  wx100)
    DEFAULT_SOURCE_STAMP="20260424T063801Z"
    DEFAULT_SOURCE_ARM="topo_replay_move_fix_3k"
    ;;
  *)
    echo "unsupported TOPOLOGY=$TOPOLOGY; expected brain, geant, or wx100" >&2
    exit 1
    ;;
esac
SOURCE_STAMP="${SOURCE_STAMP:-$DEFAULT_SOURCE_STAMP}"
SOURCE_ARM="${SOURCE_ARM:-$DEFAULT_SOURCE_ARM}"
ARM="${ARM:-${TOPOLOGY}_k_sweep_${SOURCE_ARM}}"
SEEDS="${SEEDS:-0 1 2}"
K_VALUES="${K_VALUES:-1 3 5 7 9 11}"

RESULTS_ROOT="${RESULTS_ROOT:-$ROOT_DIR/results/journal_suite/results}"
SOLVER_RESULTS_ROOT="${SOLVER_RESULTS_ROOT:-$RESULTS_ROOT/alpha_zero_sfc}"
ANALYSIS_ROOT="${ANALYSIS_ROOT:-$ROOT_DIR/results/${TOPOLOGY}_k_sweep/$STAMP}"
EXTRACTED_MODELS_DIR="$ANALYSIS_ROOT/extracted_models"
RUN_LOG="$ANALYSIS_ROOT/run.log"
EVAL_SUMMARY_CSV="$ANALYSIS_ROOT/eval_summary.csv"
REPORT_MD="$ANALYSIS_ROOT/report.md"

RESUME_COMPLETED="${RESUME_COMPLETED:-1}"
DRY_RUN="${DRY_RUN:-0}"
NUM_V_NETS="${NUM_V_NETS:-1000}"
COMPUTATION_BUDGET="${COMPUTATION_BUDGET:-96}"

NN_EMBED_DIM="${NN_EMBED_DIM:-96}"
NN_HIDDEN_DIM="${NN_HIDDEN_DIM:-96}"
NN_GNN_LAYERS="${NN_GNN_LAYERS:-2}"
NN_HEADS="${NN_HEADS:-6}"
NN_TRANSFORMER_LAYERS="${NN_TRANSFORMER_LAYERS:-2}"

# Match the fixed-code recipe used by the recovered brain/geant/wx100 runs.
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

dataset_dir() { echo "$ROOT_DIR/datasets/generated/journal/nominal/${TOPOLOGY}/seed_$1/test"; }
source_model() {
  echo "$SOLVER_RESULTS_ROOT/journal_suite__alpha_zero_sfc__${TOPOLOGY}__${SOURCE_ARM}__seed$1__train__ktrain10__${SOURCE_STAMP}/models/policy_latest.pt"
}
eval_run_id() {
  echo "journal_suite__alpha_zero_sfc__${TOPOLOGY}__${ARM}__k$2__seed$1__eval__keval$2__${STAMP}"
}
solver_run_dir() { echo "$SOLVER_RESULTS_ROOT/$1"; }

print_plan() {
  section "${TOPOLOGY} K Eval Sweep"
  echo "stamp:          $STAMP"
  echo "topology:       $TOPOLOGY"
  echo "source_stamp:   $SOURCE_STAMP"
  echo "source_arm:     $SOURCE_ARM"
  echo "arm:            $ARM"
  echo "seeds:          $SEEDS"
  echo "k_values:       $K_VALUES"
  echo "analysis_root:  $ANALYSIS_ROOT"
  echo "num_v_nets:     $NUM_V_NETS"
  echo "budget:         $COMPUTATION_BUDGET"
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
  echo "branch:        $(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo unknown)"
  echo "HEAD:          $(git rev-parse HEAD 2>/dev/null || echo unknown)"
}

preflight() {
  section "Preflight"
  local seed flag missing=0
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
    require_dir "$(dataset_dir "$seed")"
    require_file "$(source_model "$seed")"
  done
  echo "All required $TOPOLOGY datasets and source checkpoints present."
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

find_completed_eval() {
  local seed="$1" k="$2"
  local pattern="$SOLVER_RESULTS_ROOT/journal_suite__alpha_zero_sfc__${TOPOLOGY}__${ARM}__k${k}__seed${seed}__eval__keval${k}__*"
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

run_eval() {
  local seed="$1" k="$2" model_path weights_path existing run_id run_dir test_dir
  if [[ "$RESUME_COMPLETED" == "1" ]]; then
    existing="$(find_completed_eval "$seed" "$k" || true)"
    if [[ -n "$existing" ]]; then
      section "Eval $TOPOLOGY seed=$seed k=$k"
      echo "reusing completed eval: $existing"
      return 0
    fi
  fi

  model_path="$(source_model "$seed")"
  weights_path="$EXTRACTED_MODELS_DIR/${TOPOLOGY}_seed${seed}_latest_weights.pt"
  extract_weights "$model_path" "$weights_path"

  run_id="$(eval_run_id "$seed" "$k")"
  run_dir="$(solver_run_dir "$run_id")"
  test_dir="$(dataset_dir "$seed")"

  section "Eval $TOPOLOGY seed=$seed k=$k"
  run_cmd conda run -n virne python main.py \
    solver.shortest_method=k_shortest \
    solver.allow_rejection=false \
    solver.solver_name=alpha_zero_sfc \
    solver.k_shortest="$k" \
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
stamp = sys.argv[2]
arm = sys.argv[3]
summary_csv = pathlib.Path(sys.argv[4])
report_md = pathlib.Path(sys.argv[5])
topology = sys.argv[6]

pattern = re.compile(
    r'^journal_suite__alpha_zero_sfc__' + re.escape(topology) + r'__' + re.escape(arm) + r'__k(?P<k>\\d+)__seed(?P<seed>\\d+)__eval__keval(?P=k)__' + re.escape(stamp) + r'$'
)

rows = []
for summary_path in sorted(solver_root.glob(f'journal_suite__alpha_zero_sfc__{topology}__{arm}__k*__seed*__eval__keval*__{stamp}/summary.csv')):
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
        'k_eval': match.group('k'),
        'acceptance_rate': row.get('acceptance_rate', ''),
        'long_term_r2c_ratio': row.get('long_term_r2c_ratio', ''),
        'clock_running_time': row.get('clock_running_time', ''),
        'run_id': run_id,
    })

summary_csv.parent.mkdir(parents=True, exist_ok=True)
with summary_csv.open('w', newline='') as handle:
    writer = csv.DictWriter(handle, fieldnames=['topology','seed','k_eval','acceptance_rate','long_term_r2c_ratio','clock_running_time','run_id'])
    writer.writeheader()
    writer.writerows(sorted(rows, key=lambda r: (int(r['k_eval']), int(r['seed']))))

by_k = {}
for row in rows:
    if row['acceptance_rate']:
        by_k.setdefault(row['k_eval'], []).append(float(row['acceptance_rate']))

with report_md.open('w') as handle:
    handle.write(f'# {topology} k-shortest eval sweep ({arm}, stamp {stamp})\\n\\n')
    handle.write('## Mean acceptance by k\\n\\n')
    handle.write('| k | seeds | mean acceptance | std acceptance |\\n')
    handle.write('| --- | ---: | ---: | ---: |\\n')
    for k in sorted(by_k, key=lambda x: int(x)):
        vals = by_k[k]
        std = statistics.pstdev(vals) if len(vals) > 1 else 0.0
        handle.write(f'| {k} | {len(vals)} | {statistics.mean(vals):.3f} | {std:.3f} |\\n')
    handle.write('\\n## Per-seed results\\n\\n')
    handle.write('| k | seed | acceptance | lrc | clock | run |\\n')
    handle.write('| --- | --- | --- | --- | --- | --- |\\n')
    for row in sorted(rows, key=lambda r: (int(r['k_eval']), int(r['seed']))):
        handle.write(f\"| {row['k_eval']} | {row['seed']} | {row['acceptance_rate']} | {row['long_term_r2c_ratio']} | {row['clock_running_time']} | {row['run_id']} |\\n\")

print(f'wrote {summary_csv}')
print(f'wrote {report_md}')
" "$SOLVER_RESULTS_ROOT" "$STAMP" "$ARM" "$EVAL_SUMMARY_CSV" "$REPORT_MD" "$TOPOLOGY"

  echo
  cat "$REPORT_MD"
}

print_plan
preflight

if [[ "$DRY_RUN" == "1" ]]; then
  echo
  echo "dry-run only. preflight passed; no eval commands executed."
  exit 0
fi

for k in $K_VALUES; do
  for seed in $SEEDS; do
    run_eval "$seed" "$k"
  done
done

generate_report

section "Done"
echo "analysis_root:  $ANALYSIS_ROOT"
echo "eval summary:   $EVAL_SUMMARY_CSV"
echo "report:         $REPORT_MD"
