# ==============================================================================
# Copyright 2025 GeminiLight (wtfly2018@gmail.com). All Rights Reserved.
# ==============================================================================


from __future__ import annotations

import random
from collections import deque
from typing import Dict, List, Tuple

from virne.utils import path_to_links


class State:
    """State container with in-place residual tracking for MCTS."""

    def __init__(self, p_net, v_net, controller, recorder, counter, link_params: dict | None = None):
        self._original_p_net = p_net
        self.v_net = v_net
        self.controller = controller
        self.recorder = recorder
        self.counter = counter

        default_method = getattr(controller, 'shortest_method', 'bfs_shortest')
        default_k = getattr(controller, 'k_shortest', 1)
        self.link_params = link_params or {
            'shortest_method': default_method,
            'k': default_k,
        }

        self.node_resource_names = [attr.name for attr in controller.node_resource_attrs]
        self.link_resource_names = [attr.name for attr in controller.link_resource_attrs]

        self.v_index = -1
        self.p_node_id = p_net.num_nodes
        self.selected_p_net_nodes: List[int] = []
        self.max_expansion = p_net.num_nodes
        self.placement_map = [-1] * self.v_net.num_nodes
        self.reject_action_id = p_net.num_nodes
        self.rejected = False

        self.allow_rejection = False
        cfg = getattr(controller, 'config', None)
        try:
            if cfg is not None:
                if isinstance(cfg, dict):
                    solver_cfg = cfg.get('solver', {})
                    self.allow_rejection = bool(solver_cfg.get('allow_rejection', False))
                else:
                    solver_cfg = getattr(cfg, 'solver', None)
                    if solver_cfg is not None:
                        self.allow_rejection = bool(getattr(solver_cfg, 'allow_rejection', False))
        except Exception:
            self.allow_rejection = False

        self.reject_penalty = 50.0
        if cfg is not None:
            try:
                candidate = None
                if isinstance(cfg, dict):
                    solver_cfg = cfg.get('solver', {})
                    candidate = solver_cfg.get('reject_penalty', cfg.get('reject_penalty'))
                else:
                    solver_cfg = getattr(cfg, 'solver', None)
                    if solver_cfg is not None:
                        candidate = getattr(solver_cfg, 'reject_penalty', None)
                    if candidate is None:
                        candidate = getattr(cfg, 'reject_penalty', None)
                if candidate is not None:
                    self.reject_penalty = float(candidate)
            except Exception:
                pass

        self._resource_allocations: Dict[str, Dict] = {
            'node': {},
            'link': {},
        }
        self._reserved_paths: Dict[Tuple[int, int], List[int]] = {}
        self._p_net_view: PhysicalNetworkView | None = None

        self._initialise_virtual_order()
        self._precompute_totals()

    def _initialise_virtual_order(self) -> None:
        scores: List[Tuple[int, float]] = []
        for v_node in self.v_net.nodes:
            node_attrs = self.v_net.nodes[v_node]
            node_sum = sum(float(node_attrs.get(attr, 0)) for attr in self.node_resource_names)

            edge_sum = 0.0
            for neighbor in self.v_net.adj[v_node]:
                edge_attrs = self._virtual_edge_attrs(v_node, neighbor)
                for attr in self.link_resource_names:
                    edge_sum += float(edge_attrs.get(attr, 0))

            scores.append((v_node, node_sum + edge_sum))

        scores.sort(key=lambda item: item[1], reverse=True)
        self.v_order: List[int] = [node for node, _ in scores] or list(self.v_net.nodes)
        self.v_pos: Dict[int, int] = {node: idx for idx, node in enumerate(self.v_order)}

    def _precompute_totals(self) -> None:
        self.total_node_demand = 0.0
        for v_node in self.v_net.nodes:
            node_attrs = self.v_net.nodes[v_node]
            for attr in self.node_resource_names:
                self.total_node_demand += float(node_attrs.get(attr, 0))

        self.total_link_demand = 0.0
        for u, v in self.v_net.edges:
            edge_attrs = self._virtual_edge_attrs(u, v)
            for attr in self.link_resource_names:
                self.total_link_demand += float(edge_attrs.get(attr, 0))

        self.total_v_revenue = self.total_node_demand + self.total_link_demand

    @property
    def current_virtual_node(self) -> int | None:
        if self.v_index < 0 or self.v_index >= len(self.v_order):
            return None
        return self.v_order[self.v_index]

    @property
    def p_net(self):
        if self._p_net_view is None:
            self._p_net_view = PhysicalNetworkView(self._original_p_net, self._resource_allocations)
        return self._p_net_view

    def _virtual_edge_attrs(self, u: int, v: int) -> Dict:
        links = getattr(self.v_net, 'links', self.v_net.edges)
        try:
            return links[(u, v)]
        except KeyError:
            try:
                return links[(v, u)]
            except KeyError:
                return {}

    def _build_link_requirements(self, v_target: int):
        link_requirements = []
        if not self.link_resource_names:
            return link_requirements
        for n_v in self.v_net.adj[v_target]:
            if self.v_pos.get(n_v, 0) > self.v_index:
                continue
            pos = self.v_pos.get(n_v, None)
            if pos is None or pos >= len(self.selected_p_net_nodes):
                continue
            p_neighbor = self.selected_p_net_nodes[pos]
            edge_attrs = self._virtual_edge_attrs(v_target, n_v)
            demands = {}
            for attr in self.link_resource_names:
                demand = float(edge_attrs.get(attr, 0.0))
                if demand > 0.0:
                    demands[attr] = demand
            if demands:
                link_requirements.append((p_neighbor, demands))
        return link_requirements

    def _has_reachable_path(self, p_src: int, p_dst: int, demands: Dict) -> bool:
        if p_src == p_dst:
            return True
        if not demands:
            return True
        if p_src not in self._original_p_net or p_dst not in self._original_p_net:
            return False
        visited = set([p_src])
        queue = deque([p_src])
        while queue:
            u = queue.popleft()
            for v in self._original_p_net.adj[u]:
                if v in visited:
                    continue
                edge = self.p_net.links[(u, v)]
                ok = True
                for attr, demand in demands.items():
                    if demand <= 0.0:
                        continue
                    available = edge.get(attr, 0.0)
                    if available + 1e-8 < demand:
                        ok = False
                        break
                if not ok:
                    continue
                if v == p_dst:
                    return True
                visited.add(v)
                queue.append(v)
        return False

    def _filter_candidates_by_reachability(self, v_target: int, candidates: List[int]) -> List[int]:
        link_requirements = self._build_link_requirements(v_target)
        if not link_requirements:
            return candidates
        filtered: List[int] = []
        for p_node_id in candidates:
            reachable = True
            for p_neighbor, demands in link_requirements:
                if not self._has_reachable_path(p_node_id, p_neighbor, demands):
                    reachable = False
                    break
            if reachable:
                filtered.append(p_node_id)
        return filtered

    def is_terminal(self) -> bool:
        if self.rejected or self.p_node_id == -1:
            return True
        if not self.v_order:
            return True
        return self.v_index == len(self.v_order) - 1

    def compute_final_reward(self) -> float:
        if self.rejected:
            return -float(self.reject_penalty)
        if self.p_node_id == -1:
            return -1000.0
        if len(self.selected_p_net_nodes) != self.v_net.num_nodes:
            return -1000.0

        link_cost = 0.0
        for allocations in self._resource_allocations['link'].values():
            link_cost += sum(allocations.values())

        total_cost = self.total_node_demand + link_cost
        return 1000.0 + self.total_v_revenue - total_cost

    def _next_virtual_node_id(self) -> int | None:
        next_index = self.v_index + 1
        if next_index >= len(self.v_order):
            return None
        return self.v_order[next_index]

    def get_candidate_actions(self) -> List[int]:
        v_target = self._next_virtual_node_id()
        actions: List[int]

        if v_target is None:
            actions = []
        else:
            actions = list(self.controller.find_candidate_nodes(
                v_net=self.v_net,
                p_net=self.p_net,
                v_node_id=v_target,
                filter=self.selected_p_net_nodes,
                check_link_constraint=False,
            ))
            actions = self._filter_candidates_by_reachability(v_target, actions)

        if self.allow_rejection and not self.rejected:
            actions.append(self.reject_action_id)

        if not actions:
            actions = [-1]

        self.max_expansion = len(actions)
        return actions

    def random_select_next_state(self):
        actions = self.get_candidate_actions()
        choice = random.choice(actions) if actions else -1
        return self._create_child_state(choice)

    def get_candidate_states(self):
        return [self._create_child_state(action) for action in self.get_candidate_actions()]

    def _create_child_state(self, p_node_id: int):
        child = State.__new__(State)
        child._original_p_net = self._original_p_net
        child.v_net = self.v_net
        child.controller = self.controller
        child.recorder = self.recorder
        child.counter = self.counter
        child.link_params = self.link_params
        child.node_resource_names = self.node_resource_names
        child.link_resource_names = self.link_resource_names
        child.reject_action_id = self.reject_action_id
        child.v_order = self.v_order
        child.v_pos = self.v_pos
        child.total_node_demand = self.total_node_demand
        child.total_link_demand = self.total_link_demand
        child.total_v_revenue = self.total_v_revenue
        child.allow_rejection = self.allow_rejection
        child.reject_penalty = self.reject_penalty
        child.rejected = self.rejected
        child.v_index = self.v_index + 1
        child.p_node_id = p_node_id
        child.selected_p_net_nodes = list(self.selected_p_net_nodes)
        child.max_expansion = self.max_expansion
        child.placement_map = list(self.placement_map)
        child._resource_allocations = {
            'node': {nid: attrs.copy() for nid, attrs in self._resource_allocations['node'].items()},
            'link': {lid: attrs.copy() for lid, attrs in self._resource_allocations['link'].items()},
        }
        child._reserved_paths = {edge: list(path) for edge, path in self._reserved_paths.items()}
        child._p_net_view = None

        if p_node_id == self.reject_action_id:
            if child.allow_rejection:
                child.rejected = True
            else:
                child.p_node_id = -1
            return child

        if p_node_id == -1:
            child.p_node_id = -1
            return child

        child.selected_p_net_nodes.append(p_node_id)
        v_target = child.current_virtual_node
        if v_target is None:
            return child
        child.placement_map[v_target] = p_node_id

        if not child._apply_node_allocation(p_node_id, v_target):
            child.p_node_id = -1
            return child

        if not child._reserve_links_for_new_node(v_target, p_node_id):
            child.p_node_id = -1
            return child

        return child

    def _apply_node_allocation(self, p_node_id: int, v_node_id: int) -> bool:
        node_attrs = self.v_net.nodes[v_node_id]
        for attr in self.node_resource_names:
            demand = float(node_attrs.get(attr, 0))
            if demand <= 0:
                continue
            available = self.p_net.nodes[p_node_id].get(attr, 0.0)
            if available + 1e-8 < demand:
                return False
        for attr in self.node_resource_names:
            demand = float(node_attrs.get(attr, 0))
            if demand <= 0:
                continue
            self._track_resource_allocation('node', p_node_id, attr, demand)
        return True

    def _reserve_links_for_new_node(self, v_node_id: int, p_node_id: int) -> bool:
        for neighbor in self.v_net.adj[v_node_id]:
            neighbor_pos = self.v_pos.get(neighbor, float('inf'))
            if neighbor_pos > self.v_index:
                continue
            mapped_neighbor = self.placement_map[neighbor]
            if mapped_neighbor < 0:
                continue
            if not self._reserve_path_for_virtual_edge(v_node_id, neighbor, p_node_id, mapped_neighbor):
                return False
        return True

    def _reserve_path_for_virtual_edge(self, v_src: int, v_dst: int, p_src: int, p_dst: int) -> bool:
        edge_attrs = self._virtual_edge_attrs(v_src, v_dst)
        demands = {
            attr: float(edge_attrs.get(attr, 0))
            for attr in self.link_resource_names
        }
        positive_demands = {k: v for k, v in demands.items() if v > 0}

        method = self.link_params.get('shortest_method', 'bfs_shortest')
        k_limit = int(self.link_params.get('k', 1))
        if method in ('bfs_shortest', 'first_shortest', 'available_shortest'):
            k_limit = 1

        paths = self.controller.topology_analyzer.find_shortest_paths(
            self.v_net,
            self.p_net,
            (v_src, v_dst),
            (p_src, p_dst),
            method=method,
            k=max(1, k_limit),
        )

        if not paths:
            return False

        for candidate_path in paths:
            if len(candidate_path) < 2:
                continue

            link_pairs = path_to_links(candidate_path)
            feasible = True
            for p_link in link_pairs:
                link_view = self.p_net.links[p_link]
                for attr_name, demand in positive_demands.items():
                    if link_view.get(attr_name, 0.0) + 1e-8 < demand:
                        feasible = False
                        break
                if not feasible:
                    break
            if not feasible:
                continue

            for p_link in link_pairs:
                for attr_name, demand in positive_demands.items():
                    self._track_resource_allocation('link', p_link, attr_name, demand)

            key = (v_src, v_dst)
            self._reserved_paths[key] = list(candidate_path)
            return True

        return False

    def _track_resource_allocation(self, element_type: str, element_id, attr_name: str, value: float) -> None:
        element_table = self._resource_allocations.setdefault(element_type, {})
        attr_table = element_table.setdefault(element_id, {})
        attr_table[attr_name] = attr_table.get(attr_name, 0.0) + float(value)

    def get_reserved_paths(self) -> Dict[Tuple[int, int], List[int]]:
        return {edge: list(path) for edge, path in self._reserved_paths.items()}


