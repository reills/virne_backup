#!/usr/bin/env bash
# Journal-insurance runs for AlphaVNE.
#
# Runs the small set of extra experiments most likely to satisfy journal reviewers:
#   1. final fixed AlphaVNE on Brain/Geant seeds 3,4
#   2. matched benchmark baselines on Brain/Geant seeds 3,4
#   3. Brain nominal->generalization eval for final fixed AlphaVNE and baselines
#
# Defaults are resumable. Existing completed runs are reused where supported.

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

STAMP="${STAMP:-$(date -u +%Y%m%dT%H%M%SZ)}"
CONFIG_PATH="${CONFIG_PATH:-results/journal_suite/journal_insurance.yaml}"
INSURANCE_ROOT="${INSURANCE_ROOT:-$ROOT_DIR/results/journal_insurance/$STAMP}"
RUN_LOG="$INSURANCE_ROOT/run.log"

RUN_PREP_DATASETS="${RUN_PREP_DATASETS:-1}"
RUN_ALPHA_EXTRA_SEEDS="${RUN_ALPHA_EXTRA_SEEDS:-1}"
RUN_BASELINE_EXTRA_SEEDS="${RUN_BASELINE_EXTRA_SEEDS:-1}"
RUN_GENERALIZATION="${RUN_GENERALIZATION:-1}"
RUN_AGGREGATE="${RUN_AGGREGATE:-1}"
DRY_RUN="${DRY_RUN:-0}"

EXTRA_SEEDS_CSV="${EXTRA_SEEDS_CSV:-3,4}"
GENERALIZATION_SEEDS_CSV="${GENERALIZATION_SEEDS_CSV:-0,1,2}"
EXTRA_TOPOLOGIES_CSV="${EXTRA_TOPOLOGIES_CSV:-brain,geant}"
GENERALIZATION_TOPOLOGY="${GENERALIZATION_TOPOLOGY:-brain}"

# Final fixed AlphaVNE recipe.
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

mkdir -p "$INSURANCE_ROOT" "$(dirname "$CONFIG_PATH")"

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
require_file() { [[ -f "$1" ]] || { echo "missing file: $1" >&2; exit 1; }; }

print_plan() {
  section "Journal Insurance Plan"
  echo "stamp:                     $STAMP"
  echo "config_path:               $CONFIG_PATH"
  echo "insurance_root:            $INSURANCE_ROOT"
  echo "extra_seeds:               $EXTRA_SEEDS_CSV"
  echo "extra_topologies:          $EXTRA_TOPOLOGIES_CSV"
  echo "generalization_topology:   $GENERALIZATION_TOPOLOGY"
  echo "generalization_seeds:      $GENERALIZATION_SEEDS_CSV"
  echo "run_prep_datasets:         $RUN_PREP_DATASETS"
  echo "run_alpha_extra_seeds:     $RUN_ALPHA_EXTRA_SEEDS"
  echo "run_baseline_extra_seeds:  $RUN_BASELINE_EXTRA_SEEDS"
  echo "run_generalization:        $RUN_GENERALIZATION"
  echo "run_aggregate:             $RUN_AGGREGATE"
  echo "dry_run:                   $DRY_RUN"
  echo
  echo "AlphaVNE env flags:"
  echo "  AZSFC_CPP_USE_MEAN_Q_ROOT_VALUE=$AZSFC_CPP_USE_MEAN_Q_ROOT_VALUE"
  echo "  AZSFC_CPP_AVAILABLE_SHORTEST_FALLBACK=$AZSFC_CPP_AVAILABLE_SHORTEST_FALLBACK"
  echo "  AZSFC_CPP_MIX_STEP_SEED=$AZSFC_CPP_MIX_STEP_SEED"
  echo "  AZSFC_CPP_SHARE_REVERSE_EDGE_CAPACITY=$AZSFC_CPP_SHARE_REVERSE_EDGE_CAPACITY"
  echo "  AZSFC_CPP_PERSISTENT_TREE=$AZSFC_CPP_PERSISTENT_TREE"
  echo "  AZSFC_CPP_SET_V_NODE_OVERRIDE=$AZSFC_CPP_SET_V_NODE_OVERRIDE"
  echo "  AZSFC_CPP_USE_CANDIDATE_FEATURES=$AZSFC_CPP_USE_CANDIDATE_FEATURES"
  echo
  echo "branch:  $(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo unknown)"
  echo "HEAD:    $(git rev-parse HEAD 2>/dev/null || echo unknown)"
}

