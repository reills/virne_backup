#!/usr/bin/env bash
# Train/eval neural-guide ablation for the journal paper.
#
# Purpose:
#   Compare the current feasibility-aware MCTS machinery with a simpler neural
#   guide under the same search, masks, candidate features, k, seeds, and
#   datasets. The default run trains/evaluates the new MLP-style policy-value
#   guide on Brain/Geant seeds 0..2.
#
# Examples:
#   bash tools/run_alpha_neural_guide_ablation.sh
#   BACKBONES=mlp TOPOLOGIES=geant SEEDS="0 1 2" bash tools/run_alpha_neural_guide_ablation.sh
#   STAGES="train eval" TRAIN_MAX_STEPS=3000 bash tools/run_alpha_neural_guide_ablation.sh

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

STAMP="${STAMP:-$(date -u +%Y%m%dT%H%M%SZ)}"
TOPOLOGIES="${TOPOLOGIES:-brain geant}"
SEEDS="${SEEDS:-0 1 2}"
BACKBONES="${BACKBONES:-mlp}"
STAGES="${STAGES:-train eval}"
ARM="${ARM:-neural_guide_ablation}"

RESULTS_ROOT="${RESULTS_ROOT:-$ROOT_DIR/results/journal_suite/results}"
SOLVER_RESULTS_ROOT="${SOLVER_RESULTS_ROOT:-$RESULTS_ROOT/alpha_zero_sfc}"
ANALYSIS_ROOT="${ANALYSIS_ROOT:-$ROOT_DIR/results/alpha_neural_guide_ablation/$STAMP}"
EXTRACTED_MODELS_DIR="$ANALYSIS_ROOT/extracted_models"
RUN_LOG="$ANALYSIS_ROOT/run.log"
EVAL_SUMMARY_CSV="$ANALYSIS_ROOT/eval_summary.csv"
REPORT_MD="$ANALYSIS_ROOT/report.md"

PAPER_DIR="${PAPER_DIR:-$ROOT_DIR/paperjournal/current}"
PAPER_TABLE="$PAPER_DIR/tables/neural_guide_ablation.tex"

RESUME_COMPLETED="${RESUME_COMPLETED:-1}"
DRY_RUN="${DRY_RUN:-0}"
NUM_V_NETS="${NUM_V_NETS:-1000}"
K_SHORT="${K_SHORT:-10}"
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

normalize_backbone() {
  case "$1" in
    mlp|gcn|transformer) echo "$1" ;;
    *)
      echo "unsupported backbone '$1'; expected mlp, gcn, or transformer" >&2
      exit 1
      ;;
  esac
}

dataset_dir() {
  local topology="$1" seed="$2" split="$3"
  echo "$ROOT_DIR/datasets/generated/journal/nominal/${topology}/seed_${seed}/${split}"
}

arm_for_backbone() {
  local backbone="$1"
  echo "${ARM}_${backbone}"
}

train_run_id() {
  local topology="$1" seed="$2" backbone="$3"
  echo "journal_suite__alpha_zero_sfc__${topology}__$(arm_for_backbone "$backbone")__seed${seed}__train__ktrain${K_SHORT}__${STAMP}"
}

eval_run_id() {
  local topology="$1" seed="$2" backbone="$3"
  echo "journal_suite__alpha_zero_sfc__${topology}__$(arm_for_backbone "$backbone")__seed${seed}__eval__keval${K_SHORT}__${STAMP}"
}

solver_run_dir() {
  local run_id="$1"
  echo "$SOLVER_RESULTS_ROOT/$run_id"
}

find_completed_train() {
  local topology="$1" seed="$2" backbone="$3" run_id dir
  run_id="$(train_run_id "$topology" "$seed" "$backbone")"
  dir="$(solver_run_dir "$run_id")"
  [[ -f "$dir/models/policy_latest.pt" && -f "$dir/summary.csv" ]] && echo "$run_id"
}

find_completed_eval() {
  local topology="$1" seed="$2" backbone="$3" run_id dir
  run_id="$(eval_run_id "$topology" "$seed" "$backbone")"
  dir="$(solver_run_dir "$run_id")"
  [[ -f "$dir/summary.csv" ]] && echo "$run_id"
}

print_plan() {
  section "AlphaVNE Neural-Guide Ablation"
  echo "stamp:          $STAMP"
  echo "topologies:     $TOPOLOGIES"
  echo "seeds:          $SEEDS"
  echo "backbones:      $BACKBONES"
  echo "stages:         $STAGES"
  echo "arm:            $ARM"
  echo "analysis_root:  $ANALYSIS_ROOT"
  echo "results_root:   $RESULTS_ROOT"
  echo "paper_table:    $PAPER_TABLE"
  echo "k_eval/train:   $K_SHORT"
  echo "budget:         $COMPUTATION_BUDGET"
  echo "train_steps:    $TRAIN_MAX_STEPS"
  echo
  echo "env flags:"
  echo "  AZSFC_CPP_AVAILABLE_SHORTEST_FALLBACK=$AZSFC_CPP_AVAILABLE_SHORTEST_FALLBACK"
  echo "  AZSFC_CPP_PERSISTENT_TREE=$AZSFC_CPP_PERSISTENT_TREE"
  echo "  AZSFC_CPP_USE_CANDIDATE_FEATURES=$AZSFC_CPP_USE_CANDIDATE_FEATURES"
  echo
  echo "branch:         $(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo unknown)"
  echo "HEAD:           $(git rev-parse HEAD 2>/dev/null || echo unknown)"
}

