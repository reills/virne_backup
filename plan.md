# Journal Experiment Automation Plan (`virne`)

## 1) Goal
Build a single, reproducible automation flow that:
- generates fixed, standardized datasets (same PNet + VNet events across methods),
- runs train/eval for all target baselines and AlphaZero-SFC,
- supports k-ablations (inference-time and training-time),
- records journal-ready metrics (RAC/LRC/AST_run + time/request distribution + timeout + training cost),
- avoids config drift/conflicts across `settings/*`, Hydra overrides, and legacy defaults.

## 2) Repo Reality (what we will build on)

Entrypoint and config:
- `main.py` (Hydra runner)
- `settings/main.yaml`, `settings/learning.yaml`
- `virne/utils/config.py` (`add_simulation_into_config`, run-id wiring)

AlphaZero components:
- `virne/solver/learning/reinforcement_learning/alpha_vne/alpha_zero_sfc_solver.py`
- `virne/solver/learning/reinforcement_learning/alpha_vne/actor_optimized.py`
- `virne/solver/learning/reinforcement_learning/alpha_vne/learner.py`
- Existing sweep/eval helpers:
  - `tools/train_alpha_zero_k_sweep.py`
  - `run_k_eval_zero.sh`
  - `run_k_eval_baseline_vs_nn_parallel.sh`

Dataset generators:
- `tools/generator/create_training_dataset.py`
- `tools/generator/generate_k_ablation_datasets.py`

Metrics outputs:
- `results/<solver>/<run_id>/summary.csv`
- `results/<solver>/<run_id>/records/*.csv`
- `summary.csv` includes acceptance/r2c/runtime summary fields through `virne/core/environment.py` + `virne/core/recorder.py`.

Topologies available now:
- `datasets/topology/Waxman100.gml`
- `datasets/topology/Waxman500.gml`
- `datasets/topology/Geant.gml`
- `datasets/topology/Brain.gml`

## 3) What to Implement

Create one orchestrator script:
- `tools/journal_experiments.py`

Create one experiment matrix config:
- `settings/experiments/journal_suite.yaml`

Create one aggregator:
- `tools/aggregate_journal_results.py`

Optional runtime instrumentation patch:
- `virne/system/base_system.py` to log per-request solve latency (for p50/p95), or capture in orchestrator wrapper if avoiding core edits.

## 4) Config-Conflict Strategy (critical)

Do **not** mutate shared defaults in `settings/*.yaml` during runs.
Every run uses explicit Hydra overrides from the orchestrator.

For fixed datasets, every run must set all of:
1. `use_fixed_dataset=true`
2. `experiment.if_load_p_net=true`
3. `experiment.if_load_v_nets=true`
4. `simulation.p_net_dataset_dir=<dataset_dir>` (no `+`)
5. `simulation.v_nets_dataset_dir=<dataset_dir>` (no `+`)
6. `experiment.seed=<seed>`

Topology-path rule:
- set `p_net_setting.topology.file_path=<topology_gml_abs_path>` during dataset generation.
- for fixed-dataset train/eval runs, omit `p_net_setting.topology.file_path` unless preflight confirms it is ignored when `experiment.if_load_p_net=true`.

For deterministic training/eval:
- `training.if_use_random_training_seed=false`
- `training.seed=<seed>`
- `experiment.seed=<seed>`
- `training.num_workers=<fixed_value>`
- set and log thread env: `OMP_NUM_THREADS`, `MKL_NUM_THREADS`, `OPENBLAS_NUM_THREADS`

Run isolation:
- deterministic `experiment.run_id` from matrix key including stage and k-role, e.g.:
  - `...__train__ktrain10`
  - `...__eval__keval5__ckpt<id>`
- explicit `hydra.run.dir=<result_run_dir>/hydra`
- explicit `experiment.save_root_dir=<suite_root>/results`
- never reuse the same `<solver>/<run_id>` between training and evaluation jobs.

Legacy config note:
- `virne/config.py` has legacy defaults; orchestration should use `main.py` + Hydra overrides only for experiment execution.
- `settings/experiments/journal_suite.yaml` must declare `simulation.p_net_dataset_dir` and `simulation.v_nets_dataset_dir` so strict overrides can be used safely.

Fail-fast Hydra policy:
1. enable structured config checking in the orchestrator (set struct mode before job launch).
2. disallow `+` overrides for any critical key (`simulation.*`, `experiment.*`, `solver.*`, `training.*`).
3. preflight each command by validating all override keys against the composed config; unknown key => hard fail.

