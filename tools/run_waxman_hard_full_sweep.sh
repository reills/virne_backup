#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

STAMP="${STAMP:-$(date -u +%Y%m%dT%H%M%SZ)}"
TOPOLOGY_KEY="${TOPOLOGY_KEY:-wx100}"
HARD_SCENARIO_KEY="${HARD_SCENARIO_KEY:-${TOPOLOGY_KEY}_hard_compare}"
METHODS="${METHODS:-alpha_zero_sfc grc_rank mcts ppo_dual_gcn_plus ppo_mlp_plus pso_meta}"
SEEDS="${SEEDS:-0 1 2}"
K_EVAL="${K_EVAL:-10}"
COMPUTATION_BUDGET="${COMPUTATION_BUDGET:-96}"
PARALLELISM="${PARALLELISM:-1}"

WX_HARD_NUM_VNETS="${WX_HARD_NUM_VNETS:-1000}"
WX_HARD_VNET_SIZE_LOW="${WX_HARD_VNET_SIZE_LOW:-3}"
WX_HARD_VNET_SIZE_HIGH="${WX_HARD_VNET_SIZE_HIGH:-12}"
WX_HARD_ARRIVAL_LAM="${WX_HARD_ARRIVAL_LAM:-0.06}"
WX_HARD_NODE_DEMAND_HIGH="${WX_HARD_NODE_DEMAND_HIGH:-26}"
WX_HARD_LINK_DEMAND_HIGH="${WX_HARD_LINK_DEMAND_HIGH:-65}"

TRAIN_MISSING="${TRAIN_MISSING:-0}"
FORCE_GENERATE_DATASETS="${FORCE_GENERATE_DATASETS:-0}"
RERUN_COMPLETED="${RERUN_COMPLETED:-0}"
DRY_RUN="${DRY_RUN:-0}"

ANALYSIS_ROOT="${ANALYSIS_ROOT:-results/waxman_hard_full_sweep/${STAMP}}"
CONFIG_ROOT="${CONFIG_ROOT:-${ANALYSIS_ROOT}/configs}"
RESULTS_ROOT="${RESULTS_ROOT:-results/journal_suite/results}"
PAPER_TABLE="${PAPER_TABLE:-paperjournal/current/tables/waxman_hard_comparison.tex}"

export AZSFC_CPP_AVAILABLE_SHORTEST_FALLBACK="${AZSFC_CPP_AVAILABLE_SHORTEST_FALLBACK:-0}"
export AZSFC_CPP_MIX_STEP_SEED="${AZSFC_CPP_MIX_STEP_SEED:-0}"
export AZSFC_CPP_PERSISTENT_TREE="${AZSFC_CPP_PERSISTENT_TREE:-1}"
export AZSFC_CPP_USE_CANDIDATE_FEATURES="${AZSFC_CPP_USE_CANDIDATE_FEATURES:-1}"

seeds_csv=""
for seed in $SEEDS; do
  if [[ -n "$seeds_csv" ]]; then
    seeds_csv+=","
  fi
  seeds_csv+="$seed"
done

run_cmd() {
  echo "+ $*"
  if [[ "$DRY_RUN" == "1" ]]; then
    return 0
  fi
  "$@"
}

method_slug() {
  local method="$1"
  method="${method//+/_plus}"
  method="${method//-/_}"
  echo "$method"
}

is_trainable_method() {
  case "$1" in
    alpha_zero_sfc|ppo_dual_gcn_plus|ppo_mlp_plus) return 0 ;;
    *) return 1 ;;
  esac
}

