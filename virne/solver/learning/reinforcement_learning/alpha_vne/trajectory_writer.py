"""Trajectory recording and replay buffer management for AlphaZero."""
from __future__ import annotations

import json
import os
import random
import tempfile
import time
import uuid
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

    def save_episode(
        self,
        static_environment: dict,
        trajectory: List[dict],
        final_reward: float,
        policy_state_dict: dict = None,
        episode_metrics: dict | None = None,
    ) -> None:
        """Save complete episode to replay buffer.

        Args:
            static_environment: Static environment data (networks, etc.)
            trajectory: List of timestep dictionaries
            final_reward: Final reward for the episode
            policy_state_dict: Optional policy state dict for fingerprinting
            episode_metrics: Optional top-level episode metadata
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
        if isinstance(episode_metrics, dict):
            for key, value in episode_metrics.items():
                if key in ("static_environment", "trajectory", "model"):
                    continue
                data[key] = value

        # Use a truly unique filename across processes to avoid collisions.
        # Write to a unique temp file, then atomically replace to final path.
        os.makedirs(self.replay_dir, exist_ok=True)
        fd, tmp_path = tempfile.mkstemp(dir=self.replay_dir, prefix="episode_", suffix=".json.tmp")
        try:
            with os.fdopen(fd, "w") as f:
                json.dump(data, f, cls=NumpyEncoder)
                f.flush()
                os.fsync(f.fileno())
        except Exception:
            try:
                os.close(fd)
            except Exception:
                pass
            try:
                if os.path.exists(tmp_path):
                    os.remove(tmp_path)
            except Exception:
                pass
            raise

        # Generate a unique final name to prevent any collision with existing files.
        # Retry a few times if a rare collision occurs.
        replaced = False
        for _ in range(5):
            final_name = f"episode_{time.time_ns()}_{os.getpid()}_{uuid.uuid4().hex}.json"
            final_path = os.path.join(self.replay_dir, final_name)
            try:
                os.replace(tmp_path, final_path)
                replaced = True
                break
            except FileNotFoundError:
                # Temp file missing or path issue; fall back to rewriting next call.
                break
            except FileExistsError:
                # Extremely unlikely; retry with a new name.
                continue
        if not replaced and os.path.exists(tmp_path):
            try:
                os.remove(tmp_path)
            except Exception:
                pass

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
