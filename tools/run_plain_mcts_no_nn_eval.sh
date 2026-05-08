#!/usr/bin/env bash
# Eval-only ablation for the current pure C++ feasibility-aware MCTS solver with
# neural guidance disabled. This is the clean "how much does the NN add?"
# comparison against the existing AlphaVNE journal results.
#
# Defaults run all nominal journal topologies and all available seeds:
#   brain seeds 0..4, geant seeds 0..4, wx100 seeds 0..2
#
# Examples:
#   bash tools/run_plain_mcts_no_nn_eval.sh
#   TOPOLOGIES=geant bash tools/run_plain_mcts_no_nn_eval.sh
#   TOPOLOGIES="brain geant wx100" SEEDS="0 1 2" bash tools/run_plain_mcts_no_nn_eval.sh
#   K_SHORT=10 COMPUTATION_BUDGET=96 bash tools/run_plain_mcts_no_nn_eval.sh
#   K_VALUES="1 3 5 7 9 11" PARALLEL_JOBS=4 bash tools/run_plain_mcts_no_nn_eval.sh

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

STAMP="${STAMP:-$(date -u +%Y%m%dT%H%M%SZ)}"
TOPOLOGIES="${TOPOLOGIES:-brain geant wx100}"
SEEDS="${SEEDS:-auto}"
ARM="${ARM:-plain_mcts_no_nn}"

RESULTS_ROOT="${RESULTS_ROOT:-$ROOT_DIR/results/journal_suite/results}"
SOLVER_RESULTS_ROOT="${SOLVER_RESULTS_ROOT:-$RESULTS_ROOT/alpha_zero_sfc}"
ANALYSIS_ROOT="${ANALYSIS_ROOT:-$ROOT_DIR/results/plain_mcts_no_nn_eval/$STAMP}"
RUN_LOG="$ANALYSIS_ROOT/run.log"
EVAL_SUMMARY_CSV="$ANALYSIS_ROOT/eval_summary.csv"
REPORT_MD="$ANALYSIS_ROOT/report.md"

RESUME_COMPLETED="${RESUME_COMPLETED:-1}"
DRY_RUN="${DRY_RUN:-0}"
NUM_V_NETS="${NUM_V_NETS:-1000}"
K_SHORT="${K_SHORT:-10}"
K_VALUES="${K_VALUES:-$K_SHORT}"
COMPUTATION_BUDGET="${COMPUTATION_BUDGET:-96}"
ROLLOUT_DEPTH_LIMIT="${ROLLOUT_DEPTH_LIMIT:-100}"
PARALLEL_JOBS="${PARALLEL_JOBS:-1}"

NN_EMBED_DIM="${NN_EMBED_DIM:-96}"
NN_HIDDEN_DIM="${NN_HIDDEN_DIM:-96}"
NN_GNN_LAYERS="${NN_GNN_LAYERS:-2}"
NN_HEADS="${NN_HEADS:-6}"
NN_TRANSFORMER_LAYERS="${NN_TRANSFORMER_LAYERS:-2}"

# Match the fixed-code journal recipe while disabling neural guidance.
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

mkdir -p "$ANALYSIS_ROOT"

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

normalize_topology() {
  case "$1" in
    brain|geant|wx100) echo "$1" ;;
    waxman|wx) echo "wx100" ;;
    *)
      echo "unsupported topology '$1'; expected brain, geant, wx100, or waxman" >&2
      exit 1
      ;;
  esac
}

dataset_dir() {
  local topology="$1" seed="$2"
  echo "$ROOT_DIR/datasets/generated/journal/nominal/${topology}/seed_${seed}/test"
}

discover_seeds() {
  local topology="$1"
  if [[ "$SEEDS" != "auto" ]]; then
    echo "$SEEDS"
    return 0
  fi

  local base="$ROOT_DIR/datasets/generated/journal/nominal/${topology}"
  local seeds=()
  local dir name
  shopt -s nullglob
  for dir in "$base"/seed_*; do
    [[ -d "$dir/test" ]] || continue
    name="$(basename "$dir")"
    seeds+=("${name#seed_}")
  done
  shopt -u nullglob
  if [[ "${#seeds[@]}" -eq 0 ]]; then
    echo "no test seeds found for topology $topology under $base" >&2
    exit 1
  fi
  printf '%s\n' "${seeds[@]}" | sort -n | xargs
}

eval_run_id() {
  local topology="$1" seed="$2" k_short="$3"
  echo "journal_suite__alpha_zero_sfc__${topology}__${ARM}__seed${seed}__eval__keval${k_short}__${STAMP}"
}

solver_run_dir() {
  local run_id="$1"
  echo "$SOLVER_RESULTS_ROOT/$run_id"
}

