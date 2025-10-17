"""Trajectory recording and replay buffer management for AlphaZero."""
from __future__ import annotations

import json
import os
import random
from typing import List

import numpy as np
import torch


class NumpyEncoder(json.JSONEncoder):
    """Custom JSON encoder for numpy and PyTorch data types."""
    def default(self, obj):
        if isinstance(obj, np.integer):
            return int(obj)
        elif isinstance(obj, np.floating):
            return float(obj)
        elif isinstance(obj, np.ndarray):
            return obj.tolist()
        elif isinstance(obj, torch.Tensor):
            return obj.cpu().tolist()
        return super().default(obj)


class TrajectoryWriter:
    """Handles trajectory recording and replay buffer management."""

    def __init__(self, config, replay_dir: str = "replay_buffer", policy_path: str = None,
                 disable_trajectory_writing: bool = False):
        """Initialize TrajectoryWriter.

        Args:
            config: Configuration object with training settings
            replay_dir: Directory to store replay buffer files
            policy_path: Path to the policy model (for fingerprinting)
            disable_trajectory_writing: If True, disable all trajectory recording
        """
        self.config = config
        self.replay_dir = replay_dir
        self.policy_path = policy_path
        self.enabled = not disable_trajectory_writing

        if self.enabled:
            os.makedirs(self.replay_dir, exist_ok=True)

        # Replay buffer size limit
        self.max_buffer_size = getattr(config.training, 'replay_buffer_max_size', 500000)

    def save_episode(self, static_environment: dict, trajectory: List[dict],
                     final_reward: float, policy_state_dict: dict = None) -> None:
        """Save complete episode to replay buffer.

        Args:
            static_environment: Static environment data (networks, etc.)
            trajectory: List of timestep dictionaries
            final_reward: Final reward for the episode
            policy_state_dict: Optional policy state dict for fingerprinting
        """
        if not self.enabled:
            return

        # Include model fingerprint for traceability
        policy_sha = None
        if policy_state_dict is not None:
            try:
                import hashlib
                h = hashlib.sha256()
                for n, p in policy_state_dict.items():
                    h.update(n.encode())
                    h.update(p.detach().cpu().numpy().tobytes())
                policy_sha = h.hexdigest()
            except Exception:
                pass

        # File mtime for version tracing
        policy_mtime = None
        try:
            if self.policy_path and os.path.exists(self.policy_path):
                policy_mtime = os.path.getmtime(self.policy_path)
        except Exception:
            pass

        data = {
            "static_environment": static_environment,
            "trajectory": trajectory,
            "final_reward": final_reward,
            "model": {
                "policy_path": self.policy_path,
                "sha256": policy_sha,
                "mtime": policy_mtime,
            }
        }

        path = os.path.join(self.replay_dir, f"{random.random():.6f}.json")
        with open(path, "w") as f:
            json.dump(data, f, cls=NumpyEncoder)

        self.cleanup()

    def cleanup(self, keep: int = None) -> None:
        """Clean up old replay buffer files, keeping only the most recent ones.

        Args:
            keep: Number of files to keep (defaults to max_buffer_size)
        """
        if not self.enabled:
            return

        if keep is None:
            keep = self.max_buffer_size

        files = sorted([f for f in os.listdir(self.replay_dir) if f.endswith(".json")])
        if len(files) > keep:
            for f in files[:-keep]:
                os.remove(os.path.join(self.replay_dir, f))
