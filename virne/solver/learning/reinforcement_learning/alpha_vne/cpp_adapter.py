"""Adapter that wires the C++ MCTS core into the Python AlphaZero actor."""
from __future__ import annotations

from typing import Dict, List, Optional, Tuple

import torch

from .node import Node, State

try:
    import alpha_zero_cpp_core as cpp_core  # type: ignore
except ImportError:  # pragma: no cover - optional dependency
    cpp_core = None


class CppMCTSAdapter:
    """Bridges the Python environment with the C++ MCTS engine via callbacks."""

    def __init__(self, actor, computation_budget: int, c_puct: float, dirichlet_alpha: float, dirichlet_epsilon: float,
                 use_neural_network: bool = True, rollout_depth_limit: int = 100):
        if cpp_core is None:
            raise RuntimeError("alpha_zero_cpp_core extension is not available.")

        self.actor = actor
        self._engine = cpp_core.MCTSEngine(
            self._build_config(computation_budget, c_puct, dirichlet_alpha, dirichlet_epsilon, use_neural_network, rollout_depth_limit)
        )
        self._engine.set_callbacks(
            self._expand_callback,
            self._evaluate_callback,
            self._terminal_value_callback,
            self._terminal_check_callback,
        )
        self._state_registry: Dict[int, State] = {}
        self._vnode_override: Dict[int, int] = {}
        self._cpp_p_network: cpp_core.Network | None = None
        self._cpp_v_network: cpp_core.Network | None = None
        self._root_cpp_config: cpp_core.VNRConfig | None = None
        self._edge_lookup: Dict[Tuple[int, int], int] = {}
        self._node_resource_names = [
            getattr(attr, "name", str(attr)) for attr in getattr(actor.controller, "node_resource_attrs", [])
        ]
        self._link_resource_names = [
            getattr(attr, "name", str(attr)) for attr in getattr(actor.controller, "link_resource_attrs", [])
        ]

    @staticmethod
    def _build_config(
        computation_budget: int,
        c_puct: float,
        dirichlet_alpha: float,
        dirichlet_epsilon: float,
        use_neural_network: bool = True,
        rollout_depth_limit: int = 100,
    ) -> cpp_core.SearchConfig:
        cfg = cpp_core.SearchConfig()
        cfg.simulations = computation_budget
        cfg.c_puct = float(c_puct)
        cfg.dirichlet_alpha = float(dirichlet_alpha)
        cfg.dirichlet_epsilon = float(dirichlet_epsilon)
        cfg.use_neural_network = bool(use_neural_network)
        cfg.rollout_depth_limit = int(rollout_depth_limit)
        return cfg

    # ------------------------------------------------------------------ API ------------------------------------------------------------------

    def run_search(self, root_node: Node, root_v_node_id: int) -> Optional[cpp_core.SearchResult]:
        """Run the C++ search and project the result back to the Python tree."""
        if cpp_core is None:
            return None

        self._state_registry.clear()
        self._vnode_override.clear()

        root_state = root_node.state
        root_state_id = self._register_state(root_state)
        self._vnode_override[root_state_id] = root_v_node_id
        self._ensure_cpp_networks(root_state)

        cpp_state = self._initialize_cpp_state(root_state)
        root_state._cpp_state = cpp_state

        state_view = cpp_core.StateView(root_state_id)
        state_view.step_index = len(root_state.selected_p_net_nodes)
        state_view.domain_state = cpp_state

        result = self._engine.run_search(state_view)
        if result is None:
            return None

        visit_counts = result.visit_counts.cpu()
        policy = result.policy.cpu()

        candidate_actions = list(cpp_state.get_candidate_nodes())
        if hasattr(root_state, "max_expansion"):
            root_state.max_expansion = max(len(candidate_actions), 1)
        root_node.children = []
        root_node._diag_root_priors = []
        root_node._diag_root_action_ids = []

        candidate_priors = []
        for action in candidate_actions:
            if 0 <= action < policy.numel():
                candidate_priors.append(float(policy[action].item()))
            else:
                candidate_priors.append(0.0)
        total_prior = sum(candidate_priors)
        if total_prior <= 1e-8 and candidate_priors:
            candidate_priors = [1.0 / len(candidate_priors)] * len(candidate_priors)
        elif total_prior > 0:
            candidate_priors = [p / total_prior for p in candidate_priors]

        for idx, action in enumerate(candidate_actions):
            child_cpp_state = cpp_state.create_child(int(action))
            child_state = self._python_state_from_cpp(root_state, child_cpp_state)
            child_state._cpp_state = child_cpp_state
            prior = candidate_priors[idx] if idx < len(candidate_priors) else 0.0
            child = Node(root_node, child_state, prior=prior)
            if 0 <= action < visit_counts.numel():
                child.visit_times = int(visit_counts[action].item())
            else:
                child.visit_times = 0
            child.value = 0.0
            root_node._diag_root_priors.append(prior)
            root_node._diag_root_action_ids.append(action)

        root_node._diag_effective_sims = int(visit_counts.sum().item())
        root_node._diag_root_value = float(result.value)

        return result

    # ----------------------------------------------------------------- Callbacks -------------------------------------------------------------

    def _register_state(self, state: State) -> int:
        state_id = id(state)
        self._state_registry[state_id] = state
        return state_id

    def _fetch_state(self, state_view: cpp_core.StateView) -> State:
        state = self._state_registry.get(state_view.id)
        if state is None:
            raise KeyError(f"State with id={state_view.id} not found in registry.")
        return state

    def _evaluate_callback(self, state_view: cpp_core.StateView) -> Tuple[torch.Tensor, torch.Tensor]:
        obs: dict
        domain_state = getattr(state_view, "domain_state", None)
        if domain_state is not None:
            obs = self._build_obs_from_cpp_state(domain_state)
            # Ensure we don't leak overrides for C++ driven states
            self._vnode_override.pop(state_view.id, None)
        else:
            state = self._fetch_state(state_view)
            v_override = self._vnode_override.pop(state_view.id, None)
            obs = self.actor._state_to_obs(state, v_override)

        logits_tensor, value_tensor = self._run_policy(obs)

        state_view.policy_logits = logits_tensor
        state_view.value = value_tensor

        action_mask = obs.get("action_mask")
        if isinstance(action_mask, torch.Tensor):
            mask_tensor = action_mask.squeeze(0).to(torch.bool)
        else:
            mask_tensor = torch.ones_like(logits_tensor, dtype=torch.bool)
        state_view.action_mask = mask_tensor

        return logits_tensor, value_tensor

    def _expand_callback(self, state_view: cpp_core.StateView):
        # With domain_state present the C++ core performs expansion internally.
        return []

    def _terminal_check_callback(self, state_view: cpp_core.StateView) -> bool:
        domain_state = getattr(state_view, "domain_state", None)
        if domain_state is not None:
            return domain_state.is_terminal()
        state = self._fetch_state(state_view)
        return state.is_terminal()

    def _terminal_value_callback(self, state_view: cpp_core.StateView) -> float:
        domain_state = getattr(state_view, "domain_state", None)
        if domain_state is not None:
            return domain_state.compute_final_reward()
        state = self._fetch_state(state_view)
        return state.compute_final_reward()

    # ---------------------------------------------------------------- Internal helpers ----------------------------------------------------

    def _ensure_cpp_networks(self, root_state: State) -> None:
        """Serialize the static physical network once and rebuild the per-request virtual topology."""
        if self._cpp_p_network is None:
            self._cpp_p_network, self._edge_lookup = self._build_cpp_network(root_state._original_p_net)
        elif not self._edge_lookup:
            _, self._edge_lookup = self._build_cpp_network(root_state._original_p_net)
        # Always refresh the virtual request representation
        self._cpp_v_network, _ = self._build_cpp_network(root_state.v_net)
        config = cpp_core.VNRConfig()
        config.node_resource_names = list(self._node_resource_names)
        config.link_resource_names = list(self._link_resource_names)
        config.allow_rejection = bool(getattr(root_state, "allow_rejection", False))
        config.reject_penalty = float(getattr(root_state, "reject_penalty", 50.0))
        config.shortest_method = getattr(self.actor, "shortest_method", "bfs_shortest")
        config.k_shortest = int(getattr(self.actor, "k_shortest", 1))
        self._root_cpp_config = config

    def _initialize_cpp_state(self, root_state: State) -> cpp_core.VNRState:
        cached = getattr(root_state, "_cpp_state", None)
        if cached is not None:
            return cached

        if self._cpp_p_network is None or self._cpp_v_network is None or self._root_cpp_config is None:
            raise RuntimeError("C++ networks are not initialised before building state.")

        cpp_state = cpp_core.VNRState(self._cpp_p_network, self._cpp_v_network, self._root_cpp_config)
        for p_node in root_state.selected_p_net_nodes:
            cpp_state = cpp_state.create_child(int(p_node))

        if getattr(root_state, "rejected", False):
            reject_idx = self._cpp_p_network.num_nodes
            cpp_state = cpp_state.create_child(reject_idx)
        elif root_state.p_node_id == -1:
            cpp_state = cpp_state.create_child(-1)

        return cpp_state

    def _build_cpp_network(self, net) -> Tuple[cpp_core.Network, Dict[Tuple[int, int], int]]:
        """Convert a NetworkX-style graph into the light-weight C++ representation."""
        cpp_net = cpp_core.Network()
        num_nodes = int(getattr(net, "num_nodes", len(net.nodes)))
        cpp_net.set_num_nodes(num_nodes)

        # Node attributes (numeric only)
        node_attrs: list[dict[str, float]] = [{} for _ in range(num_nodes)]
        for node_id, data in net.nodes(data=True):
            attrs = {}
            for key, value in data.items():
                if isinstance(value, (int, float, bool)):
                    attrs[str(key)] = float(value)
            node_attrs[int(node_id)] = attrs
        cpp_net.set_node_attrs(node_attrs)

        edges: List[Tuple[int, int]] = []
        edge_attrs: List[dict[str, float]] = []
        edge_lookup: Dict[Tuple[int, int], int] = {}
        for u, v, data in net.edges(data=True):
            edges.append((int(u), int(v)))
            attrs = {}
            for key, value in data.items():
                if isinstance(value, (int, float, bool)):
                    attrs[str(key)] = float(value)
            edge_attrs.append(attrs)
            edge_lookup[(int(u), int(v))] = len(edges) - 1
            edge_lookup[(int(v), int(u))] = len(edges) - 1
        cpp_net.set_edges(edges, is_directed=False)
        if len(edge_attrs) == len(edges):
            cpp_net.set_edge_attrs(edge_attrs)
        return cpp_net, edge_lookup

    def _python_state_from_cpp(self, parent: State, cpp_state: "cpp_core.VNRState") -> State:
        child = State.__new__(State)

        # Shared references
        child._original_p_net = parent._original_p_net
        child.v_net = parent.v_net
        child.controller = parent.controller
        child.counter = parent.counter
        child.recorder = parent.recorder
        child.link_params = parent.link_params

        # Ordering metadata
        child.v_order = list(getattr(parent, "v_order", []))
        child.v_pos = dict(getattr(parent, "v_pos", {}))

        # Selection state
        selected_nodes = list(cpp_state.selected_physical_nodes())
        child.selected_p_net_nodes = selected_nodes
        child.v_node_id = cpp_state.current_virtual_index()
        child.p_node_id = cpp_state.last_physical_node()
        child.rejected = cpp_state.rejected()
        child.allow_rejection = getattr(parent, "allow_rejection", False)
        child.reject_penalty = getattr(parent, "reject_penalty", 50.0)
        child.max_expansion = max(len(cpp_state.get_candidate_nodes()), 1)

        # Resource allocations reconstructed from residual capacity
        node_allocations: Dict[int, Dict[str, float]] = {}
        for node_id in range(child._original_p_net.num_nodes):
            alloc = {}
            for attr_name in self._node_resource_names:
                capacity = float(child._original_p_net.nodes[node_id].get(attr_name, 0.0))
                available = float(cpp_state.get_available_node_resource(node_id, attr_name))
                used = capacity - available
                if used > 1e-6:
                    alloc[attr_name] = used
            if alloc:
                node_allocations[node_id] = alloc

        link_allocations: Dict[Tuple[int, int], Dict[str, float]] = {}
        for (u, v) in child._original_p_net.links:
            edge_id = self._get_cpp_edge_id(int(u), int(v))
            if edge_id < 0:
                continue
            alloc = {}
            link_attrs = child._original_p_net.links[(u, v)]
            for attr_name in self._link_resource_names:
                capacity = float(link_attrs.get(attr_name, 0.0))
                available = float(cpp_state.get_available_link_resource(edge_id, attr_name))
                used = capacity - available
                if used > 1e-6:
                    alloc[attr_name] = used
            if alloc:
                link_allocations[(u, v)] = alloc

        child._resource_allocations = {
            "node": node_allocations,
            "link": link_allocations,
        }
        child._p_net_view = None
        child._prune_log_count = getattr(parent, "_prune_log_count", 0)

        return child

    def _build_obs_from_cpp_state(self, cpp_state: "cpp_core.VNRState") -> dict:
        # Delegate to actor's observation builder
        return self.actor.obs_builder.build_from_cpp_state(
            cpp_state=cpp_state,
            policy=self.actor.policy,
            node_resource_names=self._node_resource_names,
            link_resource_names=self._link_resource_names,
            edge_lookup=self._edge_lookup
        )

    def _num_actions(self) -> int:
        """Get number of actions using actor's public API."""
        return self.actor.get_num_actions()

    def _get_cpp_edge_id(self, u: int, v: int) -> int:
        if (u, v) in self._edge_lookup:
            return self._edge_lookup[(u, v)]
        return self._edge_lookup.get((v, u), -1)

    def _run_policy(self, obs: dict) -> Tuple[torch.Tensor, torch.Tensor]:
        # Use PolicyNetwork for evaluation
        logits_tensor, value_float = self.actor.policy_network.evaluate(
            obs,
            use_nn_policy=getattr(self.actor, "use_nn_policy", True),
            use_nn_value=getattr(self.actor, "use_nn_value", True),
        )

        if logits_tensor is None or logits_tensor.numel() == 0:
            logits_tensor = torch.zeros(self._num_actions(), dtype=torch.float32)
        elif logits_tensor.dim() > 1:
            logits_tensor = logits_tensor.squeeze(0)
        logits_tensor = logits_tensor.to(torch.float32)
        value_tensor = torch.tensor(value_float, dtype=torch.float32)
        return logits_tensor, value_tensor


def create_cpp_adapter(actor, computation_budget: int):
    """Factory that returns a configured adapter or ``None`` if the extension is unavailable."""
    if cpp_core is None:
        return None
    adapter = CppMCTSAdapter(
        actor,
        computation_budget=computation_budget,
        c_puct=getattr(actor, "c_puct", 1.0),
        dirichlet_alpha=getattr(actor, "dirichlet_alpha", 0.03),
        dirichlet_epsilon=getattr(actor, "dirichlet_epsilon", 0.25),
        use_neural_network=getattr(actor, "use_neural_network", True),
        rollout_depth_limit=getattr(actor, "rollout_depth_limit", 100),
    )
    return adapter
