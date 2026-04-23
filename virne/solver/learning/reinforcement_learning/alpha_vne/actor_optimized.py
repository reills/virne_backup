"""
Optimized Actor with Batched GPU Inference
==========================================

This is a drop-in replacement for actor.py that uses batched GPU evaluation
for massive MCTS speedup.

Key optimizations:
1. Batched GPU worker for NN evaluations  
2. Reduced computation budget
3. Optional trajectory writing disable
4. Memory-efficient observation caching
"""
from __future__ import annotations

import math
import os
import time
from typing import List

import numpy as np
import torch

from virne.core import Solution
from virne.solver.base_solver import Solver
from .node import Node, State
from .cpp_adapter import create_cpp_adapter, create_cpp_full_solver
from .trajectory_writer import TrajectoryWriter
from .observation_builder import ObservationBuilder
from .policy_network import PolicyNetwork
from .node_expander import NodeExpander
from .mcts_engine import MCTSEngine
from .utils import build_model_config
from .value_target import build_value_target_builder


class OptimizedAlphaZeroActor(Solver):
    """
    Optimized Actor with batched GPU inference for MCTS.
    
    Key improvements over original Actor:
    - Uses batched GPU worker for ~10x NN speedup
    - Optional trajectory writing disable for training speed
    - Memory-efficient observation preparation
    - Configurable MCTS budget for speed/quality tradeoff
    """

    def __init__(self, controller, recorder, counter, logger, config,
                 replay_dir: str = "replay_buffer", models_dir: str = None, 
                 use_batched_gpu: bool = True, 
                 disable_trajectory_writing: bool = False,
                 **kwargs):
        super().__init__(controller, recorder, counter, logger, config, **kwargs)
        self.replay_dir = replay_dir
        self.disable_trajectory_writing = disable_trajectory_writing
        self.force_root_noise_all_modes = str(
            os.environ.get("AZSFC_FORCE_ROOT_NOISE_ALWAYS", "0")
        ).strip().lower() in {"1", "true", "yes", "on"}

        # Policy path should be in models directory, not replay buffer
        if models_dir:
            self.policy_path = os.path.join(models_dir, "policy_latest.pt")
        else:
            self.policy_path = os.path.join(self.replay_dir, "policy_latest.pt")

        os.makedirs(self.replay_dir, exist_ok=True)
        if models_dir:
            os.makedirs(models_dir, exist_ok=True)

        if self.force_root_noise_all_modes:
            self.logger.info(
                "Forcing root Dirichlet noise in all actor modes via "
                "AZSFC_FORCE_ROOT_NOISE_ALWAYS."
            )

        # Initialize trajectory writer
        self.trajectory_writer = TrajectoryWriter(
            config=config,
            replay_dir=replay_dir,
            policy_path=self.policy_path,
            disable_trajectory_writing=disable_trajectory_writing
        )

        # Initialize observation builder (always use CPU for IPC safety)
        self.obs_builder = ObservationBuilder(
            controller=controller,
            config=config,
            device=torch.device("cpu")
        )

        # MCTS configuration parameters from config
        self.computation_budget = getattr(config.training, 'computation_budget', 5)  # Reduced default
        self.c_puct = getattr(config.training, 'c_puct', 1.0)

        # Dirichlet noise for root exploration (AlphaZero style)
        self.dirichlet_epsilon = getattr(config.training, 'dirichlet_epsilon', 0.25)
        self.dirichlet_alpha = getattr(config.training, 'dirichlet_alpha', 0.1)
        self.top_k_candidates = int(getattr(config.training, 'top_k_candidates', 0))

        # Temperature schedule for MCTS action selection.
        # Keep legacy temperature_train/temperature_eval fields for compatibility.
        legacy_train_temp = float(getattr(config.training, 'temperature_train', 1.0))
        self.temperature_eval = float(getattr(config.training, 'temperature_eval', 0.0))
        self.temperature_start = float(getattr(config.training, 'temperature_start', legacy_train_temp))
        self.temperature_end = float(getattr(config.training, 'temperature_end', 0.5))
        self.temperature_anneal_steps = int(getattr(config.training, 'temperature_anneal_steps', 0))
        self.temperature_move_threshold = int(getattr(config.training, 'temperature_move_threshold', -1))
        self.temperature_after_threshold = float(
            getattr(config.training, 'temperature_after_threshold', self.temperature_end)
        )
        self.replay_policy_temperature = float(getattr(config.training, 'replay_policy_temperature', 1.0))
        self._temperature_step = 0
        self.temperature_train = self.temperature_start

        self.value_target_mode = str(getattr(config.training, "value_target_mode", "tanh")).lower()
        self.value_target_builder = build_value_target_builder(self.value_target_mode, config.training)

        # Link mapping parameters (inherited from MctsSolver)
        self.shortest_method = kwargs.get('shortest_method', 'bfs_shortest')
        self.k_shortest = kwargs.get('k_shortest', 10)

        use_cuda_cfg = bool(getattr(config.training, "use_cuda", True))
        self.device = torch.device(
            "cuda" if (use_cuda_cfg and torch.cuda.is_available()) else "cpu"
        )
        # Ablation and instrumentation flags
        self.use_nn_policy = getattr(config.training, 'use_nn_policy', True)
        self.use_nn_value = getattr(config.training, 'use_nn_value', True)
        self.uniform_prior = getattr(config.training, 'uniform_prior', False)

        # Plain MCTS mode (vanilla MCTS without neural network)
        self.use_neural_network = getattr(config.training, 'use_neural_network', True)
        self.rollout_depth_limit = getattr(config.training, 'rollout_depth_limit', 100)

        # Setup GPU evaluation
        model_config = build_model_config(config)

        # Initialize PolicyNetwork wrapper
        self.policy_network = PolicyNetwork(
            model_config=model_config,
            policy_path=self.policy_path,
            device=self.device,
            use_batched_gpu=use_batched_gpu,
            batch_size=getattr(config.training, 'gpu_batch_size', 32),
            gpu_timeout_ms=getattr(config.training, 'gpu_timeout_ms', 10),
            logger=self.logger
        )

        # Load model weights
        alphazero_model_path = getattr(config.training, 'alphazero_model_path', '')
        resume_training = getattr(config.training, 'resume_training', True)
        self.policy_network.load_weights(alphazero_model_path, resume_training)

        # Backward compatibility: expose model and gpu_manager
        self.policy = self.policy_network.model
        self.gpu_manager = self.policy_network.gpu_manager
        self.use_batched_gpu = self.policy_network.use_batched_gpu

        # Initialize NodeExpander
        self.node_expander = NodeExpander(
            policy_network=self.policy_network,
            observation_builder=self.obs_builder,
            controller=self.controller,
            dirichlet_alpha=self.dirichlet_alpha,
            dirichlet_epsilon=self.dirichlet_epsilon,
            use_nn_policy=self.use_nn_policy,
            use_nn_value=self.use_nn_value,
            uniform_prior=self.uniform_prior,
            logger=self.logger
        )

        # Initialize MCTSEngine
        value_norm = "tanh"
        value_scale = 1000.0
        try:
            cfg_obj = getattr(config, "training", None)
            if isinstance(cfg_obj, dict):
                value_norm = cfg_obj.get("value_normalization", value_norm)
                value_scale = float(cfg_obj.get("value_scale", value_scale))
            elif cfg_obj is not None:
                value_norm = getattr(cfg_obj, "value_normalization", value_norm)
                value_scale = float(getattr(cfg_obj, "value_scale", value_scale))
        except Exception:
            pass
        self.mcts_engine = MCTSEngine(
            node_expander=self.node_expander,
            computation_budget=self.computation_budget,
            c_puct=self.c_puct,
            logger=self.logger,
            value_normalization=value_norm,
            value_scale=value_scale,
            reject_value=float(getattr(config.training, "value_target_reject", -1.0)),
            accept_value_min=float(getattr(config.training, "value_target_accept_min", 0.2)),
            accept_value_max=float(getattr(config.training, "value_target_accept_max", 1.0)),
        )

        # Timing sync flag (for accurate GPU timings in benchmarks)
        self._sync_cuda_timing = False
        try:
            if bool(getattr(config.experiment, 'gpu_synchronize_timing', True)):
                self._sync_cuda_timing = bool(getattr(config.training, 'use_cuda', False))
        except Exception:
            self._sync_cuda_timing = False
        self.node_expander.sync_cuda_timing = bool(self._sync_cuda_timing)

        # Caches used during one solve episode
        self._p_data = None
        self._v_data = None
        self._encoder_outputs = None

        # Diagnostics accumulators
        self._calib_n = 0
        self._calib_sum_pred = 0.0
        self._calib_sum_true = 0.0
        self._calib_sum_pred2 = 0.0
        self._calib_sum_true2 = 0.0
        self._calib_sum_prod = 0.0
        self._episode_rejects = 0
        self._last_cuda_log_ts = 0.0

        self.cpp_adapter = None
        self.cpp_full_solver = None
        training_cfg = getattr(config, "training", None)
        use_cpp_flag = False
        self.pure_cpp = False
        if training_cfg is not None:
            if isinstance(training_cfg, dict):
                use_cpp_flag = bool(training_cfg.get("use_cpp_mcts", False))
                self.pure_cpp = bool(training_cfg.get("pure_cpp", False))
            else:
                use_cpp_flag = bool(getattr(training_cfg, "use_cpp_mcts", False))
                self.pure_cpp = bool(getattr(training_cfg, "pure_cpp", False))

        if use_cpp_flag:
            try:
                self.cpp_full_solver = create_cpp_full_solver(self, self.computation_budget)
                if self.cpp_full_solver is not None:
                    self.logger.info("🧠 Using full C++ solve backend.")
            except Exception as exc:
                if self.pure_cpp:
                    raise RuntimeError(
                        "training.pure_cpp=true requires the full C++ solve backend, but initialization failed."
                    ) from exc
                self.logger.warning(f"C++ full solve backend unavailable: {exc}")

        if use_cpp_flag and self.cpp_full_solver is None:
            if self.pure_cpp:
                raise RuntimeError(
                    "training.pure_cpp=true requires the full C++ solve backend, "
                    "but it is unavailable in this environment."
                )
            try:
                self.cpp_adapter = create_cpp_adapter(self, self.computation_budget)
                if self.cpp_adapter is not None:
                    self.logger.info("🧠 Using hybrid C++ MCTS backend.")
                else:
                    self.logger.warning(
                        "C++ MCTS backend requested but the alpha_zero_cpp_core extension is not available. "
                        "Build it under virne/solver/learning/reinforcement_learning/alpha_vne/cpp_core "
                        "or set training.use_cpp_mcts=false to use the Python implementation."
                    )
            except Exception as exc:
                self.logger.warning(
                    "Failed to initialize C++ MCTS backend despite training.use_cpp_mcts=true. "
                    f"Reason: {exc}"
                )


    # ------------------------------------------------------------------
    def solve(self, instance, training: bool = None):
        """Run MCTS guided by the current policy and store the episode.

        Args:
            instance: Problem instance with v_net and p_net
            training: If True, use training temperature (exploration); if False, use eval temperature (greedy).
                     If None, infer from disable_trajectory_writing (False=train, True=eval)
        """
        v_net, p_net = instance["v_net"], instance["p_net"]

        if getattr(self, "cpp_full_solver", None) is not None:
            try:
                return self._solve_with_cpp_full(instance, training)
            except Exception as exc:
                if self.pure_cpp:
                    raise RuntimeError(
                        "C++ full solve failed while training.pure_cpp=true; refusing Python fallback."
                    ) from exc
                self.logger.warning(f"C++ full solve failed, falling back to Python: {exc}")

        solve_start = time.perf_counter()
        timers = {
            "encode_ms": 0.0,
            "build_inputs_ms": 0.0,
            "policy_eval_ms": 0.0,
            "candidate_ms": 0.0,
            "mcts_ms": 0.0,
            "postprocess_ms": 0.0,
            "link_ms": 0.0,
            "traj_ms": 0.0,
            "total_simulations": 0,
        }
        self.node_expander.set_timers(timers)

        self.obs_builder.set_episode_data(p_net, v_net)
        if self.cpp_adapter is not None:
            self.cpp_adapter.begin_request(p_net, v_net)

        # Determine temperature based on mode
        if training is None:
            training = not self.disable_trajectory_writing  # If writing trajectories, we're training
        temperature = self.get_action_selection_temperature(training)

        # Create static environment data (only needed when training and writing trajectories)
        write_trajectory = training and not self.disable_trajectory_writing
        if write_trajectory:
            self._log_active_temperature(temperature)
        static_environment = self._create_static_environment(p_net, v_net) if write_trajectory else None

        current_node = Node(
            None,
            State(
                p_net,
                v_net,
                self.controller,
                self.recorder,
                self.counter,
                link_params={
                    'shortest_method': self.shortest_method,
                    'k': self.k_shortest,
                },
            ),
        )
        solution = Solution.from_v_net(v_net)
        trajectory: List[dict] = [] if write_trajectory else None
        allow_rejection = getattr(self.policy.actor.decoder, 'allow_rejection', False)

        for v_node_idx in range(v_net.num_nodes):
            # Run MCTS search to update current_node's children with visit statistics
            # Pass actual virtual node id for current position
            next_pos = current_node.state.v_node_id + 1
            curr_v_id = current_node.state.v_order[next_pos]
            t_mcts = time.perf_counter()
            self.search(
                current_node,
                curr_v_id,
                add_root_noise=(training or self.force_root_noise_all_modes),
            )
            timers["mcts_ms"] += (time.perf_counter() - t_mcts) * 1000.0
            try:
                timers["total_simulations"] += sum(child.visit_times for child in current_node.children)
            except Exception:
                pass
            # Log prior quality at root (feasible entropy and top5) + postprocess timing
            post_start = time.perf_counter()
            try:
                self._log_root_prior_stats(current_node, current_node.state, curr_v_id)

                # Periodic CUDA mem log
                try:
                    now = time.time()
                    if self.device.type == 'cuda' and now - self._last_cuda_log_ts > 10.0:
                        mem_alloc = torch.cuda.memory_allocated(self.device)
                        mem_res = torch.cuda.memory_reserved(self.device)
                        self.logger.info(f"Actor CUDA memory: alloc={mem_alloc/1e6:.1f}MB reserved={mem_res/1e6:.1f}MB")
                        self._last_cuda_log_ts = now
                except Exception:
                    pass

                # Select the best child based on visit counts with appropriate temperature
                try:
                    best_child = self._select_best_child(
                        current_node,
                        temperature=self.get_action_selection_temperature(training, move_index=v_node_idx),
                    )
                except ValueError as exc:
                    solution["place_result"] = False
                    self.logger.warning(
                        f"MCTS search produced zero-visit children for v_node={curr_v_id} "
                        f"(step={current_node.state.v_node_id + 1}): {exc}"
                    )
                    break
                if best_child is None:
                    solution["place_result"] = False
                    self.logger.warning(
                        f"MCTS failed to select child for v_node={curr_v_id} "
                        f"(step={current_node.state.v_node_id + 1})"
                    )
                    break

                # Handle REJECT action (always at index p_net.num_nodes)
                reject_idx = self._state_num_nodes(current_node.state)
                if allow_rejection and best_child.state.p_node_id == reject_idx:
                    solution["place_result"] = False
                    solution["rejected"] = True
                    current_node = best_child  # advance to terminal rejected state for reward consistency
                    break
                # Guard against invalid action (-1 or out of range). This can happen when a child
                # has been marked terminal-bad by incremental feasibility checks.
                if best_child.state.p_node_id < 0 or best_child.state.p_node_id >= reject_idx:
                    solution["place_result"] = False
                    self.logger.warning(
                        f"Selected child with invalid p_node_id={best_child.state.p_node_id} "
                        f"(reject_idx={reject_idx}) for v_node={curr_v_id}"
                    )
                    self._log_root_diagnostics(current_node, current_node.state, curr_v_id, best_child)
                    break

                # Store the action taken using stable ordering
                placed_v = curr_v_id
                solution["node_slots"].update({placed_v: best_child.state.p_node_id})

                # Create timestep data using the current root (before moving to child)
                if write_trajectory:
                    t_traj = time.perf_counter()
                    timestep_data = self._create_timestep_data(current_node, curr_v_id, best_child.state.p_node_id)
                    timers["traj_ms"] += (time.perf_counter() - t_traj) * 1000.0
                    trajectory.append(timestep_data)

                # Promote the best child as the new root for next iteration
                # Detach from parent to avoid memory buildup
                best_child.parent = None
                current_node = best_child
            finally:
                timers["postprocess_ms"] += (time.perf_counter() - post_start) * 1000.0

        if solution.get("place_result", True) and not solution.get("rejected", False):
            t_link = time.perf_counter()
            link_ok = self.controller.link_mapper.link_mapping(
                v_net, p_net, solution=solution,
                shortest_method=self.shortest_method, k=self.k_shortest, inplace=True)
            if not link_ok:
                solution["route_result"] = False
            timers["link_ms"] += (time.perf_counter() - t_link) * 1000.0
        # Set final result flag for accurate reward accounting
        solution["result"] = bool(solution.get("place_result", False) and solution.get("route_result", False)) and not solution.get("rejected", False)

        # Store episode only if enabled
        if write_trajectory:
            episode_metrics = self._build_episode_metrics(solution, v_net, p_net)
            t_store = time.perf_counter()
            self._store_episode_new_format(
                static_environment,
                trajectory,
                episode_metrics["final_reward_raw"],
                episode_metrics=episode_metrics,
            )
            timers["traj_ms"] += (time.perf_counter() - t_store) * 1000.0

        if self.logger is not None:
            try:
                steps = len(solution.get("node_slots", {})) if isinstance(solution, dict) else len(solution["node_slots"])
            except Exception:
                steps = 0
            total_ms = (time.perf_counter() - solve_start) * 1000.0
            self.logger.info(
                "Python solve metrics: steps=%s sims=%s total_time_ms=%.2f "
                "encode_ms=%.2f build_inputs_ms=%.2f policy_eval_ms=%.2f candidate_ms=%.2f "
                "mcts_ms=%.2f postprocess_ms=%.2f link_ms=%.2f traj_ms=%.2f",
                steps,
                int(timers.get("total_simulations", 0)),
                total_ms,
                float(timers.get("encode_ms", 0.0)),
                float(timers.get("build_inputs_ms", 0.0)),
                float(timers.get("policy_eval_ms", 0.0)),
                float(timers.get("candidate_ms", 0.0)),
                float(timers.get("mcts_ms", 0.0)),
                float(timers.get("postprocess_ms", 0.0)),
                float(timers.get("link_ms", 0.0)),
                float(timers.get("traj_ms", 0.0)),
            )
            
        self._advance_temperature_schedule(training)
        return solution

    # ------------------------------------------------------------------
    # AlphaZero MCTS Implementation (Optimized)
    # ------------------------------------------------------------------
    
    def search(self, root_node: Node, v_node_id: int, add_root_noise: bool = True) -> None:
        """Dispatch to C++ engine when available, otherwise use Python MCTSEngine."""
        if getattr(self, "cpp_adapter", None) is not None:
            try:
                result = self.cpp_adapter.run_search(root_node, v_node_id, add_root_noise=add_root_noise)
                if result is not None:
                    root_node._cpp_search_pending_advance = True
                    return
            except Exception as exc:
                self.logger.warning(f"C++ MCTS search failed, falling back to Python: {exc}")
        # Delegate to MCTSEngine
        self.mcts_engine.search(root_node, v_node_id, add_root_dirichlet_noise=add_root_noise)

    def get_action_selection_temperature(self, training: bool, move_index: int | None = None) -> float:
        """Return action-selection temperature for current episode."""
        if not training:
            return float(self.temperature_eval)
        if self.temperature_anneal_steps <= 0:
            base_temperature = float(self.temperature_start)
        else:
            frac = min(1.0, float(self._temperature_step) / float(self.temperature_anneal_steps))
            base_temperature = float(self.temperature_start + frac * (self.temperature_end - self.temperature_start))
        if move_index is not None and self.temperature_move_threshold >= 0 and move_index >= self.temperature_move_threshold:
            return float(self.temperature_after_threshold)
        return base_temperature

    def _advance_temperature_schedule(self, training: bool) -> None:
        """Advance annealing progress after each completed training episode."""
        if not training or self.temperature_anneal_steps <= 0:
            return
        self._temperature_step = min(self._temperature_step + 1, self.temperature_anneal_steps)

    def _log_active_temperature(self, temperature: float) -> None:
        """Emit the active actor temperature used for data generation."""
        if self.logger is None:
            return
        try:
            self.logger.info(
                "Actor data-generation temperature: step=%s/%s value=%.6f",
                int(self._temperature_step),
                int(max(self.temperature_anneal_steps, 0)),
                float(temperature),
            )
        except Exception:
            pass

    def _select_best_child(self, node: Node, temperature: float = 1.0) -> Node:
        """Select best child with guardrails for invalid zero-visit states."""
        num_nodes = self._state_num_nodes(node.state)
        allow_rejection = bool(getattr(node.state, 'allow_rejection', False))
        selectable_children = [
            child for child in node.children
            if (0 <= child.state.p_node_id < num_nodes)
            or (allow_rejection and child.state.p_node_id == num_nodes)
            or child.state.p_node_id == -1
        ]
        if not selectable_children:
            return None

        visit_counts = [child.visit_times for child in selectable_children]
        if visit_counts and all(count == 0 for count in visit_counts):
            msg = (
                f"All children have zero visits at step={node.state.v_node_id + 1} "
                f"(num_children={len(selectable_children)})"
            )
            logger = getattr(self, "logger", None)
            if logger is not None:
                logger.error(msg)
            raise ValueError(msg)

        best = self.mcts_engine.select_best_child(node, temperature)
        if best is None:
            return None
        if bool(getattr(node, "_cpp_search_pending_advance", False)) and getattr(self, "cpp_adapter", None) is not None:
            try:
                self.cpp_adapter.advance_root(int(best.state.p_node_id))
            except Exception:
                # Best-effort: keep Python path running even if adapter state drifts.
                pass
            node._cpp_search_pending_advance = False
        return best

    def get_num_actions(self) -> int:
        """Get the number of actions in the action space (for cpp_adapter).

        Returns:
            Number of actions (physical nodes + optional reject action)
        """
        num_actions = getattr(self.policy.actor.decoder, 'num_actions', None)
        if num_actions is not None:
            return num_actions

        num_nodes = int(getattr(self.config.simulation, 'p_net_setting_num_nodes', 0))
        allow_rejection = getattr(self.policy.actor.decoder, 'allow_rejection', False)
        if num_nodes > 0:
            return num_nodes + (1 if allow_rejection else 0)

        return 0

    def _log_root_diagnostics(self, root: Node, state: State, v_node_id: int, chosen_child: Node):
        """Log candidate and search diagnostics at the root."""
        try:
            # Candidate diagnostics
            v_target = v_node_id
            candidates = self.controller.find_candidate_nodes(
                v_net=state.v_net, p_net=state.p_net, v_node_id=v_target, filter=state.selected_p_net_nodes)
            already_taken = 0
            cpu_violation = 0
            total_nodes = state.p_net.num_nodes
            node_resource_names = [attr.name for attr in self.controller.node_resource_attrs]
            reqs = {name: state.v_net.nodes[v_target].get(name, 0.0) for name in node_resource_names}
            for p in range(total_nodes):
                if p in state.selected_p_net_nodes:
                    already_taken += 1
                    continue
                for name in node_resource_names:
                    avail = state.p_net.nodes[p].get(name, 0.0)
                    if avail < reqs[name]:
                        cpu_violation += 1
                        break
            # Search diagnostics
            branching = len(root.children)
            eff = getattr(root, '_diag_effective_sims', 0)
            # Root entropy and KL between root visits and NN priors
            visits = np.array([child.visit_times for child in root.children], dtype=np.float64)
            pi = visits / max(visits.sum(), 1.0)
            if hasattr(root, '_diag_root_priors') and root._diag_root_priors:
                q = np.array(root._diag_root_priors, dtype=np.float64)
                # Keep only up to children count
                m = min(len(pi), len(q))
                pi_s = pi[:m]
                q_s = q[:m]
                # Sanitize: clamp to [0,1], renormalize; if degenerate, fallback to uniform
                q_s = np.where(np.isfinite(q_s) & (q_s > 0.0), q_s, 0.0)
                if q_s.sum() <= 1e-12:
                    q_s = np.ones_like(q_s) / max(len(q_s), 1)
                else:
                    q_s = q_s / q_s.sum()
                pi_s = np.where(np.isfinite(pi_s) & (pi_s >= 0.0), pi_s, 0.0)
                if pi_s.sum() <= 1e-12:
                    pi_s = np.ones_like(pi_s) / max(len(pi_s), 1)
                else:
                    pi_s = pi_s / pi_s.sum()
                eps = 1e-8
                kl = float((pi_s * (np.log(pi_s + eps) - np.log(q_s + eps))).sum())
                entropy = float(-(q_s * np.log(q_s + eps)).sum())
            else:
                # Fallback diagnostics when priors unavailable
                m = max(len(pi), 1)
                pi_s = pi[:m]
                pi_s = np.where(np.isfinite(pi_s) & (pi_s >= 0.0), pi_s, 0.0)
                if pi_s.sum() <= 1e-12:
                    pi_s = np.ones_like(pi_s) / m
                else:
                    pi_s = pi_s / pi_s.sum()
                entropy = float(-(pi_s * np.log(pi_s + 1e-8)).sum())
                kl = float('nan')
            # Q vs U for chosen action at root
            N = sum(child.visit_times for child in root.children)
            sqrtN = math.sqrt(N + 1)
            q_ch = float('nan')
            u_ch = 0.0
            if chosen_child is not None:
                if chosen_child.visit_times > 0:
                    q_ch = (chosen_child.value / chosen_child.visit_times)
                u_ch = self.c_puct * chosen_child.prior * sqrtN / (1 + chosen_child.visit_times)
            self.logger.debug(
                f"Diag VNF[{v_target}] cand={len(candidates)} taken={already_taken} cpu_violate={cpu_violation} | "
                f"branch={branching} eff_sims={eff} | H(root)={entropy:.3f} KL(pi||logit)={kl:.3f} | Q={q_ch:.3f} U={u_ch:.3f}")
        except Exception as e:
            self.logger.debug(f"Diagnostics logging skipped: {e}")

    def _log_root_prior_stats(self, root: Node, state: State, v_node_id: int):
        """Log entropy of NN prior over feasible actions, H/H*, top-5, and Spearman corr with visits."""
        # This is diagnostics only. It must not trigger expensive candidate-state materialization,
        # especially on large p_nets (e.g. wx500), where `State.get_candidate_states()` can run
        # incremental k-shortest feasibility checks for every candidate.
        try:
            import logging
            logger = getattr(self, "logger", None) or logging.getLogger(__name__)
            if not getattr(logger, "isEnabledFor", lambda lvl: False)(logging.DEBUG):
                return
        except Exception:
            # If we cannot reliably detect the log level, default to skipping diagnostics.
            return

        try:
            # Cheap feasibility proxy: node-capacity-only candidates (no link checks).
            feas_ids = self._candidate_actions(state, v_node_id)
            num_feasible = len(feas_ids)

            priors = getattr(root, "_diag_root_priors", None)
            action_ids = getattr(root, "_diag_root_action_ids", None)
            if not priors or not action_ids or num_feasible == 0:
                logger.debug(
                    f"PriorStats VNF[{v_node_id}] feasible={num_feasible} "
                    f"H(prior)=nan H*={np.log(max(num_feasible,1)):.3f} ratio=nan top5=[] spearman=nan"
                )
                return

            # Align priors with action ids and keep only physical-node actions.
            q_full = np.array(priors, dtype=np.float64)
            a_full = np.array(action_ids, dtype=np.int64)
            mask_phys = (a_full >= 0) & (a_full < self._state_num_nodes(state))
            q = q_full[mask_phys]
            a = a_full[mask_phys]
            if q.size == 0:
                logger.debug(
                    f"PriorStats VNF[{v_node_id}] feasible={num_feasible} "
                    f"H(prior)=nan H*={np.log(max(num_feasible,1)):.3f} ratio=nan top5=[] spearman=nan"
                )
                return
            q = q / max(q.sum(), 1e-8)
            eps = 1e-8
            H = float(-(q * np.log(q + eps)).sum())
            H_star = float(np.log(max(num_feasible, 1)))
            ratio = H / H_star if H_star > 0 else float('nan')
            order = np.argsort(-q)[:5]
            top5 = [(int(a[i]), float(q[i])) for i in order]

            # Spearman correlation between prior probs and child visit counts (after search).
            # Only uses reconstructed children (usually visited actions), so treat as indicative.
            try:
                child_visits = {int(child.state.p_node_id): float(child.visit_times) for child in root.children}
                visits = np.array([child_visits.get(int(act), 0.0) for act in a.tolist()], dtype=np.float64)
                if visits.sum() > 0 and visits.size == q.size:
                    # rank transform
                    def rankdata(a):
                        # average ranks for ties
                        temp = a.argsort()
                        ranks = np.empty_like(temp, dtype=np.float64)
                        ranks[temp] = np.arange(len(a))
                        # handle ties
                        _, inv, counts = np.unique(a, return_inverse=True, return_counts=True)
                        sums = np.bincount(inv, ranks)
                        avg = sums / counts
                        return avg[inv]
                    r_q = rankdata(q)
                    r_v = rankdata(visits)
                    r_q = (r_q - r_q.mean()) / (r_q.std() + 1e-8)
                    r_v = (r_v - r_v.mean()) / (r_v.std() + 1e-8)
                    spearman = float((r_q * r_v).mean())
                else:
                    spearman = float('nan')
            except Exception:
                spearman = float('nan')
            logger.debug(
                f"PriorStats VNF[{v_node_id}] feasible={num_feasible} "
                f"H(prior)={H:.3f} H*={H_star:.3f} ratio={ratio:.3f} top5={top5} spearman={spearman:.3f}"
            )
        except Exception as e:
            try:
                logger.debug(f"PriorStats logging skipped: {e}")
            except Exception:
                pass

    # ------------------------------------------------------------------
    def _state_to_obs(self, state: State, v_node_id: int = None) -> dict:
        """Convert state to observation for NN evaluation.

        Note: Returns observation with CPU tensors for pickle-safe IPC with batched GPU worker.
        The GPU worker will handle moving tensors to device internally.
        """
        cpp_state = getattr(state, "_cpp_state", None)
        if cpp_state is not None and self.cpp_adapter is not None:
            try:
                return self.cpp_adapter.build_obs_from_cpp_state(cpp_state)
            except Exception:
                pass
        return self.obs_builder.build(state, self.policy, v_node_id)

    @staticmethod
    def _state_num_nodes(state: State) -> int:
        original = getattr(state, "_original_p_net", None)
        if original is not None:
            return int(getattr(original, "num_nodes", 0))
        return int(state.p_net.num_nodes)

    def _candidate_actions(self, state: State, v_node_id: int) -> List[int]:
        cpp_state = getattr(state, "_cpp_state", None)
        if cpp_state is not None:
            try:
                return [int(action) for action in cpp_state.get_candidate_nodes()]
            except Exception:
                pass
        if hasattr(state, "get_candidate_node_ids"):
            return state.get_candidate_node_ids(v_target=v_node_id)
        return self.controller.find_candidate_nodes(
            v_net=state.v_net,
            p_net=state.p_net,
            v_node_id=v_node_id,
            filter=state.selected_p_net_nodes,
            check_link_constraint=False,
        )

    # ------------------------------------------------------------------
    # Utility methods (same as original)
    # ------------------------------------------------------------------
    
    def _store_episode_new_format(
        self,
        static_environment: dict,
        trajectory: List[dict],
        final_reward: float,
        episode_metrics: dict | None = None,
    ) -> None:
        """Store episode in new efficient JSON format."""
        policy_state_dict = self.policy.state_dict() if self.policy is not None else None
        self.trajectory_writer.save_episode(
            static_environment=static_environment,
            trajectory=trajectory,
            final_reward=final_reward,
            policy_state_dict=policy_state_dict,
            episode_metrics=episode_metrics,
        )

    def _cleanup(self, keep: int = None) -> None:
        """Clean up old replay buffer files, keeping only the most recent ones."""
        self.trajectory_writer.cleanup(keep=keep)

    def _create_static_environment(self, p_net, v_net) -> dict:
        """Create static environment data containing unchanging network info."""
        # Same as original implementation
        physical_network = {
            "nodes": [
                {
                    "id": node_id,
                    "max_cpu": p_net.nodes[node_id].get("max_cpu", p_net.nodes[node_id].get("cpu", 0))
                }
                for node_id in p_net.nodes
            ],
            "links": [
                {
                    "source": u,
                    "target": v,
                    "max_bw": p_net.edges[u, v].get("max_bw", p_net.edges[u, v].get("bw", 0))
                }
                for u, v in p_net.edges
            ]
        }
        
        sfc_request = {
            "nodes": [
                {
                    "id": node_id,
                    "cpu_demand": v_net.nodes[node_id].get("cpu", 0)
                }
                for node_id in v_net.nodes
            ],
            "links": [
                {
                    "source": u,
                    "target": v,
                    "bw_demand": v_net.edges[u, v].get("bw", 0)
                }
                for u, v in v_net.edges
            ]
        }
        
        return {
            "physical_network": physical_network,
            "sfc_request": sfc_request
        }
    
    def _create_timestep_data(self, node: Node, v_node_id: int, action_taken: int) -> dict:
        """Create timestep data with full observation for learner consumption."""
        state = node.state

        # Get the exact observation dict used by the neural network
        obs = self._state_to_obs(state, v_node_id)

        # Convert PyG Data to CPU tensors for serialization
        obs_cpu = self._obs_to_cpu(obs)

        # Compute policy distribution over action space (only physical node placements)
        num_actions = self.policy.actor.decoder.num_actions
        policy = self._compute_policy_vector(node, num_actions)
        # Fallback if no visits (all zeros): use NN prior over feasible actions or uniform
        if sum(policy) == 0.0:
            try:
                priors = getattr(node, '_diag_root_priors', None)
                action_ids = getattr(node, '_diag_root_action_ids', None)
                if priors and action_ids:
                    # Map priors aligned to reconstructed action ids back into global action space.
                    pairs = list(zip(action_ids, priors))
                    pi = [0.0] * num_actions
                    s = sum(max(0.0, float(p)) for _, p in pairs)
                    if s <= 1e-8:
                        raise ValueError('empty priors')
                    for a, p in pairs:
                        a = int(a)
                        if 0 <= a < num_actions:
                            pi[a] = float(p) / s
                    policy = pi
                else:
                    raise ValueError('no priors')
            except Exception:
                # Uniform over feasible
                pi = [0.0] * num_actions
                cand_nodes = self._candidate_actions(state, v_node_id)
                reject_idx = self._state_num_nodes(state)
                allow_rejection = bool(getattr(state, "allow_rejection", False))
                if not cand_nodes:
                    # If REJECT action exists, put full prob on reject; else uniform over all actions
                    if allow_rejection and num_actions > reject_idx:
                        pi[reject_idx] = 1.0
                    else:
                        # Avoid all-zero vector: uniform over all actions
                        for a in range(num_actions):
                            pi[a] = 1.0 / max(1, num_actions)
                else:
                    s = float(len(cand_nodes))
                    for a in cand_nodes:
                        if 0 <= a < num_actions:
                            pi[a] = 1.0 / s
                policy = pi

        # Get value from root NN evaluation
        value_root = self._compute_value(node, v_node_id)

        # Action mask for loss masking (optional)
        candidate_nodes = self._candidate_actions(state, v_node_id)
        reject_idx = self._state_num_nodes(state)
        allow_rejection = bool(getattr(state, "allow_rejection", False))
        action_mask = [False] * num_actions
        for node_id in candidate_nodes:
            if 0 <= node_id < num_actions:
                action_mask[node_id] = True
        # REJECT action at last index if present
        if allow_rejection and num_actions > reject_idx:
            action_mask[reject_idx] = True

        return {
            "observation": obs_cpu,        # Full observation dict (on CPU)
            "pi": policy,                  # Visit-count distribution over num_actions
            "v_root": value_root,          # NN value at root
            "a_taken": action_taken,       # Picked action index
            "mask": action_mask            # Action mask for loss masking
        }
    
    def _obs_to_cpu(self, obs: dict) -> dict:
        """Convert observation tensors to CPU for serialization."""
        return self.obs_builder.obs_to_cpu(obs)

    def _compute_policy_vector(self, node: Node, num_actions: int = None) -> List[float]:
        """Compute normalized policy vector from MCTS visit counts.

        Args:
            node: MCTS node with children representing actions taken
            num_actions: Total action space size (p_net_num_nodes for physical node placements)

        Returns:
            Policy vector of length num_actions with visit-count distribution
        """
        if num_actions is None:
            num_actions = self._state_num_nodes(node.state)

        policy = [0.0] * num_actions

        if not node.children:
            return policy

        total_visits = sum(child.visit_times for child in node.children)
        if total_visits == 0:
            return policy

        for child in node.children:
            p_node_id = child.state.p_node_id
            # Map p_node_id to action index (1:1 mapping for physical nodes)
            if 0 <= p_node_id < num_actions:
                policy[p_node_id] = child.visit_times / total_visits

        return policy
    
    def _compute_value(self, node: Node, v_node_id: int) -> float:
        """Compute value estimate from MCTS root node."""
        diag_root_value = getattr(node, "_diag_root_value", None)
        if diag_root_value is not None:
            try:
                return float(diag_root_value)
            except Exception:
                pass
        if node.visit_times == 0:
            if not self.use_neural_network:
                return 0.0
            obs = self._state_to_obs(node.state, v_node_id)
            _, value_float = self.policy_network.evaluate(obs, use_nn_value=True)
            return value_float
        return node.value / node.visit_times
    
    def _compute_final_reward(self, solution: Solution, v_net, p_net) -> float:
        """Compute the final reward for the trajectory."""
        if solution.get("result", False):
            v_net_cost = self.counter.calculate_v_net_cost(v_net, solution)
            v_net_revenue = self.counter.calculate_v_net_revenue(v_net)
            return 1000 + v_net_revenue - v_net_cost
        else:
            return -1000.0

    def _build_episode_metrics(self, solution: Solution, v_net, p_net) -> dict:
        accepted = bool(solution.get("result", False))
        total_cost = None
        total_revenue = None
        if accepted:
            try:
                total_cost = float(self.counter.calculate_v_net_cost(v_net, solution))
                total_revenue = float(self.counter.calculate_v_net_revenue(v_net))
            except Exception:
                total_cost = None
                total_revenue = None
        final_reward_raw = float(self._compute_final_reward(solution, v_net, p_net))
        value_target = float(
            self.value_target_builder.compute_target(
                accepted=accepted,
                total_cost=total_cost,
                total_revenue=total_revenue,
                raw_reward=final_reward_raw,
                update_stats=True,
            )
        )
        return {
            "final_reward_raw": final_reward_raw,
            "accepted": bool(accepted),
            "total_cost": total_cost,
            "total_revenue": total_revenue,
            "value_target": value_target,
            "value_target_mode": self.value_target_mode,
        }

    def _normalize_cpp_link_mapping_for_deploy(self, p_net, cpp_link_paths, cpp_link_paths_info):
        if not isinstance(cpp_link_paths, dict) or not isinstance(cpp_link_paths_info, dict):
            return cpp_link_paths, cpp_link_paths_info
        try:
            if bool(p_net.is_directed()):
                return cpp_link_paths, cpp_link_paths_info
        except Exception:
            pass

        normalized_paths = {}
        normalized_info = {}
        for v_key, p_links in cpp_link_paths.items():
            canonical_links = []
            for raw_link in p_links:
                try:
                    u, v = int(raw_link[0]), int(raw_link[1])
                except Exception:
                    canonical_links.append(raw_link)
                    continue
                canonical_link = (u, v) if u <= v else (v, u)
                canonical_links.append(canonical_link)

                raw_info_key = (v_key, raw_link)
                canonical_info_key = (v_key, canonical_link)
                used_resources = cpp_link_paths_info.get(raw_info_key)
                if used_resources is None:
                    used_resources = cpp_link_paths_info.get(canonical_info_key)
                if used_resources is None:
                    continue

                if canonical_info_key not in normalized_info:
                    normalized_info[canonical_info_key] = dict(used_resources)
                else:
                    merged = normalized_info[canonical_info_key]
                    for attr_name, attr_value in dict(used_resources).items():
                        merged[attr_name] = float(merged.get(attr_name, 0.0)) + float(attr_value)

            normalized_paths[v_key] = canonical_links

        return normalized_paths, normalized_info

    def _solve_with_cpp_full(self, instance, training: bool = None):
        """Solve a request using the full C++ backend and rebuild trajectory in Python."""
        v_net, p_net = instance["v_net"], instance["p_net"]

        if training is None:
            training = not self.disable_trajectory_writing

        pure_cpp = bool(self.pure_cpp)
        write_trajectory = training and not self.disable_trajectory_writing
        if write_trajectory:
            self._log_active_temperature(self.get_action_selection_temperature(training))
        static_environment = self._create_static_environment(p_net, v_net) if write_trajectory else None

        max_buffer_size = 500000
        training_cfg = getattr(self.config, "training", None)
        if isinstance(training_cfg, dict):
            max_buffer_size = int(training_cfg.get("replay_buffer_max_size", max_buffer_size))
        elif training_cfg is not None:
            max_buffer_size = int(getattr(training_cfg, "replay_buffer_max_size", max_buffer_size))

        cpp_result = self.cpp_full_solver.solve(
            p_net,
            v_net,
            training=training,
            pure_cpp=pure_cpp,
            replay_dir=self.replay_dir,
            max_buffer_size=max_buffer_size,
        )
        metrics = cpp_result.get("metrics", {}) if isinstance(cpp_result, dict) else {}
        if metrics:
            try:
                metrics = dict(metrics)
            except Exception:
                pass
        if self.logger is not None:
            try:
                steps = metrics.get("steps", None)
                if steps is None:
                    steps = len(cpp_result.get("actions", [])) if isinstance(cpp_result, dict) else 0
                sims = metrics.get("total_simulations", None)
                if sims is None:
                    sims = 0
                total_ms = float(metrics.get("total_time_ms") or 0.0)
                encode_ms = float(metrics.get("encode_ms") or 0.0)
                build_ms = float(metrics.get("build_inputs_ms") or 0.0)
                policy_ms = float(metrics.get("policy_eval_ms") or 0.0)
                mcts_ms = float(metrics.get("mcts_ms") or 0.0)
                post_ms = float(metrics.get("postprocess_ms") or 0.0)
                self.logger.info(
                    "C++ solve metrics: steps=%s sims=%s total_time_ms=%.2f "
                    "encode_ms=%.2f build_inputs_ms=%.2f policy_eval_ms=%.2f mcts_ms=%.2f postprocess_ms=%.2f",
                    steps,
                    sims,
                    total_ms,
                    encode_ms,
                    build_ms,
                    policy_ms,
                    mcts_ms,
                    post_ms,
                )
            except Exception:
                pass
        actions = list(cpp_result.get("actions", []))
        policies = list(cpp_result.get("policies", []))
        values = list(cpp_result.get("values", []))
        rejected = bool(cpp_result.get("rejected", False))
        place_result = bool(cpp_result.get("place_result", True))
        route_result = cpp_result.get("route_result", None)
        cpp_place_info = cpp_result.get("place_info", {})
        cpp_place_v = cpp_result.get("place_v_node_id", None)
        cpp_place_p = cpp_result.get("place_p_node_id", None)
        replay_written = bool(cpp_result.get("replay_written", False))
        replay_error = cpp_result.get("replay_error", None)
        cpp_node_slots = cpp_result.get("node_slots", None)
        cpp_link_paths = cpp_result.get("link_paths", None)
        cpp_link_paths_info = cpp_result.get("link_paths_info", None)
        cpp_link_paths, cpp_link_paths_info = self._normalize_cpp_link_mapping_for_deploy(
            p_net,
            cpp_link_paths,
            cpp_link_paths_info,
        )
        if cpp_place_info and cpp_place_info.get("incomplete_placement") and self.logger is not None:
            try:
                self.logger.warning(
                    "C++ incomplete placement: node_slots_size=%s expected=%s",
                    cpp_place_info.get("node_slots_size"),
                    v_net.num_nodes,
                )
            except Exception:
                pass

        solution = Solution.from_v_net(v_net)
        if metrics:
            solution["cpp_metrics"] = metrics
        build_trajectory = write_trajectory and (not pure_cpp or not replay_written)
        trajectory: List[dict] = [] if build_trajectory else None
        if pure_cpp and not replay_written and write_trajectory:
            raise RuntimeError(
                f"C++ replay write failed while training.pure_cpp=true; refusing Python reconstruction fallback: {replay_error}"
            )

        use_cpp_link_mapping = isinstance(cpp_link_paths, dict) and isinstance(cpp_link_paths_info, dict)
        if not build_trajectory and pure_cpp and isinstance(cpp_node_slots, (list, tuple)):
            # Use C++ outputs directly (no Python reconstruction).
            solution["selected_actions"] = list(actions)
            for v_id, p_id in enumerate(cpp_node_slots):
                if p_id is None or p_id < 0:
                    continue
                solution["node_slots"].update({v_id: p_id})
                used_node_resources = {
                    attr.name: v_net.nodes[v_id].get(attr.name, 0.0)
                    for attr in getattr(self.controller, "node_resource_attrs", [])
                }
                solution["node_slots_info"][(v_id, p_id)] = used_node_resources

            if rejected:
                solution["place_result"] = False
                solution["rejected"] = True
            else:
                solution["place_result"] = place_result

            if use_cpp_link_mapping:
                solution["link_paths"] = cpp_link_paths
                solution["link_paths_info"] = cpp_link_paths_info
                solution["route_result"] = bool(route_result) if route_result is not None else True
            else:
                solution["route_result"] = False

            solution["result"] = bool(solution.get("place_result", False) and solution.get("route_result", False)) and not solution.get("rejected", False)
            self._advance_temperature_schedule(training)
            return solution

        # Rebuild trajectory with Python observations for replay compatibility
        if build_trajectory:
            self.obs_builder.set_episode_data(p_net, v_net)

        state = State(
            p_net,
            v_net,
            self.controller,
            self.recorder,
            self.counter,
            link_params={
                'shortest_method': self.shortest_method,
                'k': self.k_shortest,
            },
        )
        num_actions = self.policy.actor.decoder.num_actions
        reject_idx = self._state_num_nodes(state)

        for step, action_taken in enumerate(actions):
            if action_taken < 0 or action_taken >= num_actions:
                place_result = False
                break

            next_pos = state.v_node_id + 1
            if next_pos < 0 or next_pos >= len(state.v_order):
                place_result = False
                break
            curr_v_id = state.v_order[next_pos]

            solution["node_slots"].update({curr_v_id: action_taken})
            used_node_resources = {
                attr.name: v_net.nodes[curr_v_id].get(attr.name, 0.0)
                for attr in getattr(self.controller, "node_resource_attrs", [])
            }
            solution["node_slots_info"][(curr_v_id, action_taken)] = used_node_resources

            if build_trajectory:
                obs = self._state_to_obs(state, curr_v_id)
                obs_cpu = self._obs_to_cpu(obs)

                policy = policies[step] if step < len(policies) else [0.0] * num_actions
                if len(policy) != num_actions:
                    # Pad or trim to action space size
                    policy = (policy + [0.0] * num_actions)[:num_actions]
                value_root = float(values[step]) if step < len(values) else 0.0

                candidate_nodes = self._candidate_actions(state, curr_v_id)
                action_mask = [False] * num_actions
                for node_id in candidate_nodes:
                    if 0 <= node_id < num_actions:
                        action_mask[node_id] = True
                if bool(getattr(state, "allow_rejection", False)) and num_actions > reject_idx:
                    action_mask[reject_idx] = True

                trajectory.append({
                    "observation": obs_cpu,
                    "pi": policy,
                    "v_root": value_root,
                    "a_taken": action_taken,
                    "mask": action_mask,
                })

            state = state.next_state(action_taken)
            if state.p_node_id == -1:
                if cpp_place_info:
                    try:
                        self.logger.warning(
                            f"C++ placement rejected v_node={cpp_place_v} -> p_node={cpp_place_p} "
                            f"offsets={cpp_place_info}"
                        )
                    except Exception:
                        pass
                place_result = False
                break

        if rejected:
            solution["place_result"] = False
            solution["rejected"] = True
        else:
            solution["place_result"] = place_result

        if solution.get("place_result", True) and not solution.get("rejected", False):
            if use_cpp_link_mapping:
                solution["link_paths"] = cpp_link_paths
                solution["link_paths_info"] = cpp_link_paths_info
                solution["route_result"] = bool(route_result) if route_result is not None else True
            else:
                link_ok = self.controller.link_mapper.link_mapping(
                    v_net, p_net, solution=solution,
                    shortest_method=self.shortest_method, k=self.k_shortest, inplace=True)
                if not link_ok:
                    solution["route_result"] = False
        solution["result"] = bool(solution.get("place_result", False) and solution.get("route_result", False)) and not solution.get("rejected", False)

        if build_trajectory:
            episode_metrics = self._build_episode_metrics(solution, v_net, p_net)
            self._store_episode_new_format(
                static_environment,
                trajectory,
                episode_metrics["final_reward_raw"],
                episode_metrics=episode_metrics,
            )

        self._advance_temperature_schedule(training)
        return solution

    def solve_vnr_with_mcts(self, v_net, p_net, solution, controller, training: bool = None):
        """Consolidated MCTS VNR solving method used by both solver and workers.

        Args:
            training: If True, use training temperature; if False, use eval temperature.
                     If None, infer from disable_trajectory_writing.
        """
        if getattr(self, "cpp_full_solver", None) is not None:
            try:
                return self._solve_with_cpp_full({"v_net": v_net, "p_net": p_net}, training=training)
            except Exception as exc:
                if self.pure_cpp:
                    raise RuntimeError(
                        "C++ full solve failed in worker while training.pure_cpp=true; refusing Python fallback."
                    ) from exc
                self.logger.warning(f"C++ full solve failed in worker path, falling back: {exc}")
        # Same implementation as original, but with optimizations
        self.obs_builder.set_episode_data(p_net, v_net)
        if self.cpp_adapter is not None:
            self.cpp_adapter.begin_request(p_net, v_net)

        # Determine temperature based on mode
        if training is None:
            training = not self.disable_trajectory_writing
        temperature = self.get_action_selection_temperature(training)
        write_trajectory = training and not self.disable_trajectory_writing
        if write_trajectory:
            self._log_active_temperature(temperature)

        current_node = Node(
            None,
            State(
                p_net,
                v_net,
                controller,
                self.recorder,
                self.counter,
                link_params={
                    'shortest_method': self.shortest_method,
                    'k': self.k_shortest,
                },
            ),
        )

        # Generate training data for this episode (optional)
        static_environment = self._create_static_environment(p_net, v_net) if write_trajectory else None
        trajectory = [] if write_trajectory else None
        allow_rejection = getattr(self.policy.actor.decoder, 'allow_rejection', False)

        def _finalize_failure(node: Node, v_id: int, action_taken: int = -1) -> bool:
            solution["place_result"] = False
            solution["route_result"] = False
            solution["result"] = False
            if write_trajectory:
                try:
                    timestep_data = self._create_timestep_data(node, v_id, action_taken)
                    trajectory.append(timestep_data)
                except Exception:
                    # Keep failure-path robust even when diagnostics/timestep extraction fails.
                    pass
                episode_metrics = self._build_episode_metrics(solution, v_net, p_net)
                self._store_episode_new_format(
                    static_environment,
                    trajectory,
                    episode_metrics["final_reward_raw"],
                    episode_metrics=episode_metrics,
                )
                self._cleanup()
            self._advance_temperature_schedule(training)
            return False

        for v_node_idx in range(v_net.num_nodes):
            # Use actual virtual node id under stable ordering
            next_pos = current_node.state.v_node_id + 1
            curr_v_id = current_node.state.v_order[next_pos]
            self.search(
                current_node,
                curr_v_id,
                add_root_noise=(training or self.force_root_noise_all_modes),
            )

            try:
                best_child = self._select_best_child(current_node, temperature=temperature)
            except ValueError as exc:
                self.logger.warning(
                    f"Worker MCTS produced zero-visit children for v_node={curr_v_id} "
                    f"(step={current_node.state.v_node_id + 1}): {exc}"
                )
                return _finalize_failure(current_node, curr_v_id, -1)
            if best_child is None:
                self.logger.warning(
                    f"Worker MCTS failed to select child for v_node={curr_v_id} "
                    f"(step={current_node.state.v_node_id + 1})"
                )
                return _finalize_failure(current_node, curr_v_id, -1)

            # Handle REJECT
            reject_idx = self._state_num_nodes(current_node.state)
            if allow_rejection and best_child.state.p_node_id == reject_idx:
                self._episode_rejects += 1
                self._log_root_diagnostics(current_node, current_node.state, curr_v_id, best_child)
                return _finalize_failure(current_node, curr_v_id, reject_idx)
            # Guard against invalid action (-1 or out of range). This can happen when a child
            # is pruned during incremental feasibility checks and marked as terminal-bad.
            if best_child.state.p_node_id < 0 or best_child.state.p_node_id >= reject_idx:
                self.logger.warning(
                    f"Worker selected invalid p_node_id={best_child.state.p_node_id} "
                    f"(reject_idx={reject_idx}) for v_node={curr_v_id}"
                )
                self._log_root_diagnostics(current_node, current_node.state, curr_v_id, best_child)
                return _finalize_failure(current_node, curr_v_id, best_child.state.p_node_id)

            p_node_id = best_child.state.p_node_id
            placed_v = curr_v_id
            
            place_result, place_info = controller.node_mapper.place(
                v_net, p_net, placed_v, p_node_id, solution=solution
            )
            
            if not place_result:
                self.logger.warning(
                    f"Controller rejected placement v_node={placed_v} -> "
                    f"p_node={p_node_id} offsets={place_info}"
                )
                self._log_root_diagnostics(current_node, current_node.state, curr_v_id, best_child)
                return _finalize_failure(current_node, curr_v_id, p_node_id)
                
            if write_trajectory:
                timestep_data = self._create_timestep_data(current_node, curr_v_id, p_node_id)
                trajectory.append(timestep_data)
            # Log root diagnostics once per decision
            self._log_root_diagnostics(current_node, current_node.state, curr_v_id, best_child)

            best_child.parent = None
            current_node = best_child

        # Perform link mapping (consistent with solve() and _solve_with_cpp_full())
        solution["place_result"] = True
        link_ok = self.controller.link_mapper.link_mapping(
            v_net, p_net, solution=solution,
            shortest_method=self.shortest_method, k=self.k_shortest, inplace=True)
        if not link_ok:
            solution["route_result"] = False
        solution["result"] = bool(solution.get("place_result", False) and solution.get("route_result", False)) and not solution.get("rejected", False)

        # Store episode for learning (optional)
        if write_trajectory:
            episode_metrics = self._build_episode_metrics(solution, v_net, p_net)
            final_reward = episode_metrics["final_reward_raw"]
            # Value calibration update using root prediction if available
            root_pred = getattr(current_node, '_diag_root_value', None)
            if root_pred is not None:
                self._calib_n += 1
                self._calib_sum_pred += root_pred
                self._calib_sum_true += final_reward
                self._calib_sum_pred2 += root_pred * root_pred
                self._calib_sum_true2 += final_reward * final_reward
                self._calib_sum_prod += root_pred * final_reward
                if self._calib_n % 50 == 0:
                    n = float(self._calib_n)
                    cov = self._calib_sum_prod - (self._calib_sum_pred * self._calib_sum_true) / n
                    varx = self._calib_sum_pred2 - (self._calib_sum_pred ** 2) / n
                    vary = self._calib_sum_true2 - (self._calib_sum_true ** 2) / n
                    corr = cov / max((varx * vary) ** 0.5, 1e-8)
                    self.logger.info(f"Value calibration: n={self._calib_n} corr={corr:.3f}")
            # Episode-level reject usage
            if self._episode_rejects:
                self.logger.info(f"Reject actions this episode: {self._episode_rejects}")
            self._episode_rejects = 0
            self._store_episode_new_format(
                static_environment,
                trajectory,
                final_reward,
                episode_metrics=episode_metrics,
            )
            self._cleanup()

        self._advance_temperature_schedule(training)
        return solution

    def shutdown(self):
        """Cleanup method to shut down GPU worker."""
        if hasattr(self, 'policy_network'):
            self.policy_network.shutdown()

    def __del__(self):
        """Ensure GPU worker is shut down on deletion."""
        if hasattr(self, 'policy_network'):
            self.policy_network.shutdown()
