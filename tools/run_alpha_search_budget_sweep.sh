#!/usr/bin/env bash
# Eval-only AlphaVNE MCTS search-budget sweep for the journal runtime/quality
# ablation. Reuses trained k=10 checkpoints and varies only
# training.computation_budget during evaluation.
#
# Defaults:
#   topologies: brain geant
#   seeds:      0 1 2
#   budgets:    16 32 64 96
#   k_eval:     10
#
# Examples:
#   bash tools/run_alpha_search_budget_sweep.sh
#   TOPOLOGIES=geant BUDGET_VALUES="16 32" bash tools/run_alpha_search_budget_sweep.sh
#   STAMP=20260507Tbudget RESUME_COMPLETED=1 bash tools/run_alpha_search_budget_sweep.sh

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

STAMP="${STAMP:-$(date -u +%Y%m%dT%H%M%SZ)}"
TOPOLOGIES="${TOPOLOGIES:-brain geant}"
SEEDS="${SEEDS:-0 1 2}"
BUDGET_VALUES="${BUDGET_VALUES:-16 32 64 96}"
K_SHORT="${K_SHORT:-10}"
ARM="${ARM:-search_budget_sweep}"

RESULTS_ROOT="${RESULTS_ROOT:-$ROOT_DIR/results/journal_suite/results}"
SOLVER_RESULTS_ROOT="${SOLVER_RESULTS_ROOT:-$RESULTS_ROOT/alpha_zero_sfc}"
ANALYSIS_ROOT="${ANALYSIS_ROOT:-$ROOT_DIR/results/alpha_search_budget_sweep/$STAMP}"
EXTRACTED_MODELS_DIR="$ANALYSIS_ROOT/extracted_models"
RUN_LOG="$ANALYSIS_ROOT/run.log"
EVAL_SUMMARY_CSV="$ANALYSIS_ROOT/eval_summary.csv"
REPORT_MD="$ANALYSIS_ROOT/report.md"

PAPER_DIR="${PAPER_DIR:-$ROOT_DIR/paperjournal/current}"
PAPER_TABLE="$PAPER_DIR/tables/search_budget.tex"
PAPER_FIGURE="$PAPER_DIR/figures/search_budget_pgf.tex"

RESUME_COMPLETED="${RESUME_COMPLETED:-1}"
DRY_RUN="${DRY_RUN:-0}"
NUM_V_NETS="${NUM_V_NETS:-1000}"

NN_EMBED_DIM="${NN_EMBED_DIM:-96}"
NN_HIDDEN_DIM="${NN_HIDDEN_DIM:-96}"
NN_GNN_LAYERS="${NN_GNN_LAYERS:-2}"
NN_HEADS="${NN_HEADS:-6}"
NN_TRANSFORMER_LAYERS="${NN_TRANSFORMER_LAYERS:-2}"

# Match the fixed-code journal recipe. The fallback is disabled because this is
# measuring the intended strict route-aware k-shortest behavior.
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
require_dir()  { [[ -d "$1" ]] || { echo "missing dir: $1" >&2; exit 1; }; }
require_file() { [[ -f "$1" ]] || { echo "missing file: $1" >&2; exit 1; }; }

normalize_topology() {
  case "$1" in
    brain|geant) echo "$1" ;;
    *)
      echo "unsupported topology '$1'; expected brain or geant" >&2
      exit 1
      ;;
  esac
}

source_stamp() {
  case "$1" in
    brain) echo "${BRAIN_SOURCE_STAMP:-20260423T101342Z}" ;;
    geant) echo "${GEANT_SOURCE_STAMP:-20260423T225501Z}" ;;
  esac
}

source_arm() {
  case "$1" in
    brain) echo "${BRAIN_SOURCE_ARM:-brain_replay_move_fix_3k}" ;;
    geant) echo "${GEANT_SOURCE_ARM:-topo_replay_move_fix_3k}" ;;
  esac
}

dataset_dir() {
  local topology="$1" seed="$2"
  echo "$ROOT_DIR/datasets/generated/journal/nominal/${topology}/seed_${seed}/test"
}

source_model() {
  local topology="$1" seed="$2"
  echo "$SOLVER_RESULTS_ROOT/journal_suite__alpha_zero_sfc__${topology}__$(source_arm "$topology")__seed${seed}__train__ktrain10__$(source_stamp "$topology")/models/policy_latest.pt"
}

