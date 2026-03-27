"""Adapter that wires the C++ MCTS core into the Python AlphaZero actor."""
from __future__ import annotations

import glob
import os
import time
from typing import Dict, List, Optional, Tuple

import torch

from .feature_constructor import (
    AlphaZeroFeatureAdapter,
)
from .node import Node, State

try:
    from . import alpha_zero_cpp_core as cpp_core  # type: ignore
except ImportError:  # pragma: no cover - optional dependency
    cpp_core = None


class _LazyCppStateProxy:
    """Lightweight Python view over a C++ VNRState that materializes on demand."""

    def __init__(
        self,
        adapter: "CppMCTSAdapter",
        parent: State,
        cache_key,
        cpp_state: "cpp_core.VNRState" | None = None,
        parent_cpp_state: "cpp_core.VNRState" | None = None,
        action: int | None = None,
    ):
        self._adapter = adapter
        self._parent_state = parent
        self._cpp_state = cpp_state
        self._cpp_parent_state = parent_cpp_state
        self._cpp_action = int(action) if action is not None else None
        self._cpp_network_cache_key = cache_key
        self._materialized_state: State | None = None

        # Shared references / scalar metadata needed by selection and bookkeeping.
        self._original_p_net = parent._original_p_net
        self.v_net = parent.v_net
        self.controller = parent.controller
        self.counter = parent.counter
        self.recorder = parent.recorder
        self.link_params = parent.link_params
        self.v_order = list(getattr(parent, "v_order", []))
        self.v_pos = dict(getattr(parent, "v_pos", {}))
        self.allow_rejection = getattr(parent, "allow_rejection", False)
        self.reject_penalty = getattr(parent, "reject_penalty", 50.0)
        reject_idx = self._original_p_net.num_nodes

        if self._cpp_state is not None:
            self.selected_p_net_nodes = list(self._cpp_state.selected_physical_nodes)
            self.v_node_id = int(self._cpp_state.current_virtual_index)
            self.p_node_id = int(self._cpp_state.last_physical_node)
            self.rejected = bool(self._cpp_state.rejected)
        else:
            p_node = int(self._cpp_action) if self._cpp_action is not None else -1
            selected = list(getattr(parent, "selected_p_net_nodes", []))
            if 0 <= p_node < reject_idx:
                selected.append(p_node)
            self.selected_p_net_nodes = selected
            self.v_node_id = int(getattr(parent, "v_node_id", -1)) + 1
            self.p_node_id = p_node
            self.rejected = bool(self.allow_rejection and p_node == reject_idx)

        # Keep this cheap; avoid invoking get_candidate_nodes() during reconstruction.
        self.max_expansion = max(int(getattr(parent, "max_expansion", 1)), 1)
        self._prune_log_count = getattr(parent, "_prune_log_count", 0)

    def materialize(self) -> State:
        if self._cpp_state is None and self._cpp_parent_state is not None and self._cpp_action is not None:
            self._cpp_state = self._cpp_parent_state.create_child(int(self._cpp_action))
        if self._materialized_state is None:
            if self._cpp_state is None:
                raise RuntimeError("Lazy C++ proxy has no source state to materialize.")
            child = self._adapter._python_state_from_cpp(self._parent_state, self._cpp_state)
            child._cpp_state = self._cpp_state
            child._cpp_network_cache_key = self._cpp_network_cache_key
            self._materialized_state = child
        return self._materialized_state

    def __getattr__(self, name):
        # Defer expensive full-state reconstruction until an unsupported attribute is requested.
        return getattr(self.materialize(), name)


