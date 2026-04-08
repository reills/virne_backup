# ==============================================================================
# alpha_zero_sfc_solver.py
# ==============================================================================  
from __future__ import annotations

import os
import multiprocessing
from multiprocessing import Process
from typing import Optional, Tuple, Dict, Any

import torch

from virne.solver.base_solver import Solver, SolverRegistry
from virne.solver.learning.rl_core import RLSolver
from virne.core import Solution
from virne.utils.config import get_run_id_dir

from .actor_optimized import OptimizedAlphaZeroActor
from .learner import AlphaZeroLearner
from .model_factory import build_actor_critic
from .utils import build_model_config




@SolverRegistry.register(solver_name="alpha_zero_sfc", solver_type="r_learning")
class AlphaZeroSFCSolver(RLSolver):
    """Orchestrator that manages Actor and Learner processes."""

    def __init__(
        self,
        controller,
        recorder,
        counter,
        logger,
        config,
        replay_dir: str = None,
        batch_size: int = 32,
        **kwargs,
    ) -> None:
        # Ensure spawn is the global start method for CUDA safety
        try:
            import multiprocessing as _mp
            _mp.set_start_method('spawn', force=True)
            logger.info("Multiprocessing start_method set to 'spawn'")
        except Exception:
            pass
        # AlphaZero uses its own neural network, provide required functions for RLSolver
        def make_policy(solver):
            policy = build_actor_critic(build_model_config(solver.config))
            optimizer = torch.optim.Adam(
                policy.parameters(), 
                lr=solver.config.rl.learning_rate.actor
            )
            return policy, optimizer
        
        def obs_as_tensor(obs, device):
            # AlphaZero handles its own observation preprocessing
            return obs
        
        # Pass distributed training params from config to RLSolver
        kwargs['num_workers'] = config.training.num_workers
        super().__init__(controller, recorder, counter, logger, config, make_policy, obs_as_tensor, **kwargs)
        
        # Use proper experiment directory structure like other solvers
        if replay_dir is None:
            experiment_dir = get_run_id_dir(config)
            self.replay_dir = os.path.join(experiment_dir, "replay_buffer")
        else:
            self.replay_dir = replay_dir
            
        self.batch_size = batch_size
        os.makedirs(self.replay_dir, exist_ok=True)
        
        # Save model in experiment directory, not generic replay_buffer
        self.models_dir = os.path.join(get_run_id_dir(config), "models")
        os.makedirs(self.models_dir, exist_ok=True)
        self.policy_path = os.path.join(self.models_dir, "policy_latest.pt")
        
        # Standard VNE solver parameters
        # Honor global config.solver settings to enable ablations (e.g., k_shortest)
        self.shortest_method = getattr(config.solver, 'shortest_method', getattr(self, 'shortest_method', 'k_shortest'))
        self.k_shortest = getattr(config.solver, 'k_shortest', getattr(self, 'k_shortest', 10))

        # Use optimized actor with batched GPU inference
        use_batched_gpu = getattr(config.training, 'use_batched_gpu', True)
        disable_trajectory_writing = getattr(config.training, 'disable_trajectory_writing', False)

        self.inference_only = bool(getattr(config.training, 'inference_only', False))
        self.enable_async_learner = bool(getattr(config.training, 'enable_async_learner', True))
        if self.inference_only:
            self.enable_async_learner = False
        self._learner_disabled_logged = False
        
        # Build the primary actor. Explicitly pass shortest_method/k_shortest so
        # State.link_params used for feasibility checks and reward match the
        # orchestrator's link-mapping config.
        self.actor = OptimizedAlphaZeroActor(
            controller,
            recorder,
            counter,
            logger,
            config,
            replay_dir=self.replay_dir,
            models_dir=self.models_dir,
            use_batched_gpu=use_batched_gpu,
            disable_trajectory_writing=disable_trajectory_writing,
            shortest_method=self.shortest_method,
            k_shortest=self.k_shortest,
            **kwargs,
        )
        
        if use_batched_gpu:
            logger.info("✅ Using OptimizedAlphaZeroActor with batched GPU inference")
        else:
            logger.info("⚠️  Using OptimizedAlphaZeroActor without batching (slower)")
        self.learner_process: Optional[Process] = None
        self._stop_signal = None
        self._num_train_steps = getattr(config.training, "num_train_steps_per_epoch", 100)
        self._sync_learner: Optional[AlphaZeroLearner] = None
        
        # Cache for model weights to avoid repeated loading
        self._cached_model_mtime = None

    # ------------------------------------------------------------------
    def _learner_loop(self) -> None:
        learner = AlphaZeroLearner(
            self.controller,
            self.recorder,
            self.counter,
            self.logger,
            self.config,
            replay_dir=self.replay_dir,
            models_dir=self.models_dir,
            batch_size=self.batch_size,
        )
        
        # Get termination conditions from config
        max_training_steps = getattr(self.config.training, 'max_training_steps', 10000)
        min_buffer_size = getattr(self.config.training, 'min_buffer_size', 100)
        
        total_steps = 0
        consecutive_empty_batches = 0
        max_empty_batches = getattr(self.config.training, 'max_empty_batches', 50)
        
        while total_steps < max_training_steps:
            # Check if we have enough data to train
            replay_files = [f for f in os.listdir(self.replay_dir) if f.endswith('.json')]
            if len(replay_files) < min_buffer_size:
                consecutive_empty_batches += 1
                if consecutive_empty_batches > max_empty_batches:
                    self.logger.warning(f"Stopping learner: insufficient data for {max_empty_batches} attempts")
                    break
                import time
                time.sleep(1)  # Wait for more data
                continue
            
            consecutive_empty_batches = 0
            learner.train_steps(self._num_train_steps)
            total_steps += self._num_train_steps
            
        self.logger.info(f"Learner terminated after {total_steps} training steps")

    def _start_learner(self) -> None:
        """Start the learner in a CUDA-safe spawned process (rebuilds components in child)."""
        if not self.enable_async_learner:
            if not self._learner_disabled_logged:
                self.logger.info("Async learner disabled; running in inference-only mode.")
                self._learner_disabled_logged = True
            return
        if self._sync_learner is not None:
            return
        if self.learner_process is not None and self.learner_process.is_alive():
            return
        # Use saved config file for reconstruction
        config_path = os.path.join(get_run_id_dir(self.config), 'config.yaml')
        # Ensure stop signal exists and is cleared for a fresh training run
        stop_event = self._stop_signal
        mp_ctx = None
        try:
            mp_ctx = multiprocessing.get_context('spawn')
        except Exception:
            mp_ctx = None
        if stop_event is None:
            try:
                if mp_ctx is not None:
                    stop_event = mp_ctx.Event()
                else:
                    stop_event = multiprocessing.Event()
            except PermissionError as exc:
                self.logger.warning(
                    f"Async learner IPC unavailable ({exc}); falling back to in-process learner."
                )
                self._sync_learner = AlphaZeroLearner(
                    self.controller,
                    self.recorder,
                    self.counter,
                    self.logger,
                    self.config,
                    replay_dir=self.replay_dir,
                    models_dir=self.models_dir,
                    batch_size=self.batch_size,
                )
                return
            self._stop_signal = stop_event
        else:
            stop_event.clear()
        try:
            if mp_ctx is None:
                raise RuntimeError("spawn context unavailable")
            self.learner_process = mp_ctx.Process(
                target=_learner_process_entry,
                args=(config_path, self.replay_dir, self.models_dir, self.batch_size, self._stop_signal),
                daemon=True,
            )
            self.logger.info("Starting learner process with start_method=spawn")
        except Exception:
            # Fallback to default if spawn is unavailable
            if mp_ctx is not None:
                # Recreate stop signal with default context to match fallback process start method
                self._stop_signal = multiprocessing.Event()
            self.learner_process = Process(
                target=_learner_process_entry,
                args=(config_path, self.replay_dir, self.models_dir, self.batch_size, self._stop_signal),
                daemon=True,
            )
            self.logger.warning("Falling back to default start_method (not spawn)")
        try:
            self.learner_process.start()
        except PermissionError as exc:
            self.logger.warning(
                f"Failed to start async learner process ({exc}); falling back to in-process learner."
            )
            self.learner_process = None
            self._stop_signal = None
            self._sync_learner = AlphaZeroLearner(
                self.controller,
                self.recorder,
                self.counter,
                self.logger,
                self.config,
                replay_dir=self.replay_dir,
                models_dir=self.models_dir,
                batch_size=self.batch_size,
            )

    # ------------------------------------------------------------------
    def solve(self, instance):
        """
        Main solve method that follows the standard VNE solver pattern.
        This should work exactly like other solvers in the framework.
        """
        v_net, p_net = instance['v_net'], instance['p_net']
        
        # Create solution following the standard pattern
        solution = Solution.from_v_net(v_net)
        
        # Load latest policy weights only if file has changed
        self._load_model_if_changed()
        
        # Use the actor to determine node mappings via MCTS
        node_mapping_result = self._node_mapping_with_mcts(v_net, p_net, solution)

        # The actor may return a Solution (C++ full path) or a boolean (legacy path).
        if isinstance(node_mapping_result, Solution):
            solution = node_mapping_result
            node_mapping_ok = bool(solution.get("place_result", True) and not solution.get("rejected", False))
        else:
            node_mapping_ok = bool(node_mapping_result)

        if node_mapping_ok:
            # Standard link mapping using the controller (skip if already mapped).
            if solution.get("route_result", True) and not solution.get("link_paths") and not solution.get("rejected", False):
                link_mapping_result = self.controller.link_mapper.link_mapping(
                    v_net, p_net, solution=solution,
                    shortest_method=self.shortest_method, 
                    k=self.k_shortest, 
                    inplace=True
                )
                if not link_mapping_result:
                    solution['route_result'] = False
            else:
                link_mapping_result = bool(solution.get("route_result", False))

            if link_mapping_result:
                solution['result'] = True
                return solution
        else:
            solution['place_result'] = False
            
        solution['result'] = False
        return solution

    def _load_model_if_changed(self):
        """Load model weights only if the file has been modified."""
        if not os.path.exists(self.policy_path):
            return
            
        current_mtime = os.path.getmtime(self.policy_path)
        if self._cached_model_mtime != current_mtime:
            state = torch.load(self.policy_path, map_location=self.actor.device)
            self.actor.policy.load_state_dict(state)
            # Ensure model is on correct device after loading
            self.actor.policy.to(self.actor.device)
            # Instrument: log checkpoint stats to prove non-zero weights
            try:
                import hashlib
                h = hashlib.sha256()
                with torch.no_grad():
                    for n, p in self.actor.policy.state_dict().items():
                        h.update(n.encode()); h.update(p.detach().cpu().numpy().tobytes())
                sha = h.hexdigest()
                n_params = sum(p.numel() for p in self.actor.policy.parameters())
                first_lin = getattr(self.actor.policy.encoder, 'token_embed', None)
                l2 = float(first_lin.weight.detach().norm().item()) if first_lin is not None else float('nan')
                self.logger.info(f"Actor reloaded policy: path={self.policy_path} sha256={sha[:12]}.. params={n_params} token_embed_L2={l2:.3f}")
            except Exception:
                pass
            self._cached_model_mtime = current_mtime

    def _node_mapping_with_mcts(self, v_net, p_net, solution):
        """Use MCTS to determine node mappings, then use controller to place them."""
        # Delegate to actor's consolidated solve method
        return self.actor.solve_vnr_with_mcts(v_net, p_net, solution, self.controller,
                                              training=not self.inference_only)

    def learn(self, env, num_epochs: int, start_epoch: int = 0, **kwargs) -> None:
        """
        Standard learn method following the VNE framework pattern.
        Uses the existing distributed training infrastructure.
        
        Args:
            env: Training environment  
            num_epochs: Number of training epochs (from config.training.num_train_epochs)
            start_epoch: Starting epoch (for resuming)
        """
        total_vnrs = env.v_net_simulator.v_sim_setting['num_v_nets']  # Gets from config
        self.logger.info(f"AlphaZero Training: {num_epochs} epochs x {total_vnrs} VNRs each")
        self.logger.info(f"Using distributed_training: {self.config.training.distributed_training}, num_workers: {self.config.training.num_workers}")
        
        # Safety: warn if trajectory writing is disabled while training, which would starve the learner
        if getattr(self.actor, 'disable_trajectory_writing', False):
            self.logger.warning("Trajectory writing is disabled; the learner will not receive new episodes.")
        if self.inference_only or num_epochs <= 0:
            self.logger.info("Inference-only mode enabled or zero epochs requested; skipping training loop.")
            return
        self._start_learner()
        if not self.enable_async_learner:
            self.logger.info("Async learner disabled; skipping background learner startup.")
            return
        
        # Use the standard RLSolver distributed training if enabled
        if self._sync_learner is not None and self.config.training.distributed_training:
            self.logger.warning(
                "In-process learner fallback does not support distributed actor workers; "
                "switching to single-worker training."
            )
            self.learn_singly(env, num_epochs, **kwargs)
        elif self.config.training.distributed_training:
            self.learn_distributedly(env, num_epochs, **kwargs)
        else:
            self.learn_singly(env, num_epochs, **kwargs)
        
        if self._stop_signal is not None and self._stop_signal.is_set():
            self.logger.info("Learner stop signal acknowledged; actor loops ended early.")

        # Guarantee a discoverable checkpoint for orchestration even when the learner
        # did not emit one (e.g., no replay data or early process termination).
        try:
            if not os.path.exists(self.policy_path) or os.path.getsize(self.policy_path) <= 0:
                torch.save(self.actor.policy.state_dict(), self.policy_path)
                self.logger.warning(
                    f"No learner checkpoint found; wrote fallback actor weights to {self.policy_path}"
                )
        except Exception as exc:
            self.logger.warning(f"Failed to write fallback actor checkpoint: {exc}")

        self.logger.info(f"Training completed! Model saved to {self.policy_path}")
        self.logger.info(f"Now ready for evaluation phase (num_simulations = inference-only runs)")

    def learn_singly(self, env, num_epochs: int, **kwargs) -> None:
        """Single-worker training: one worker processes all epochs sequentially."""
        import tqdm
        from torch.utils.tensorboard import SummaryWriter
        from virne.utils.config import get_run_id_dir
        
        total_vnrs = env.v_net_simulator.v_sim_setting['num_v_nets']
        
        # TensorBoard writer for VNE metrics
        tb_log_dir = os.path.join(get_run_id_dir(self.config), "logs")
        writer = SummaryWriter(tb_log_dir)
        stop_event = getattr(self, "_stop_signal", None)
        stop_logged = False
        
        for epoch in range(num_epochs):
            if stop_event is not None and stop_event.is_set():
                if not stop_logged:
                    self.logger.info("Learner signaled completion; exiting training loop.")
                    stop_logged = True
                break
            self.logger.info(f"Training Epoch {epoch + 1}/{num_epochs} - Processing {total_vnrs} VNRs")
            
            # Reset metrics tracking
            epoch_metrics = {
                'accepted': 0,
                'rejected': 0,
                'total_revenue': 0.0,
                'total_cost': 0.0,
                'episode_files_before': len([f for f in os.listdir(self.replay_dir) if f.endswith('.json')])
            }
            
            # Process the full VNR dataset for this training epoch
            instance = env.reset(self.config.experiment.seed)
            vnr_count = 0
            
            # Progress bar for this epoch
            pbar = tqdm.tqdm(
                desc=f'Epoch {epoch + 1}/{num_epochs}', 
                total=total_vnrs,
                bar_format='{desc}: {n_fmt}/{total_fmt} [{elapsed}<{remaining}, {rate_fmt}] {percentage:3.0f}%'
            )
            
            while True:
                if stop_event is not None and stop_event.is_set():
                    if not stop_logged:
                        self.logger.info("Learner signaled completion; stopping current epoch early.")
                        stop_logged = True
                    break
                solution = self.solve(instance)
                next_instance, _, done, info = env.step(solution)
                vnr_count += 1
                
                # Track VNE metrics
                if solution.get('result', False):
                    epoch_metrics['accepted'] += 1
                    # Calculate revenue and cost if available
                    v_net = instance['v_net']
                    revenue = self.counter.calculate_v_net_revenue(v_net)
                    cost = self.counter.calculate_v_net_cost(v_net, solution)
                    epoch_metrics['total_revenue'] += revenue
                    epoch_metrics['total_cost'] += cost
                else:
                    epoch_metrics['rejected'] += 1
                
                pbar.update(1)
                if stop_event is not None and stop_event.is_set():
                    if not stop_logged:
                        self.logger.info("Learner signaled completion; stopping current epoch early.")
                        stop_logged = True
                    break
                
                if done:
                    break
                instance = next_instance
            
            pbar.close()
            if stop_event is not None and stop_event.is_set():
                break
            
            # Calculate epoch summary metrics
            acceptance_rate = epoch_metrics['accepted'] / (epoch_metrics['accepted'] + epoch_metrics['rejected']) * 100
            avg_revenue = epoch_metrics['total_revenue'] / max(epoch_metrics['accepted'], 1)
            avg_cost = epoch_metrics['total_cost'] / max(epoch_metrics['accepted'], 1)
            rc_ratio = avg_revenue / max(avg_cost, 0.001)
            
            episode_files_after = len([f for f in os.listdir(self.replay_dir) if f.endswith('.json')])
            new_episodes = episode_files_after - epoch_metrics['episode_files_before']
            
            # Log to TensorBoard
            writer.add_scalar('VNE/AcceptanceRate', acceptance_rate, epoch)
            writer.add_scalar('VNE/AverageRevenue', avg_revenue, epoch)
            writer.add_scalar('VNE/AverageCost', avg_cost, epoch)
            writer.add_scalar('VNE/RevenueCostRatio', rc_ratio, epoch)
            writer.add_scalar('Training/EpisodesCollected', new_episodes, epoch)
            writer.add_scalar('Training/BufferSize', episode_files_after, epoch)
            
            # Print epoch summary with canary metrics
            self.logger.info("=" * 80)
            self.logger.info(f"EPOCH {epoch + 1}/{num_epochs} SUMMARY")
            self.logger.info("=" * 80)
            self.logger.info(f"VNE Performance:")
            self.logger.info(f"   Acceptance Rate: {acceptance_rate:.1f}% ({epoch_metrics['accepted']}/{vnr_count})")
            self.logger.info(f"   Avg Revenue:     {avg_revenue:.2f}")
            self.logger.info(f"   Avg Cost:        {avg_cost:.2f}")
            self.logger.info(f"   R/C Ratio:       {rc_ratio:.2f}")
            self.logger.info(f"Training Data:")
            self.logger.info(f"   Episodes Added:  {new_episodes}")
            self.logger.info(f"   Buffer Size:     {episode_files_after}")
            
            # Get learner stats if available
            self.logger.info(f"Neural Network: Training in background...")
            
            # Health check warnings
            warnings = []
            if acceptance_rate < 30:
                warnings.append("WARNING: LOW ACCEPTANCE RATE - Check MCTS parameters")
            if acceptance_rate > 95:
                warnings.append("WARNING: TOO HIGH ACCEPTANCE - May not be learning constraints")
            if new_episodes < total_vnrs * 0.8:
                warnings.append("WARNING: LOW EPISODE COLLECTION - Check solve() method")
            if rc_ratio < 1.0:
                warnings.append("WARNING: NEGATIVE PROFIT - Solutions are too expensive")
            
            if warnings:
                self.logger.warning("HEALTH WARNINGS:")
                for warning in warnings:
                    self.logger.warning(f"   {warning}")
            else:
                self.logger.info("All metrics look healthy!")

            if self._sync_learner is not None:
                learner_stats = self._sync_learner.train_steps(self._num_train_steps)
                if learner_stats is not None:
                    self.logger.info(
                        "Synchronous learner: "
                        f"steps={learner_stats['num_training_steps']} "
                        f"avg_total_loss={learner_stats['avg_total_loss']:.4f}"
                    )
                # Refresh actor weights if learner updated checkpoint.
                self._load_model_if_changed()
                
            self.logger.info("=" * 80)
        
        writer.close()
        
    def close(self) -> None:
        """Cleanup method to terminate background processes."""
        if hasattr(self, 'learner_process') and self.learner_process is not None:
            self.learner_process.terminate()
            self.learner_process.join()
            self.learner_process = None
            self.logger.info("Learner process terminated")
        if self._sync_learner is not None:
            try:
                self._sync_learner.writer.close()
            except Exception:
                pass
            self._sync_learner = None
            self.logger.info("In-process learner terminated")
        
        # Shutdown GPU worker
        if hasattr(self, 'actor') and self.actor:
            self.actor.shutdown()
            self.logger.info("GPU worker terminated")

    def learn_distributedly(self, env, num_epochs: int, **kwargs) -> None:
        """Distributed training: split epochs among workers."""
        import multiprocessing as mp
        
        assert self.config.training.distributed_training, 'distributed_training should be True'
        assert num_epochs % self.num_workers == 0, f'num_epochs ({num_epochs}) should be divisible by num_workers ({self.num_workers})'
        
        epochs_per_worker = num_epochs // self.num_workers
        total_vnrs = env.v_net_simulator.v_sim_setting['num_v_nets']
        
        self.logger.info(f"Distributed Training: {self.num_workers} workers x {epochs_per_worker} epochs each")
        self.logger.info(f"Each worker processes: {epochs_per_worker} x {total_vnrs} = {epochs_per_worker * total_vnrs} VNRs")
        self.logger.info(f"All workers share replay buffer: {self.replay_dir}")
        
        # Start the learner process (shared across all workers)
        self._start_learner()
        
        # Create worker processes
        processes = []
        mp.set_start_method('spawn', force=True)
        
        for worker_id in range(self.num_workers):
            # Each worker uses a different random seed for diversity
            worker_seed = (self.config.experiment.seed or 0) + worker_id * 1000
            
            # Pass config instead of environment - worker will create its own
            process = mp.Process(
                target=_worker_training_loop,
                args=(worker_id, self.config, epochs_per_worker, worker_seed, self.replay_dir, self.policy_path, self._stop_signal)
            )
            processes.append(process)
            process.start()
            self.logger.debug(f"Started worker {worker_id} (PID: {process.pid})")
        
        # Wait for all workers to complete
        for i, process in enumerate(processes):
            process.join()
            self.logger.debug(f"Worker {i} completed")
            
        self.logger.info("All workers completed. Training finished!")