missing_train_seeds() {
  local method="$1"
  if ! is_trainable_method "$method"; then
    echo ""
    return 0
  fi
  conda run -n virne python -c "
import csv
import sys
from pathlib import Path

method, topology, k_eval, seeds_raw = sys.argv[1:5]
wanted = [int(part) for part in seeds_raw.split(',') if part]
registry = Path('results/journal_suite/model_registry.csv')
present = set()
if registry.exists():
    with registry.open(newline='') as f:
        for row in csv.DictReader(f):
            if row.get('method') != method:
                continue
            if row.get('topology') != topology:
                continue
            if row.get('scenario') != 'nominal':
                continue
            if row.get('k_train') != str(k_eval):
                continue
            model_path = Path(row.get('model_path', ''))
            if model_path.is_file() and model_path.stat().st_size > 0:
                present.add(int(row['seed']))
missing = [str(seed) for seed in wanted if seed not in present]
print(','.join(missing))
" "$method" "$TOPOLOGY_KEY" "$K_EVAL" "$seeds_csv"
}

echo
echo "=== Hard Waxman full comparison sweep ==="
echo "stamp:                 $STAMP"
echo "topology:              $TOPOLOGY_KEY"
echo "hard_scenario:         $HARD_SCENARIO_KEY"
echo "methods:               $METHODS"
echo "seeds:                 $SEEDS"
echo "k_eval:                $K_EVAL"
echo "budget:                $COMPUTATION_BUDGET"
echo "parallelism:           $PARALLELISM"
echo "analysis_root:         $ROOT_DIR/$ANALYSIS_ROOT"
echo "results_root:          $ROOT_DIR/$RESULTS_ROOT"
echo "paper_table:           $ROOT_DIR/$PAPER_TABLE"
echo
echo "hard request settings:"
echo "  num_v_nets:          $WX_HARD_NUM_VNETS"
echo "  v_net_size:          [$WX_HARD_VNET_SIZE_LOW, $WX_HARD_VNET_SIZE_HIGH]"
echo "  arrival_rate.lam:    $WX_HARD_ARRIVAL_LAM"
echo "  node_demand.high:    $WX_HARD_NODE_DEMAND_HIGH"
echo "  link_demand.high:    $WX_HARD_LINK_DEMAND_HIGH"
echo
echo "old Waxman data/results remain untouched:"
echo "  datasets/generated/journal/nominal/$TOPOLOGY_KEY/seed_<seed>/test"
echo "  results/journal_suite/results/*/*__${TOPOLOGY_KEY}__nominal__*"
echo
echo "new hard Waxman data/results will use:"
echo "  datasets/generated/journal/$HARD_SCENARIO_KEY/$TOPOLOGY_KEY/seed_<seed>/test"
echo "  results/journal_suite/results/*/*__${TOPOLOGY_KEY}__nominal_to_${HARD_SCENARIO_KEY}__*"
echo
echo "env flags:"
echo "  AZSFC_CPP_AVAILABLE_SHORTEST_FALLBACK=$AZSFC_CPP_AVAILABLE_SHORTEST_FALLBACK"
echo "  AZSFC_CPP_MIX_STEP_SEED=$AZSFC_CPP_MIX_STEP_SEED"
echo "  AZSFC_CPP_PERSISTENT_TREE=$AZSFC_CPP_PERSISTENT_TREE"
echo "  AZSFC_CPP_USE_CANDIDATE_FEATURES=$AZSFC_CPP_USE_CANDIDATE_FEATURES"
echo

mkdir -p "$CONFIG_ROOT" "$ANALYSIS_ROOT"

echo
echo "=== Register existing nominal trained models ==="
run_cmd conda run -n virne python tools/register_existing_nominal_models.py \
  --results-root "$RESULTS_ROOT" \
  --topology-key "$TOPOLOGY_KEY" \
  --scenario-key nominal \
  --methods "$METHODS" \
  --seeds "$SEEDS" \
  --k-train "$K_EVAL"

