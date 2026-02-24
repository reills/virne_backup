"""PolicyNetwork wrapper for neural network policy/value inference.

This module encapsulates all neural network operations for the AlphaZero actor,
including model loading, batched GPU inference, and policy/value evaluation.
"""
from __future__ import annotations

import hashlib
import os
from typing import Tuple, Optional

import torch

from .net import ActorCritic
from .gpu_batch_worker import BatchedGPUManager


class PolicyNetwork:
    """Wraps neural network for policy/value inference with optional batched GPU."""

    def __init__(
        self,
        model_config: dict,
        policy_path: str,
        device: torch.device,
        use_batched_gpu: bool = False,
        batch_size: int = 32,
        gpu_timeout_ms: int = 10,
        logger = None
    ):
        """Initialize PolicyNetwork.

        Args:
            model_config: Configuration dict for ActorCritic model
            policy_path: Path to saved model weights
            device: Device to run inference on (cuda/cpu)
            use_batched_gpu: Whether to use batched GPU worker
            batch_size: Batch size for GPU worker
            gpu_timeout_ms: Timeout for GPU worker in milliseconds
            logger: Logger instance for diagnostic messages
        """
        self.model_config = model_config
        self.policy_path = policy_path
        self.device = device
        self.use_batched_gpu = use_batched_gpu and torch.cuda.is_available()
        self.logger = logger
        self._batched_failures = 0

        # Initialize the neural network model
        self.model = ActorCritic(**model_config).to(device)

        # Setup batched GPU worker if enabled
        if self.use_batched_gpu:
            self.gpu_manager = BatchedGPUManager(
                model_config=model_config,
                policy_path=policy_path,
                batch_size=batch_size,
                timeout_ms=gpu_timeout_ms
            )
            if self.logger:
                self.logger.info(f"🚀 PolicyNetwork using batched GPU inference (batch_size={batch_size})")
        else:
            self.gpu_manager = None
            if self.logger:
                self.logger.info("⚠️  PolicyNetwork using single-threaded GPU inference (slower)")

    def load_weights(self, alphazero_model_path: str = '', resume_training: bool = True) -> bool:
        """Load model weights with priority logic.

        Priority:
        1. Specific alphazero_model_path if provided
        2. Latest policy from policy_path if resume_training=True
        3. Random initialization (no weights loaded)

        Args:
            alphazero_model_path: Specific model path (highest priority)
            resume_training: Whether to resume from latest policy

        Returns:
            True if weights were loaded, False if using random init
        """
        model_loaded = False

        # Priority 1: Specific model path
        if alphazero_model_path and os.path.exists(alphazero_model_path):
            self.model.load_state_dict(torch.load(alphazero_model_path, map_location=self.device))
            if self.logger:
                self.logger.info(f"PolicyNetwork loaded from: {alphazero_model_path}")
            model_loaded = True

        # Priority 2: Resume from latest policy
        elif resume_training and os.path.exists(self.policy_path):
            self.model.load_state_dict(torch.load(self.policy_path, map_location=self.device))
            if self.logger:
                self.logger.info(f"PolicyNetwork resumed from: {self.policy_path}")
            model_loaded = True

        if not model_loaded:
            if self.logger:
                self.logger.info("PolicyNetwork starting from scratch (no pretrained model loaded)")
        else:
            self._log_model_fingerprint()

        self.model.eval()
        return model_loaded

    def _log_model_fingerprint(self):
        """Log diagnostic fingerprint of loaded model weights."""
        if not self.logger:
            return

        try:
            # SHA256 hash of weights
            h = hashlib.sha256()
            with torch.no_grad():
                for name, param in self.model.state_dict().items():
                    h.update(name.encode())
                    h.update(param.detach().cpu().numpy().tobytes())
            sha = h.hexdigest()

            # Parameter count
            n_params = sum(p.numel() for p in self.model.parameters())

            # First layer L2 norm
            first_lin = getattr(self.model.encoder, 'token_embed', None)
            l2 = float(first_lin.weight.detach().norm().item()) if first_lin is not None else float('nan')

            # GPU memory usage
            mem_alloc = 0
            mem_res = 0
            if self.device.type == 'cuda':
                mem_alloc = torch.cuda.memory_allocated(self.device)
                mem_res = torch.cuda.memory_reserved(self.device)

            self.logger.info(
                f"PolicyNetwork: sha256={sha[:12]}.. params={n_params} "
                f"token_embed_L2={l2:.3f} mem={mem_alloc/1e6:.1f}/{mem_res/1e6:.1f}MB device={self.device}"
            )
        except Exception as e:
            self.logger.debug(f"Could not log model fingerprint: {e}")

    def evaluate(self, obs: dict, use_nn_policy: bool = True, use_nn_value: bool = True) -> Tuple[Optional[torch.Tensor], float]:
        """Evaluate policy and value for given observation.

        Args:
            obs: Observation dictionary (should have CPU tensors for batched GPU)
            use_nn_policy: Whether to use NN policy (False = uniform)
            use_nn_value: Whether to use NN value (False = 0.0)

        Returns:
            Tuple of (logits_tensor, value_float)
            - logits_tensor: [num_actions] on CPU, or None on failure
            - value_float: scalar value estimate
        """
        logits_tensor = None
        value_float = 0.0

        if self.use_batched_gpu:
            try:
                logits, value = self.gpu_manager.evaluate(obs)

                # Process logits
                if isinstance(logits, torch.Tensor) and use_nn_policy:
                    logits_tensor = logits.detach().cpu()
                    if logits_tensor.dim() > 1:
                        logits_tensor = logits_tensor.squeeze(0)

                # Process value
                if use_nn_value:
                    try:
                        value_float = float(value)
                    except Exception:
                        value_float = 0.0
                return logits_tensor, value_float
            except Exception as exc:
                self._batched_failures += 1
                if self.logger:
                    self.logger.warning(f"Batched GPU evaluation failed: {exc}")
                    self.logger.warning("Restarting GPU worker and retrying once.")
                try:
                    if self.gpu_manager:
                        self.gpu_manager.restart()
                    logits, value = self.gpu_manager.evaluate(obs)
                    if isinstance(logits, torch.Tensor) and use_nn_policy:
                        logits_tensor = logits.detach().cpu()
                        if logits_tensor.dim() > 1:
                            logits_tensor = logits_tensor.squeeze(0)
                    if use_nn_value:
                        try:
                            value_float = float(value)
                        except Exception:
                            value_float = 0.0
                    return logits_tensor, value_float
                except Exception as exc2:
                    if self.logger:
                        self.logger.error(f"Batched GPU evaluation retry failed: {exc2}")
                    raise

        # Local single-threaded inference (non-batched path)
        with torch.inference_mode():
            obs_device = self._move_obs_to_device(obs)

            # Get logits
            if use_nn_policy:
                logits = self.model.act(obs_device)
                logits_tensor = logits.detach().cpu()
                if logits_tensor.dim() > 1:
                    logits_tensor = logits_tensor.squeeze(0)

            # Get value
            if use_nn_value:
                value = self.model.evaluate(obs_device)
                value_float = float(value.item())

        return logits_tensor, value_float

    def encode(self, inputs: dict) -> torch.Tensor:
        """Run encoder on inputs (used for pre-computing embeddings).

        Args:
            inputs: Input dictionary with "v_net_x" key

        Returns:
            Encoder output tensor
        """
        with torch.inference_mode():
            inputs_device = self._move_obs_to_device(inputs)
            return self.model.encode(inputs_device)

    def _move_obs_to_device(self, obs: dict) -> dict:
        """Move observation tensors/Data objects to model device.

        Args:
            obs: Observation dictionary

        Returns:
            Observation dictionary with tensors on device
        """
        if self.device.type == "cpu":
            return obs

        obs_device = {}
        for key, value in obs.items():
            if hasattr(value, "to"):
                obs_device[key] = value.to(self.device)
            else:
                obs_device[key] = value
        return obs_device

    def shutdown(self):
        """Cleanup method to shut down GPU worker if active."""
        if self.gpu_manager:
            self.gpu_manager.shutdown()

    def get_gpu_stats(self) -> Optional[dict]:
        """Get GPU worker statistics.

        Returns:
            Statistics dict if GPU worker is active, None otherwise
        """
        return self.gpu_manager.get_stats() if self.gpu_manager else None

    def __del__(self):
        """Ensure GPU worker is shut down on deletion."""
        if hasattr(self, 'gpu_manager') and self.gpu_manager:
            self.gpu_manager.shutdown()