preflight() {
  section "Preflight"
  run_cmd conda run -n virne python -c "from virne.solver.learning.reinforcement_learning.alpha_vne import alpha_zero_cpp_core as m; print(m.__file__)"
  run_cmd conda run -n virne python -c "from virne.solver.learning.reinforcement_learning.alpha_vne.model_factory import normalize_model_name; print([normalize_model_name(x) for x in '$BACKBONES'.split()])"

  local raw topology seed split
  for raw in $TOPOLOGIES; do
    topology="$(normalize_topology "$raw")"
    for seed in $SEEDS; do
      for split in train test; do
        require_dir "$(dataset_dir "$topology" "$seed" "$split")"
      done
    done
    echo "$topology train/test seeds: $SEEDS"
  done
}

run_train() {
  local topology="$1" seed="$2" backbone="$3"
  local existing run_id run_dir train_dir
  if [[ "$RESUME_COMPLETED" == "1" ]]; then
    existing="$(find_completed_train "$topology" "$seed" "$backbone" || true)"
    if [[ -n "$existing" ]]; then
      section "Train $topology seed=$seed backbone=$backbone"
      echo "reusing completed train: $existing"
      return 0
    fi
  fi

  run_id="$(train_run_id "$topology" "$seed" "$backbone")"
  run_dir="$(solver_run_dir "$run_id")"
  train_dir="$(dataset_dir "$topology" "$seed" train)"

  section "Train $topology seed=$seed backbone=$backbone"
  run_cmd conda run -n virne python main.py \
    solver.shortest_method=k_shortest \
    solver.allow_rejection=false \
    solver.solver_name=alpha_zero_sfc \
    solver.k_shortest="$K_SHORT" \
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
    training.alpha_zero_backbone="$backbone" \
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
  local topology="$1" seed="$2" backbone="$3"
  local existing train_id model_path weights_path run_id run_dir test_dir
  if [[ "$RESUME_COMPLETED" == "1" ]]; then
    existing="$(find_completed_eval "$topology" "$seed" "$backbone" || true)"
    if [[ -n "$existing" ]]; then
      section "Eval $topology seed=$seed backbone=$backbone"
      echo "reusing completed eval: $existing"
      return 0
    fi
  fi

  train_id="$(train_run_id "$topology" "$seed" "$backbone")"
  model_path="$(solver_run_dir "$train_id")/models/policy_latest.pt"
  require_file "$model_path"
  weights_path="$EXTRACTED_MODELS_DIR/${topology}_${backbone}_seed${seed}_latest_weights.pt"
  extract_weights "$model_path" "$weights_path"

  run_id="$(eval_run_id "$topology" "$seed" "$backbone")"
  run_dir="$(solver_run_dir "$run_id")"
  test_dir="$(dataset_dir "$topology" "$seed" test)"

  section "Eval $topology seed=$seed backbone=$backbone"
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
    training.computation_budget="$COMPUTATION_BUDGET" \
    training.c_puct=1.4 \
    training.pure_cpp=true \
    training.use_cpp_mcts=true \
    training.use_cuda=true \
    training.use_batched_gpu=false \
    training.distributed_training=false \
    training.alpha_zero_backbone="$backbone" \
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

write_summary_and_table() {
  [[ "$DRY_RUN" == "1" ]] && return 0

  run_cmd conda run -n virne python -c "
import csv, pathlib, re, statistics, sys

solver_root = pathlib.Path(sys.argv[1])
stamp = sys.argv[2]
arm = sys.argv[3]
k_short = sys.argv[4]
summary_csv = pathlib.Path(sys.argv[5])
report_md = pathlib.Path(sys.argv[6])
paper_table = pathlib.Path(sys.argv[7])

pattern = re.compile(
    r'^journal_suite__alpha_zero_sfc__(?P<topology>brain|geant)__'
    + re.escape(arm)
    + r'_(?P<backbone>mlp|gcn|transformer)__seed(?P<seed>\\d+)__eval__keval'
    + re.escape(str(k_short))
    + r'__'
    + re.escape(stamp)
    + r'$'
)

rows = []
for summary_path in sorted(solver_root.glob(f'journal_suite__alpha_zero_sfc__*__{arm}_*__seed*__eval__keval{k_short}__{stamp}/summary.csv')):
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
        'backbone': match.group('backbone'),
        'k_eval': k_short,
        'seed': match.group('seed'),
        'acceptance_rate': last.get('acceptance_rate', ''),
        'long_term_r2c_ratio': last.get('long_term_r2c_ratio', ''),
        'clock_running_time': last.get('clock_running_time', ''),
        'run_id': run_id,
    })

