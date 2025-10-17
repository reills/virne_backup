"""MCTSEngine for pure MCTS tree search logic.

This module handles the core MCTS operations:
- Running MCTS search with multiple simulations
- Selection (PUCT formula)
- Expansion (via NodeExpander)
- Backup (value backpropagation)
- Best child selection (temperature-based)
"""
from __future__ import annotations

import math
from typing import List, TYPE_CHECKING

import numpy as np

from .node import Node

if TYPE_CHECKING:
    from .node_expander import NodeExpander


class MCTSEngine:
    """Pure MCTS search engine using PUCT formula."""

    def __init__(
        self,
        node_expander: NodeExpander,
        computation_budget: int = 5,
        c_puct: float = 1.0,
        logger=None
    ):
        """Initialize MCTSEngine.

        Args:
            node_expander: NodeExpander for expanding nodes
            computation_budget: Number of MCTS simulations per search
            c_puct: Exploration constant for PUCT formula
            logger: Logger instance
        """
        self.node_expander = node_expander
        self.computation_budget = computation_budget
        self.c_puct = c_puct
        self.logger = logger

    def search(self, root_node: Node, v_node_id: int) -> None:
        """Run MCTS search from root node.

        Args:
            root_node: Root node to search from
            v_node_id: Virtual node ID being placed
        """
        # If this is the first call, expand the root node with Dirichlet noise
        if not root_node.children and not root_node.state.is_terminal():
            self.node_expander.expand_node(root_node, v_node_id, add_dirichlet_noise=True)

        # Run MCTS simulations
        effective_expansions = 0
        for _ in range(self.computation_budget):
            expanded = self._run_simulation(root_node)
            if expanded:
                effective_expansions += 1

        # Attach quick search diagnostics to root for logging later
        root_node._diag_effective_sims = effective_expansions

    def _run_simulation(self, root_node: Node) -> bool:
        """Run a single MCTS simulation from root to leaf.

        Args:
            root_node: Root node to start simulation from

        Returns:
            True if a new node was expanded, False otherwise
        """
        # Path must include root and all nodes down to leaf (inclusive)
        path = [root_node]
        node = root_node

        # 1. Selection - traverse down the tree using PUCT
        while not node.state.is_terminal() and node.children:
            node = self._select_child_puct(node)
            path.append(node)

        # 2. Expansion - get both policy and value in single NN call
        expanded = False
        if not node.state.is_terminal():
            had_children = bool(node.children)
            # At non-root depths, infer the correct next virtual node from node.state
            self.node_expander.expand_node(node)  # Caches leaf_value on node
            expanded = (not had_children) and bool(node.children)

        # 3. Backup - terminal uses true reward (z), non-terminal uses NN value (v_θ)
        if node.state.is_terminal():
            # Terminal nodes: use true final reward (z)
            value = node.state.compute_final_reward()
        else:
            # Non-terminal leaf: use NN value (v_θ) cached during expansion
            value = node.leaf_value if node.leaf_value is not None else 0.0

        self._backup(path, value)
        return expanded

    def _select_child_puct(self, node: Node) -> Node:
        """Select child using PUCT (Polynomial Upper Confidence Trees).

        Args:
            node: Parent node

        Returns:
            Selected child node
        """
        def _is_selectable(child: Node) -> bool:
            pid = child.state.p_node_id
            # Allow normal placements and explicit reject (num_nodes). Treat -1 as fallback.
            return (0 <= pid < node.state.p_net.num_nodes) or pid == node.state.p_net.num_nodes or pid == -1

        selectable_children = [child for child in node.children if _is_selectable(child)]
        if not selectable_children:
            return None

        total_visits = sum(child.visit_times for child in selectable_children)
        sqrt_total = math.sqrt(total_visits + 1)

        best_score = -float('inf')
        best_child = None

        for child in selectable_children:
            # PUCT formula: Q(s,a) + c_puct * P(s,a) * sqrt(N(s)) / (1 + N(s,a))
            if child.visit_times > 0:
                q_value = child.value / child.visit_times
            else:
                q_value = 0.0

            u_value = self.c_puct * child.prior * sqrt_total / (1 + child.visit_times)
            score = q_value + u_value

            if score > best_score:
                best_score = score
                best_child = child

        return best_child if best_child else selectable_children[0]

    def _backup(self, path: List[Node], value: float) -> None:
        """Backup the value through the path.

        Args:
            path: List of nodes from root to leaf
            value: Value to backup
        """
        for node in reversed(path):
            node.visit_times += 1
            node.value += value

    def select_best_child(self, node: Node, temperature: float = 1.0) -> Node:
        """Select best child based on visit counts.

        Args:
            node: Parent node
            temperature: Temperature for action selection (0 = greedy, 1 = proportional)

        Returns:
            Selected child node
        """
        def _is_selectable(child: Node) -> bool:
            pid = child.state.p_node_id
            return (0 <= pid < node.state.p_net.num_nodes) or pid == node.state.p_net.num_nodes or pid == -1

        selectable_children = [child for child in node.children if _is_selectable(child)]
        if not selectable_children:
            return None

        if temperature == 0:
            # Greedy selection
            return max(selectable_children, key=lambda child: child.visit_times)
        else:
            # Temperature-based selection
            visits = np.array([child.visit_times for child in selectable_children])
            if temperature != 1.0:
                visits = visits ** (1.0 / temperature)

            probs = visits / visits.sum()
            idx = np.random.choice(len(selectable_children), p=probs)
            return selectable_children[idx]
