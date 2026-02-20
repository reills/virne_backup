# PROJECT.md - AlphaZero-SFC Journal Suite (ViRNE)

This repo already contains an AlphaZero-style SFC/VNE solver registered as
`alpha_zero_sfc`. This document maps the real entrypoints/paths and defines the
minimal additions needed for a journal-grade experimental suite (baselines +
runtime + realistic topologies/demand + commit-on-expand ablation), while
keeping training bounded.

## Hard Constraints

- No assumptions: confirm paths/names in this repo before edits.
- Keep diffs minimal and isolated; avoid refactors unless required.
- Bounded training budget: 3 primary trainings total (k = 1, 5, 10).

## CODE MAP (Discovered Paths)

Entrypoint / runner
- Main Hydra entrypoint: `main.py`
- Hydra config root: `settings/main.yaml` (includes `settings/learning.yaml`, `settings/p_net_setting/default.yaml`, `settings/v_sim_setting/default.yaml`)
- System loop: `virne/system/base_system.py` (`BaseSystem.from_config`, `OnlineSystem.run`)
- Simulation path wiring: `virne/utils/config.py` (`add_simulation_into_config`, `get_run_id_dir`)

Topology + routing
- Topology files shipped in-repo: `datasets/topology/Waxman100.gml` (100 nodes), `datasets/topology/cost266.gml` (37), `datasets/topology/germany50.gml` (50)
- Physical loader/generator: `virne/network/physical_network.py:PhysicalNetwork.from_setting`
- k-shortest/simple paths: `virne/core/controller/topology_analyzer.py:TopologyAnalyzer.find_shortest_paths` (`k_shortest` uses `networkx.shortest_simple_paths`)
- Link mapping (BW reservation): `virne/core/controller/link_mapper.py`

Requests / arrivals
- Request + event simulator: `virne/network/virtual_network_request_simulator.py`
- Distribution helper (currently: `uniform|normal|exponential|poisson`): `virne/utils/dataset.py:generate_data_with_distribution`
- VNet topology generation: `virne/network/base_network.py:BaseNetwork.generate_topology`

Solver registry / selection
- Registry: `virne/solver/base_solver.py:SolverRegistry`
- Auto-import registrations: `virne/solver/__init__.py`
- Selection knob: Hydra `solver.solver_name` (`python main.py solver.solver_name=...`)

AlphaZero-SFC (target solver)
- Orchestrator (registered entrypoint): `virne/solver/learning/reinforcement_learning/alpha_vne/alpha_zero_sfc_solver.py`
- Actor: `virne/solver/learning/reinforcement_learning/alpha_vne/actor_optimized.py`
- MCTS engine (Python): `virne/solver/learning/reinforcement_learning/alpha_vne/mcts_engine.py`
- Commit-on-expand routing + shadow reservations (Python): `virne/solver/learning/reinforcement_learning/alpha_vne/node.py:State._create_child_state`
- Learner (replay -> SGD): `virne/solver/learning/reinforcement_learning/alpha_vne/learner.py`
- C++ MCTS backend: `virne/solver/learning/reinforcement_learning/alpha_vne/cpp_core/` (wired by `virne/solver/learning/reinforcement_learning/alpha_vne/cpp_adapter.py`)

Baselines already implemented
- Vanilla MCTS: `virne/solver/learning/reinforcement_learning/mcts_solver/mcts.py` (solver_name `mcts`)
- DRL examples (pick 2): `virne/solver/learning/reinforcement_learning/mlp_solver.py` (`pg_mlp`), `virne/solver/learning/reinforcement_learning/seq2seq_solver.py` (`a3c_gcn_seq2seq`)
- Heuristics: `virne/solver/heuristic/node_rank.py` (`nrm_rank`, `grc_rank`, ...), `virne/solver/heuristic/joint_pr.py` (`order_joint_pr`, ...)

Logging / results
- Logger: `virne/core/logger.py` (writes `results/<solver>/<run_id>/logs/`)
- Recorder: `virne/core/recorder.py` (writes `results/<solver>/<run_id>/records/` and `results/<solver>/<run_id>/summary.csv`)
- AlphaZero extras per run: `results/<solver>/<run_id>/models/policy_latest.pt`, `results/<solver>/<run_id>/replay_buffer/*.json`

Existing experiment utilities
- Fixed dataset generator: `tools/generator/create_training_dataset.py`
- Per-k dataset cloner: `tools/generator/generate_k_ablation_datasets.py`
- Parallel AlphaZero k-sweep trainer: `tools/train_alpha_zero_k_sweep.py` (shell wrapper: `run_k_sweep_zero_train.sh`)
- Parallel k-eval using trained models: `run_k_eval_zero.sh`, `run_k_eval_baseline_vs_nn_parallel.sh`
- k-shortest ablation runner (writes CSV + runtimes): `tools/k_shortest_ablation.py`
- Offline learner resume: `tools/run_alpha_zero_offline_learner.py`

## How To Run (Current Repo)

Quick single run (any solver)
- `python main.py`
- Example baseline: `python main.py solver.solver_name=mcts training.computation_budget=64 solver.k_shortest=5 v_sim_setting.num_v_nets=200`

Use a real topology file (prefer absolute paths to avoid Hydra chdir surprises)
- `python main.py p_net_setting.topology.file_path=$(pwd)/datasets/topology/cost266.gml`

Generate a fixed dataset (contains `p_net.gml`, `v_nets/`, `events.yaml`)
- `python tools/generator/create_training_dataset.py --output-dir datasets/generated/myset --num-vnrs 1000 --overwrite`