## 4.1) Fairness Rules (non-negotiable)

All methods are compared under identical conditions per experiment cell.

Matched conditions for every compared run:
1. Same fixed dataset dir (`p_net.gml`, `v_nets/`, `events.yaml`).
2. Same topology/scenario/split/seed.
3. Same `solver.shortest_method` and `solver.k_shortest` for the comparison being reported.
4. Same request count (`v_sim_setting.num_v_nets`) and event stream.
5. Same per-request timeout and same failure handling (timeout => failure).
6. Same hardware class and CPU thread limits for online evaluation.
7. Same metric denominators: acceptance and latency must be computed on arrival events only (never on departure events).

Implementation guarantee:
For each eval cell `(topology, scenario, seed, k_eval)`, all solvers are assigned the same `dataset_dir`, so they read the same `p_net.gml`, `v_nets/*.gml`, and `events.yaml`.
The orchestrator forces fixed-dataset loading (`use_fixed_dataset=true`, `experiment.if_load_p_net=true`, `experiment.if_load_v_nets=true`) to prevent per-method regeneration at run time.
Dataset generation is keyed by `(scenario, topology, seed, split)` and occurs once per key, not once per solver.
Train/test leakage is prevented by split-aware generation seeds, while cross-solver fairness is preserved because methods share identical datasets within a split.

Training fairness rules for trainable methods:
1. Reported comparisons use a declared training budget profile (`smoke/core/full`).
2. Methods in the same profile use fixed, declared training steps/epochs (or explicitly method-specific budgets).
3. Training wall-clock is reported separately from online embedding latency.

Search fairness rules:
1. `mcts` and `alpha_zero_sfc` compared with equal `training.computation_budget` and `training.c_puct` unless a dedicated ablation changes them.
2. Any non-default search settings are included in the run manifest and output tables.
3. k-semantics parity must be validated per solver (how `k_shortest` is consumed in routing); if semantics differ and cannot be aligned, report in a separate table (no pooled headline deltas).

## 5) Experiment Matrix (journal-focused)

Topologies:
- `wx100` -> `datasets/topology/Waxman100.gml`
- `geant` -> `datasets/topology/Geant.gml`
- `brain` -> `datasets/topology/Brain.gml`
- scalability stress (required for `full` profile): `wx500` -> `datasets/topology/Waxman500.gml`

Scenarios:
- `nominal`: default online traffic profile
- `generalization` cell: train at nominal profile, evaluate on shifted profile (e.g., higher arrival pressure / changed demand distribution)

Methods (minimum credible set):
- `alpha_zero_sfc`
- `mcts`
- `grc_rank`
- one meta: `pso_meta` (or `ga_meta`)
- `ppo_mlp+`
- `ppo_dual_gcn` (optional add `ppo_dual_gat+` after smoke validation)
- optional legacy reference: `pg_mlp` (report as legacy PG baseline, not PPO replacement)

k values:
- eval k sweep: `{1, 3, 5, 10, 15}`
- AlphaZero training-time specialization: train separate checkpoints per k in `{1, 3, 5, 10, 15}` (or bounded `{1,5,10}` profile)

Seeds:
- start with 3 seeds for development profile
- scale to 10 seeds for final significance profile

## 6) Pipeline Design

### Stage A: Preflight
Validate:
- topology files exist
- solver names are available and importable
- CUDA/CPU resources and worker counts are valid
- dataset/result roots exist or can be created
- critical config keys exist in schema (`use_fixed_dataset`, `experiment.if_load_*`, `simulation.*`) and are writable without `+`
- each solver honors required knobs: `solver.shortest_method`, `solver.k_shortest`, eval-only mode/model loading where applicable
- determinism fields are pinned and logged (seed, worker count, thread env vars, deterministic torch flags if used)
- metric denominator sanity checks are enabled (arrival-event counts only)
- fixed-dataset PN load precedence is validated (dataset PN is used when `if_load_p_net=true`)
- offline-slice data compatibility is validated (`system.if_offline_system=true` can consume planned dataset format), otherwise fail fast and require conversion step
- k-semantics parity micro-test:
  - use a deterministic tiny case where shortest path is infeasible and second-shortest is feasible
  - assert `k=1` fails and `k>=2` succeeds for methods included in pooled k-ablation deltas

Emit:
- `manifest.json` with git commit, config hash, matrix, resource limits.