write_config() {
  section "Write Journal Insurance Config"
  run_cmd conda run -n virne python -c "
from omegaconf import OmegaConf
from pathlib import Path

cfg = OmegaConf.load('settings/experiments/journal_suite.yaml')
extra_seeds = [int(x.strip()) for x in '$EXTRA_SEEDS_CSV'.split(',') if x.strip()]
gen_seeds = [int(x.strip()) for x in '$GENERALIZATION_SEEDS_CSV'.split(',') if x.strip()]
extra_topos = [x.strip() for x in '$EXTRA_TOPOLOGIES_CSV'.split(',') if x.strip()]
gen_topo = '$GENERALIZATION_TOPOLOGY'

cfg.journal_suite.default_profile = 'journal_insurance_datasets'
cfg.journal_suite.offline_slice.enabled = False
cfg.journal_suite.k_semantics_parity.enabled = False
cfg.journal_suite.evaluation.parallelism = 2

baseline_methods = ['mcts', 'grc_rank', 'pso_meta', 'ppo_mlp_plus', 'ppo_dual_gcn_plus']

cfg.journal_suite.profiles['journal_insurance_datasets'] = OmegaConf.create({
    'seeds': sorted(set(extra_seeds + gen_seeds)),
    'topologies': sorted(set(extra_topos + [gen_topo])),
    'scenarios': ['nominal', 'generalization'],
    'methods': ['grc_rank'],
    'k_eval_values': [10],
    'generalization_cells': [],
})

cfg.journal_suite.profiles['journal_insurance_baselines_extra'] = OmegaConf.create({
    'seeds': extra_seeds,
    'topologies': extra_topos,
    'scenarios': ['nominal'],
    'methods': baseline_methods,
    'k_eval_values': [10],
    'generalization_cells': [],
})

cfg.journal_suite.profiles['journal_insurance_generalization'] = OmegaConf.create({
    'seeds': gen_seeds,
    'topologies': [gen_topo],
    # Keep only the train/source scenario here. The shifted eval scenario is
    # introduced exclusively through generalization_cells below. If
    # 'generalization' is listed as a normal scenario, journal_experiments.py
    # expects separate models trained on that scenario, which is not the
    # experiment we want.
    'scenarios': ['nominal'],
    'methods': baseline_methods,
    'k_eval_values': [10],
    'generalization_cells': [
        {'train_scenario': 'nominal', 'eval_scenario': 'generalization', 'topology': gen_topo, 'seed': seed}
        for seed in gen_seeds
    ],
})

Path('$CONFIG_PATH').parent.mkdir(parents=True, exist_ok=True)
OmegaConf.save(cfg, '$CONFIG_PATH')
print('wrote $CONFIG_PATH')
print('extra_seeds=', extra_seeds)
print('extra_topologies=', extra_topos)
print('generalization=', gen_topo, gen_seeds)
"
}

run_journal_stage() {
  local profile="$1"
  local stage="$2"
  shift 2
  section "journal_experiments profile=$profile stage=$stage"
  run_cmd conda run -n virne python tools/journal_experiments.py \
    --config "$CONFIG_PATH" \
    --profile "$profile" \
    --stage "$stage" \
    "$@"
}

run_alpha_extra_seeds() {
  section "Final AlphaVNE Extra Seeds"
  local seeds="${EXTRA_SEEDS_CSV//,/ }"
  local topos="${EXTRA_TOPOLOGIES_CSV//,/ }"
  run_cmd env \
    STAMP="${STAMP}_alpha_extra" \
    ARM=journal_insurance_replay_move_fix_3k \
    TOPOLOGIES="$topos" \
    SEEDS="$seeds" \
    SWEEP_BRAIN_CHECKPOINTS=0 \
    TRAIN_NUM_EPOCHS=24 \
    TRAIN_MAX_STEPS=3000 \
    NON_BRAIN_SAVE_INTERVAL=4152 \
    GUARANTEED_SAVE_STEP=4152 \
    RESUME_COMPLETED=1 \
    bash tools/run_codex_lock_in.sh
}