# Removed: _solve_vnr_with_mcts_worker - consolidated into actor.solve_vnr_with_mcts

def _learner_process_entry(config_path: str, replay_dir: str, models_dir: str, batch_size: int, stop_event):
    """Spawn-safe learner entrypoint. Rebuilds environment and trains in a loop.

    Args:
        config_path: Path to saved Hydra config YAML for this run
        replay_dir: Directory where actors write episodes
        models_dir: Directory to write models/checkpoints
        batch_size: Learner batch size
    """
    import os
    import time
    from omegaconf import OmegaConf
    from virne.system.base_system import BaseSystem
    from virne.core import Controller, Recorder, Counter, Logger
    import multiprocessing as mp

    config = OmegaConf.load(config_path)
    logger = Logger(config=config)
    logger.info(f"Learner spawned with config: {config_path}")

    # Seed the learner process explicitly so model init, replay sampling, and
    # minibatch order are reproducible across reruns with the same config seed.
    try:
        import random
        import numpy as np
        import torch

        learner_seed = getattr(config.training, 'seed', None)
        if learner_seed is None:
            learner_seed = getattr(config.experiment, 'seed', None)
        if learner_seed is not None:
            learner_seed = int(learner_seed)
            random.seed(learner_seed)
            np.random.seed(learner_seed)
            torch.manual_seed(learner_seed)
            if torch.cuda.is_available():
                torch.cuda.manual_seed(learner_seed)
            logger.info(f"Learner RNG seeded with seed={learner_seed}")
    except Exception as exc:
        logger.warning(f"Learner RNG seeding failed: {exc}")

    try:
        if stop_event is not None:
            stop_event.clear()
    except Exception:
        logger.warning("Learner failed to clear stop_event on startup")
    try:
        logger.info(f"Start method (child) = {mp.get_start_method(default='spawn')}")
    except Exception:
        pass

    # Build env components fresh (avoid pickling parent objects)
    p_net, _ = BaseSystem.load_dataset(logger, config)
    node_attrs_setting = config.v_sim_setting['node_attrs_setting']
    link_attrs_setting = config.v_sim_setting['link_attrs_setting']
    graph_attrs_setting = config.v_sim_setting.get('graph_attrs_setting', {})
    counter = Counter(node_attrs_setting, link_attrs_setting, graph_attrs_setting, config)
    controller = Controller(node_attrs_setting, link_attrs_setting, graph_attrs_setting, config)
    recorder = Recorder(counter, config, worker_id=9999)

    learner = AlphaZeroLearner(
        controller,
        recorder,
        counter,
        logger,
        config,
        replay_dir=replay_dir,
        models_dir=models_dir,
        batch_size=batch_size,
    )

    # Training loop with conditions from config
    max_training_steps = getattr(config.training, 'max_training_steps', 10000)
    min_buffer_size = getattr(config.training, 'min_buffer_size', 100)
    max_empty_batches = getattr(config.training, 'max_empty_batches', 50)
    steps_per_iter = getattr(config.training, 'num_train_steps_per_epoch', 100)

    total_steps = 0
    trained_any_steps = False
    consecutive_empty = 0
    try:
        while total_steps < max_training_steps:
            files = [f for f in os.listdir(replay_dir) if f.endswith('.json')]
            if len(files) < min_buffer_size:
                consecutive_empty += 1
                if consecutive_empty > max_empty_batches:
                    # Do not stop before the first successful training batch.
                    # Actors may still be generating trajectories, and exiting here
                    # would leave no checkpoint for downstream eval.
                    if not trained_any_steps:
                        logger.warning(
                            f"Replay buffer still below min_buffer_size={min_buffer_size} "
                            f"after {max_empty_batches} checks; waiting for actors to populate data."
                        )
                        consecutive_empty = 0
                    else:
                        logger.warning(f"Stopping learner: insufficient data for {max_empty_batches} attempts")
                        break
                time.sleep(1.0)
                continue
            consecutive_empty = 0
            stats = learner.train_steps(steps_per_iter)
            trained_any_steps = True
            total_steps += steps_per_iter
            if stats:
                logger.info(f"Learner iter: +{steps_per_iter} steps, avg_total_loss={stats['avg_total_loss']:.4f}")
    finally:
        # Guarantee at least one usable checkpoint for orchestration resume/eval.
        try:
            if not os.path.exists(learner.policy_path) or os.path.getsize(learner.policy_path) <= 0:
                learner._save_model_atomically()
                learner._save_full_checkpoint()
                logger.warning(
                    f"Learner emitted fallback checkpoint at {learner.policy_path} "
                    "(no non-empty checkpoint was present at shutdown)."
                )
        except Exception as exc:
            logger.warning(f"Failed to emit fallback checkpoint on learner shutdown: {exc}")
        logger.info(f"Learner terminated after {total_steps} training steps")
        # Signal workers after learner completion so training can transition
        # promptly to shutdown/eval once model updates have stopped.
        signal_stop = bool(
            getattr(config.training, 'signal_stop_event_on_learner_complete', False)
        )
        if stop_event is not None and trained_any_steps and signal_stop:
            logger.info(
                "Setting stop_event because training.signal_stop_event_on_learner_complete=true "
                "and learner has finished updating weights."
            )
            stop_event.set()

