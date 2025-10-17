# ==============================================================================
# Copyright 2023 GeminiLight (wtfly2018@gmail.com). All Rights Reserved.
# ==============================================================================


import copy
import random

from virne.core import Solution
from virne.utils import path_to_links


class State:
    """
    Optimized State class for MCTS that minimizes expensive deep copies.
    Instead of copying the entire physical network, we track resource changes.
    """
    def __init__(self, p_net, v_net, controller, recorder, counter, link_params: dict | None = None):
        # Store references to immutable components
        self._original_p_net = p_net  # Keep reference to original
        self.v_net = v_net
        self.controller = controller
        self.counter = counter
        self.recorder = recorder
        # Store link-mapping params for consistent evaluation with production
        default_shortest = getattr(controller, 'shortest_method', 'bfs_shortest')
        default_k = 1
        self.link_params = link_params or {
            'shortest_method': default_shortest,
            'k': default_k,
        }
        
        # Track state changes instead of copying entire network
        self.v_node_id = -1  # wait
        self.p_node_id = p_net.num_nodes
        self.selected_p_net_nodes = []
        self.max_expansion = p_net.num_nodes
        self.rejected = False
        # Respect solver setting for explicit rejection action
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
        # Penalty for explicit rejection (moderate, smaller magnitude than failure)
        # Prefer config.solver.reject_penalty, then top-level reject_penalty, else default 50.0
        self.reject_penalty = 50.0
        cfg = getattr(controller, 'config', None)
        if cfg is not None:
            try:
                rp = getattr(getattr(cfg, 'solver', {}), 'reject_penalty', None)
                if rp is None:
                    rp = getattr(cfg, 'reject_penalty', None)
                if rp is not None:
                    self.reject_penalty = float(rp)
            except Exception:
                pass
        
        # Track resource allocations: {element_type: {element_id: {attr_name: allocated_amount}}}
        self._resource_allocations = {
            'node': {},  # {node_id: {resource_name: allocated_amount}}
            'link': {}   # {link_id: {resource_name: allocated_amount}}
        }

        # Stable per-request virtual node ordering (descending demand)
        # Demand = sum(node resources) + sum(incident link demands)
        try:
            node_resource_names = [attr.name for attr in self.controller.node_resource_attrs]
            link_resource_names = [attr.name for attr in self.controller.link_resource_attrs]
            scores = []
            for v in self.v_net.nodes:
                node_demand = 0.0
                for attr in node_resource_names:
                    node_demand += float(self.v_net.nodes[v].get(attr, 0))
                edge_demand = 0.0
                for n in self.v_net.adj[v]:
                    # Avoid double-counting by summing both directions; order is irrelevant here for ranking
                    for l_attr in link_resource_names:
                        edge_demand += float(self.v_net.edges[v, n].get(l_attr, 0))
                scores.append((v, node_demand + edge_demand))
            self.v_order = [vid for vid, _ in sorted(scores, key=lambda x: x[1], reverse=True)]
        except Exception:
            # Fallback to ID order
            self.v_order = list(self.v_net.nodes)
        # Position index: v-node id -> order position
        self.v_pos = {vid: i for i, vid in enumerate(self.v_order)}
        
    @property 
    def p_net(self):
        """Return a view of current p_net state with resource tracking"""
        if not hasattr(self, '_p_net_view'):
            self._p_net_view = PhysicalNetworkView(self._original_p_net, self._resource_allocations)
        return self._p_net_view
        
    def _track_resource_allocation(self, element_type: str, element_id: int, attr_name: str, value: float):
        """Track resource allocation for rollback purposes"""
        if element_type not in self._resource_allocations:
            self._resource_allocations[element_type] = {}
        if element_id not in self._resource_allocations[element_type]:
            self._resource_allocations[element_type][element_id] = {}
        
        # Track cumulative allocation
        current_allocation = self._resource_allocations[element_type][element_id].get(attr_name, 0)
        self._resource_allocations[element_type][element_id][attr_name] = current_allocation + value
        
    def get_node_resource_types(self) -> list:
        """Get all node resource type names from controller configuration"""
        return [attr.name for attr in self.controller.node_resource_attrs]
        
    def get_link_resource_types(self) -> list:
        """Get all link resource type names from controller configuration"""
        return [attr.name for attr in self.controller.link_resource_attrs]
        
    def get_available_resources(self, element_type: str, element_id: int, attr_name: str) -> float:
        """Get currently available resources accounting for allocations"""
        if element_type == 'node':
            original_value = self._original_p_net.nodes[element_id].get(attr_name, 0)
        elif element_type == 'link':
            original_value = self._original_p_net.links[element_id].get(attr_name, 0)
        else:
            raise ValueError(f"Unknown element_type: {element_type}")
            
        allocated = self._resource_allocations.get(element_type, {}).get(element_id, {}).get(attr_name, 0)
        return original_value - allocated
        
    def is_terminal(self):
        """Check the state is a terminal state"""
        # Case 1: current virtual node is the lastest one
        # Case 2: there is no node which is capable of accommodate the current virtual node
        if self.rejected or self.v_node_id == self.v_net.num_nodes - 1 or self.p_node_id == -1:
            return True
        else:
            return False

    def compute_final_reward(self):
        """
        Success: reward = revenue - cost
        Failure: return a large negative value without attempting full mapping
        """
        # If explicit rejection was chosen, apply moderate penalty
        if self.rejected:
            return -float(self.reject_penalty)

        # If termination is due to infeasibility (no candidates), return failure immediately
        if self.p_node_id == -1:
            return -1000.0

        # Only attempt link mapping when we have a complete placement
        if len(self.selected_p_net_nodes) != self.v_net.num_nodes:
            return -1000.0

        solution = Solution.from_v_net(self.v_net)
        # Map selected placements following the stable ordering
        for pos in range(self.v_net.num_nodes):
            v_id = self.v_order[pos]
            solution['node_slots'].update({v_id: self.selected_p_net_nodes[pos]})

        # IMPORTANT: Use the original physical network with inplace=False here.
        # The State.p_net is a read-only view that subtracts shadow allocations.
        # Passing it into link_mapper (which mutates p_net when inplace=True) would break.
        # Using inplace=False ensures we deep-copy the original network and avoid side effects.
        link_result = self.controller.link_mapper.link_mapping(
            self.v_net,
            self._original_p_net,
            solution=solution,
            shortest_method=self.link_params.get('shortest_method', 'bfs_shortest'),
            k=int(self.link_params.get('k', 1)),
            inplace=False,
        )

        if link_result:
            v_net_cost = self.counter.calculate_v_net_cost(self.v_net, solution)
            v_net_revenue = self.counter.calculate_v_net_revenue(self.v_net)
            return 1000 + v_net_revenue - v_net_cost
        else:
            return -1000.0

    def _create_child_state(self, p_node_id):
        """Efficiently create child state by copying minimal data"""
        child = State.__new__(State)  # Skip __init__ to avoid deep copy
        
        # Copy references (no deep copy needed)
        child._original_p_net = self._original_p_net
        child.v_net = self.v_net
        child.controller = self.controller
        child.counter = self.counter
        child.recorder = self.recorder
        
        # Copy state data (lightweight)
        child.v_node_id = self.v_node_id + 1
        child.p_node_id = p_node_id
        child.selected_p_net_nodes = list(self.selected_p_net_nodes)
        child.max_expansion = self._original_p_net.num_nodes
        # Ensure link params are preserved in child
        child.link_params = self.link_params
        # Preserve rejection state and penalty; copy stable ordering
        child.rejected = getattr(self, 'rejected', False)
        child.reject_penalty = getattr(self, 'reject_penalty', 50.0)
        child.allow_rejection = getattr(self, 'allow_rejection', False)
        child.v_order = getattr(self, 'v_order', list(self.v_net.nodes))
        child.v_pos = getattr(self, 'v_pos', {vid: i for i, vid in enumerate(child.v_order)})
        
        # Copy resource allocations tracking (shallow copy of nested dicts)
        child._resource_allocations = {
            'node': {k: v.copy() for k, v in self._resource_allocations['node'].items()},
            'link': {k: v.copy() for k, v in self._resource_allocations['link'].items()}
        }
        
        # If we're placing a valid node, track the resource allocation
        # REJECT action: use virtual action id = number of physical nodes
        reject_action_id = self._original_p_net.num_nodes
        if p_node_id == reject_action_id:
            if getattr(self, 'allow_rejection', False):
                child.rejected = True
            else:
                child.p_node_id = -1
            return child

        if p_node_id != -1:
            child.selected_p_net_nodes.append(p_node_id)

        if p_node_id != -1 and self.v_node_id + 1 < len(self.v_net.nodes):
            # Next virtual node to place in our stable order
            v_target = self.v_order[self.v_node_id + 1]
            v_node = self.v_net.nodes[v_target]
            
            # Get all node resource attribute names from controller
            node_resource_names = self.get_node_resource_types()
            
            # Track all node resource allocations dynamically (cpu, ram, gpu, etc.)
            for attr_name in v_node.keys():
                if attr_name in node_resource_names:
                    required_resource = v_node[attr_name]
                    child._track_resource_allocation('node', p_node_id, attr_name, required_resource)
            
            # Incremental link-feasibility check and shadow reservation.
            # After placing this virtual node, try to route any virtual edges
            # whose both endpoints are already placed. If any fail, prune.
            new_v = v_target
            for n_v in self.v_net.adj[new_v]:
                # A neighbor is already placed iff its position <= current position
                if self.v_pos[n_v] > self.v_node_id:
                    continue

                p_u = p_node_id  # newly selected p-node for v_target
                p_v = child.selected_p_net_nodes[self.v_pos[n_v]]

                # Quick non-allocating path check honoring link constraints.
                # Use the same shortest-path policy as the orchestrator so ablations on k stay coherent.
                shortest_method = self.link_params.get('shortest_method', 'bfs_shortest')
                k_limit = int(self.link_params.get('k', 1))
                # For methods that inherently return a single path (e.g. bfs_shortest) keep k=1
                if shortest_method in ('bfs_shortest', 'first_shortest'):
                    k_limit = 1
                paths = self.controller.topology_analyzer.find_shortest_paths(
                    self.v_net,
                    child.p_net,  # view with shadow allocations applied
                    (new_v, n_v),
                    (p_u, p_v),
                    method=shortest_method,
                    k=max(1, k_limit),
                )

                if not paths:
                    # prune: make this child immediately terminal-bad
                    import logging
                    # Only log first few occurrences to avoid spam
                    if not hasattr(self, '_prune_log_count'):
                        self._prune_log_count = 0
                    if self._prune_log_count < 3:
                        logging.getLogger(__name__).warning(
                            f"⚠️  LINK PRUNING: v_node={v_target} -> p_node={p_node_id} FAILED link check for v_link=({new_v},{n_v}) p_link=({p_u},{p_v}). "
                            f"Step={self.v_node_id+1}, already_placed={child.selected_p_net_nodes}, v_pos[{n_v}]={self.v_pos[n_v]}, parent_v_node_id={self.v_node_id}"
                        )
                        self._prune_log_count += 1
                    child.p_node_id = -1
                    return child

                # Shadow-reserve link resources along the found path so subsequent
                # expansions see reduced residual capacity through the view.
                p_links = path_to_links(paths[0])
                for p_link in p_links:
                    for l_attr in self.controller.link_resource_attrs:
                        demand = self.v_net.links[(new_v, n_v)][l_attr.name]
                        child._track_resource_allocation('link', p_link, l_attr.name, demand)
        
        return child

    def random_select_next_state(self):
        """Random select a physical node to accommodate the next virtual node"""
        v_target = self.v_order[self.v_node_id + 1]
        candidate_p_nodes = self.controller.find_candidate_nodes(
            v_net=self.v_net, 
            p_net=self.p_net, 
            v_node_id=v_target, 
            filter=self.selected_p_net_nodes,
            check_link_constraint=False)

        reject_action_id = self._original_p_net.num_nodes
        candidate_with_reject = list(candidate_p_nodes)
        if getattr(self, 'allow_rejection', False):
            candidate_with_reject.append(reject_action_id)
        if not candidate_with_reject:
            candidate_with_reject = [-1]
        self.max_expansion = len(candidate_with_reject)
        random_choice = random.choice(candidate_with_reject)
            
        return self._create_child_state(random_choice)

    def get_candidate_states(self):
        """Return all feasible next states for the upcoming virtual node."""
        v_target = self.v_order[self.v_node_id + 1]
        candidate_p_nodes = self.controller.find_candidate_nodes(
            v_net=self.v_net,
            p_net=self.p_net,
            v_node_id=v_target,
            filter=self.selected_p_net_nodes,
            check_link_constraint=False,
        )

        # Include explicit REJECT action only if solver allows it
        reject_action_id = self._original_p_net.num_nodes
        candidate_with_reject = list(candidate_p_nodes)
        if getattr(self, 'allow_rejection', False):
            candidate_with_reject.append(reject_action_id)
        if not candidate_with_reject:
            import logging
            logging.getLogger(__name__).debug(
                "State.get_candidate_states no feasible nodes for v_node=%s after placing=%s",
                v_target,
                self.selected_p_net_nodes,
            )
            candidate_with_reject = [-1]
        self.max_expansion = len(candidate_with_reject)

        next_states = []
        for p_node in candidate_with_reject:
            next_states.append(self._create_child_state(p_node))
        return next_states

    def next_state(self, p_node_id: int):
        """Generate the next state choosing a specific physical node."""
        return self._create_child_state(p_node_id)