class Node:
    """Node of the Monte Carlo search tree."""

    def __init__(self, parent=None, state: State | None = None):
        self.parent = parent
        if parent is not None:
            parent.children.append(self)
        self.children: List[Node] = []
        self.state = state
        self.visit_times = 0
        self.value = 0.0

    def is_complete_expand(self) -> bool:
        return len(self.children) == self.state.max_expansion


class PhysicalNetworkView:
    """View of the physical network reflecting shadow allocations."""

    def __init__(self, original_network, resource_allocations: Dict[str, Dict]):
        self._original = original_network
        self._allocations = resource_allocations

    def __getattr__(self, name):
        return getattr(self._original, name)

    def __iter__(self):
        return iter(self._original)

    def __len__(self):
        return len(self._original)

    def __contains__(self, node_id):
        return node_id in self._original

    def __getitem__(self, node_id):
        return self._original[node_id]

    @property
    def nodes(self):
        return NodesView(self._original.nodes, self._allocations.get('node', {}))

    @property
    def links(self):
        return LinksView(self._original.links, self._allocations.get('link', {}))


class NodesView:
    """Node view applying residual capacity adjustments."""

    def __init__(self, original_nodes, node_allocations: Dict[int, Dict[str, float]]):
        self._original = original_nodes
        self._allocations = node_allocations

    def _materialize_node(self, node_id):
        view = NodeView(self._original[node_id], self._allocations.get(node_id, {}))
        return {k: v for k, v in view.items()}

    def __getitem__(self, node_id):
        return NodeView(self._original[node_id], self._allocations.get(node_id, {}))

    def __iter__(self):
        return iter(self._original)

    def __len__(self):
        return len(self._original)

    def __contains__(self, node_id):
        return node_id in self._original

    def __call__(self, data=False, default=None):
        if data is False:
            return self._original(data=False, default=default)

        if data is True:
            def generator():
                for node_id in self._original:
                    yield (node_id, self._materialize_node(node_id))
            return generator()

        attr_name = data

        def attr_generator():
            for node_id in self._original:
                node_view = self[node_id]
                if attr_name in node_view:
                    yield (node_id, node_view[attr_name])
                else:
                    yield (node_id, default)

        return attr_generator()

    def data(self, data=True, default=None):
        return self.__call__(data=data, default=default)

    def items(self):
        for node_id in self._original:
            yield (node_id, self[node_id])

    def values(self):
        for node_id in self._original:
            yield self[node_id]

    def keys(self):
        return self._original.keys()