def _create_worker_environment(worker_id: int, config, seed: int, replay_dir: str, policy_path: str):
    """Create environment components for a worker process."""
    # Set different random seed for each worker
    import random
    import numpy as np
    import torch
    random.seed(seed)
    np.random.seed(seed)
    torch.manual_seed(seed)
    if torch.cuda.is_available():
        torch.cuda.manual_seed(seed)

    # Keep the worker-local config seed aligned with the actual worker seed so
    # the pure_cpp solve path does not reuse the parent process seed.
    try:
        config.experiment.seed = int(seed)
    except Exception:
        pass
    try:
        config.training.seed = int(seed)
    except Exception:
        pass
    
    # Create fresh environment for this worker
    from virne.system.base_system import BaseSystem
    from virne.core.environment import SolutionStepEnvironment
    from virne.core import Controller, Recorder, Counter, Logger
    
    # Create logger first for BaseSystem.load_dataset
    logger = Logger(config=config)
    p_net, v_net_simulator = BaseSystem.load_dataset(logger, config)
    
    # Create components for this worker
    node_attrs_setting = config.v_sim_setting['node_attrs_setting']
    link_attrs_setting = config.v_sim_setting['link_attrs_setting']
    graph_attrs_setting = config.v_sim_setting.get('graph_attrs_setting', {})
    counter = Counter(node_attrs_setting, link_attrs_setting, graph_attrs_setting, config)
    controller = Controller(node_attrs_setting, link_attrs_setting, graph_attrs_setting, config)
    recorder = Recorder(counter, config, worker_id=worker_id)
    
    env = SolutionStepEnvironment(p_net, v_net_simulator, controller, recorder, counter, logger, config)
    
    # Create a minimal solver instance for this worker (just for solving, no training)
    # Use optimized actor but disable batching for workers (to avoid multiprocessing conflicts)
    # Workers act as additional actors to collect episodes into the shared replay buffer.
    # Keep batched GPU off to avoid CUDA contention across processes; write trajectories.
    worker_actor = OptimizedAlphaZeroActor(
        controller, recorder, counter, logger, config,
        replay_dir=replay_dir,
        models_dir=os.path.dirname(policy_path),
        use_batched_gpu=False,
        disable_trajectory_writing=False,
        shortest_method=getattr(config.solver, 'shortest_method', getattr(controller, 'shortest_method', 'k_shortest')),
        k_shortest=getattr(config.solver, 'k_shortest', 10),
    )
    worker_actor._cpp_worker_seed = int(seed)
    worker_actor._cpp_request_seed = None

    return env, controller, worker_actor