find_completed_eval() {
  local topology="$1" seed="$2" k_short="$3"
  local pattern="$SOLVER_RESULTS_ROOT/journal_suite__alpha_zero_sfc__${topology}__${ARM}__seed${seed}__eval__keval${k_short}__*"
  local best="" best_ts=-1 dir ts
  shopt -s nullglob
  for dir in $pattern; do
    [[ -d "$dir" && -f "$dir/summary.csv" ]] || continue
    ts="$(stat -c %Y "$dir/summary.csv" 2>/dev/null || echo 0)"
    (( ts > best_ts )) && { best="$dir"; best_ts="$ts"; }
  done
  shopt -u nullglob
  [[ -n "$best" ]] && basename "$best"
}

print_plan() {
  section "Pure C++ Plain MCTS / No NN Eval"
  echo "stamp:          $STAMP"
  echo "topologies:     $TOPOLOGIES"
  echo "seeds:          $SEEDS"
  echo "arm:            $ARM"
  echo "analysis_root:  $ANALYSIS_ROOT"
  echo "results_root:   $RESULTS_ROOT"
  echo "num_v_nets:     $NUM_V_NETS"
  echo "k_values:       $K_VALUES"
  echo "budget:         $COMPUTATION_BUDGET"
  echo "rollout_depth:  $ROLLOUT_DEPTH_LIMIT"
  echo "parallel_jobs:  $PARALLEL_JOBS"
  echo
  echo "neural flags:"
  echo "  training.use_neural_network=false"
  echo "  training.use_nn_policy=false"
  echo "  training.use_nn_value=false"
  echo
  echo "env flags:"
  echo "  AZSFC_CPP_AVAILABLE_SHORTEST_FALLBACK=$AZSFC_CPP_AVAILABLE_SHORTEST_FALLBACK"
  echo "  AZSFC_CPP_MIX_STEP_SEED=$AZSFC_CPP_MIX_STEP_SEED"
  echo "  AZSFC_CPP_PERSISTENT_TREE=$AZSFC_CPP_PERSISTENT_TREE"
  echo "  AZSFC_CPP_USE_CANDIDATE_FEATURES=$AZSFC_CPP_USE_CANDIDATE_FEATURES"
  echo
  echo "branch:         $(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo unknown)"
  echo "HEAD:           $(git rev-parse HEAD 2>/dev/null || echo unknown)"
}

preflight() {
  section "Preflight"
  run_cmd conda run -n virne python -c "from virne.solver.learning.reinforcement_learning.alpha_vne import alpha_zero_cpp_core as m; print(m.__file__)"

  local raw topology seed seeds
  for raw in $TOPOLOGIES; do
    topology="$(normalize_topology "$raw")"
    seeds="$(discover_seeds "$topology")"
    for seed in $seeds; do
      require_dir "$(dataset_dir "$topology" "$seed")"
    done
    echo "$topology seeds: $seeds"
  done
}

run_eval() {
  local topology="$1" seed="$2" k_short="$3"
  local existing run_id run_dir test_dir

  if [[ "$RESUME_COMPLETED" == "1" ]]; then
    existing="$(find_completed_eval "$topology" "$seed" "$k_short" || true)"
    if [[ -n "$existing" ]]; then
      section "Eval $topology seed=$seed k=$k_short"
      echo "reusing completed eval: $existing"
      return 0
    fi
  fi

  run_id="$(eval_run_id "$topology" "$seed" "$k_short")"
  run_dir="$(solver_run_dir "$run_id")"
  test_dir="$(dataset_dir "$topology" "$seed")"

  section "Eval $topology seed=$seed k=$k_short"
  run_cmd conda run -n virne python main.py \
    solver.shortest_method=k_shortest \
    solver.allow_rejection=false \
    solver.solver_name=alpha_zero_sfc \
    solver.k_shortest="$k_short" \
    solver.pretrained_model_path= \
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
    training.use_neural_network=false \
    training.use_nn_policy=false \
    training.use_nn_value=false \
    +training.rollout_depth_limit="$ROLLOUT_DEPTH_LIMIT" \
    training.use_cuda=false \
    training.use_batched_gpu=false \
    training.distributed_training=false \
    training.alpha_zero_backbone=transformer \
    training.signal_stop_event_on_learner_complete=true \
    training.alphazero_model_path= \
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
    experiment.gpu_synchronize_timing=false \
    hydra.run.dir="$run_dir/hydra" \
    simulation.p_net_dataset_dir="$test_dir" \
    simulation.v_nets_dataset_dir="$test_dir" \
    v_sim_setting.num_v_nets="$NUM_V_NETS" \
    nn.embedding_dim="$NN_EMBED_DIM" \
    nn.hidden_dim="$NN_HIDDEN_DIM" \
    nn.num_gnn_layers="$NN_GNN_LAYERS" \
    nn.n_heads="$NN_HEADS" \
    nn.transformer_layers="$NN_TRANSFORMER_LAYERS"
}

