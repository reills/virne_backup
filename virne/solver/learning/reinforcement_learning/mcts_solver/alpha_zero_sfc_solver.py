from __future__ import annotations

import os
import copy
import multiprocessing
from multiprocessing import Process, Pool
from typing import Optional, Tuple, Dict, Any

import torch

from virne.solver.base_solver import Solver, SolverRegistry
from virne.solver.learning.rl_core import RLSolver
from virne.core import Solution
from virne.utils.config import get_run_id_dir

from .actor import AlphaZeroActor
from .learner import AlphaZeroLearner
from .node import Node, State




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
        # AlphaZero uses its own neural network, provide required functions for RLSolver
        def make_policy(solver):
            from .net import ActorCritic
            policy = ActorCritic(
                p_net_num_nodes=solver.config.simulation.p_net_setting_num_nodes,
                p_net_feature_dim=solver.config.simulation.p_net_setting_num_node_resource_attrs,
                v_net_feature_dim=solver.config.simulation.v_sim_setting_num_node_resource_attrs,
                embedding_dim=getattr(solver.config.nn, 'embedding_dim', 128),
                n_heads=8,  # Fixed reasonable default
                n_layers=getattr(solver.config.nn, 'num_gnn_layers', 3),
                dropout=getattr(solver.config.nn, 'dropout_prob', 0.1),
                allow_revocable=getattr(solver.config.solver, 'allow_revocable', False),
                allow_rejection=getattr(solver.config.solver, 'allow_rejection', False),
            )
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
        self.shortest_method = kwargs.get('shortest_method', 'k_shortest')
        self.k_shortest = kwargs.get('k_shortest', 10)

        self.actor = AlphaZeroActor(
            controller,
            recorder,
            counter,
            logger,
            config,
            replay_dir=self.replay_dir,
            models_dir=self.models_dir,
            **kwargs,
        )
        self.learner_process: Optional[Process] = None
        self._num_train_steps = getattr(config.training, "num_train_steps_per_epoch", 100)

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
        if self.learner_process is not None and self.learner_process.is_alive():
            return
        self.learner_process = Process(target=self._learner_loop, daemon=True)
        self.learner_process.start()

    # ------------------------------------------------------------------
    def solve(self, instance):
        """
        Main solve method that follows the standard VNE solver pattern.
        This should work exactly like other solvers in the framework.
        """
        v_net, p_net = instance['v_net'], instance['p_net']
        
        # Create solution following the standard pattern
        solution = Solution.from_v_net(v_net)
        
        # Load latest policy weights if available
        if os.path.exists(self.policy_path):
            self.actor.policy.load_state_dict(
                torch.load(self.policy_path, map_location=self.actor.device)
            )
        
        # Use the actor to determine node mappings via MCTS
        node_mapping_result = self._node_mapping_with_mcts(v_net, p_net, solution)
        
        if node_mapping_result:
            # Standard link mapping using the controller
            link_mapping_result = self.controller.link_mapper.link_mapping(
                v_net, p_net, solution=solution,
                shortest_method=self.shortest_method, 
                k=self.k_shortest, 
                inplace=True
            )
            if link_mapping_result:
                solution['result'] = True
                return solution
            else:
                solution['route_result'] = False
        else:
            solution['place_result'] = False
            
        solution['result'] = False
        return solution

    def _node_mapping_with_mcts(self, v_net, p_net, solution):
        """Use MCTS to determine node mappings, then use controller to place them."""
        # Delegate to actor's consolidated solve method
        return self.actor.solve_vnr_with_mcts(v_net, p_net, solution, self.controller)

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
        
        self._start_learner()
        
        # Use the standard RLSolver distributed training if enabled
        if self.config.training.distributed_training:
            self.learn_distributedly(env, num_epochs, **kwargs)
        else:
            self.learn_singly(env, num_epochs, **kwargs)
        
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
        
        for epoch in range(num_epochs):
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
                
                if done:
                    break
                instance = next_instance
            
            pbar.close()
            
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
            print("=" * 80)
            self.logger.info(f"EPOCH {epoch + 1}/{num_epochs} SUMMARY")
            print("=" * 80)
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
                print("HEALTH WARNINGS:")
                for warning in warnings:
                    self.logger.warning(f"   {warning}")
            else:
                print("All metrics look healthy!")
                
            print("=" * 80)
        
        writer.close()

    def learn_distributedly(self, env, num_epochs: int, **kwargs) -> None:
        """Distributed training: split epochs among workers."""
        import multiprocessing as mp
        import copy
        
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
                args=(worker_id, self.config, epochs_per_worker, worker_seed, self.replay_dir, self.policy_path)
            )
            processes.append(process)
            process.start()
            self.logger.debug(f"Started worker {worker_id} (PID: {process.pid})")
        
        # Wait for all workers to complete
        for i, process in enumerate(processes):
            process.join()
            self.logger.debug(f"Worker {i} completed")
            
        print("All workers completed. Training finished!")

# Removed: _solve_vnr_with_mcts_worker - consolidated into actor.solve_vnr_with_mcts

def _worker_training_loop(worker_id: int, config, num_epochs: int, seed: int, replay_dir: str, policy_path: str) -> None:
    """Training loop for a single worker process."""
    import tqdm
    
    # print(f"Worker {worker_id}: Starting training with seed {seed}")
    
    # Set different random seed for each worker
    import random
    import numpy as np
    import torch
    random.seed(seed)
    np.random.seed(seed)
    torch.manual_seed(seed)
    if torch.cuda.is_available():
        torch.cuda.manual_seed(seed)
    
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
    worker_actor = AlphaZeroActor(
        controller, recorder, counter, logger, config,
        replay_dir=replay_dir,
        models_dir=os.path.dirname(policy_path),
    )
    
    total_vnrs = env.v_net_simulator.v_sim_setting['num_v_nets']
    
    for epoch in range(num_epochs):
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
            # Solve using MCTS (same as main solver)
            v_net, p_net = instance['v_net'], instance['p_net']
            from virne.core import Solution
            
            solution = Solution.from_v_net(v_net)
            
            # Load latest policy weights if available
            if os.path.exists(policy_path):
                worker_actor.policy.load_state_dict(
                    torch.load(policy_path, map_location=worker_actor.device)
                )
            
            # Use MCTS to solve this VNR - simplified version for worker
            node_mapping_result = worker_actor.solve_vnr_with_mcts(v_net, p_net, solution, controller)
            
            if node_mapping_result:
                # Standard link mapping using the controller
                link_mapping_result = controller.link_mapper.link_mapping(
                    v_net, p_net, solution=solution,
                    shortest_method='k_shortest', 
                    k=10, 
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
            
            if done:
                break
            instance = next_instance
        
        pbar.close()
        print(f"Worker {worker_id}: Epoch {epoch + 1} completed - {vnr_count} VNRs processed")
    
    print(f"Worker {worker_id}: All epochs completed")


    def close(self) -> None:
        if self.learner_process is not None:
            self.learner_process.terminate()
            self.learner_process.join()
            self.learner_process = None