write_alpha_extra_summary() {
  section "Summarize Final AlphaVNE Extra Seeds"
  run_cmd conda run -n virne python -c "
import csv
import pathlib
import statistics

root = pathlib.Path('results/journal_suite/results/alpha_zero_sfc')
stamp = '${STAMP}_alpha_extra'
arm = 'journal_insurance_replay_move_fix_3k'
out_root = pathlib.Path('$INSURANCE_ROOT/alpha_extra')
out_root.mkdir(parents=True, exist_ok=True)
rows = []
for topo in [x.strip() for x in '$EXTRA_TOPOLOGIES_CSV'.split(',') if x.strip()]:
    for seed in [int(x.strip()) for x in '$EXTRA_SEEDS_CSV'.split(',') if x.strip()]:
        run_id = f'journal_suite__alpha_zero_sfc__{topo}__{arm}_latest__seed{seed}__eval__keval10__{stamp}'
        summary = root / run_id / 'summary.csv'
        row = {
            'method': 'alpha_vne_final',
            'topology': topo,
            'seed': seed,
            'scenario': 'nominal',
            'k_eval': 10,
            'acceptance_rate': '',
            'long_term_r2c_ratio': '',
            'clock_running_time': '',
            'run_id': run_id,
            'summary_path': str(summary),
            'status': 'missing',
        }
        if summary.exists():
            data = list(csv.DictReader(summary.open()))
            if data:
                last = data[-1]
                row.update({
                    'acceptance_rate': last.get('acceptance_rate', ''),
                    'long_term_r2c_ratio': last.get('long_term_r2c_ratio', ''),
                    'clock_running_time': last.get('clock_running_time', ''),
                    'status': 'ok',
                })
        rows.append(row)

fields = ['method','topology','seed','scenario','k_eval','acceptance_rate','long_term_r2c_ratio','clock_running_time','status','run_id','summary_path']
summary_csv = out_root / 'eval_summary.csv'
with summary_csv.open('w', newline='') as f:
    writer = csv.DictWriter(f, fieldnames=fields)
    writer.writeheader()
    writer.writerows(rows)

report = out_root / 'report.md'
with report.open('w') as f:
    f.write('# Final AlphaVNE Extra Seeds\\n\\n')
    f.write('| topology | seed | acceptance | lrc | clock | status | run |\\n')
    f.write('| --- | ---: | ---: | ---: | ---: | --- | --- |\\n')
    by_topo = {}
    for row in rows:
        f.write(f\"| {row['topology']} | {row['seed']} | {row['acceptance_rate']} | {row['long_term_r2c_ratio']} | {row['clock_running_time']} | {row['status']} | {row['run_id']} |\\n\")
        if row['status'] == 'ok' and row['acceptance_rate']:
            by_topo.setdefault(row['topology'], []).append(float(row['acceptance_rate']))
    f.write('\\n## Means\\n\\n')
    for topo, vals in sorted(by_topo.items()):
        f.write(f'- {topo}: n={len(vals)} mean={statistics.mean(vals):.3f} std={statistics.pstdev(vals) if len(vals) > 1 else 0.0:.3f}\\n')
    f.write(f'\\n- eval summary: {summary_csv}\\n')
print(f'wrote {summary_csv}')
print(f'wrote {report}')
"
}

run_alpha_generalization() {
  section "Final AlphaVNE Brain Generalization"
  run_cmd conda run -n virne python tools/run_alpha_vne_generalization_eval.py \
    --topology "$GENERALIZATION_TOPOLOGY" \
    --seeds "$GENERALIZATION_SEEDS_CSV" \
    --stamp "$STAMP" \
    --output-root "$INSURANCE_ROOT/generalization_alpha_vne"
}

run_aggregate() {
  section "Aggregate Journal Tables"
  run_cmd conda run -n virne python tools/aggregate_journal_results.py \
    --suite-root results/journal_suite \
    --bootstrap-samples 200 \
    --latest-per-cell
}

print_plan
write_config

if [[ "$RUN_PREP_DATASETS" == "1" ]]; then
  run_journal_stage journal_insurance_datasets preflight
  run_journal_stage journal_insurance_datasets generate-datasets
fi

if [[ "$RUN_ALPHA_EXTRA_SEEDS" == "1" ]]; then
  run_alpha_extra_seeds
fi

write_alpha_extra_summary

if [[ "$RUN_BASELINE_EXTRA_SEEDS" == "1" ]]; then
  run_journal_stage journal_insurance_baselines_extra preflight
  run_journal_stage journal_insurance_baselines_extra train
  run_journal_stage journal_insurance_baselines_extra eval
fi

if [[ "$RUN_GENERALIZATION" == "1" ]]; then
  run_journal_stage journal_insurance_generalization preflight
  run_journal_stage journal_insurance_generalization eval
  run_alpha_generalization
fi

if [[ "$RUN_AGGREGATE" == "1" ]]; then
  run_aggregate
fi

section "Done"
echo "insurance_root: $INSURANCE_ROOT"
echo "config:         $CONFIG_PATH"
echo "log:            $RUN_LOG"