class CppMCTSAdapter:
    """Bridges the Python environment with the C++ MCTS engine via callbacks."""

    def __init__(self, actor, computation_budget: int, c_puct: float, dirichlet_alpha: float, dirichlet_epsilon: float,
                 use_neural_network: bool = True, rollout_depth_limit: int = 100):
        if cpp_core is None:
            raise RuntimeError("alpha_zero_cpp_core extension is not available.")

        self.actor = actor
        self.use_neural_network = bool(use_neural_network)
        self._engine = cpp_core.MCTSEngine(
            self._build_config(
                computation_budget,
                c_puct,
                dirichlet_alpha,
                dirichlet_epsilon,
                int(getattr(actor, "top_k_candidates", 0)),
                self.use_neural_network,
                rollout_depth_limit,
            )
        )
        self._engine.set_callbacks(
            self._expand_callback,
            self._evaluate_callback if self.use_neural_network else self._evaluate_callback_plain,
            self._terminal_value_callback,
            self._terminal_check_callback,
        )
        self._state_registry: Dict[int, State] = {}
        self._vnode_override: Dict[int, int] = {}
        self._cpp_p_network: cpp_core.Network | None = None
        self._cpp_v_network: cpp_core.Network | None = None
        self._root_cpp_config: cpp_core.VNRConfig | None = None
        self._edge_lookup: Dict[Tuple[int, int], int] = {}
        self._active_network_cache_key: Tuple[int, int, int, bool, float, str, int] | None = None
        self._request_generation: int = 0
        self._request_network_ids: Tuple[int, int] | None = None
        self._node_resource_names = [
            getattr(attr, "name", str(attr)) for attr in getattr(actor.controller, "node_resource_attrs", [])
        ]
        self._link_resource_names = [
            getattr(attr, "name", str(attr)) for attr in getattr(actor.controller, "link_resource_attrs", [])
        ]

    def build_obs_from_cpp_state(self, cpp_state: "cpp_core.VNRState") -> dict:
        """Public helper for actor hot paths that can consume C++ state directly."""
        return self._build_obs_from_cpp_state(cpp_state)

    @staticmethod
    def materialize_state(state):
        """Return a fully-materialized Python State when `state` is a lazy proxy."""
        if isinstance(state, _LazyCppStateProxy):
            return state.materialize()
        return state

    def begin_request(self, p_net, v_net) -> None:
        """Mark a request boundary for per-request network snapshot caching."""
        self._request_generation += 1
        self._request_network_ids = (id(p_net), id(v_net))

    @staticmethod
    def _build_config(
        computation_budget: int,
        c_puct: float,
        dirichlet_alpha: float,
        dirichlet_epsilon: float,
        top_k_candidates: int,
        use_neural_network: bool = True,
        rollout_depth_limit: int = 100,
    ) -> cpp_core.SearchConfig:
        cfg = cpp_core.SearchConfig()
        cfg.simulations = computation_budget
        cfg.c_puct = float(c_puct)
        cfg.dirichlet_alpha = float(dirichlet_alpha)
        cfg.dirichlet_epsilon = float(dirichlet_epsilon)
        cfg.top_k_candidates = int(top_k_candidates)
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
        root_state._cpp_network_cache_key = self._active_network_cache_key

        state_view = cpp_core.StateView(root_state_id)
        state_view.step_index = len(root_state.selected_p_net_nodes)
        state_view.domain_state = cpp_state

        result = self._engine.run_search(state_view)
        if result is None:
            return None

        visit_counts = result.visit_counts.cpu()
        policy = result.policy.cpu()
        total_visits = int(visit_counts.sum().item())

        logger = getattr(self.actor, "logger", None)
        if logger is not None:
            visit_list = visit_counts.tolist()
            visited_actions = [int(idx) for idx, count in enumerate(visit_list) if count > 0]
            head = visit_counts[: min(16, visit_counts.numel())].tolist()
            logger.debug(
                f"C++ search stats: total_visits={total_visits} "
                f"visited_actions={visited_actions} head_visit_counts={head}"
            )

        if total_visits == 0:
            if logger is not None:
                logger.warning("C++ search produced zero total visits; marking request as infeasible.")
            root_node.children = []
            root_node._diag_root_priors = []
            root_node._diag_root_action_ids = []
            root_node._diag_effective_sims = 0
            root_node._diag_root_value = float(result.value)
            root_state.p_node_id = -1
            return result

        candidate_actions = list(cpp_state.get_candidate_nodes())
        if hasattr(root_state, "max_expansion"):
            root_state.max_expansion = max(len(candidate_actions), 1)
        root_node.children = []
        root_node._diag_root_priors = []
        root_node._diag_root_action_ids = []

        # IMPORTANT: Do not reconstruct a Python child for every candidate action.
        # On large topologies (e.g. 500 nodes), `create_child()` can be expensive because it
        # may perform feasibility checks / shadow reservations. For selecting an action and
        # recording π, we only need actions that were actually visited by the C++ search.
        actions_to_reconstruct: List[int] = []
        try:
            for action in candidate_actions:
                if 0 <= action < visit_counts.numel() and int(visit_counts[action].item()) > 0:
                    actions_to_reconstruct.append(int(action))
        except Exception:
            actions_to_reconstruct = []

        # Fallback: if the search somehow visited nothing in the candidate set, keep a small
        # subset of highest-prior actions so downstream logic can proceed deterministically.
        if not actions_to_reconstruct and candidate_actions:
            scored = []
            for action in candidate_actions:
                if 0 <= action < policy.numel():
                    scored.append((float(policy[action].item()), int(action)))
                else:
                    scored.append((0.0, int(action)))
            scored.sort(reverse=True, key=lambda t: t[0])
            actions_to_reconstruct = [a for _, a in scored[: min(8, len(scored))]]

        # Optional cap for debugging / stress runs.
        try:
            max_children = int(getattr(getattr(self.actor, "config", None).training, "cpp_reconstruct_max_children", 0))
        except Exception:
            max_children = 0
        if max_children and len(actions_to_reconstruct) > max_children:
            # Keep top by visit count, then by policy prior.
            def _key(a: int):
                v = int(visit_counts[a].item()) if 0 <= a < visit_counts.numel() else 0
                p = float(policy[a].item()) if 0 <= a < policy.numel() else 0.0
                return (v, p)
            actions_to_reconstruct = sorted(actions_to_reconstruct, key=_key, reverse=True)[:max_children]

        # Normalize priors over the reconstructed set only (sufficient for diagnostics).
        priors_map: Dict[int, float] = {}
        total_prior = 0.0
        for action in actions_to_reconstruct:
            prior = float(policy[action].item()) if 0 <= action < policy.numel() else 0.0
            prior = prior if prior > 0.0 and prior < float("inf") else 0.0
            priors_map[action] = prior
            total_prior += prior
        if total_prior <= 1e-8 and actions_to_reconstruct:
            uniform = 1.0 / len(actions_to_reconstruct)
            for action in actions_to_reconstruct:
                priors_map[action] = uniform
        elif total_prior > 0:
            for action in list(priors_map.keys()):
                priors_map[action] = priors_map[action] / total_prior

        valid_children = 0
        reject_idx = root_state._original_p_net.num_nodes
        allow_rejection = bool(getattr(root_state, "allow_rejection", False))
        for action in actions_to_reconstruct:
            p_node_id = int(action)
            is_reject_action = p_node_id == reject_idx
            is_invalid = p_node_id < 0 and not is_reject_action
            reject_not_allowed = is_reject_action and not allow_rejection
            out_of_range = p_node_id > reject_idx
            if is_invalid or reject_not_allowed or out_of_range:
                if logger is not None:
                    logger.debug(
                        "Skipping invalid child action="
                        f"{action} p_node_id={p_node_id} reject_idx={reject_idx} "
                        f"allow_rejection={allow_rejection}"
                    )
                continue

            child_state = _LazyCppStateProxy(
                adapter=self,
                parent=root_state,
                cache_key=self._active_network_cache_key,
                cpp_state=None,
                parent_cpp_state=cpp_state,
                action=p_node_id,
            )

            prior = priors_map.get(int(action), 0.0)
            child = Node(root_node, child_state, prior=prior)
            if 0 <= action < visit_counts.numel():
                child.visit_times = int(visit_counts[action].item())
            else:
                child.visit_times = 0
            child.value = 0.0
            root_node._diag_root_priors.append(prior)
            root_node._diag_root_action_ids.append(action)
            valid_children += 1

        if valid_children == 0:
            if logger is not None:
                logger.warning(
                    "C++ search returned "
                    f"{total_visits} total visits but no valid children were reconstructed (request infeasible)."
                )
            root_node.children = []
            root_state.p_node_id = -1

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

    def _evaluate_callback_plain(self, state_view: cpp_core.StateView) -> Tuple[torch.Tensor, torch.Tensor]:
        """Neural-network-free evaluation used for uniform prior + rollout mode."""
        num_actions = max(self._num_actions(), 1)
        logits_tensor = torch.zeros(num_actions, dtype=torch.float32)
        value_tensor = torch.tensor(0.0, dtype=torch.float32)

        action_mask = torch.zeros(num_actions, dtype=torch.bool)
        domain_state = getattr(state_view, "domain_state", None)
        candidates = []
        if domain_state is not None:
            try:
                candidates = domain_state.get_candidate_nodes()
            except Exception:
                candidates = []
        else:
            try:
                state = self._fetch_state(state_view)
                candidates = [st.p_node_id for st in state.get_candidate_states()]
            except Exception:
                candidates = list(range(num_actions))

        if not candidates:
            candidates = list(range(num_actions))

        for action in candidates:
            if 0 <= action < num_actions:
                action_mask[action] = True

        state_view.policy_logits = logits_tensor
        state_view.value = value_tensor
        state_view.action_mask = action_mask

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

    def _build_network_cache_key(self, root_state: State) -> Tuple[int, int, int, bool, float, str, int]:
        return (
            int(self._request_generation),
            id(root_state._original_p_net),
            id(root_state.v_net),
            bool(getattr(root_state, "allow_rejection", False)),
            float(getattr(root_state, "reject_penalty", 50.0)),
            str(getattr(self.actor, "shortest_method", "bfs_shortest")),
            int(getattr(self.actor, "k_shortest", 1)),
        )

    def _invalidate_cpp_network_cache(self) -> None:
        self._cpp_p_network = None
        self._cpp_v_network = None
        self._root_cpp_config = None
        self._edge_lookup = {}
        self._active_network_cache_key = None

    def _ensure_cpp_networks(self, root_state: State) -> None:
        """Cache graph snapshots per request and rebuild only when networks change."""
        cache_key = self._build_network_cache_key(root_state)
        if (
            cache_key == self._active_network_cache_key
            and self._cpp_p_network is not None
            and self._cpp_v_network is not None
            and self._root_cpp_config is not None
        ):
            return

        self._invalidate_cpp_network_cache()
        self._cpp_p_network, self._edge_lookup = self._build_cpp_network(root_state._original_p_net)
        self._cpp_v_network, _ = self._build_cpp_network(root_state.v_net)
        config = cpp_core.VNRConfig()
        config.node_resource_names = list(self._node_resource_names)
        config.link_resource_names = list(self._link_resource_names)
        try:
            node_constraints = getattr(self.actor.controller, "node_constraint_attrs_checking_at_node", [])
            config.node_constraint_names = [getattr(attr, "name", str(attr)) for attr in node_constraints]
            config.hard_constraint_names = [
                getattr(attr, "name", str(attr))
                for attr in node_constraints
                if getattr(attr, "constraint_restrictions", "hard") == "hard"
            ]
        except Exception:
            config.node_constraint_names = []
            config.hard_constraint_names = []
        config.allow_rejection = bool(getattr(root_state, "allow_rejection", False))
        config.reject_penalty = float(getattr(root_state, "reject_penalty", 50.0))
        config.shortest_method = getattr(self.actor, "shortest_method", "bfs_shortest")
        config.k_shortest = int(getattr(self.actor, "k_shortest", 1))
        self._root_cpp_config = config
        self._active_network_cache_key = cache_key

    def _initialize_cpp_state(self, root_state: State) -> cpp_core.VNRState:
        cached = getattr(root_state, "_cpp_state", None)
        cached_key = getattr(root_state, "_cpp_network_cache_key", None)
        if cached is not None and cached_key == self._active_network_cache_key:
            return cached
        if cached is not None and cached_key != self._active_network_cache_key:
            root_state._cpp_state = None

        parent_cpp_state = getattr(root_state, "_cpp_parent_state", None)
        parent_action = getattr(root_state, "_cpp_action", None)
        if (
            parent_cpp_state is not None
            and parent_action is not None
            and cached_key == self._active_network_cache_key
        ):
            child_cpp_state = parent_cpp_state.create_child(int(parent_action))
            root_state._cpp_state = child_cpp_state
            return child_cpp_state

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

        root_state._cpp_network_cache_key = self._active_network_cache_key
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
        selected_nodes = list(cpp_state.selected_physical_nodes)
        child.selected_p_net_nodes = selected_nodes
        child.v_node_id = int(cpp_state.current_virtual_index)
        child.p_node_id = int(cpp_state.last_physical_node)
        child.rejected = cpp_state.rejected
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
        # Don't set _p_net_view - let the property create it on demand
        child._prune_log_count = getattr(parent, "_prune_log_count", 0)

        return child

    def _build_obs_from_cpp_state(self, cpp_state: "cpp_core.VNRState") -> dict:
        root_state = State(
            self.actor.obs_builder._episode_p_net,
            self.actor.obs_builder._episode_v_net,
            self.actor.controller,
            self.actor.recorder,
            self.actor.counter,
            link_params={
                "shortest_method": getattr(self.actor, "shortest_method", "bfs_shortest"),
                "k": int(getattr(self.actor, "k_shortest", 1)),
            },
        )
        python_state = self._python_state_from_cpp(root_state, cpp_state)
        return self.actor.obs_builder.build(python_state, self.actor.policy)

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
        dirichlet_alpha=getattr(actor, "dirichlet_alpha", 0.1),
        dirichlet_epsilon=getattr(actor, "dirichlet_epsilon", 0.25),
        use_neural_network=getattr(actor, "use_neural_network", True),
        rollout_depth_limit=getattr(actor, "rollout_depth_limit", 100),
    )
    return adapter