class PhysicalNetworkView:
    """
    A view of the physical network that accounts for resource allocations
    without modifying the original network.
    """
    def __init__(self, original_p_net, resource_allocations):
        self._original = original_p_net
        self._allocations = resource_allocations
        
    def __getattr__(self, name):
        """Delegate attribute access to original network"""
        return getattr(self._original, name)

    def __iter__(self):
        """Iterate over nodes like a regular NetworkX graph."""
        return iter(self._original)

    def __len__(self):
        """Return the number of nodes to satisfy len(G) contracts."""
        return len(self._original)

    def __contains__(self, node_id):
        """Support `node in G` checks required by NetworkX shortest path routines."""
        return node_id in self._original

    def __getitem__(self, node_id):
        """Delegate bracket indexing (adjacency lookup) to the original graph."""
        return self._original[node_id]
        
    @property
    def nodes(self):
        """Return a view of nodes with adjusted resources"""
        return NodesView(self._original.nodes, self._allocations.get('node', {}))
        
    @property 
    def links(self):
        """Return a view of links with adjusted resources"""
        return LinksView(self._original.links, self._allocations.get('link', {}))


class NodesView:
    """View of network nodes with resource allocations applied"""
    def __init__(self, original_nodes, node_allocations):
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
        """
        Mimic networkx NodeView.__call__ signature so downstream code can use
        p_net.nodes(data=...).
        """
        if data is False:
            return self._original(data=False, default=default)

        if data is True:
            def generator():
                for node_id in self._original:
                    yield (node_id, self._materialize_node(node_id))
            return generator()

        # data treated as attribute name
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
        """Compatibility helper for code using nodes.data(...)."""
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
    """View of a single node with resource allocations applied"""
    def __init__(self, original_node, allocations):
        self._original = original_node
        self._allocations = allocations

    def __iter__(self):
        return iter(self._original)
        
    def get(self, attr_name, default=None):
        """Get attribute value accounting for allocations"""
        original_value = self._original.get(attr_name, default)
        if original_value is None:
            return default
        allocated = self._allocations.get(attr_name, 0)
        return original_value - allocated
        
    def __getitem__(self, attr_name):
        """Get attribute value accounting for allocations"""
        original_value = self._original[attr_name]
        allocated = self._allocations.get(attr_name, 0)
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
    """View of network links with resource allocations applied"""
    def __init__(self, original_links, link_allocations):
        self._original = original_links  
        self._allocations = link_allocations

    def _materialize_link(self, link_id):
        view = NodeView(self._original[link_id], self._allocations.get(link_id, {}))
        return {k: v for k, v in view.items()}

    def __getitem__(self, link_id):
        return NodeView(self._original[link_id], self._allocations.get(link_id, {}))  # Reuse NodeView
        
    def __iter__(self):
        return iter(self._original)
        
    def __len__(self):
        return len(self._original)

    def __contains__(self, link_id):
        return link_id in self._original

    def __call__(self, nbunch=None, data=False, default=None):
        """
        Mimic networkx EdgeView.__call__ so callers can use p_net.links(...).
        """
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

class Node:
    """Node of the Monte Carlo Tree."""

    def __init__(self, parent=None, state=None, prior: float = 0.0):
        self.parent = parent
        if parent is not None:
            parent.children.append(self)
        self.children = []
        self.state = state
        self.visit_times = 0
        self.value = 0.0
        # Prior probability of selecting this node predicted by the policy
        self.prior = float(prior)
        # Cached leaf value from NN evaluation during expansion (avoids double NN calls)
        self.leaf_value = None

    def is_complete_expand(self):
        if len(self.children) == self.state.max_expansion:
            return True
        else:
            return False