class NodeView:
    """Single-node view with residual capacity lookup."""

    def __init__(self, original_node, allocations: Dict[str, float]):
        self._original = original_node
        self._allocations = allocations

    def __iter__(self):
        return iter(self._original)

    def get(self, attr_name, default=None):
        original_value = self._original.get(attr_name, default)
        if original_value is None:
            return default
        allocated = self._allocations.get(attr_name, 0.0)
        return original_value - allocated

    def __getitem__(self, attr_name):
        original_value = self._original[attr_name]
        allocated = self._allocations.get(attr_name, 0.0)
        return original_value - allocated

    def __contains__(self, attr_name):
        return attr_name in self._original

    def keys(self):
        return self._original.keys()

    def items(self):
        for key in self._original.keys():
            yield key, self[key]

    def values(self):
        for key in self._original.keys():
            yield self[key]


class LinksView:
    """Edge view mirroring residual capacity updates."""

    def __init__(self, original_links, link_allocations: Dict[Tuple[int, int], Dict[str, float]]):
        self._original = original_links
        self._allocations = link_allocations

    def _materialize_link(self, link_id):
        view = NodeView(self._original[link_id], self._allocations.get(link_id, {}))
        return {k: v for k, v in view.items()}

    def __getitem__(self, link_id):
        return NodeView(self._original[link_id], self._allocations.get(link_id, {}))

    def __iter__(self):
        return iter(self._original)

    def __len__(self):
        return len(self._original)

    def __contains__(self, link_id):
        return link_id in self._original

    def __call__(self, nbunch=None, data=False, default=None):
        if data is False:
            return self._original(nbunch, data=False, default=default)

        def generator():
            for u, v, attr_dict in self._original(nbunch, data=True, default=default):
                link_id = (u, v)
                if data is True:
                    yield (u, v, self._materialize_link(link_id))
                else:
                    attr_name = data
                    view = self[link_id]
                    value = view[attr_name] if attr_name in view else default
                    yield (u, v, value)

        return generator()

    def data(self, nbunch=None, data=True, default=None):
        return self.__call__(nbunch=nbunch, data=data, default=default)
