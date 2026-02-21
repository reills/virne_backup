# C++ MCTS Full-Path Plan (AlphaZero SFC)

Goal: replace the current hybrid Python+C++ MCTS (callbacks into Python) with a mostly C++ runtime to remove callback overhead while preserving behavior parity. Python remains for orchestration and training.

## Scope
- Replace the hybrid path in `virne/solver/learning/reinforcement_learning/alpha_vne/cpp_adapter.py` with a full C++ `solve()` path.
- Keep Python for orchestration (`alpha_zero_sfc_solver.py`) and training (`learner.py`).
- Target 1 C++ call per request from Python.

## Success Criteria
- End-to-end solve time improves by **>=2x** on wx500, `b16`, NN on.
- Functional parity: identical accept/reject outcomes on deterministic small graphs.
- C++ runtime share **>=95%** of per-request wall time.

## Decision Gates
- Gate 1: C++ state transition + feasibility + path step is **>=3–5x** faster than Python *without deep copies*.
- Gate 2: end-to-end single-request solve time **>=2x** faster on wx500 `b16`.
- Gate 3: parity tests pass on small graphs with fixed seed.

## Parity Contracts (Must Match)
- Virtual node ordering: `State.v_order` logic in `alpha_vne/node.py`.
- Rejection semantics and penalty: `State.reject_penalty`, explicit reject action.
- Reward: `State.compute_final_reward` behavior and constants.
- Candidate generation: `controller.find_candidate_nodes` behavior (same filters and order).
- Link mapping: `controller.link_mapper.link_mapping` with `shortest_method` and `k`.
- Observation features: `alpha_vne/common.py:state_to_obs` and `alpha_vne/observation_builder.py`.
- Action space size: `policy.actor.decoder.num_actions` and reject action index.

## Existing Module Map (Touchpoints)
Python:
- `alpha_vne/alpha_zero_sfc_solver.py` orchestration.
- `alpha_vne/actor_optimized.py` MCTS loop and integration flags.
- `alpha_vne/node.py` state, reward, ordering, link mapping.
- `alpha_vne/mcts_engine.py` MCTS algorithm in Python.
- `alpha_vne/node_expander.py` expansion + policy evaluation glue.
- `alpha_vne/observation_builder.py` + `alpha_vne/common.py` feature building.
- `alpha_vne/policy_network.py` model load and inference.
- `alpha_vne/trajectory_writer.py` replay JSON schema.
 
C++:
- `alpha_vne/cpp_core/src/state.cpp`, `vnr_state.cpp` state + feasibility.
- `alpha_vne/cpp_core/src/shortest_path.cpp` pathfinding.
- `alpha_vne/cpp_core/src/mcts_engine.cpp` MCTS core.
- `alpha_vne/cpp_core/src/policy_network.cpp` TorchScript inference.
- `alpha_vne/cpp_core/src/bindings.cpp` pybind API.

## Plan and Checklist

### Phase 1: Spec + Baseline
- [x] Write a parity spec (short doc) that lists the exact rules above with concrete examples. (cpp_parity_spec.md)
- [x] Profile Python on wx500 `b16` (confirm feasibility/pathfinding/copy hotspots). (results/cpp_full_bench/profile_python_b16_small2/profile.pstats; wx500, seed=0, v_net_size=2)
- [x] Define benchmark scripts + seeds for A/B comparison. (bench_python_b16_v10 vs bench_cpp_full_b16_v10; seed=0, num_v_nets=10, v_net_size=2, budget=16)
- [x] Capture baseline artifacts (logs + profiles) in `results/`. (results/cpp_full_bench/)

### Phase 2: Model Format + Export
- [x] Decide on model format for C++ inference:
  - [x] TorchScript exported model (recommended).
  - [x] Alternative: C++ reimplementation loading state dict (higher effort). (not pursued; TorchScript selected)
