"""NodeExpander for MCTS node expansion logic.

This module handles all node expansion operations for the AlphaZero MCTS,
including:
- Preparing expansion data (policy/value/candidates)
- Creating child nodes with priors
- Applying Dirichlet noise for root exploration
- Prior normalization
"""
from __future__ import annotations

import math
import time
from typing import List, TYPE_CHECKING

import numpy as np
import torch

from .node import Node, State

if TYPE_CHECKING:
    from .policy_network import PolicyNetwork
    from .observation_builder import ObservationBuilder


class NodeExpander:
    """Handles MCTS node expansion with neural network guidance."""

    def __init__(
        self,
        policy_network: PolicyNetwork,
        observation_builder: ObservationBuilder,
        controller,
        dirichlet_alpha: float = 0.1,
        dirichlet_epsilon: float = 0.25,
        use_nn_policy: bool = True,
        use_nn_value: bool = True,
        uniform_prior: bool = False,
        logger=None,
        timers: dict | None = None,
        sync_cuda_timing: bool = False
    ):
        """Initialize NodeExpander.

        Args:
            policy_network: PolicyNetwork for inference
            observation_builder: ObservationBuilder for state conversion
            controller: Controller for resource management
            dirichlet_alpha: Alpha parameter for Dirichlet noise
            dirichlet_epsilon: Mixing weight for Dirichlet noise
            use_nn_policy: Whether to use NN policy (False = uniform)
            use_nn_value: Whether to use NN value (False = 0.0)
            uniform_prior: Force uniform priors regardless of NN
            logger: Logger instance
        """
        self.policy_network = policy_network
        self.obs_builder = observation_builder
        self.controller = controller
        self.dirichlet_alpha = dirichlet_alpha
        self.dirichlet_epsilon = dirichlet_epsilon
        self.use_nn_policy = use_nn_policy
        self.use_nn_value = use_nn_value
        self.uniform_prior = uniform_prior
        self.logger = logger
        self.timers = timers
        self.sync_cuda_timing = bool(sync_cuda_timing)

    @staticmethod
    def _renormalize_priors(priors: List[float]) -> List[float]:
        cleaned = [
            float(p) if (p == p and p > 0.0 and p < float("inf")) else 0.0
            for p in priors
        ]
        total = float(sum(cleaned))
        if total <= 1e-12:
            n = max(len(cleaned), 1)
            return [1.0 / n] * len(cleaned)
        return [p / total for p in cleaned]

    def _effective_root_dirichlet_alpha(self, num_feasible_children: int) -> float:
        """Use dynamic root-alpha scaling over feasible root children."""
        if num_feasible_children <= 0:
            return max(float(self.dirichlet_alpha), 1e-6)
        return float(np.clip(10.0 / float(num_feasible_children), 0.03, 0.30))

    def _apply_root_dirichlet_noise(
        self,
        priors: List[float],
        candidate_states: List[State],
    ) -> List[float]:
        """Mix Dirichlet noise over surviving feasible root children only."""
        if not candidate_states:
            return []

        mixed_priors = list(priors)
        feasible_indices = [i for i, st in enumerate(candidate_states) if int(st.p_node_id) >= 0]
        if not feasible_indices:
            return self._renormalize_priors(mixed_priors)

        base = np.array([max(0.0, float(mixed_priors[i])) for i in feasible_indices], dtype=np.float64)
        base_sum = float(base.sum())
        if base_sum <= 1e-12:
            base = np.full(len(feasible_indices), 1.0 / float(len(feasible_indices)), dtype=np.float64)
        else:
            base /= base_sum

        alpha = self._effective_root_dirichlet_alpha(len(feasible_indices))
        noise = np.random.dirichlet([alpha] * len(feasible_indices))
        mixed = (1.0 - float(self.dirichlet_epsilon)) * base + float(self.dirichlet_epsilon) * noise
        mixed_sum = float(mixed.sum())
        if mixed_sum <= 1e-12:
            mixed = np.full(len(feasible_indices), 1.0 / float(len(feasible_indices)), dtype=np.float64)
        else:
            mixed /= mixed_sum

        for local_idx, prior_idx in enumerate(feasible_indices):
            mixed_priors[prior_idx] = float(mixed[local_idx])

        return self._renormalize_priors(mixed_priors)

    def set_timers(self, timers: dict | None) -> None:
        """Attach a per-solve timers dict for benchmarking."""
        self.timers = timers

    def _bump_timer(self, key: str, delta_ms: float) -> None:
        if self.timers is None:
            return
        try:
            self.timers[key] = float(self.timers.get(key, 0.0)) + float(delta_ms)
        except Exception:
            pass

    def _maybe_sync_cuda(self) -> None:
        if not self.sync_cuda_timing:
            return
        try:
            if torch.cuda.is_available():
                torch.cuda.synchronize()
        except Exception:
            pass

    def expand_node(self, node: Node, v_node_id: int | None = None, add_dirichlet_noise: bool = False) -> None:
        """Expand node using neural network policy and cache value (single NN call).

        If v_node_id is None, uses node.state's next virtual node according to its ordering.

        Args:
            node: Node to expand
            v_node_id: Virtual node ID being placed (None = infer from state)
            add_dirichlet_noise: Whether to add Dirichlet noise (for root exploration)
        """
        expansion = self._prepare_expansion(node.state, v_node_id)
        candidate_states = expansion["candidate_states"]
        priors = self._renormalize_priors(expansion["priors"])
        cand_action_ids = expansion["action_ids"]
        final_priors = priors
        if add_dirichlet_noise and node.parent is None and candidate_states:
            final_priors = self._apply_root_dirichlet_noise(priors, candidate_states)
        else:
            final_priors = self._renormalize_priors(priors)

        for i, state in enumerate(candidate_states):
            Node(node, state, prior=final_priors[i])
        if node.parent is None:
            node._diag_root_priors = final_priors[:]
            node._diag_root_action_ids = cand_action_ids

        node.leaf_value = expansion["leaf_value"]
        if node.parent is None and expansion["diag_value"] is not None:
            node._diag_root_value = expansion["diag_value"]

    def _prepare_expansion(self, state: State, v_node_id: int | None = None) -> dict:
        """Compute policy/value/candidate data needed to expand a state.

        Returns a dictionary containing:
            - obs: observation dict (CPU tensors)
            - logits: raw logits tensor (or None on failure)
            - probs: normalized probability tensor (1D)
            - leaf_value: float value estimate
            - candidate_states: list[State] of next states (non-terminal)
            - priors: list[float] aligned with candidate_states
            - action_ids: list[int] per candidate (physical node id or special)
        """
        t_obs = time.perf_counter()
        obs = self.obs_builder.build(state, self.policy_network.model, v_node_id)
        self._bump_timer("build_inputs_ms", (time.perf_counter() - t_obs) * 1000.0)
        logits_tensor = None
        probs_tensor = None
        leaf_value = 0.0
        diag_value = None

        # Use PolicyNetwork for evaluation
        self._maybe_sync_cuda()
        t_eval = time.perf_counter()
        logits_tensor, value_float = self.policy_network.evaluate(
            obs,
            use_nn_policy=self.use_nn_policy,
            use_nn_value=self.use_nn_value
        )
        self._maybe_sync_cuda()
        self._bump_timer("policy_eval_ms", (time.perf_counter() - t_eval) * 1000.0)

        # Process logits into probabilities
        if logits_tensor is not None:
            probs_tensor = torch.softmax(logits_tensor, dim=-1)
            probs_tensor = torch.where(torch.isfinite(probs_tensor), probs_tensor, torch.zeros_like(probs_tensor))

        # Set values
        if self.use_nn_value:
            leaf_value = value_float
            diag_value = value_float
        else:
            leaf_value = 0.0
            diag_value = None

        t_cand = time.perf_counter()
        candidate_states = state.get_candidate_states()
        self._bump_timer("candidate_ms", (time.perf_counter() - t_cand) * 1000.0)

        # Inject fallback candidates when necessary (mirrors original logic)
        candidate_states = [st for st in candidate_states if st.p_node_id != -1]
        if not candidate_states:
            try:
                if getattr(self.policy_network.model.actor.decoder, 'allow_rejection', False):
                    reject_idx = getattr(state._original_p_net, 'num_nodes', state.p_net.num_nodes)
                    candidate_states = [state._create_child_state(reject_idx)]
                else:
                    candidate_states = [state._create_child_state(-1)]
            except Exception:
                candidate_states = [state._create_child_state(-1)]

        # Determine priors for candidates
        priors = []
        cand_action_ids = []
        if self.uniform_prior or not self.use_nn_policy or probs_tensor is None:
            n = max(len(candidate_states), 1)
            priors = [1.0 / n] * len(candidate_states)
            cand_action_ids = [st.p_node_id for st in candidate_states]
        else:
            num_actions = getattr(self.policy_network.model.actor.decoder, 'num_actions', None)
            if num_actions is not None and probs_tensor.numel() == num_actions:
                for st in candidate_states:
                    a = st.p_node_id
                    cand_action_ids.append(a if a is not None else -1)
                    if a is not None and 0 <= a < probs_tensor.numel():
                        priors.append(float(probs_tensor[a].item()))
                    else:
                        priors.append(0.0)
            elif probs_tensor.dim() == 1 and probs_tensor.numel() == len(candidate_states):
                priors = [float(x) for x in probs_tensor.tolist()]
                cand_action_ids = [st.p_node_id for st in candidate_states]
            else:
                n = max(len(candidate_states), 1)
                priors = [1.0 / n] * len(candidate_states)
                cand_action_ids = [st.p_node_id for st in candidate_states]

        priors = self._renormalize_priors(priors)

        num_actions = getattr(self.policy_network.model.actor.decoder, 'num_actions', None)
        if num_actions is None:
            num_actions = getattr(state._original_p_net, 'num_nodes', state.p_net.num_nodes)
            if getattr(self.policy_network.model.actor.decoder, 'allow_rejection', False):
                num_actions += 1

        if logits_tensor is None or logits_tensor.numel() != num_actions:
            logits_tensor_fallback = torch.full((num_actions,), -1e9, dtype=torch.float32)
            for action, prior in zip(cand_action_ids, priors):
                if action is not None and 0 <= action < num_actions:
                    logits_tensor_fallback[action] = math.log(max(prior, 1e-8))
            logits_tensor = logits_tensor_fallback
        else:
            logits_tensor = logits_tensor.to(torch.float32)

        action_mask = obs.get("action_mask")
        if isinstance(action_mask, torch.Tensor):
            action_mask_tensor = action_mask.squeeze(0).to(torch.bool)
        else:
            action_mask_tensor = torch.ones(num_actions, dtype=torch.bool)

        return {
            "logits": logits_tensor,
            "leaf_value": leaf_value,
            "diag_value": diag_value,
            "candidate_states": candidate_states,
            "priors": priors,
            "action_ids": cand_action_ids,
            "action_mask": action_mask_tensor,
        }
