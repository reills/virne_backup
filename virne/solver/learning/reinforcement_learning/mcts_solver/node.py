# ==============================================================================
# Copyright 2023 GeminiLight (wtfly2018@gmail.com). All Rights Reserved.
# ==============================================================================


import copy
import random

from virne.core import Solution


class State:
    """
    Optimized State class for MCTS that minimizes expensive deep copies.
    Instead of copying the entire physical network, we track resource changes.
    """
    def __init__(self, p_net, v_net, controller, recorder, counter):
        # Store references to immutable components
        self._original_p_net = p_net  # Keep reference to original
        self.v_net = v_net
        self.controller = controller
        self.counter = counter
        self.recorder = recorder
        
        # Track state changes instead of copying entire network
        self.v_node_id = -1  # wait
        self.p_node_id = p_net.num_nodes
        self.selected_p_net_nodes = []
        self.max_expansion = p_net.num_nodes
        
        # Track resource allocations: {element_type: {element_id: {attr_name: allocated_amount}}}
        self._resource_allocations = {
            'node': {},  # {node_id: {resource_name: allocated_amount}}
            'link': {}   # {link_id: {resource_name: allocated_amount}}
        }
        
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
        
    def get_allocation_summary(self) -> dict:
        """Get a summary of all current resource allocations (useful for debugging)"""
        summary = {
            'node_allocations': {},
            'link_allocations': {},
            'resource_types': {
                'node': self.get_node_resource_types(),
                'link': self.get_link_resource_types()
            }
        }
        
        # Summarize node allocations
        for node_id, allocations in self._resource_allocations.get('node', {}).items():
            summary['node_allocations'][node_id] = {}
            for resource, amount in allocations.items():
                original = self._original_p_net.nodes[node_id].get(resource, 0)
                remaining = original - amount
                summary['node_allocations'][node_id][resource] = {
                    'original': original,
                    'allocated': amount,
                    'remaining': remaining
                }
        
        # Summarize link allocations  
        for link_id, allocations in self._resource_allocations.get('link', {}).items():
            summary['link_allocations'][link_id] = {}
            for resource, amount in allocations.items():
                original = self._original_p_net.links[link_id].get(resource, 0)
                remaining = original - amount
                summary['link_allocations'][link_id][resource] = {
                    'original': original,
                    'allocated': amount,
                    'remaining': remaining
                }
                
        return summary

    def is_terminal(self):
        """Check the state is a terminal state"""
        # Case 1: current virtual node is the lastest one
        # Case 2: there is no node which is capable of accommodate the current virtual node
        if self.v_node_id == self.v_net.num_nodes - 1 or self.p_node_id == -1:
            return True
        else:
            return False

    def compute_final_reward(self):
        """
        Success: reward = revenue - cost
        Failure: reward = -inf
        """
        solution = Solution.from_v_net(self.v_net)
        for i in range(self.v_net.num_nodes):
            solution['node_slots'].update({i: self.selected_p_net_nodes[i]})
        link_result = self.controller.link_mapper.link_mapping(self.v_net, self.p_net, solution=solution,
                                                shortest_method='bfs_shortest', k=1, inplace=True)

        if link_result:
            v_net_cost = self.counter.calculate_v_net_cost(self.v_net, solution)
            v_net_revenue = self.counter.calculate_v_net_revenue(self.v_net)
            return 1000 + v_net_revenue - v_net_cost
        else:
            return -float('inf')

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
        child.selected_p_net_nodes = self.selected_p_net_nodes + [p_node_id]
        child.max_expansion = self._original_p_net.num_nodes
        
        # Copy resource allocations tracking (shallow copy of nested dicts)
        child._resource_allocations = {
            'node': {k: v.copy() for k, v in self._resource_allocations['node'].items()},
            'link': {k: v.copy() for k, v in self._resource_allocations['link'].items()}
        }
        
        # If we're placing a valid node, track the resource allocation
        if p_node_id != -1 and self.v_node_id + 1 < len(self.v_net.nodes):
            v_node = self.v_net.nodes[self.v_node_id + 1]
            
            # Get all node resource attribute names from controller
            node_resource_names = self.get_node_resource_types()
            
            # Track all node resource allocations dynamically (cpu, ram, gpu, etc.)
            for attr_name in v_node.keys():
                if attr_name in node_resource_names:
                    required_resource = v_node[attr_name]
                    child._track_resource_allocation('node', p_node_id, attr_name, required_resource)
                    
            # Note: Link resource tracking (bandwidth) happens during link mapping,
            # which is handled by the controller after MCTS node selection
        
        return child

    def random_select_next_state(self):
        """Random select a physical node to accommodate the next virtual node"""
        candidate_p_nodes = self.controller.find_candidate_nodes(
            v_net=self.v_net, 
            p_net=self.p_net, 
            v_node_id=self.v_node_id+1, 
            filter=self.selected_p_net_nodes)

        self.max_expansion = len(candidate_p_nodes)
        if self.max_expansion > 0:
            random_choice = random.choice([action for action in candidate_p_nodes])
        else:
            random_choice = -1
            
        return self._create_child_state(random_choice)

    def get_candidate_states(self):
        """Return all feasible next states for the upcoming virtual node."""
        candidate_p_nodes = self.controller.find_candidate_nodes(
            v_net=self.v_net,
            p_net=self.p_net,
            v_node_id=self.v_node_id + 1,
            filter=self.selected_p_net_nodes,
        )
        self.max_expansion = len(candidate_p_nodes)
        if self.max_expansion == 0:
            candidate_p_nodes = [-1]
            self.max_expansion = 1

        next_states = []
        for p_node in candidate_p_nodes:
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
        
    def __getitem__(self, node_id):
        return NodeView(self._original[node_id], self._allocations.get(node_id, {}))
        
    def __iter__(self):
        return iter(self._original)
        
    def __len__(self):
        return len(self._original)


class NodeView:
    """View of a single node with resource allocations applied"""
    def __init__(self, original_node, allocations):
        self._original = original_node
        self._allocations = allocations
        
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


class LinksView:
    """View of network links with resource allocations applied"""
    def __init__(self, original_links, link_allocations):
        self._original = original_links  
        self._allocations = link_allocations
        
    def __getitem__(self, link_id):
        return NodeView(self._original[link_id], self._allocations.get(link_id, {}))  # Reuse NodeView
        
    def __iter__(self):
        return iter(self._original)
        
    def __len__(self):
        return len(self._original)


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

    def is_complete_expand(self):
        if len(self.children) == self.state.max_expansion:
            return True
        else:
            return False