eval_run_id() {
  local topology="$1" seed="$2" budget="$3"
  echo "journal_suite__alpha_zero_sfc__${topology}__${ARM}__budget${budget}__seed${seed}__eval__keval${K_SHORT}__${STAMP}"
}

solver_run_dir() {
  local run_id="$1"
  echo "$SOLVER_RESULTS_ROOT/$run_id"
}

find_completed_eval() {
  local topology="$1" seed="$2" budget="$3"
  local pattern="$SOLVER_RESULTS_ROOT/journal_suite__alpha_zero_sfc__${topology}__${ARM}__budget${budget}__seed${seed}__eval__keval${K_SHORT}__${STAMP}"
  [[ -f "$pattern/summary.csv" ]] && basename "$pattern"
}

print_plan() {
  section "AlphaVNE Search-Budget Sweep"
  echo "stamp:          $STAMP"
  echo "topologies:     $TOPOLOGIES"
  echo "seeds:          $SEEDS"
  echo "budgets:        $BUDGET_VALUES"
  echo "k_eval:         $K_SHORT"
  echo "arm:            $ARM"
  echo "analysis_root:  $ANALYSIS_ROOT"
  echo "results_root:   $RESULTS_ROOT"
  echo "paper_table:    $PAPER_TABLE"
  echo "paper_figure:   $PAPER_FIGURE"
  echo "num_v_nets:     $NUM_V_NETS"
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
  echo "branch:         $(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo unknown)"
  echo "HEAD:           $(git rev-parse HEAD 2>/dev/null || echo unknown)"
}