### Stage B: Standardized Dataset Build
For each `(topology, scenario, seed, split)`:
1. generate one canonical dataset dir:
   - `datasets/generated/journal/<scenario>/<topology>/seed_<seed>/<split>/`
2. save `config_snapshot.yaml` + generation metadata
3. validate online stream integrity:
   - `events.yaml` exists and is non-empty
   - exactly two events per request (`arrival` + `departure`)
   - one arrival and one departure per `v_net_id`
   - non-decreasing event time ordering
4. never regenerate unless `--force` is passed

Use same generated dataset for all methods at that `(topology, scenario, seed, split)`.

### Stage B2: Offline Solvability Slice
Add a smaller, explicit solvability slice using the same requests but no cumulative online carry-over:
1. run designated rows with `system.if_offline_system=true`
2. report acceptance/runtime separately as `offline_solvability_*` metrics
3. if offline loader requires a different format, generate a parallel converted offline dataset and record conversion metadata
4. keep this section small (journal-control experiment, not full matrix explosion)

### Stage C: Training Jobs
Rule by method category:
- Non-train baselines (`grc_rank`, `pso_meta`, `mcts`): no training stage.
- RL baselines (`ppo_mlp+`, `ppo_dual_gcn`, optional `pg_mlp`): train once per `(topology, scenario, seed, k_train_policy)`.
- `alpha_zero_sfc`: train per requested k specialization set.

Persist model registry:
- `results/journal_suite/model_registry.csv`
- columns: method, topology, scenario, seed, k_train, model_path, run_id.
- parallel write safety is required (file lock or per-run shard files merged in aggregation).

### Stage D: Evaluation Jobs
For each matrix row:
- load fixed dataset
- run inference-only/eval mode
- attach trained model path where applicable
- enforce per-request timeout with cooperative checks (timeout => request failure, continue run)
- enforce per-run watchdog timeout as fallback and record `run_timeout` separately
- record request-level solve runtime and timeout flag for arrival events
- runtime timing spec:
  - measure end-to-end solve latency per arrival request (not just NN forward pass)
  - include candidate enumeration/path search/feasibility checks/reservation logic in timing window
  - when GPU inference is active, call `torch.cuda.synchronize()` immediately before timer start and immediately after solver return
- write stdout/stderr logs to run folder

### Stage E: Aggregation
Parse:
- run-level `summary.csv`
- `records/*.csv` for optional fine metrics

Produce:
- `results/journal_suite/tables/main_metrics.csv`
- `results/journal_suite/tables/runtime_metrics.csv`
- `results/journal_suite/tables/k_ablation.csv`
- `results/journal_suite/tables/pairwise_deltas.csv`
- `results/journal_suite/tables/significance.csv`
- `results/journal_suite/tables/ranked_summary.csv`

Core metrics:
- RAC: `acceptance_rate`
- LRC proxy: `long_term_r2c_ratio` (and optionally `avg_r2c_ratio`)
- AST_run: `clock_running_time` (seconds per simulation run)
- AST_req: `clock_running_time / num_arrival_requests` (seconds per arrival request)
- Time/request: mean/median/p95 solve time per arrival request (include failures/timeouts in denominator)
- Timeout rate: timed-out arrivals / total arrivals
- Training cost: wall clock per trained model

Comparison metrics (computed on matched seeds):
- Delta RAC (`method_a - method_b`)
- Delta LRC (`method_a - method_b`)
- Speedup (`ast_req_b / ast_req_a` and `time_req_p95_b / time_req_p95_a`)
- Win rate across matched seeds/topologies

## 7) k-Ablation Protocol in Automation

Inference-time sensitivity:
1. train AlphaZero at default `k_train=10`
2. evaluate same checkpoint across `k_eval in {1,3,5,10,15}`

Training-time specialization:
1. train AlphaZero separately for each `k_train in {1,3,5,10,15}` (or bounded set)
2. evaluate each checkpoint at matched `k_eval=k_train`

Fairness extension for baselines:
- run `mcts`, `grc_rank`, and chosen meta baseline across same `k_eval` set
- RL baselines:
  - minimum: train once at `k_train=10`, evaluate across k
  - stronger: retrain representative points (`k=1` and `k=10`)
- preflight must include a k-semantics capability check per solver; only methods passing parity checks are included in pooled k-ablation deltas.

## 8) Script Interface (proposed)

`python tools/journal_experiments.py --config settings/experiments/journal_suite.yaml --stage all`

