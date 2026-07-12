#!/usr/bin/env bash
set -euo pipefail

# Complete the hard Waxman-100 in-domain comparison for journal headline use.
#
# Existing final hard Waxman table uses seeds 0,1,2 with AlphaVNE one-off
# 5000-step checkpoints. This wrapper adds the missing seeds 3,4 using the
# same AlphaVNE one-off path, runs the remaining methods on seeds 3,4, then
# aggregates seeds 0..4 into the paper hard-Waxman table.

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

STAMP="${STAMP:-$(date -u +%Y%m%dT%H%M%SZ)}"
SEEDS="${SEEDS:-3 4}"
FINAL_SEEDS="${FINAL_SEEDS:-0 1 2 3 4}"

K_EVAL="${K_EVAL:-10}"
K_TRAIN_VALUES="${K_TRAIN_VALUES:-10}"
K_EVAL_VALUES="${K_EVAL_VALUES:-$K_EVAL}"
MAX_TRAINING_STEPS="${MAX_TRAINING_STEPS:-5000}"
COMPUTATION_BUDGET="${COMPUTATION_BUDGET:-96}"
PARALLELISM="${PARALLELISM:-1}"
DRY_RUN="${DRY_RUN:-0}"

TOPOLOGY_KEY="${TOPOLOGY_KEY:-wx100}"
HARD_SCENARIO_KEY="${HARD_SCENARIO_KEY:-${TOPOLOGY_KEY}_hard_compare}"
RESULTS_ROOT="${RESULTS_ROOT:-results/journal_suite/results}"

NONALPHA_METHODS="${NONALPHA_METHODS:-grc_rank mcts ppo_dual_gcn_plus ppo_mlp_plus pso_meta}"
FINAL_METHODS="${FINAL_METHODS:-alpha_zero_sfc grc_rank mcts ppo_dual_gcn_plus ppo_mlp_plus pso_meta}"

ALPHA_BASE_CONFIG="${ALPHA_BASE_CONFIG:-results/waxman_hard_indomain_sweep/20260511T073528Z/configs/wx100_hard_compare_indomain_alpha_zero_sfc.yaml}"
ALPHA_TRAIN_PROFILE="${ALPHA_TRAIN_PROFILE:-wx100_hard_compare_indomain_alpha_zero_sfc_train}"
ALPHA_EVAL_PROFILE="${ALPHA_EVAL_PROFILE:-wx100_hard_compare_indomain_alpha_zero_sfc_eval}"

NONALPHA_ANALYSIS_ROOT="${NONALPHA_ANALYSIS_ROOT:-results/waxman_hard_indomain_sweep/${STAMP}_seeds34_nonalpha}"
FINAL_ANALYSIS_ROOT="${FINAL_ANALYSIS_ROOT:-results/waxman_hard_indomain_sweep/${STAMP}_seeds0_4_final}"
PAPER_TABLE="${PAPER_TABLE:-paperjournal/current/tables/waxman_hard_indomain_comparison.tex}"

export AZSFC_CPP_AVAILABLE_SHORTEST_FALLBACK="${AZSFC_CPP_AVAILABLE_SHORTEST_FALLBACK:-0}"
export AZSFC_CPP_MIX_STEP_SEED="${AZSFC_CPP_MIX_STEP_SEED:-0}"
export AZSFC_CPP_PERSISTENT_TREE="${AZSFC_CPP_PERSISTENT_TREE:-1}"
export AZSFC_CPP_USE_CANDIDATE_FEATURES="${AZSFC_CPP_USE_CANDIDATE_FEATURES:-1}"

run_cmd() {
  echo "+ $*"
  if [[ "$DRY_RUN" == "1" ]]; then
    return 0
  fi
  "$@"
}

if [[ ! -f "$ALPHA_BASE_CONFIG" ]]; then
  echo "missing AlphaVNE hard Waxman base config: $ALPHA_BASE_CONFIG" >&2
  exit 1
fi

echo
echo "=== Complete hard Waxman seeds for headline ==="
echo "stamp:                   $STAMP"
echo "missing seeds:           $SEEDS"
echo "final aggregate seeds:   $FINAL_SEEDS"
echo "topology:                $TOPOLOGY_KEY"
echo "hard scenario:           $HARD_SCENARIO_KEY"
echo "k train/eval:            $K_TRAIN_VALUES / $K_EVAL_VALUES"
echo "AlphaVNE train steps:    $MAX_TRAINING_STEPS"
echo "non-AlphaVNE methods:    $NONALPHA_METHODS"
echo "final methods:           $FINAL_METHODS"
echo "nonalpha analysis root:  $NONALPHA_ANALYSIS_ROOT"
echo "final analysis root:     $FINAL_ANALYSIS_ROOT"
echo "paper table:             $PAPER_TABLE"
echo "dry run:                 $DRY_RUN"
echo

