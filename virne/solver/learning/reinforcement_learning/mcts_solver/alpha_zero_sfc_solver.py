from __future__ import annotations

import os
from multiprocessing import Process
from typing import Optional

import torch

from virne.solver.base_solver import Solver, SolverRegistry

from .actor import AlphaZeroActor
from .learner import AlphaZeroLearner


@SolverRegistry.register(solver_name="alpha_zero_sfc", solver_type="r_learning")
class AlphaZeroSFCSolver(Solver):
    """Orchestrator that manages Actor and Learner processes."""

    def __init__(
        self,
        controller,
        recorder,
        counter,
        logger,
        config,
        replay_dir: str = "replay_buffer",
        batch_size: int = 32,
        **kwargs,
    ) -> None:
        super().__init__(controller, recorder, counter, logger, config, **kwargs)
        self.replay_dir = replay_dir
        self.batch_size = batch_size
        os.makedirs(self.replay_dir, exist_ok=True)
        self.policy_path = os.path.join(self.replay_dir, "policy_latest.pt")

        self.actor = AlphaZeroActor(
            controller,
            recorder,
            counter,
            logger,
            config,
            replay_dir=self.replay_dir,
            **kwargs,
        )
        self.learner_process: Optional[Process] = None
        self._num_train_steps = kwargs.get("num_train_steps_per_epoch", 100)

    # ------------------------------------------------------------------
    def _learner_loop(self) -> None:
        learner = AlphaZeroLearner(
            self.controller,
            self.recorder,
            self.counter,
            self.logger,
            self.config,
            replay_dir=self.replay_dir,
            batch_size=self.batch_size,
        )
        
        # Get termination conditions from config
        max_training_steps = getattr(self.config.training, 'max_training_steps', 10000)
        min_buffer_size = getattr(self.config.training, 'min_buffer_size', 100)
        
        total_steps = 0
        consecutive_empty_batches = 0
        max_empty_batches = 50  # Stop if no data for 50 consecutive attempts
        
        while total_steps < max_training_steps:
            # Check if we have enough data to train
            replay_files = [f for f in os.listdir(self.replay_dir) if f.endswith('.json')]
            if len(replay_files) < min_buffer_size:
                consecutive_empty_batches += 1
                if consecutive_empty_batches > max_empty_batches:
                    print(f"Stopping learner: insufficient data for {max_empty_batches} attempts")
                    break
                import time
                time.sleep(1)  # Wait for more data
                continue
            
            consecutive_empty_batches = 0
            learner.train_steps(self._num_train_steps)
            total_steps += self._num_train_steps
            
        print(f"Learner terminated after {total_steps} training steps")

    def _start_learner(self) -> None:
        if self.learner_process is not None and self.learner_process.is_alive():
            return
        self.learner_process = Process(target=self._learner_loop, daemon=True)
        self.learner_process.start()

    # ------------------------------------------------------------------
    def solve(self, instance):
        if os.path.exists(self.policy_path):
            self.actor.policy.load_state_dict(
                torch.load(self.policy_path, map_location=self.actor.device)
            )
        return self.actor.solve(instance)

    def learn(self, env, num_epochs: int, start_epoch: int = 0, **kwargs) -> None:
        self._num_train_steps = kwargs.get("num_train_steps_per_epoch", self._num_train_steps)
        num_games = kwargs.get("num_games_per_epoch", 50)
        self._start_learner()

        for _ in range(start_epoch, num_epochs):
            for _ in range(num_games):
                instance = env.reset()
                self.solve(instance)

    def close(self) -> None:
        if self.learner_process is not None:
            self.learner_process.terminate()
            self.learner_process.join()
            self.learner_process = None