generated_datasets=0
for method in $METHODS; do
  slug="$(method_slug "$method")"
  config_path="$CONFIG_ROOT/${HARD_SCENARIO_KEY}_${slug}.yaml"
  train_profile="${HARD_SCENARIO_KEY}_${slug}_train"
  eval_profile="${HARD_SCENARIO_KEY}_${slug}_eval"
  train_seeds=""
  if [[ "$TRAIN_MISSING" == "1" ]]; then
    train_seeds="$(missing_train_seeds "$method")"
  fi

  echo
  echo "=== Configure $method ==="
  if [[ "$TRAIN_MISSING" == "1" && -n "$train_seeds" ]]; then
    echo "missing nominal checkpoints for $method seeds: $train_seeds"
  fi

  run_cmd conda run -n virne python tools/build_waxman_hard_compare_config.py \
    --config-path "$config_path" \
    --method-key "$method" \
    --train-profile "$train_profile" \
    --eval-profile "$eval_profile" \
    --topology-key "$TOPOLOGY_KEY" \
    --hard-scenario-key "$HARD_SCENARIO_KEY" \
    --train-seeds "$train_seeds" \
    --eval-seeds "$seeds_csv" \
    --num-v-nets "$WX_HARD_NUM_VNETS" \
    --v-net-size-low "$WX_HARD_VNET_SIZE_LOW" \
    --v-net-size-high "$WX_HARD_VNET_SIZE_HIGH" \
    --arrival-lam "$WX_HARD_ARRIVAL_LAM" \
    --node-demand-high "$WX_HARD_NODE_DEMAND_HIGH" \
    --link-demand-high "$WX_HARD_LINK_DEMAND_HIGH" \
    --k-eval "$K_EVAL" \
    --computation-budget "$COMPUTATION_BUDGET" \
    --parallelism "$PARALLELISM"

  if [[ "$TRAIN_MISSING" == "1" && -n "$train_seeds" ]]; then
    echo
    echo "=== Train missing nominal checkpoints for $method ==="
    run_cmd conda run -n virne python tools/journal_experiments.py \
      --config "$config_path" \
      --profile "$train_profile" \
      --stage preflight
    run_cmd conda run -n virne python tools/journal_experiments.py \
      --config "$config_path" \
      --profile "$train_profile" \
      --stage train
  fi

  echo
  echo "=== Preflight hard eval for $method ==="
  run_cmd conda run -n virne python tools/journal_experiments.py \
    --config "$config_path" \
    --profile "$eval_profile" \
    --stage preflight

  if [[ "$generated_datasets" == "0" || "$FORCE_GENERATE_DATASETS" == "1" ]]; then
    echo
    echo "=== Generate hard Waxman datasets ==="
    run_cmd conda run -n virne python tools/journal_experiments.py \
      --config "$config_path" \
      --profile "$eval_profile" \
      --stage generate-datasets
    generated_datasets=1
  fi

  echo
  echo "=== Eval hard Waxman for $method ==="
  if [[ "$RERUN_COMPLETED" == "1" ]]; then
    run_cmd conda run -n virne python tools/journal_experiments.py \
      --config "$config_path" \
      --profile "$eval_profile" \
      --stage eval
  else
    run_cmd conda run -n virne python tools/journal_experiments.py \
      --config "$config_path" \
      --profile "$eval_profile" \
      --stage eval \
      --resume
  fi
done

echo
echo "=== Aggregate hard Waxman results ==="
run_cmd conda run -n virne python tools/aggregate_waxman_hard_results.py \
  --results-root "$RESULTS_ROOT" \
  --analysis-root "$ANALYSIS_ROOT" \
  --paper-table "$PAPER_TABLE" \
  --topology-key "$TOPOLOGY_KEY" \
  --hard-scenario-key "$HARD_SCENARIO_KEY" \
  --methods "$METHODS" \
  --seeds "$SEEDS" \
  --k-eval "$K_EVAL"

echo
echo "=== Done ==="
echo "analysis_root: $ROOT_DIR/$ANALYSIS_ROOT"
echo "summary:       $ROOT_DIR/$ANALYSIS_ROOT/eval_summary.csv"
echo "report:        $ROOT_DIR/$ANALYSIS_ROOT/report.md"
echo "paper_table:   $ROOT_DIR/$PAPER_TABLE"