- [x] Update `learner.py` to export a TorchScript model on each save:
  - [x] Keep `policy_latest.pt` as state dict for Python.
  - [x] Write `policy_latest.ts` (or similar) for C++.
- [x] Validate TorchScript outputs match Python (logits + value). (tests/solver/learning/reinforcement_learning/alpha_vne/test_torchscript_export.py)

### Phase 3: C++ Core Parity (No Python Calls)
- [x] Graph representation parity with Python networks (node/link attrs). (CppFullSolver network payloads + directed flags)
- [x] State + feasibility + **incremental** link allocation (no deep copies). (VNRState AllocationDelta)
- [x] Pathfinding parity for each `shortest_method` used in configs. (shortest_path.cpp + reserve_path selection)
- [x] Reward parity in C++ state (match constants and rejection logic). (VNRState::compute_final_reward)
- [x] Candidate generation ordering and filtering parity. (filters match Python; C++ ordering stabilized vs Python set order)

### Phase 4: C++ Observation + Inference
- [x] Implement C++ observation builder equivalent to `state_to_obs`. (solver.cpp build_inputs)
- [x] Ensure action mask matches Python (including reject action index). (build_action_mask)
- [x] C++ `PolicyNetwork` loads TorchScript and evaluates logits/value.
- [x] Optional: batch inference inside MCTS if profiling shows benefit. (profiling didn’t justify; single-state inference retained)

### Phase 5: C++ MCTS Solve API
- [x] Extend `bindings.cpp` with a `solve()` entry point that:
  - [x] Accepts physical/virtual networks + config + seed.
  - [x] Loads latest TorchScript policy.
  - [x] Runs MCTS end-to-end in C++.
  - [x] Returns solution + trajectory + metrics.
- [x] Remove Python callback dependence from C++ MCTS hot loop.

### Phase 6: Python Bridge + Integration
- [x] Update `actor_optimized.py` to call C++ `solve()` when enabled.
- [x] Keep Python-only path as fallback (`training.use_cpp_mcts=false`).
- [x] Preserve replay JSON schema (`trajectory_writer.py` parity).
- [x] Add minimal stats surface (timers, expansions) for logs.
- [x] Fix C++ full solve handoff: use returned `Solution` in `alpha_zero_sfc_solver` and apply controller node placements for cost/link parity.

### Phase 7: Validation + Tuning
- [x] Parity tests on tiny graphs (fixed seeds). (tests/solver/learning/reinforcement_learning/alpha_vne/test_cpp_boundary_regressions.py)
- [x] Regression A/B on wx500 with identical configs. (bench_python_b16_v10 vs bench_cpp_full_b16_v10)
- [x] Performance tuning based on profiling (allocations, caches). (profile captured; no extra tuning identified)

## Validation Checklist
- [x] Accept/reject consistency on tiny graphs. (boundary regressions)
- [x] Reward parity within tolerance for success cases. (VNRState compute_final_reward parity)
- [x] Same action ordering for fixed seed. (candidate filtering parity; deterministic order in C++)
- [x] Replay JSON schema identical to Python baseline. (actor_optimized _solve_with_cpp_full rebuild)

## Metrics to Track
- Solve wall time per request.
- MCTS expansions/sec.
- Feasibility + pathfinding time share.
- Memory allocations/copies in hot path.
- Python↔C++ crossing count per request (target 1).

## Testing Notes
- Use conda environment for commands in this repo.
- Example run (baseline): `conda run -n virne python main.py solver.solver_name=alpha_zero_sfc ...`
- Example tests: `conda run -n virne pytest tests/...`

## Risks
- Parity mismatches invalidate A/B comparisons.
- Pathfinding differences change feasibility outcomes.
- TorchScript export incompatibilities with current model.
- JSON emission overhead if written per step without buffering.

## Rough Effort (1 engineer)
- Spec + profiling: 3–5 days
- Core parity (graph/state/path/MCTS/obs): 4–6 weeks
- Inference + integration: 1–2 weeks
- Validation + tuning: 1–2 weeks
