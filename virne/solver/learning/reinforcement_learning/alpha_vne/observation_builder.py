"""Observation building for converting game states to neural network inputs."""
from __future__ import annotations

import torch
from torch_geometric.data import Data

from .common import state_to_obs


class ObservationBuilder:
    """Converts game state to neural network observation."""

    def __init__(self, controller, device: torch.device = None):
        """Initialize ObservationBuilder.

        Args:
            controller: Controller object for finding candidate nodes
            device: Device to build observations on (default: CPU for IPC safety)
        """
        self.controller = controller
        self.device = device if device is not None else torch.device("cpu")

        # Caches used during one solve episode (set by actor)
        self._p_data = None
        self._v_data = None
        self._encoder_outputs = None

    def set_episode_data(self, p_data, v_data, encoder_outputs):
        """Set cached data for the current episode.

        Args:
            p_data: Physical network PyG Data
            v_data: Virtual network PyG Data
            encoder_outputs: Pre-computed encoder outputs
        """
        self._p_data = p_data
        self._v_data = v_data
        self._encoder_outputs = encoder_outputs

    def build(self, state, policy, v_node_id: int = None) -> dict:
        """Build observation dict from state.

        Args:
            state: Game state object
            policy: Neural network policy (for encoder)
            v_node_id: Virtual node ID to place (if None, inferred from state)

        Returns:
            Observation dictionary with CPU tensors for IPC safety
        """
        if v_node_id is None:
            v_node_id = state.v_node_id + 1

        # Use real encoder outputs (computed once per episode, kept on CPU for IPC)
        return state_to_obs(
            state,
            policy,
            self.controller,
            self.device,  # Always build obs on CPU for IPC safety
            p_data=self._p_data,
            v_data=self._v_data,
            encoder_outputs=self._encoder_outputs,
            v_node_id=v_node_id,
        )

    def build_from_cpp_state(self, cpp_state, policy, node_resource_names: list,
                            link_resource_names: list, edge_lookup: dict) -> dict:
        """Build observation from C++ VNRState.

        Args:
            cpp_state: C++ VNRState object
            policy: Neural network policy (for decoder settings)
            node_resource_names: List of node resource attribute names
            link_resource_names: List of link resource attribute names
            edge_lookup: Dictionary mapping (u, v) tuples to edge indices

        Returns:
            Observation dictionary
        """
        if self._p_data is None or self._v_data is None or self._encoder_outputs is None:
            raise RuntimeError("Episode data not set; call set_episode_data() first.")

        # Clone static tensors to avoid mutating cached copies
        p_data = self._p_data.clone() if hasattr(self._p_data, "clone") else self._p_data
        v_data = self._v_data
        encoder_outputs = self._encoder_outputs

        # Update residual node resources
        if getattr(p_data, "x", None) is not None:
            for node_idx in range(p_data.x.size(0)):
                for feat_idx, attr_name in enumerate(node_resource_names):
                    if feat_idx >= p_data.x.size(1):
                        break
                    available = cpp_state.get_available_node_resource(int(node_idx), attr_name)
                    p_data.x[node_idx, feat_idx] = float(available)

        # Update residual link resources
        if getattr(p_data, "edge_attr", None) is not None and p_data.edge_attr.numel() > 0:
            edge_index = p_data.edge_index
            for edge_pos in range(edge_index.size(1)):
                u = int(edge_index[0, edge_pos].item())
                v = int(edge_index[1, edge_pos].item())
                edge_id = self._get_cpp_edge_id(u, v, edge_lookup)
                if edge_id < 0:
                    continue
                for feat_idx, attr_name in enumerate(link_resource_names):
                    if feat_idx >= p_data.edge_attr.size(1):
                        break
                    available = cpp_state.get_available_link_resource(edge_id, attr_name)
                    p_data.edge_attr[edge_pos, feat_idx] = float(available)

        selected_nodes = list(cpp_state.selected_physical_nodes())
        history_len = len(selected_nodes) + 1
        num_features = p_data.x.size(1) if getattr(p_data, "x", None) is not None else 0
        hist_dtype = p_data.x.dtype if num_features > 0 else torch.float32
        history_features = torch.zeros((1, history_len, num_features), dtype=hist_dtype)

        # Get start embedding from policy decoder
        start_embedding = policy.actor.decoder.start_embedding.detach().cpu()
        if num_features > 0 and start_embedding.numel() > 0:
            length = min(num_features, start_embedding.numel())
            history_features[0, 0, :length] = start_embedding[:length].to(hist_dtype)

        for idx, node in enumerate(selected_nodes):
            if 0 <= node < getattr(p_data, "num_nodes", p_data.x.size(0)):
                history_features[0, idx + 1] = p_data.x[node]

        curr_step_idx = len(selected_nodes)
        total_virtual = len(cpp_state.virtual_order())
        vnfs_remaining = max(total_virtual - (curr_step_idx + 1), 0)

        # Determine action mask size
        num_actions = self._get_num_actions(policy, p_data)
        action_mask = torch.zeros(num_actions, dtype=torch.bool)
        candidates = cpp_state.get_candidate_nodes()
        for action in candidates:
            if 0 <= action < action_mask.numel():
                action_mask[action] = True

        obs = {
            "p_net": p_data,
            "history_features": history_features,
            "encoder_outputs": encoder_outputs,
            "curr_v_node_id": torch.tensor([curr_step_idx], dtype=torch.long),
            "vnfs_remaining": torch.tensor([vnfs_remaining], dtype=torch.long),
            "action_mask": action_mask.unsqueeze(0),
            "v_net_x": v_data.x.unsqueeze(0),
        }
        return obs

    def obs_to_cpu(self, obs: dict) -> dict:
        """Convert observation tensors to CPU for serialization.

        Args:
            obs: Observation dictionary

        Returns:
            Observation dictionary with CPU tensors converted to lists
        """
        obs_cpu = {}
        for key, value in obs.items():
            if key == 'p_net' and isinstance(value, Data):
                # For PyG Data, serialize to dict representation
                obs_cpu[key] = {
                    'x': value.x.cpu().tolist(),
                    'edge_index': value.edge_index.cpu().tolist(),
                    'edge_attr': value.edge_attr.cpu().tolist() if value.edge_attr is not None else None,
                    'num_nodes': value.num_nodes,
                }
            elif isinstance(value, torch.Tensor):
                obs_cpu[key] = value.cpu().tolist()
            else:
                obs_cpu[key] = value
        return obs_cpu

    @staticmethod
    def _get_cpp_edge_id(u: int, v: int, edge_lookup: dict) -> int:
        """Get C++ edge ID from node pair."""
        if (u, v) in edge_lookup:
            return edge_lookup[(u, v)]
        return edge_lookup.get((v, u), -1)

    @staticmethod
    def _get_num_actions(policy, p_data) -> int:
        """Determine the number of actions in the action space."""
        actor_module = getattr(policy, "actor", None)
        decoder = getattr(actor_module, "decoder", None) if actor_module is not None else None
        if decoder is not None and hasattr(decoder, "num_actions"):
            return int(decoder.num_actions)

        allow_rejection = bool(getattr(decoder, "allow_rejection", False)) if decoder is not None else False
        if p_data is not None and getattr(p_data, "x", None) is not None:
            base_actions = int(p_data.x.size(0))
            return base_actions + 1 if allow_rejection else base_actions
        return 0