def _worker_training_loop(worker_id: int, config, num_epochs: int, seed: int, replay_dir: str, policy_path: str, stop_event) -> None:
    """Training loop for a single worker process."""
    import tqdm
    
    # print(f"Worker {worker_id}: Starting training with seed {seed}")
    
    # Create environment and components for this worker
    env, controller, worker_actor = _create_worker_environment(worker_id, config, seed, replay_dir, policy_path)
    
    # Cache for model weights to avoid repeated loading
    cached_model_mtime = None
    
    total_vnrs = env.v_net_simulator.v_sim_setting['num_v_nets']
    
    for epoch in range(num_epochs):
        if stop_event is not None and stop_event.is_set():
            break
        global_epoch = worker_id * num_epochs + epoch + 1
        # print(f"Worker {worker_id}: Epoch {epoch + 1}/{num_epochs} (Global: {global_epoch})")
        
        # Reset environment with worker-specific seed
        instance = env.reset(seed + epoch)
        vnr_count = 0
        
        # Progress bar for this worker's epoch
        pbar = tqdm.tqdm(
            desc=f'Worker-{worker_id} Epoch {epoch + 1}', 
            total=total_vnrs,
            position=worker_id,  # Each worker gets its own line
            leave=False,
            bar_format='{desc}: {n_fmt}/{total_fmt} [{elapsed}<{remaining}, {rate_fmt}] {percentage:3.0f}%'
        )
        
        while True:
            if stop_event is not None and stop_event.is_set():
                break
            # Solve using MCTS (same as main solver)
            v_net, p_net = instance['v_net'], instance['p_net']
            from virne.core import Solution
            
            solution = Solution.from_v_net(v_net)
            
            # Load latest policy weights only if file has changed
            if os.path.exists(policy_path):
                current_mtime = os.path.getmtime(policy_path)
                if cached_model_mtime != current_mtime:
                    state_dict = torch.load(policy_path, map_location=worker_actor.device)
                    worker_actor.policy.load_state_dict(state_dict)
                    # Ensure model is on correct device after loading
                    worker_actor.policy.to(worker_actor.device)
                    cached_model_mtime = current_mtime

            worker_actor._cpp_request_seed = int(seed + epoch * total_vnrs + vnr_count)
            
            # Use MCTS to solve this VNR - simplified version for worker
            node_mapping_result = worker_actor.solve_vnr_with_mcts(v_net, p_net, solution, controller)

            # C++ full solver returns a populated Solution; Python path returns bool.
            if isinstance(node_mapping_result, Solution) or isinstance(node_mapping_result, dict):
                solution = node_mapping_result
                if solution.get("place_result", False) and solution.get("route_result", None) is None:
                    link_mapping_result = controller.link_mapper.link_mapping(
                        v_net, p_net, solution=solution,
                        shortest_method=getattr(config.solver, 'shortest_method', 'k_shortest'),
                        k=getattr(config.solver, 'k_shortest', 10),
                        inplace=True
                    )
                    solution["route_result"] = bool(link_mapping_result)
                solution["result"] = bool(
                    solution.get("place_result", False)
                    and solution.get("route_result", False)
                ) and not solution.get("rejected", False)
            elif node_mapping_result:
                # Standard link mapping using the controller (respect config.solver.*)
                link_mapping_result = controller.link_mapper.link_mapping(
                    v_net, p_net, solution=solution,
                    shortest_method=getattr(config.solver, 'shortest_method', 'k_shortest'),
                    k=getattr(config.solver, 'k_shortest', 10),
                    inplace=True
                )
                if link_mapping_result:
                    solution['result'] = True
                else:
                    solution['route_result'] = False
                    solution['result'] = False
            else:
                solution['place_result'] = False
                solution['result'] = False
            
            next_instance, _, done, info = env.step(solution)
            vnr_count += 1
            
            pbar.update(1)
            if stop_event is not None and stop_event.is_set():
                break
            
            if done:
                break
            instance = next_instance
        
        pbar.close()
        if stop_event is not None and stop_event.is_set():
            break
        # Worker completion logging - could be moved to logger if needed
    
    # Worker completion logging
