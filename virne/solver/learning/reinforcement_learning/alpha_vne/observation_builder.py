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
        self._obs_p_data = None
        self._cached_node_allocations = {}
        self._cached_link_allocations = {}
        self._edge_positions_by_id = None
        self._edge_lookup_ref = None
        self._resource_signature = None

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
        self._reset_cpp_observation_cache()

    def clear_episode_data(self):
        """Clear cached episode data (used when NN guidance is disabled)."""
        self._p_data = None
        self._v_data = None
        self._encoder_outputs = None
        self._reset_cpp_observation_cache()

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

        if self._p_data is None or self._v_data is None or self._encoder_outputs is None:
            raise RuntimeError("Episode data not prepared; call set_episode_data() before build().")

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

        p_data = self._get_or_create_episode_observation_data(
            edge_lookup=edge_lookup,
            node_resource_names=node_resource_names,
            link_resource_names=link_resource_names,
        )
        v_data = self._v_data
        encoder_outputs = self._encoder_outputs

        node_allocations = self._get_sparse_allocations(cpp_state, "get_allocated_node_resources")
        if node_allocations is not None:
            self._apply_sparse_node_allocation_updates(node_allocations, node_resource_names)
        else:
            self._refresh_all_node_resources(cpp_state, node_resource_names)
            self._cached_node_allocations = {}

        link_allocations = self._get_sparse_allocations(cpp_state, "get_allocated_link_resources")
        if link_allocations is not None:
            self._apply_sparse_link_allocation_updates(link_allocations, link_resource_names)
        else:
            self._refresh_all_link_resources(cpp_state, link_resource_names, edge_lookup)
            self._cached_link_allocations = {}

        selected_nodes = list(cpp_state.selected_physical_nodes)
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
        total_virtual = len(cpp_state.virtual_order)
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

    def _reset_cpp_observation_cache(self) -> None:
        """Reset episode-local mutable observation caches."""
        self._obs_p_data = None
        self._cached_node_allocations = {}
        self._cached_link_allocations = {}
        self._edge_positions_by_id = None
        self._edge_lookup_ref = None
        self._resource_signature = None

    def _clone_p_data(self) -> Data:
        """Clone the static physical graph data for mutable per-step updates."""
        if hasattr(self._p_data, "clone"):
            return self._p_data.clone()
        return Data(
            x=self._p_data.x.clone() if getattr(self._p_data, "x", None) is not None else None,
            edge_index=self._p_data.edge_index.clone() if getattr(self._p_data, "edge_index", None) is not None else None,
            edge_attr=self._p_data.edge_attr.clone() if getattr(self._p_data, "edge_attr", None) is not None else None,
            num_nodes=getattr(self._p_data, "num_nodes", None),
        )

    def _get_or_create_episode_observation_data(
        self,
        edge_lookup: dict,
        node_resource_names: list,
        link_resource_names: list,
    ) -> Data:
        """Get mutable observation graph, rebuilding caches only when episode settings change."""
        signature = (tuple(node_resource_names), tuple(link_resource_names))
        if self._obs_p_data is None or self._resource_signature != signature:
            self._obs_p_data = self._clone_p_data()
            self._cached_node_allocations = {}
            self._cached_link_allocations = {}
            self._resource_signature = signature
            self._edge_positions_by_id = None
            self._edge_lookup_ref = None

        if self._edge_positions_by_id is None or self._edge_lookup_ref is not edge_lookup:
            self._edge_positions_by_id = self._build_edge_positions_by_id(self._obs_p_data, edge_lookup)
            self._edge_lookup_ref = edge_lookup
            self._cached_link_allocations = {}

        return self._obs_p_data

    def _build_edge_positions_by_id(self, p_data: Data, edge_lookup: dict) -> dict:
        """Build mapping from C++ edge IDs to one or more edge_attr rows in PyG Data."""
        edge_positions_by_id = {}
        edge_index = getattr(p_data, "edge_index", None)
        if edge_index is None:
            return edge_positions_by_id

        for edge_pos in range(edge_index.size(1)):
            u = int(edge_index[0, edge_pos].item())
            v = int(edge_index[1, edge_pos].item())
            edge_id = self._get_cpp_edge_id(u, v, edge_lookup)
            if edge_id < 0:
                continue
            edge_positions_by_id.setdefault(edge_id, []).append(edge_pos)
        return edge_positions_by_id

    @staticmethod
    def _normalize_sparse_allocations(allocations) -> dict:
        """Normalize pybind sparse-allocation dicts into plain Python dict[int][str] -> float."""
        normalized = {}
        if not isinstance(allocations, dict):
            return normalized
        for item_id, attrs in allocations.items():
            if not isinstance(attrs, dict):
                continue
            attr_values = {}
            for attr_name, value in attrs.items():
                float_value = float(value)
                if abs(float_value) <= 1e-12:
                    continue
                attr_values[str(attr_name)] = float_value
            if attr_values:
                normalized[int(item_id)] = attr_values
        return normalized

    def _get_sparse_allocations(self, cpp_state, method_name: str):
        """Read sparse allocations if supported by the C++ binding, otherwise return None."""
        getter = getattr(cpp_state, method_name, None)
        if getter is None:
            return None
        try:
            allocations = getter()
        except Exception:
            return None
        return self._normalize_sparse_allocations(allocations)

    def _apply_sparse_node_allocation_updates(self, curr_allocations: dict, node_resource_names: list) -> None:
        """Update only node features whose allocated resources changed between states."""
        p_data = self._obs_p_data
        if getattr(p_data, "x", None) is None:
            self._cached_node_allocations = {}
            return

        node_feat_count = min(len(node_resource_names), p_data.x.size(1))
        if node_feat_count <= 0:
            self._cached_node_allocations = {}
            return

        resource_to_feat = {
            attr_name: feat_idx
            for feat_idx, attr_name in enumerate(node_resource_names[:node_feat_count])
        }
        changed_node_ids = set(self._cached_node_allocations.keys()) | set(curr_allocations.keys())
        for node_id in changed_node_ids:
            if node_id < 0 or node_id >= p_data.x.size(0):
                continue
            prev_attrs = self._cached_node_allocations.get(node_id, {})
            curr_attrs = curr_allocations.get(node_id, {})
            for attr_name, feat_idx in resource_to_feat.items():
                prev_alloc = float(prev_attrs.get(attr_name, 0.0))
                curr_alloc = float(curr_attrs.get(attr_name, 0.0))
                if abs(prev_alloc - curr_alloc) <= 1e-12:
                    continue
                p_data.x[node_id, feat_idx] = self._p_data.x[node_id, feat_idx] - curr_alloc

        self._cached_node_allocations = {
            node_id: dict(attrs) for node_id, attrs in curr_allocations.items()
        }

    def _apply_sparse_link_allocation_updates(self, curr_allocations: dict, link_resource_names: list) -> None:
        """Update only edge features whose allocated resources changed between states."""
        p_data = self._obs_p_data
        if getattr(p_data, "edge_attr", None) is None or p_data.edge_attr.numel() == 0:
            self._cached_link_allocations = {}
            return

        edge_feat_count = min(len(link_resource_names), p_data.edge_attr.size(1))
        if edge_feat_count <= 0:
            self._cached_link_allocations = {}
            return

        resource_to_feat = {
            attr_name: feat_idx
            for feat_idx, attr_name in enumerate(link_resource_names[:edge_feat_count])
        }
        changed_edge_ids = set(self._cached_link_allocations.keys()) | set(curr_allocations.keys())
        for edge_id in changed_edge_ids:
            edge_positions = self._edge_positions_by_id.get(edge_id, [])
            if not edge_positions:
                continue
            prev_attrs = self._cached_link_allocations.get(edge_id, {})
            curr_attrs = curr_allocations.get(edge_id, {})
            for attr_name, feat_idx in resource_to_feat.items():
                prev_alloc = float(prev_attrs.get(attr_name, 0.0))
                curr_alloc = float(curr_attrs.get(attr_name, 0.0))
                if abs(prev_alloc - curr_alloc) <= 1e-12:
                    continue
                for edge_pos in edge_positions:
                    p_data.edge_attr[edge_pos, feat_idx] = self._p_data.edge_attr[edge_pos, feat_idx] - curr_alloc

        self._cached_link_allocations = {
            edge_id: dict(attrs) for edge_id, attrs in curr_allocations.items()
        }

    def _refresh_all_node_resources(self, cpp_state, node_resource_names: list) -> None:
        """Fallback: refresh all node resources when sparse C++ allocation APIs are unavailable."""
        p_data = self._obs_p_data
        if getattr(p_data, "x", None) is None:
            return
        for node_idx in range(p_data.x.size(0)):
            for feat_idx, attr_name in enumerate(node_resource_names):
                if feat_idx >= p_data.x.size(1):
                    break
                available = cpp_state.get_available_node_resource(int(node_idx), attr_name)
                p_data.x[node_idx, feat_idx] = float(available)

    def _refresh_all_link_resources(self, cpp_state, link_resource_names: list, edge_lookup: dict) -> None:
        """Fallback: refresh all edge resources when sparse C++ allocation APIs are unavailable."""
        p_data = self._obs_p_data
        if getattr(p_data, "edge_attr", None) is None or p_data.edge_attr.numel() == 0:
            return
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
