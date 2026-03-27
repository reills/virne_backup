from __future__ import annotations

import copy
from typing import Any, Dict, Tuple

from torch_geometric.data import Data

from virne.core import Solution
from virne.solver.learning.rl_core.feature_constructor import PNetVNetFeatureConstructor
from virne.solver.learning.utils import get_pyg_data

P_TOPO_DEGREE_ATTR = "__az_p_degree__"
P_TOPO_CLOSENESS_ATTR = "__az_p_closeness__"
P_TOPO_EIGENVECTOR_ATTR = "__az_p_eigenvector__"
P_TOPO_BETWEENNESS_ATTR = "__az_p_betweenness__"
V_TOPO_DEGREE_ATTR = "__az_v_degree__"
V_TOPO_CLOSENESS_ATTR = "__az_v_closeness__"
V_TOPO_EIGENVECTOR_ATTR = "__az_v_eigenvector__"
V_TOPO_BETWEENNESS_ATTR = "__az_v_betweenness__"


def build_partial_solution_from_state(state) -> Solution:
    """Reconstruct the partial placement solution represented by an AlphaZero state."""
    solution = Solution.from_v_net(state.v_net)
    selected = list(getattr(state, "selected_p_net_nodes", []))
    v_order = list(getattr(state, "v_order", []))
    placed_count = min(len(selected), len(v_order))
    for idx in range(placed_count):
        v_node_id = int(v_order[idx])
        p_node_id = int(selected[idx])
        solution["node_slots"][v_node_id] = p_node_id
    return solution


class AlphaZeroFeatureAdapter:
    """Bridge AlphaZero state observations through the shared RL feature constructor stack."""

    def __init__(self, config: Any, p_net, v_net) -> None:
        self.config = config
        self.p_net = p_net
        self.v_net = v_net
        self.constructor = PNetVNetFeatureConstructor(p_net, v_net, config)

    def _materialize_p_net(self, state):
        p_net = copy.deepcopy(state._original_p_net)
        for node_id, attrs in getattr(state, "_resource_allocations", {}).get("node", {}).items():
            if node_id not in p_net.nodes:
                continue
            for attr_name, value in attrs.items():
                p_net.nodes[node_id][attr_name] = float(p_net.nodes[node_id].get(attr_name, 0.0)) - float(value)
        for edge_id, attrs in getattr(state, "_resource_allocations", {}).get("link", {}).items():
            if edge_id not in p_net.links:
                continue
            for attr_name, value in attrs.items():
                p_net.links[edge_id][attr_name] = float(p_net.links[edge_id].get(attr_name, 0.0)) - float(value)
        return p_net

    @staticmethod
    def resolve_curr_v_node_id(state, v_node_id: int | None = None) -> int:
        if v_node_id is not None:
            return int(v_node_id)
        next_pos = int(getattr(state, "v_node_id", -1)) + 1
        v_order = list(getattr(state, "v_order", []))
        if 0 <= next_pos < len(v_order):
            return int(v_order[next_pos])
        return next_pos

    def construct_features(self, state, v_node_id: int | None = None) -> Dict[str, Any]:
        curr_v_node_id = self.resolve_curr_v_node_id(state, v_node_id)
        solution = build_partial_solution_from_state(state)
        p_net = self._materialize_p_net(state)
        p_net_obs = self.constructor._construct_p_net_features(p_net, self.v_net, solution, curr_v_node_id)
        v_net_obs = self.constructor._construct_v_net_features(p_net, self.v_net, solution, curr_v_node_id)
        return {
            "p_net_x": p_net_obs["x"],
            "p_net_edge_index": p_net_obs["edge_index"],
            "p_net_edge_attr": p_net_obs["edge_attr"],
            "v_net_x": v_net_obs["x"],
            "v_net_edge_index": v_net_obs["edge_index"],
            "v_net_edge_attr": v_net_obs["edge_attr"],
        }

    def build_graphs(self, state, v_node_id: int | None = None) -> Tuple[Data, Data]:
        features = self.construct_features(state, v_node_id=v_node_id)
        p_data = get_pyg_data(
            features["p_net_x"],
            features["p_net_edge_index"],
            features.get("p_net_edge_attr"),
        )
        v_data = get_pyg_data(
            features["v_net_x"],
            features["v_net_edge_index"],
            features.get("v_net_edge_attr"),
        )
        return p_data, v_data

    @staticmethod
    def _to_float_dict(values: Dict[str, Any]) -> Dict[str, float]:
        return {str(key): float(value) for key, value in values.items()}

    def build_cpp_feature_metadata(self) -> Dict[str, Any]:
        return {
            "node_attr_benchmarks": self._to_float_dict(self.constructor.node_attr_benchmarks),
            "link_attr_benchmarks": self._to_float_dict(self.constructor.link_attr_benchmarks),
            "link_sum_attr_benchmarks": self._to_float_dict(self.constructor.link_sum_attr_benchmarks),
            "feature_use_node_status_flags": bool(self.config.rl.feature_constructor.if_use_node_status_flags),
            "feature_use_aggregated_link_attrs": bool(self.config.rl.feature_constructor.if_use_aggregated_link_attrs),
            "feature_use_degree_metric": bool(self.config.rl.feature_constructor.if_use_degree_metric),
            "feature_use_more_topological_metrics": bool(self.config.rl.feature_constructor.if_use_more_topological_metrics),
            "p_topological_metrics": {
                P_TOPO_DEGREE_ATTR: self.constructor.p_net_topological_metrics.node_degree_centrality,
                P_TOPO_CLOSENESS_ATTR: self.constructor.p_net_topological_metrics.node_closeness_centrality,
                P_TOPO_EIGENVECTOR_ATTR: self.constructor.p_net_topological_metrics.node_eigenvector_centrality,
                P_TOPO_BETWEENNESS_ATTR: self.constructor.p_net_topological_metrics.node_betweenness_centrality,
            },
            "v_topological_metrics": {
                V_TOPO_DEGREE_ATTR: self.constructor.v_net_topological_metrics.node_degree_centrality,
                V_TOPO_CLOSENESS_ATTR: self.constructor.v_net_topological_metrics.node_closeness_centrality,
                V_TOPO_EIGENVECTOR_ATTR: self.constructor.v_net_topological_metrics.node_eigenvector_centrality,
                V_TOPO_BETWEENNESS_ATTR: self.constructor.v_net_topological_metrics.node_betweenness_centrality,
            },
        }