preflight() {
  section "Preflight"
  run_cmd conda run -n virne python -c "from virne.solver.learning.reinforcement_learning.alpha_vne import alpha_zero_cpp_core as m; print(m.__file__)"

  local raw topology seed
  for raw in $TOPOLOGIES; do
    topology="$(normalize_topology "$raw")"
    for seed in $SEEDS; do
      require_dir "$(dataset_dir "$topology" "$seed")"
      require_file "$(source_model "$topology" "$seed")"
    done
    echo "$topology source_arm=$(source_arm "$topology") source_stamp=$(source_stamp "$topology") seeds: $SEEDS"
  done
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
  local topology="$1" seed="$2" budget="$3"
  local existing run_id run_dir test_dir model_path weights_path

  if [[ "$RESUME_COMPLETED" == "1" ]]; then
    existing="$(find_completed_eval "$topology" "$seed" "$budget" || true)"
    if [[ -n "$existing" ]]; then
      section "Eval $topology seed=$seed budget=$budget"
      echo "reusing completed eval: $existing"
      return 0
    fi
  fi

  model_path="$(source_model "$topology" "$seed")"
  weights_path="$EXTRACTED_MODELS_DIR/${topology}_seed${seed}_latest_weights.pt"
  extract_weights "$model_path" "$weights_path"

  run_id="$(eval_run_id "$topology" "$seed" "$budget")"
  run_dir="$(solver_run_dir "$run_id")"
  test_dir="$(dataset_dir "$topology" "$seed")"

  section "Eval $topology seed=$seed budget=$budget"
  run_cmd conda run -n virne python main.py \
    solver.shortest_method=k_shortest \
    solver.allow_rejection=false \
    solver.solver_name=alpha_zero_sfc \
    solver.k_shortest="$K_SHORT" \
    solver.pretrained_model_path="$weights_path" \
    training.if_use_random_training_seed=false \
    training.num_workers=1 \
    training.inference_only=true \
    training.num_train_epochs=0 \
    training.max_training_steps=0 \
    training.enable_async_learner=false \
    training.disable_trajectory_writing=true \
    training.computation_budget="$budget" \
    training.c_puct=1.4 \
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

write_summary_and_paper_artifacts() {
  [[ "$DRY_RUN" == "1" ]] && return 0

  run_cmd conda run -n virne python -c "
import csv, math, pathlib, re, statistics, sys

solver_root = pathlib.Path(sys.argv[1])
stamp = sys.argv[2]
arm = sys.argv[3]
k_short = sys.argv[4]
summary_csv = pathlib.Path(sys.argv[5])
report_md = pathlib.Path(sys.argv[6])
paper_table = pathlib.Path(sys.argv[7])
paper_figure = pathlib.Path(sys.argv[8])

pattern = re.compile(
    r'^journal_suite__alpha_zero_sfc__(?P<topology>brain|geant)__'
    + re.escape(arm)
    + r'__budget(?P<budget>\\d+)__seed(?P<seed>\\d+)__eval__keval'
    + re.escape(str(k_short))
    + r'__'
    + re.escape(stamp)
    + r'$'
)

rows = []
for summary_path in sorted(solver_root.glob(f'journal_suite__alpha_zero_sfc__*__{arm}__budget*__seed*__eval__keval{k_short}__{stamp}/summary.csv')):
    run_id = summary_path.parent.name
    match = pattern.match(run_id)
    if not match:
        continue
    with summary_path.open(newline='') as handle:
        data = list(csv.DictReader(handle))
    if not data:
        continue
    last = data[-1]
    rows.append({
        'topology': match.group('topology'),
        'budget': match.group('budget'),
        'k_eval': k_short,
        'seed': match.group('seed'),
        'acceptance_rate': last.get('acceptance_rate', ''),
        'long_term_r2c_ratio': last.get('long_term_r2c_ratio', ''),
        'clock_running_time': last.get('clock_running_time', ''),
        'success_count': last.get('success_count', ''),
        'place_failure_count': last.get('place_failure_count', ''),
        'route_failure_count': last.get('route_failure_count', ''),
        'run_id': run_id,
    })

rows.sort(key=lambda row: (row['topology'], int(row['budget']), int(row['seed'])))
summary_csv.parent.mkdir(parents=True, exist_ok=True)
with summary_csv.open('w', newline='') as handle:
    fieldnames = [
        'topology', 'budget', 'k_eval', 'seed', 'acceptance_rate',
        'long_term_r2c_ratio', 'clock_running_time', 'success_count',
        'place_failure_count', 'route_failure_count', 'run_id'
    ]
    writer = csv.DictWriter(handle, fieldnames=fieldnames)
    writer.writeheader()
    writer.writerows(rows)

grouped = {}
for row in rows:
    grouped.setdefault((row['topology'], row['budget']), []).append(row)

def mean(vals):
    return sum(vals) / len(vals) if vals else float('nan')

summary_rows = []
for key in sorted(grouped, key=lambda item: (item[0], int(item[1]))):
    group = grouped[key]
    acc = [float(row['acceptance_rate']) for row in group if row['acceptance_rate'] != '']
    lrc = [float(row['long_term_r2c_ratio']) for row in group if row['long_term_r2c_ratio'] != '']
    clock = [float(row['clock_running_time']) for row in group if row['clock_running_time'] != '']
    summary_rows.append({
        'topology': key[0],
        'budget': int(key[1]),
        'seeds': len(group),
        'acc_mean': mean(acc),
        'acc_std': statistics.pstdev(acc) if len(acc) > 1 else 0.0,
        'lrc_mean': mean(lrc),
        'clock_mean': mean(clock),
    })

lines = [
    '# AlphaVNE search-budget sweep',
    '',
    f'stamp: `{stamp}`',
    f'k_eval: `{k_short}`',
    '',
    '## Mean acceptance and runtime',
    '',
    '| topology | budget | seeds | mean acceptance | std acceptance | mean LRC | mean runtime (s) |',
    '| --- | ---: | ---: | ---: | ---: | ---: | ---: |',
]
for row in summary_rows:
    lines.append(
        f\"| {row['topology']} | {row['budget']} | {row['seeds']} | {row['acc_mean']:.3f} | {row['acc_std']:.3f} | {row['lrc_mean']:.3f} | {row['clock_mean']:.1f} |\"
    )
lines.extend(['', '## Per-seed results', '', '| topology | budget | seed | acceptance | LRC | runtime (s) | run |', '| --- | ---: | ---: | ---: | ---: | ---: | --- |'])
for row in rows:
    lines.append(
        f\"| {row['topology']} | {row['budget']} | {row['seed']} | {float(row['acceptance_rate']):.3f} | {float(row['long_term_r2c_ratio']):.3f} | {float(row['clock_running_time']):.1f} | `{row['run_id']}` |\"
    )
report_md.write_text('\\n'.join(lines) + '\\n')

paper_table.parent.mkdir(parents=True, exist_ok=True)
table_lines = [
    r'\\begin{table}[t]',
    r'\\centering',
    r'\\small',
    r'\\caption{\\alphavne{} search-budget sensitivity at evaluation \(k=10\). Values are means over seeds 0--2. Runtime is wall-clock evaluation time in seconds.}',
    r'\\label{tab:search_budget}',
    r'\\begin{tabular}{lrrrr}',
    r'\\toprule',
    r'Topology & MCTS sims & Acceptance & R/C & Runtime (s) \\\\',
    r'\\midrule',
]
last_topology = None
for row in summary_rows:
    if last_topology is not None and row['topology'] != last_topology:
        table_lines.append(r'\\midrule')
    table_lines.append(
        f\"{row['topology'].capitalize()} & {row['budget']} & {row['acc_mean']:.3f} & {row['lrc_mean']:.3f} & {row['clock_mean']:.1f} \\\\\"
    )
    last_topology = row['topology']
table_lines.extend([r'\\bottomrule', r'\\end{tabular}', r'\\end{table}', ''])
paper_table.write_text('\\n'.join(table_lines))

paper_figure.parent.mkdir(parents=True, exist_ok=True)
colors = {'brain': 'blue!70!black', 'geant': 'orange!85!black'}
marks = {'brain': '*', 'geant': 'square*'}
figure_lines = [
    r'\\begin{figure}[t]',
    r'\\centering',
    r'\\begin{tikzpicture}',
    r'\\begin{axis}[',
    r'    width=\\linewidth,',
    r'    height=0.62\\linewidth,',
    r'    xlabel={MCTS simulations per decision},',
    r'    ylabel={Acceptance rate (\\%)},',
    r'    xtick={16,32,64,96},',
    r'    ymajorgrids=true,',
    r'    grid style={gray!20},',
    r'    tick label style={font=\\footnotesize},',
    r'    label style={font=\\footnotesize},',
    r'    legend style={at={(0.02,0.98)},anchor=north west,draw=none,fill=none,font=\\scriptsize},',
    r']',
]
legend = []
for topology in sorted({row['topology'] for row in summary_rows}):
    coords = [
        f\"({row['budget']},{100.0 * row['acc_mean']:.2f})\"
        for row in summary_rows
        if row['topology'] == topology
    ]
    figure_lines.append(
        f\"\\\\addplot+[mark={marks.get(topology, '*')}, thick, {colors.get(topology, 'black')}] coordinates {{\"
    )
    figure_lines.append('    ' + ' '.join(coords))
    figure_lines.append('};')
    legend.append(topology.capitalize())
figure_lines.append(r'\\legend{' + ','.join(legend) + '}')
figure_lines.extend([
    r'\\end{axis}',
    r'\\end{tikzpicture}',
    r'\\caption{Effect of MCTS search budget on \\alphavne{} acceptance at evaluation \(k=10\).}',
    r'\\label{fig:search_budget}',
    r'\\end{figure}',
    '',
])
paper_figure.write_text('\\n'.join(figure_lines))

print(f'wrote {summary_csv}')
print(f'wrote {report_md}')
print(f'wrote {paper_table}')
print(f'wrote {paper_figure}')
" "$SOLVER_RESULTS_ROOT" "$STAMP" "$ARM" "$K_SHORT" "$EVAL_SUMMARY_CSV" "$REPORT_MD" "$PAPER_TABLE" "$PAPER_FIGURE"
}

main() {
  print_plan
  preflight

  if [[ "$DRY_RUN" == "1" ]]; then
    echo
    echo "dry-run only. preflight passed; no eval commands executed."
    return 0
  fi

  local raw topology seed budget
  for budget in $BUDGET_VALUES; do
    for raw in $TOPOLOGIES; do
      topology="$(normalize_topology "$raw")"
      for seed in $SEEDS; do
        run_eval "$topology" "$seed" "$budget"
      done
    done
  done

  write_summary_and_paper_artifacts

  section "Done"
  echo "analysis_root: $ANALYSIS_ROOT"
  echo "summary:       $EVAL_SUMMARY_CSV"
  echo "report:        $REPORT_MD"
  echo "paper_table:   $PAPER_TABLE"
  echo "paper_figure:  $PAPER_FIGURE"
}

main "$@"
