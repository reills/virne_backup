#!/usr/bin/env bash
# Eval-only k-shortest sweep on the legacy CCWC Waxman/SFC workload.
# Defaults mirror the saved CCWC eval configs. Set PURE_CPP=true only for a
# separate current-C++ stress check; it is not legacy-compatible.

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

STAMP="${STAMP:-$(date -u +%Y%m%dT%H%M%SZ)}"
ARM="${ARM:-legacy_waxman_compat_k_sweep}"
K_VALUES="${K_VALUES:-1 3 5 7 9 11 15}"

LEGACY_P_NET_DIR="${LEGACY_P_NET_DIR:-$ROOT_DIR/dataset/p_net/100-waxman_[0.5-0.2]-cpu_[80-120]-max_cpu_None-bw_[50-100]-max_bw_None-seed_0}"
LEGACY_V_NETS_DIR="${LEGACY_V_NETS_DIR:-$ROOT_DIR/dataset/v_nets/1000-[2-10]-random-500-0.03-cpu_[0-20]-bw_[0-50]-seed_0}"
MODEL_DIR="${MODEL_DIR:-$ROOT_DIR/legacy/CCWC_alpha_zero_sfc/exported_models}"
ANALYSIS_ROOT="${ANALYSIS_ROOT:-$ROOT_DIR/results/legacy_waxman_k_sweep/$STAMP}"
RUNS_ROOT="$ANALYSIS_ROOT/runs"
RUN_LOG="$ANALYSIS_ROOT/run.log"
SUMMARY_CSV="$ANALYSIS_ROOT/eval_summary.csv"
REPORT_MD="$ANALYSIS_ROOT/report.md"

RESUME_COMPLETED="${RESUME_COMPLETED:-1}"
DRY_RUN="${DRY_RUN:-0}"
NUM_V_NETS="${NUM_V_NETS:-1000}"
COMPUTATION_BUDGET="${COMPUTATION_BUDGET:-64}"
NUM_WORKERS="${NUM_WORKERS:-4}"
DISTRIBUTED_TRAINING="${DISTRIBUTED_TRAINING:-true}"
USE_BATCHED_GPU="${USE_BATCHED_GPU:-true}"
PURE_CPP="${PURE_CPP:-false}"

NN_EMBED_DIM="${NN_EMBED_DIM:-96}"
NN_HIDDEN_DIM="${NN_HIDDEN_DIM:-96}"
NN_GNN_LAYERS="${NN_GNN_LAYERS:-2}"
NN_HEADS="${NN_HEADS:-6}"
NN_TRANSFORMER_LAYERS="${NN_TRANSFORMER_LAYERS:-2}"

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

mkdir -p "$ANALYSIS_ROOT" "$RUNS_ROOT"

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

k_label() { printf 'k%02d' "$1"; }
model_path() { echo "$MODEL_DIR/policy_latest_$(k_label "$1").pt"; }
run_id() { echo "${ARM}__$(k_label "$1")__${STAMP}"; }
run_dir() { echo "$RUNS_ROOT/alpha_zero_sfc/$(run_id "$1")"; }

print_plan() {
  section "Legacy Waxman/SFC compatibility k eval sweep"
  echo "stamp:          $STAMP"
  echo "arm:            $ARM"
  echo "k_values:       $K_VALUES"
  echo "p_net_dir:      $LEGACY_P_NET_DIR"
  echo "v_nets_dir:     $LEGACY_V_NETS_DIR"
  echo "model_dir:      $MODEL_DIR"
  echo "analysis_root:  $ANALYSIS_ROOT"
  echo "num_v_nets:     $NUM_V_NETS"
  echo "budget:         $COMPUTATION_BUDGET"
  echo "pure_cpp:       $PURE_CPP"
  echo "num_workers:    $NUM_WORKERS"
  echo "distributed:    $DISTRIBUTED_TRAINING"
  echo "batched_gpu:    $USE_BATCHED_GPU"
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
  require_dir "$LEGACY_P_NET_DIR"
  require_file "$LEGACY_P_NET_DIR/p_net.gml"
  require_dir "$LEGACY_V_NETS_DIR"
  require_file "$LEGACY_V_NETS_DIR/events.yaml"
  require_dir "$LEGACY_V_NETS_DIR/v_nets"

  local k flag missing=0
  for k in $K_VALUES; do
    require_file "$(model_path "$k")"
  done

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

  echo "All required legacy dataset/model files present."
}

find_completed_eval() {
  local k="$1"
  local dir
  dir="$(run_dir "$k")"
  [[ -d "$dir" && -f "$dir/summary.csv" ]] && echo "$(run_id "$k")"
}