write_summary() {
  [[ "$DRY_RUN" == "1" ]] && return 0
  local summary_code
  summary_code="$(cat <<'PY'
import csv
import pathlib
import sys

solver_root = pathlib.Path(sys.argv[1])
analysis_root = pathlib.Path(sys.argv[2])
summary_csv = pathlib.Path(sys.argv[3])
report_md = pathlib.Path(sys.argv[4])
arm = sys.argv[5]
stamp = sys.argv[6]

rows = []
for path in sorted(solver_root.glob(f"journal_suite__alpha_zero_sfc__*__{arm}__seed*__eval__keval*__{stamp}/summary.csv")):
    run = path.parent.name
    parts = run.split("__")
    topology = parts[2] if len(parts) > 2 else ""
    seed = ""
    k_eval = ""
    for part in parts:
        if part.startswith("seed"):
            seed = part.replace("seed", "", 1)
        elif part.startswith("keval"):
            k_eval = part.replace("keval", "", 1)
    with path.open(newline="") as f:
        data = next(csv.DictReader(f))
    rows.append({
        "topology": topology,
        "k_eval": k_eval,
        "seed": seed,
        "acceptance_rate": data.get("acceptance_rate", ""),
        "success_count": data.get("success_count", ""),
        "place_failure_count": data.get("place_failure_count", ""),
        "route_failure_count": data.get("route_failure_count", ""),
        "clock_running_time": data.get("clock_running_time", ""),
        "run_id": run,
    })

analysis_root.mkdir(parents=True, exist_ok=True)
with summary_csv.open("w", newline="") as f:
    fieldnames = ["topology", "k_eval", "seed", "acceptance_rate", "success_count", "place_failure_count", "route_failure_count", "clock_running_time", "run_id"]
    writer = csv.DictWriter(f, fieldnames=fieldnames)
    writer.writeheader()
    writer.writerows(rows)

grouped = {}
for row in rows:
    grouped.setdefault((row["topology"], row["k_eval"]), []).append(row)

lines = [
    "# Pure C++ Plain MCTS / No NN Eval",
    "",
    f"stamp: `{stamp}`",
    "",
    "## Mean acceptance and runtime",
    "",
    "| topology | k | seeds | mean acceptance | mean clock (s) |",
    "| --- | ---: | ---: | ---: | ---: |",
]
for topology, k_eval in sorted(grouped, key=lambda key: (key[0], int(key[1] or 0))):
    group_rows = grouped[(topology, k_eval)]
    acc_vals = [float(row["acceptance_rate"]) for row in group_rows]
    clock_vals = [float(row["clock_running_time"]) for row in group_rows if row["clock_running_time"] != ""]
    mean_clock = sum(clock_vals) / len(clock_vals) if clock_vals else 0.0
    lines.append(f"| {topology} | {k_eval} | {len(group_rows)} | {sum(acc_vals) / len(acc_vals):.3f} | {mean_clock:.1f} |")

lines.extend(["", "## Per-seed results", "", "| topology | k | seed | acceptance | success | place failures | route failures | run |", "| --- | ---: | ---: | ---: | ---: | ---: | ---: | --- |"])
for row in rows:
    lines.append(
        f"| {row['topology']} | {row['k_eval']} | {row['seed']} | {float(row['acceptance_rate']):.3f} | "
        f"{row['success_count']} | {row['place_failure_count']} | {row['route_failure_count']} | `{row['run_id']}` |"
    )
report_md.write_text("\n".join(lines) + "\n")
print(f"wrote {summary_csv}")
print(f"wrote {report_md}")
PY
)"
  printf '+ conda run -n virne python - %q %q %q %q %q %q\n' \
    "$SOLVER_RESULTS_ROOT" "$ANALYSIS_ROOT" "$EVAL_SUMMARY_CSV" "$REPORT_MD" "$ARM" "$STAMP" >&2
  conda run -n virne python -c "$summary_code" "$SOLVER_RESULTS_ROOT" "$ANALYSIS_ROOT" "$EVAL_SUMMARY_CSV" "$REPORT_MD" "$ARM" "$STAMP"
}

main() {
  print_plan
  preflight

  local raw topology seed seeds k active_jobs
  for k in $K_VALUES; do
    for raw in $TOPOLOGIES; do
      topology="$(normalize_topology "$raw")"
      seeds="$(discover_seeds "$topology")"
      for seed in $seeds; do
        if (( PARALLEL_JOBS > 1 )); then
          run_eval "$topology" "$seed" "$k" &
          while true; do
            active_jobs="$(jobs -pr | wc -l)"
            (( active_jobs < PARALLEL_JOBS )) && break
            wait -n
          done
        else
          run_eval "$topology" "$seed" "$k"
        fi
      done
    done
  done
  if (( PARALLEL_JOBS > 1 )); then
    wait
  fi

  write_summary
  section "Done"
  echo "analysis_root: $ANALYSIS_ROOT"
  echo "summary:       $EVAL_SUMMARY_CSV"
  echo "report:        $REPORT_MD"
}

main "$@"