rows.sort(key=lambda row: (row['topology'], row['backbone'], int(row['seed'])))
summary_csv.parent.mkdir(parents=True, exist_ok=True)
with summary_csv.open('w', newline='') as handle:
    fieldnames = ['topology', 'backbone', 'k_eval', 'seed', 'acceptance_rate', 'long_term_r2c_ratio', 'clock_running_time', 'run_id']
    writer = csv.DictWriter(handle, fieldnames=fieldnames)
    writer.writeheader()
    writer.writerows(rows)

grouped = {}
for row in rows:
    grouped.setdefault((row['topology'], row['backbone']), []).append(row)

summary_rows = []
for key in sorted(grouped):
    group = grouped[key]
    acc = [float(row['acceptance_rate']) for row in group if row['acceptance_rate'] != '']
    lrc = [float(row['long_term_r2c_ratio']) for row in group if row['long_term_r2c_ratio'] != '']
    clock = [float(row['clock_running_time']) for row in group if row['clock_running_time'] != '']
    summary_rows.append({
        'topology': key[0],
        'backbone': key[1],
        'seeds': len(group),
        'acc_mean': sum(acc) / len(acc) if acc else float('nan'),
        'acc_std': statistics.pstdev(acc) if len(acc) > 1 else 0.0,
        'lrc_mean': sum(lrc) / len(lrc) if lrc else float('nan'),
        'clock_mean': sum(clock) / len(clock) if clock else float('nan'),
    })

lines = [
    '# AlphaVNE neural-guide ablation',
    '',
    f'stamp: `{stamp}`',
    f'k_eval: `{k_short}`',
    '',
    '| topology | guide | seeds | mean acceptance | std acceptance | mean LRC | mean runtime (s) |',
    '| --- | --- | ---: | ---: | ---: | ---: | ---: |',
]
for row in summary_rows:
    lines.append(f\"| {row['topology']} | {row['backbone']} | {row['seeds']} | {row['acc_mean']:.3f} | {row['acc_std']:.3f} | {row['lrc_mean']:.3f} | {row['clock_mean']:.1f} |\")
report_md.write_text('\\n'.join(lines) + '\\n')

paper_table.parent.mkdir(parents=True, exist_ok=True)
table_lines = [
    r'\\begin{table}[t]',
    r'\\centering',
    r'\\small',
    r'\\caption{Neural-guide ablation under the same feasibility-aware C++ MCTS, \(k=10\), and \(96\) simulations per decision.}',
    r'\\label{tab:neural_guide_ablation}',
    r'\\begin{tabular}{llrrrr}',
    r'\\toprule',
    r'Topology & Guide & Seeds & Acceptance & R/C & Runtime (s) \\\\',
    r'\\midrule',
]
last_topology = None
for row in summary_rows:
    if last_topology is not None and row['topology'] != last_topology:
        table_lines.append(r'\\midrule')
    table_lines.append(f\"{row['topology'].capitalize()} & {row['backbone'].upper()} & {row['seeds']} & {row['acc_mean']:.3f} & {row['lrc_mean']:.3f} & {row['clock_mean']:.1f} \\\\\")
    last_topology = row['topology']
table_lines.extend([r'\\bottomrule', r'\\end{tabular}', r'\\end{table}', ''])
paper_table.write_text('\\n'.join(table_lines))

print(f'wrote {summary_csv}')
print(f'wrote {report_md}')
print(f'wrote {paper_table}')
" "$SOLVER_RESULTS_ROOT" "$STAMP" "$ARM" "$K_SHORT" "$EVAL_SUMMARY_CSV" "$REPORT_MD" "$PAPER_TABLE"
}

stage_enabled() {
  [[ " $STAGES " == *" $1 "* ]]
}

main() {
  print_plan
  preflight

  if [[ "$DRY_RUN" == "1" ]]; then
    echo
    echo "dry-run only. preflight passed; no train/eval commands executed."
    return 0
  fi

  local raw_topology topology raw_backbone backbone seed
  for raw_backbone in $BACKBONES; do
    backbone="$(normalize_backbone "$raw_backbone")"
    for raw_topology in $TOPOLOGIES; do
      topology="$(normalize_topology "$raw_topology")"
      for seed in $SEEDS; do
        if stage_enabled train; then
          run_train "$topology" "$seed" "$backbone"
        fi
        if stage_enabled eval; then
          run_eval "$topology" "$seed" "$backbone"
        fi
      done
    done
  done

  if stage_enabled eval; then
    write_summary_and_table
  fi

  section "Done"
  echo "analysis_root: $ANALYSIS_ROOT"
  echo "summary:       $EVAL_SUMMARY_CSV"
  echo "report:        $REPORT_MD"
  echo "paper_table:   $PAPER_TABLE"
}

main "$@"
