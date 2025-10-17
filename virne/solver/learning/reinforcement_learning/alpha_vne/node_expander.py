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
        dirichlet_alpha: float = 0.03,
        dirichlet_epsilon: float = 0.25,
        use_nn_policy: bool = True,
        use_nn_value: bool = True,
        uniform_prior: bool = False,
        logger=None
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
        priors = expansion["priors"]
        cand_action_ids = expansion["action_ids"]

        # Apply Dirichlet noise for root exploration (AlphaZero style)
        if add_dirichlet_noise and len(candidate_states) > 0:
            valid_indices = [i for i, st in enumerate(candidate_states) if st.p_node_id >= 0]
            if len(valid_indices) > 0:
                noise = np.random.dirichlet([self.dirichlet_alpha] * len(valid_indices))
                noise_map = {valid_indices[i]: noise[i] for i in range(len(valid_indices))}
                for i, state in enumerate(candidate_states):
                    prior_base = priors[i]
                    prior_noise = noise_map.get(i, 0.0)
                    prior = (1 - self.dirichlet_epsilon) * prior_base + self.dirichlet_epsilon * prior_noise
                    Node(node, state, prior=prior)
                if node.parent is None:
                    node._diag_root_priors = [
                        (1 - self.dirichlet_epsilon) * p + self.dirichlet_epsilon * noise_map.get(i, 0.0)
                        for i, p in enumerate(priors)
                    ]
                    node._diag_root_action_ids = cand_action_ids
            else:
                for i, state in enumerate(candidate_states):
                    Node(node, state, prior=priors[i])
                if node.parent is None:
                    node._diag_root_priors = priors[:]
                    node._diag_root_action_ids = cand_action_ids
        else:
            for i, state in enumerate(candidate_states):
                Node(node, state, prior=priors[i])
            if node.parent is None:
                node._diag_root_priors = priors[:]
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
        obs = self.obs_builder.build(state, self.policy_network.model, v_node_id)
        logits_tensor = None
        probs_tensor = None
        leaf_value = 0.0
        diag_value = None

        # Use PolicyNetwork for evaluation
        logits_tensor, value_float = self.policy_network.evaluate(
            obs,
            use_nn_policy=self.use_nn_policy,
            use_nn_value=self.use_nn_value
        )

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

        candidate_states = state.get_candidate_states()

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

        priors = [p if (p == p and p > 0.0 and p < float('inf')) else 0.0 for p in priors]
        total = sum(priors)
        if total <= 1e-12:
            n = max(len(candidate_states), 1)
            priors = [1.0 / n] * len(candidate_states)
        else:
            priors = [p / total for p in priors]

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