echo "=== Run missing non-AlphaVNE hard Waxman seeds ==="
run_cmd env \
  METHODS="$NONALPHA_METHODS" \
  SEEDS="$SEEDS" \
  STAMP="${STAMP}_nonalpha" \
  ANALYSIS_ROOT="$NONALPHA_ANALYSIS_ROOT" \
  PAPER_TABLE="$NONALPHA_ANALYSIS_ROOT/waxman_hard_indomain_nonalpha.tex" \
  REUSE_NONTRAINABLE_EVAL=0 \
  DRY_RUN="$DRY_RUN" \
  K_EVAL="$K_EVAL" \
  COMPUTATION_BUDGET="$COMPUTATION_BUDGET" \
  PARALLELISM="$PARALLELISM" \
  bash tools/run_waxman_hard_indomain_sweep.sh

echo
echo "=== Run missing AlphaVNE 5000-step one-off hard Waxman seeds ==="
for seed in $SEEDS; do
  echo
  echo "=== AlphaVNE hard Waxman seed $seed ==="
  run_cmd env \
    SEED="$seed" \
    CONFIG_PATH="$ALPHA_BASE_CONFIG" \
    TRAIN_PROFILE="$ALPHA_TRAIN_PROFILE" \
    EVAL_PROFILE="$ALPHA_EVAL_PROFILE" \
    MAX_TRAINING_STEPS="$MAX_TRAINING_STEPS" \
    K_TRAIN_VALUES="$K_TRAIN_VALUES" \
    K_EVAL_VALUES="$K_EVAL_VALUES" \
    STAMP="${STAMP}_alpha_seed${seed}" \
    bash tools/rerun_wx100_hard_seed1_train_eval.sh
done

echo
echo "=== Aggregate hard Waxman seeds 0..4 ==="
mkdir -p "$FINAL_ANALYSIS_ROOT"
run_cmd conda run -n virne python tools/aggregate_waxman_hard_results.py \
  --results-root "$RESULTS_ROOT" \
  --analysis-root "$FINAL_ANALYSIS_ROOT" \
  --paper-table "$PAPER_TABLE" \
  --topology-key "$TOPOLOGY_KEY" \
  --hard-scenario-key "$HARD_SCENARIO_KEY" \
  --comparison-mode indomain \
  --methods "$FINAL_METHODS" \
  --seeds "$FINAL_SEEDS" \
  --k-eval "$K_EVAL"

echo
echo "=== Headline row helper ==="
run_cmd conda run -n virne python -c "
import csv
import statistics
from pathlib import Path

display = {
    'alpha_zero_sfc': 'AlphaVNE',
    'grc_rank': 'GRC-Rank',
    'mcts': 'MCTS',
    'ppo_dual_gcn_plus': 'PPO-Dual-GCN+',
    'ppo_mlp_plus': 'PPO-MLP+',
    'pso_meta': 'PSO-Meta',
}
summary = Path('$FINAL_ANALYSIS_ROOT') / 'eval_summary.csv'
rows = list(csv.DictReader(summary.open()))
by_method = {}
for row in rows:
    by_method.setdefault(row['method'], []).append(float(row['acceptance_rate']))

alpha = statistics.fmean(by_method['alpha_zero_sfc'])
best_method, best_values = max(
    ((method, values) for method, values in by_method.items() if method != 'alpha_zero_sfc'),
    key=lambda item: statistics.fmean(item[1]),
)
best = statistics.fmean(best_values)
abs_gain = alpha - best
rel_gain = (abs_gain / best * 100.0) if best else 0.0
print(f'Hard Waxman-100 & {alpha:.3f} & {display.get(best_method, best_method)} ({best:.3f}) & +{abs_gain:.3f} & {rel_gain:.1f}%')
"

echo
echo "=== Done ==="
echo "summary:     $ROOT_DIR/$FINAL_ANALYSIS_ROOT/eval_summary.csv"
echo "report:      $ROOT_DIR/$FINAL_ANALYSIS_ROOT/report.md"
echo "paper table: $ROOT_DIR/$PAPER_TABLE"