run_eval() {
  local k="$1"
  local existing rid rdir mpath

  if [[ "$RESUME_COMPLETED" == "1" ]]; then
    existing="$(find_completed_eval "$k" || true)"
    if [[ -n "$existing" ]]; then
      section "Eval legacy Waxman $(k_label "$k")"
      echo "reusing completed eval: $existing"
      return 0
    fi
  fi

  rid="$(run_id "$k")"
  rdir="$(run_dir "$k")"
  mpath="$(model_path "$k")"

  section "Eval legacy Waxman $(k_label "$k")"
  run_cmd conda run -n virne python main.py \
    solver.shortest_method=k_shortest \
    solver.allow_rejection=false \
    solver.solver_name=alpha_zero_sfc \
    solver.k_shortest="$k" \
    solver.pretrained_model_path="$mpath" \
    training.if_use_random_training_seed=false \
    training.num_workers="$NUM_WORKERS" \
    training.inference_only=true \
    training.num_train_epochs=0 \
    training.max_training_steps=0 \
    training.enable_async_learner=false \
    training.disable_trajectory_writing=true \
    training.computation_budget="$COMPUTATION_BUDGET" \
    training.c_puct=1.4 \
    training.pure_cpp="$PURE_CPP" \
    training.use_cpp_mcts=true \
    training.use_cuda=true \
    training.use_batched_gpu="$USE_BATCHED_GPU" \
    training.distributed_training="$DISTRIBUTED_TRAINING" \
    training.alpha_zero_backbone=transformer \
    training.signal_stop_event_on_learner_complete=true \
    training.alphazero_model_path="$mpath" \
    training.resume_training=false \
    use_fixed_dataset=true \
    experiment.if_load_p_net=true \
    experiment.if_load_v_nets=true \
    experiment.num_simulations=1 \
    experiment.seed=0 \
    experiment.run_id="$rid" \
    experiment.save_root_dir="$RUNS_ROOT" \
    experiment.request_timeout_sec=0.0 \
    experiment.run_watchdog_timeout_sec=0.0 \
    experiment.record_arrival_solve_time=true \
    experiment.gpu_synchronize_timing=true \
    hydra.run.dir="$rdir/hydra" \
    simulation.p_net_dataset_dir="'$LEGACY_P_NET_DIR'" \
    simulation.v_nets_dataset_dir="'$LEGACY_V_NETS_DIR'" \
    v_sim_setting.num_v_nets="$NUM_V_NETS" \
    nn.embedding_dim="$NN_EMBED_DIM" \
    nn.hidden_dim="$NN_HIDDEN_DIM" \
    nn.num_gnn_layers="$NN_GNN_LAYERS" \
    nn.n_heads="$NN_HEADS" \
    nn.transformer_layers="$NN_TRANSFORMER_LAYERS"

  [[ "$DRY_RUN" == "1" ]] || require_file "$rdir/summary.csv"
}

generate_report() {
  section "Generate Report"
  if [[ "$DRY_RUN" == "1" ]]; then
    echo "dry-run: skipping report"
    return 0
  fi

  run_cmd conda run -n virne python -c "
import csv, pathlib, re, sys

analysis_root = pathlib.Path(sys.argv[1])
runs_root = pathlib.Path(sys.argv[2]) / 'alpha_zero_sfc'
summary_csv = pathlib.Path(sys.argv[3])
report_md = pathlib.Path(sys.argv[4])
arm = sys.argv[5]
stamp = sys.argv[6]

rows = []
pattern = re.compile(r'^' + re.escape(arm) + r'__k(?P<k>\\d+)__' + re.escape(stamp) + r'$')
for summary_path in sorted(runs_root.glob(f'{arm}__k*__{stamp}/summary.csv')):
    rid = summary_path.parent.name
    match = pattern.match(rid)
    if not match:
        continue
    with summary_path.open() as handle:
        data = list(csv.DictReader(handle))
    if not data:
        continue
    row = data[-1]
    rows.append({
        'k': int(match.group('k')),
        'acceptance_rate': row.get('acceptance_rate', ''),
        'long_term_r2c_ratio': row.get('long_term_r2c_ratio', ''),
        'route_failure_count': row.get('route_failure_count', ''),
        'place_failure_count': row.get('place_failure_count', ''),
        'clock_running_time': row.get('clock_running_time', ''),
        'run_id': rid,
    })

rows.sort(key=lambda r: r['k'])
summary_csv.parent.mkdir(parents=True, exist_ok=True)
with summary_csv.open('w', newline='') as handle:
    writer = csv.DictWriter(handle, fieldnames=['k','acceptance_rate','long_term_r2c_ratio','route_failure_count','place_failure_count','clock_running_time','run_id'])
    writer.writeheader()
    writer.writerows(rows)

with report_md.open('w') as handle:
    handle.write('# Legacy Waxman/SFC compatibility k sweep\\n\\n')
    handle.write('Each row evaluates the exported legacy model trained for the same k on the legacy Waxman/SFC dataset. Defaults mirror the saved CCWC eval configs.\\n\\n')
    handle.write('| k | acceptance | route failures | place failures | lrc | clock | run |\\n')
    handle.write('| ---: | ---: | ---: | ---: | ---: | ---: | --- |\\n')
    for row in rows:
        handle.write(f\"| {row['k']} | {row['acceptance_rate']} | {row['route_failure_count']} | {row['place_failure_count']} | {row['long_term_r2c_ratio']} | {row['clock_running_time']} | {row['run_id']} |\\n\")

print(f'wrote {summary_csv}')
print(f'wrote {report_md}')
" "$ANALYSIS_ROOT" "$RUNS_ROOT" "$SUMMARY_CSV" "$REPORT_MD" "$ARM" "$STAMP"

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
  run_eval "$k"
done

generate_report

section "Done"
echo "analysis_root: $ANALYSIS_ROOT"
echo "summary:       $SUMMARY_CSV"
echo "report:        $REPORT_MD"