def create_cpp_full_solver(actor, computation_budget: int):
    """Factory for the full C++ solve path."""
    if cpp_core is None or not hasattr(cpp_core, "solve"):
        return None
    return CppFullSolver(actor, computation_budget)


class CppFullSolver:
    """Full C++ solve path (single call per request)."""

    def __init__(self, actor, computation_budget: int):
        if cpp_core is None or not hasattr(cpp_core, "solve"):
            raise RuntimeError("alpha_zero_cpp_core.solve is not available.")
        self.actor = actor
        self.computation_budget = int(computation_budget)
        self._last_export_used_trace = False
        self._warned_cuda_unavailable = False
        self._warned_trace_fallback = False
        self._warned_trace_batchsize = False
        self._node_resource_names = [
            getattr(attr, "name", str(attr)) for attr in getattr(actor.controller, "node_resource_attrs", [])
        ]
        self._link_resource_names = [
            getattr(attr, "name", str(attr)) for attr in getattr(actor.controller, "link_resource_attrs", [])
        ]

    def _build_network_payload(self, net, node_resource_names: list, link_resource_names: list, topological_metrics: dict | None = None):
        node_attrs = []
        topological_metrics = topological_metrics or {}
        for node_id in net.nodes:
            attrs = {}
            data = net.nodes[node_id]
            for name in node_resource_names:
                value = data.get(name, 0.0)
                if isinstance(value, (int, float, bool)):
                    attrs[str(name)] = float(value)
            for topo_name, topo_values in topological_metrics.items():
                try:
                    attrs[str(topo_name)] = float(topo_values[int(node_id)][0])
                except Exception:
                    attrs[str(topo_name)] = 0.0
            node_attrs.append(attrs)

        edges = list(net.links)
        edge_attrs = []
        for (u, v) in edges:
            attrs = {}
            data = net.links[(u, v)]
            for name in link_resource_names:
                value = data.get(name, 0.0)
                if isinstance(value, (int, float, bool)):
                    attrs[str(name)] = float(value)
            edge_attrs.append(attrs)

        directed = False
        try:
            directed = bool(net.is_directed())
        except Exception:
            directed = False

        return node_attrs, edges, edge_attrs, directed

    def _build_search_config(self, training: bool | None = None) -> "cpp_core.SearchConfig":
        cfg = cpp_core.SearchConfig()
        cfg.simulations = int(self.computation_budget)
        cfg.c_puct = float(getattr(self.actor, "c_puct", 1.0))
        cfg.dirichlet_alpha = float(getattr(self.actor, "dirichlet_alpha", 0.1))
        cfg.dirichlet_epsilon = float(getattr(self.actor, "dirichlet_epsilon", 0.25))
        cfg.top_k_candidates = int(getattr(self.actor, "top_k_candidates", 0))
        cfg.use_neural_network = bool(getattr(self.actor, "use_neural_network", True))
        cfg.rollout_depth_limit = int(getattr(self.actor, "rollout_depth_limit", 100))
        if training is not None:
            cfg.add_root_noise = bool(training)
        # Batch eval size (C++): default to training.gpu_batch_size if present.
        batch_size = 1
        cfg_obj = getattr(self.actor, "config", None)
        training_cfg = getattr(cfg_obj, "training", None) if cfg_obj is not None else None
        if isinstance(training_cfg, dict):
            batch_size = int(training_cfg.get("gpu_batch_size", batch_size))
            cfg.value_normalization = str(training_cfg.get("value_normalization", "tanh"))
            cfg.value_scale = float(training_cfg.get("value_scale", 1000.0))
        elif training_cfg is not None:
            batch_size = int(getattr(training_cfg, "gpu_batch_size", batch_size))
            cfg.value_normalization = str(getattr(training_cfg, "value_normalization", "tanh"))
            cfg.value_scale = float(getattr(training_cfg, "value_scale", 1000.0))
        cfg.eval_batch_size = max(1, batch_size)
        return cfg

    def _build_vnr_config(self, feature_metadata: dict) -> "cpp_core.VNRConfig":
        cfg = cpp_core.VNRConfig()
        cfg.node_resource_names = list(self._node_resource_names)
        cfg.link_resource_names = list(self._link_resource_names)
        cfg.node_attr_benchmarks = dict(feature_metadata.get("node_attr_benchmarks", {}))
        cfg.link_attr_benchmarks = dict(feature_metadata.get("link_attr_benchmarks", {}))
        cfg.link_sum_attr_benchmarks = dict(feature_metadata.get("link_sum_attr_benchmarks", {}))
        cfg.feature_use_node_status_flags = bool(feature_metadata.get("feature_use_node_status_flags", False))
        cfg.feature_use_aggregated_link_attrs = bool(feature_metadata.get("feature_use_aggregated_link_attrs", False))
        cfg.feature_use_degree_metric = bool(feature_metadata.get("feature_use_degree_metric", False))
        cfg.feature_use_more_topological_metrics = bool(feature_metadata.get("feature_use_more_topological_metrics", False))
        try:
            node_constraints = getattr(self.actor.controller, "node_constraint_attrs_checking_at_node", [])
            cfg.node_constraint_names = [getattr(attr, "name", str(attr)) for attr in node_constraints]
            cfg.hard_constraint_names = [
                getattr(attr, "name", str(attr))
                for attr in node_constraints
                if getattr(attr, "constraint_restrictions", "hard") == "hard"
            ]
        except Exception:
            cfg.node_constraint_names = []
            cfg.hard_constraint_names = []
        allow_rejection = False
        try:
            allow_rejection = bool(getattr(self.actor.policy.actor.decoder, "allow_rejection", False))
        except Exception:
            pass
        cfg.allow_rejection = allow_rejection
        reject_penalty = 50.0
        try:
            cfg_obj = getattr(self.actor, "config", None)
            if cfg_obj is not None:
                rp = getattr(getattr(cfg_obj, "solver", {}), "reject_penalty", None)
                if rp is None:
                    rp = getattr(cfg_obj, "reject_penalty", None)
                if rp is not None:
                    reject_penalty = float(rp)
        except Exception:
            pass
        cfg.reject_penalty = float(reject_penalty)
        cfg.shortest_method = getattr(self.actor, "shortest_method", "bfs_shortest")
        cfg.k_shortest = int(getattr(self.actor, "k_shortest", 1))
        return cfg

    def _wait_for_torchscript(self, policy_ts_path: str, timeout_s: float = 5.0) -> bool:
        """Wait for an in-progress TorchScript export to finish and stabilize."""
        tmp_prefix = policy_ts_path + ".tmp"
        deadline = time.monotonic() + timeout_s
        last_size = None
        last_mtime = None
        while time.monotonic() < deadline:
            if glob.glob(tmp_prefix + "*"):
                time.sleep(0.05)
                continue
            if not os.path.exists(policy_ts_path):
                time.sleep(0.05)
                continue
            try:
                size = os.path.getsize(policy_ts_path)
                mtime = os.path.getmtime(policy_ts_path)
            except OSError:
                time.sleep(0.05)
                continue
            if last_size == size and last_mtime == mtime:
                return True
            last_size = size
            last_mtime = mtime
            time.sleep(0.05)
        return False

    def _torchscript_wait_timeout_s(self) -> float:
        timeout_s = 5.0
        cfg_obj = getattr(self.actor, "config", None)
        training_cfg = getattr(cfg_obj, "training", None) if cfg_obj is not None else None
        try:
            if isinstance(training_cfg, dict):
                timeout_s = float(training_cfg.get("torchscript_wait_timeout_s", timeout_s))
            elif training_cfg is not None and hasattr(training_cfg, "torchscript_wait_timeout_s"):
                timeout_s = float(getattr(training_cfg, "torchscript_wait_timeout_s"))
        except Exception:
            timeout_s = 5.0
        return max(0.5, timeout_s)

    def _torchscript_needs_export(self, policy_ts_path: str) -> bool:
        if not os.path.exists(policy_ts_path):
            return True
        policy_pt_path = getattr(self.actor, "policy_path", "") or ""
        if not policy_pt_path or not os.path.exists(policy_pt_path):
            return False
        try:
            return os.path.getmtime(policy_ts_path) < os.path.getmtime(policy_pt_path)
        except OSError:
            return True

    def _torchscript_mode_path(self, policy_ts_path: str) -> str:
        return f"{policy_ts_path}.mode"

    def _read_torchscript_mode(self, policy_ts_path: str) -> str | None:
        mode_path = self._torchscript_mode_path(policy_ts_path)
        try:
            with open(mode_path, "r", encoding="ascii") as f:
                mode = f.read().strip()
            if mode in ("script", "trace"):
                return mode
        except OSError:
            return None
        return None

    def _config_use_cuda(self) -> bool:
        cfg_obj = getattr(self.actor, "config", None)
        training_cfg = getattr(cfg_obj, "training", None) if cfg_obj is not None else None
        if isinstance(training_cfg, dict):
            return bool(training_cfg.get("use_cuda", True))
        if training_cfg is not None and hasattr(training_cfg, "use_cuda"):
            return bool(getattr(training_cfg, "use_cuda"))
        return bool(getattr(self.actor, "device", torch.device("cpu")).type == "cuda")

    def _resolve_runtime_device(self) -> torch.device:
        if self._config_use_cuda():
            if torch.cuda.is_available():
                return torch.device("cuda")
            logger = getattr(self.actor, "logger", None)
            if logger is not None and not self._warned_cuda_unavailable:
                logger.warning(
                    "training.use_cuda=true but CUDA is unavailable; falling back to CPU for C++ policy execution."
                )
                self._warned_cuda_unavailable = True
            return torch.device("cpu")
        return torch.device("cpu")

    def solve(self, p_net, v_net, training: bool = None, pure_cpp: bool = False,
              replay_dir: str | None = None, max_buffer_size: int | None = None) -> dict:
        if training is None:
            training = not getattr(self.actor, "disable_trajectory_writing", False)
        if hasattr(self.actor, "get_action_selection_temperature"):
            temperature = float(self.actor.get_action_selection_temperature(training))
        else:
            temperature = getattr(self.actor, "temperature_train", 1.0) if training else getattr(self.actor, "temperature_eval", 0.0)

        feature_adapter = AlphaZeroFeatureAdapter(self.actor.config, p_net, v_net)
        feature_metadata = feature_adapter.build_cpp_feature_metadata()
        p_node_attrs, p_edges, p_edge_attrs, p_directed = self._build_network_payload(
            p_net,
            self._node_resource_names,
            self._link_resource_names,
            topological_metrics=feature_metadata.get("p_topological_metrics"),
        )
        v_node_attrs, v_edges, v_edge_attrs, v_directed = self._build_network_payload(
            v_net,
            self._node_resource_names,
            self._link_resource_names,
            topological_metrics=feature_metadata.get("v_topological_metrics"),
        )

        vnr_cfg = self._build_vnr_config(feature_metadata)
        search_cfg = self._build_search_config(training=training)

        policy_ts_path = None
        try:
            policy_ts_path = self.actor.policy_path.replace(".pt", ".ts")
        except Exception:
            policy_ts_path = None
        if not policy_ts_path:
            raise RuntimeError("Could not resolve TorchScript policy path.")

        tmp_writes = glob.glob(policy_ts_path + ".tmp*")
        writer_active = bool(tmp_writes)
        if writer_active and not os.path.exists(policy_ts_path):
            wait_s = self._torchscript_wait_timeout_s()
            if not self._wait_for_torchscript(policy_ts_path, timeout_s=wait_s):
                raise RuntimeError(
                    f"TorchScript policy is still being written after {wait_s:.1f}s "
                    f"and no stable policy exists yet: {policy_ts_path}"
                )
            writer_active = bool(glob.glob(policy_ts_path + ".tmp*"))

        # If another process is writing, continue with the last stable .ts.
        # Export uses atomic replace, so the current file remains valid.
        if self._torchscript_needs_export(policy_ts_path) and not writer_active:
            self._export_torchscript(policy_ts_path)

        runtime_device = self._resolve_runtime_device()
        device = "cuda" if runtime_device.type == "cuda" else "cpu"
        ts_mode = self._read_torchscript_mode(policy_ts_path)
        if device == "cuda" and int(getattr(search_cfg, "eval_batch_size", 1)) > 1 and ts_mode != "script":
            search_cfg.eval_batch_size = 1
            logger = getattr(self.actor, "logger", None)
            if logger is not None and not self._warned_trace_batchsize:
                logger.warning(
                    "Using traced TorchScript policy on CUDA; forcing eval_batch_size=1 to avoid trace-shape mismatches."
                )
                self._warned_trace_batchsize = True
        seed = None
        try:
            explicit_request_seed = getattr(self.actor, "_cpp_request_seed", None)
            if explicit_request_seed is not None:
                seed = int(explicit_request_seed)
            else:
                worker_seed = getattr(self.actor, "_cpp_worker_seed", None)
                if worker_seed is not None:
                    seed = int(worker_seed)
                else:
                    seed = int(getattr(getattr(self.actor, "config", None).experiment, "seed", None))
        except Exception:
            seed = None

        policy_meta_path = getattr(self.actor, "policy_path", "") or ""
        write_replay = bool(pure_cpp and training and not getattr(self.actor, "disable_trajectory_writing", False))
        if replay_dir is None:
            replay_dir = getattr(self.actor, "replay_dir", "") or ""
        if not replay_dir:
            write_replay = False
        if max_buffer_size is None:
            max_buffer_size = 500000
            cfg = getattr(self.actor, "config", None)
            training_cfg = getattr(cfg, "training", None) if cfg is not None else None
            if isinstance(training_cfg, dict):
                max_buffer_size = int(training_cfg.get("replay_buffer_max_size", max_buffer_size))
            elif training_cfg is not None:
                max_buffer_size = int(getattr(training_cfg, "replay_buffer_max_size", max_buffer_size))

        try:
            return cpp_core.solve(
                p_node_attrs,
                p_edges,
                p_edge_attrs,
                p_directed,
                v_node_attrs,
                v_edges,
                v_edge_attrs,
                v_directed,
                vnr_cfg,
                search_cfg,
                policy_ts_path,
                policy_meta_path,
                device,
                seed,
                float(temperature),
                int(getattr(self.actor, "temperature_move_threshold", -1)),
                float(getattr(self.actor, "temperature_after_threshold", 0.0)),
                float(getattr(self.actor, "replay_policy_temperature", 1.0)),
                bool(getattr(self.actor, "use_nn_policy", True)),
                bool(getattr(self.actor, "use_nn_value", True)),
                write_replay,
                replay_dir,
                int(max_buffer_size),
            )
        except Exception as exc:
            msg = str(exc)
            if "PytorchStreamReader" in msg or "invalid header" in msg or "archive is corrupted" in msg:
                try:
                    if os.path.exists(policy_ts_path):
                        os.remove(policy_ts_path)
                except Exception:
                    pass
                try:
                    self._export_torchscript(policy_ts_path)
                except Exception:
                    raise
                try:
                    logger = getattr(self.actor, "logger", None)
                    if logger is not None:
                        logger.warning("Re-exported TorchScript policy after load failure; retrying C++ solve.")
                except Exception:
                    pass
                return cpp_core.solve(
                    p_node_attrs,
                    p_edges,
                    p_edge_attrs,
                    p_directed,
                    v_node_attrs,
                    v_edges,
                    v_edge_attrs,
                    v_directed,
                    vnr_cfg,
                    search_cfg,
                    policy_ts_path,
                    policy_meta_path,
                    device,
                    seed,
                    float(temperature),
                    int(getattr(self.actor, "temperature_move_threshold", -1)),
                    float(getattr(self.actor, "temperature_after_threshold", 0.0)),
                    float(getattr(self.actor, "replay_policy_temperature", 1.0)),
                    bool(getattr(self.actor, "use_nn_policy", True)),
                    bool(getattr(self.actor, "use_nn_value", True)),
                    write_replay,
                    replay_dir,
                    int(max_buffer_size),
                )
            raise

    def _export_torchscript(self, policy_ts_path: str) -> None:
        from .model_factory import build_actor_critic, get_model_classes, prefers_trace_torchscript

        model_config = getattr(self.actor.policy_network, "model_config", None)
        if model_config is None:
            raise RuntimeError("Policy model config is unavailable for TorchScript export.")

        export_device = self._resolve_runtime_device()
        model = build_actor_critic(model_config).to(export_device)
        model.load_state_dict(self.actor.policy.state_dict())
        model.eval()
        _, ActorCriticScriptWrapper = get_model_classes(model_config)
        wrapper = ActorCriticScriptWrapper(model).to(export_device)
        wrapper.eval()

        tmp = f"{policy_ts_path}.tmp.{os.getpid()}"
        mode_tmp = f"{self._torchscript_mode_path(policy_ts_path)}.tmp.{os.getpid()}"
        force_trace = prefers_trace_torchscript(model_config)
        used_trace = force_trace
        script_exc = None
        if not force_trace:
            try:
                scripted = torch.jit.script(wrapper)
                scripted.save(tmp)
            except Exception as exc:
                script_exc = exc
                used_trace = True
        if used_trace:
            # Fallback to trace with nominal shapes
            num_nodes = model_config['p_net_num_nodes']
            p_feat = model_config['p_net_feature_dim']
            p_edge_feat = model_config['p_net_edge_dim']
            max_seq_len = model_config.get('max_seq_len', 15)

            p_net_x = torch.zeros((num_nodes, p_feat), dtype=torch.float32, device=export_device)
            edge_index = torch.zeros((2, max(1, num_nodes - 1)), dtype=torch.long, device=export_device)
            edge_attr = torch.zeros((edge_index.size(1), p_edge_feat), dtype=torch.float32, device=export_device)
            p_batch = torch.zeros((num_nodes,), dtype=torch.long, device=export_device)
            selected_p_nodes = torch.zeros((0,), dtype=torch.long, device=export_device)
            encoder_outputs = torch.zeros(
                (1, max_seq_len, model.backbone.embedding_dim), dtype=torch.float32, device=export_device
            )
            curr_v_node_id = torch.zeros((1,), dtype=torch.long, device=export_device)
            vnfs_remaining = torch.zeros((1,), dtype=torch.long, device=export_device)
            action_mask = torch.ones((1, model._policy_head.num_actions), dtype=torch.bool, device=export_device)
            candidate_features = torch.zeros(
                (1, model._policy_head.num_actions, model._policy_head.candidate_feature_dim),
                dtype=torch.float32,
                device=export_device,
            )
            history_features = torch.zeros((1, 1, p_feat), dtype=torch.float32, device=export_device)
            history_lengths = torch.tensor([1], dtype=torch.long, device=export_device)

            example = {
                "p_net_x": p_net_x,
                "p_net_edge_index": edge_index,
                "p_net_edge_attr": edge_attr,
                "p_net_batch": p_batch,
                "selected_p_nodes": selected_p_nodes,
                "history_features": history_features,
                "history_lengths": history_lengths,
                "encoder_outputs": encoder_outputs,
                "curr_v_node_id": curr_v_node_id,
                "vnfs_remaining": vnfs_remaining,
                "action_mask": action_mask,
                "candidate_features": candidate_features,
            }
            scripted = torch.jit.trace(wrapper, example, check_trace=False)
            scripted.save(tmp)
            logger = getattr(self.actor, "logger", None)
            if (
                script_exc is not None
                and logger is not None
                and not self._warned_trace_fallback
            ):
                logger.warning(f"TorchScript script export failed; using trace fallback: {script_exc}")
                self._warned_trace_fallback = True
        mode = "trace" if used_trace else "script"
        with open(mode_tmp, "w", encoding="ascii") as f:
            f.write(mode)
        os.replace(tmp, policy_ts_path)
        os.replace(mode_tmp, self._torchscript_mode_path(policy_ts_path))
        self._last_export_used_trace = used_trace