Train AlphaZero for the bounded k set (3 trainings total)
- `python tools/train_alpha_zero_k_sweep.py --dataset-dir datasets/generated/2000_vnets --k-values 1,5,10 --max-workers 3 --num-epochs 12 --steps-per-epoch 128 --max-training-steps 500 --num-vnets 2000`
  (Tune `training.computation_budget` / `training.c_puct` via `--extra-overrides`.)

Best-performing Alpha-SFC training setup (short schedule)
- This is the setup that produced the strongest Alpha-SFC results in this project: distributed 4-worker training, 12 epochs, and a short learner cap (`max_training_steps=500`).
- Keep `--steps-per-epoch 128`, which yields `512` effective learner updates (4 x 128) before termination.
- Keep search/training knobs at `training.computation_budget=64`, `training.c_puct=1.4`, `training.use_cpp_mcts=true`, and neural policy/value enabled.
- Use 2000 fixed training requests: `--dataset-dir datasets/generated/2000_vnets --num-vnets 2000`.

Evaluate trained AlphaZero models (inference-only)
- `K_VALUES="1 5 10" DATASET_DIR=$(pwd)/datasets/generated/1000_vnets MODEL_ROOT=$(pwd)/results/alpha_zero_sfc_resweep/alpha_zero_sfc ./run_k_eval_zero.sh`

k-shortest sensitivity on one checkpoint (writes CSV)
- `python tools/k_shortest_ablation.py --auto-checkpoint --ks 1,5,10 --seeds 0,1,2 --num-instances 500`

## Key Config Knobs (Real Names)

Routing budget
- `solver.shortest_method`: `k_shortest|first_shortest|bfs_shortest|...` (see `virne/core/controller/topology_analyzer.py`)
- `solver.k_shortest`: k for `k_shortest`

MCTS
- `training.computation_budget`: simulations per placement decision (this is "N_sim")
- `training.c_puct`: PUCT exploration constant
- `training.use_cpp_mcts`: use `alpha_vne/cpp_core` backend when available

AlphaZero training/eval modes
- `training.enable_async_learner`: background learner process
- `training.disable_trajectory_writing`: if true, actors do NOT write replay JSON (learner will starve)
- `training.inference_only`: disables learner + training loop
- `training.alphazero_model_path`: load a specific `policy_latest.pt`

Fixed dataset (for fair comparisons)
- `use_fixed_dataset=true`
- `experiment.if_load_p_net=true`, `experiment.if_load_v_nets=true`
- `+simulation.p_net_dataset_dir=...`, `+simulation.v_nets_dataset_dir=...` (usually the same folder created by `create_training_dataset.py`)

## Journal-Grade Extensions (Minimal Edits, Where To Change)

1) Heavy-tailed demand (NOT IMPLEMENTED)
- Add `lognormal` / `pareto` support in `virne/utils/dataset.py:generate_data_with_distribution`
- Add a preset config (e.g. `settings/v_sim_setting/heavy_tailed.yaml`) and run via Hydra override
- Ensure all RNGs are seeded via `virne/utils/dataset.py:set_seed`

2) Backbone topologies (ALREADY SUPPORTED; needs capacity profiles)
- Loading exists via `p_net_setting.topology.file_path` (see `virne/network/physical_network.py`)
- Add deterministic tiered CPU/BW assignment (degree/betweenness tiers) as a `capacity_profile` hook (best place: after topology load, before `generate_attrs_data`)

3) Runtime / latency reporting (PARTIAL)
- `tools/k_shortest_ablation.py` already measures per-request runtimes
- Add p50/p95 latency recording into the main runner (`virne/system/base_system.py:OnlineSystem.run`) and write to CSV alongside acceptance/R/C

4) Commit-on-expand ablation toggle (BEHAVIOR EXISTS; TOGGLE MISSING)
- Commit-on-expand currently happens in `virne/solver/learning/reinforcement_learning/alpha_vne/node.py:State._create_child_state`
- Add config flag `solver.commit_on_expand` (and propagate to C++ backend or force Python MCTS for the ablation when `training.use_cpp_mcts=true`)

5) Unified sweep + paper-ready plots (PARTIAL)
- Current outputs: per-run `summary.csv` + global summaries from `virne/core/recorder.py`
- Add a single "metrics.csv" aggregator + plot scripts (new `tools/plot_*.py`) driven from recorded summaries

## Experiment Matrix (Bounded Training)

Topologies (3)
- Waxman-100: `datasets/topology/Waxman100.gml` (or generated waxman via default p_net_setting)
- COST266 (37): `datasets/topology/cost266.gml`
- Germany50 (50): `datasets/topology/germany50.gml`

Demand models (2)
- Uniform: current default configs (`settings/v_sim_setting/default.yaml`)
- Heavy-tailed: TODO above

Solvers (minimum set)
- AlphaZero-SFC: `alpha_zero_sfc`
- Vanilla MCTS: `mcts`
- DRL baseline #1: `pg_mlp`
- DRL baseline #2: `a3c_gcn_seq2seq`
- Heuristic sanity: `nrm_rank` (optional but cheap)

Training (3 total)
- Train AlphaZero at k = 1, 5, 10 (use `tools/train_alpha_zero_k_sweep.py`)

Optional eval-only sensitivity (no retraining)
- Fix a single checkpoint and sweep `training.computation_budget` (e.g. 25/50/100/200) to report acceptance vs p95 latency.