Stages:
- `preflight`
- `generate-datasets`
- `train`
- `eval`
- `aggregate`
- `all`

Key flags:
- `--profile smoke|core|full`
- `--max-parallel N`
- `--device-policy cpu|single-gpu|multi-gpu`
- `--resume`
- `--force`

## 9) Implementation Sequence

Phase 1 (safe foundation):
1. Add `settings/experiments/journal_suite.yaml` schema.
2. Add `tools/journal_experiments.py` with strict override validation, `preflight` + dataset generation + manifest writing.
3. Validate deterministic dataset reuse.

Phase 2 (execution):
1. Add train/eval orchestration for `alpha_zero_sfc`, `mcts`, `grc_rank`.
2. Add model registry and resume-safe job skipping.
3. Add per-request timeout/failure capture + run-level watchdog fallback.

Phase 3 (journal matrix):
1. Add RL baseline training/eval paths (`ppo_mlp+`, `ppo_dual_gcn`, optional `pg_mlp` legacy row).
2. Add k-study modes (inference and train specialization).
3. Add topology sweep (`wx100`, `geant`, `brain`, and `wx500` in full profile).
4. Add one explicit train-vs-test generalization cell.
5. Add offline solvability slice (`system.if_offline_system=true`).

Phase 4 (aggregation + paper outputs):
1. Add `tools/aggregate_journal_results.py`.
2. Emit table-ready CSVs and ablation summaries.
3. Verify reproducibility by rerunning a subset with same manifest hash.

## 10) Risks and Mitigations

Risk: hidden config drift between scripts and defaults.
- Mitigation: orchestrator logs full override list for every run and writes resolved config snapshot.

Risk: silent Hydra key typos due `+` overrides.
- Mitigation: strict structured config + disallow `+` on critical keys + preflight override validation.

Risk: train/eval output collision from reused run IDs.
- Mitigation: stage-aware run IDs (`__train__...` vs `__eval__...`) and explicit uniqueness checks before launch.

Risk: long wall time for full matrix.
- Mitigation: profile tiers (`smoke/core/full`), resume checkpoints, and parallel job limits.

Risk: incompatible solver names across versions.
- Mitigation: preflight solver name validation before queue build.

Risk: C++ MCTS extension availability variance.
- Mitigation: preflight check and controlled fallback (`training.use_cpp_mcts=false`) by profile policy.

Risk: unfair cross-method conclusions due to unpaired comparisons.
- Mitigation: only compute headline deltas from matched `(topology, scenario, seed, k_eval)` pairs; unmatched runs are excluded from significance tables.

Risk: timeout semantics differ (request-level vs run-level) and bias runtime results.
- Mitigation: report both request-timeout rate and run-timeout rate; exclude run-timeout rows from primary paired metrics unless all methods in cell timed out.

Risk: k parameter semantics differ across methods.
- Mitigation: preflight parity checks and separate reporting when semantics cannot be aligned.

Risk: model registry corruption under parallel writes.
- Mitigation: file lock or per-run shard registry files merged during aggregation.

## 11) Definition of Done

Done when:
1. A single command can regenerate the full chosen profile from scratch.
2. All runs use fixed, shared datasets per `(topology, scenario, seed, split)`.
3. Critical config keys are strictly validated (no `+` overrides for required fields).
4. k-training and k-eval are both automated with no manual path edits.
5. Aggregated CSVs contain RAC/LRC/AST_run/AST_req + time/request + timeout + training cost fields.
6. Online and offline solvability sections are both generated.
7. One explicit generalization cell is included in final tables.
8. Re-run with `--resume` skips completed jobs and reproduces prior metrics.
9. Pairwise comparison tables are generated from matched seeds and include significance outputs.
10. Train/eval outputs are collision-safe (no shared `<solver>/<run_id>` across stages).

## 12) Reporting Layout (for paper-ready comparisons)

Primary table shape (one row per method-topology-k):
- `method, topology, scenario, k_eval, seeds_n, rac_mean, rac_std, lrc_mean, lrc_std, ast_run_mean, ast_req_mean, time_req_mean, time_req_p95, timeout_rate`

Pairwise table shape (one row per method pair):
- `method_a, method_b, topology_scope, k_scope, delta_rac_mean, delta_lrc_mean, speedup_mean, win_rate, p_value`

Significance policy:
- Use paired tests on matched seeds (paired bootstrap CI or Wilcoxon signed-rank).
- Report effect size + confidence interval, not only p-value.
