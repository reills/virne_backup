from __future__ import annotations

import json
import os
import random
import math
from typing import List

import networkx as nx

import torch

from .net import ActorCritic
from virne.solver.learning.rl_core.policy_builder import PolicyBuilder

from virne.core import Solution
from virne.solver.base_solver import Solver, SolverRegistry

from .mcts import MctsSolver
from .node import Node, State


@SolverRegistry.register(solver_name="alpha_zero_sfc", solver_type="r_learning")
class AlphaZeroSFCSolver(MctsSolver):
    """AlphaZero-style solver for Service Function Chaining VNE.

    This solver uses Monte Carlo Tree Search guided by a neural policy. Actors
    generate trajectories which are stored on disk for an off-policy learner.
    The implementation here focuses on the actor side and basic replay logic.
    """

    def __init__(self, controller, recorder, counter, logger, config,
                 replay_dir: str = "replay_buffer", batch_size: int = 32, **kwargs):
        super().__init__(controller, recorder, counter, logger, config, **kwargs)
        self.replay_dir = replay_dir
        self.batch_size = batch_size
        self.policy_path = os.path.join(self.replay_dir, "policy_latest.pt")
        os.makedirs(self.replay_dir, exist_ok=True)

        feature_cfg = PolicyBuilder.get_feature_dim_config(config)
        self.device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
        self.policy = ActorCritic(
            p_net_num_nodes=feature_cfg['p_net_num_nodes'],
            p_net_feature_dim=feature_cfg['p_net_x_dim'],
            v_net_feature_dim=feature_cfg['v_net_x_dim']
        ).to(self.device)
        if os.path.exists(self.policy_path):
            self.policy.load_state_dict(torch.load(self.policy_path, map_location=self.device))
        self.policy.eval()

    def solve(self, instance):
        """Run MCTS guided by the current policy and store the episode."""
        v_net, p_net = instance["v_net"], instance["p_net"]
        current_node = Node(None, State(p_net, v_net, self.controller, self.recorder, self.counter))
        solution = Solution.from_v_net(v_net)
        trajectory: List[dict] = []

        for v_node_id in range(v_net.num_nodes):
            current_node = self.search(current_node)
            if current_node is None or current_node.state.p_node_id == -1:
                solution["place_result"] = False
                break
            solution["node_slots"].update({v_node_id: current_node.state.p_node_id})
            policy = self._compute_policy(current_node)
            trajectory.append({
                "state": self._serialize_state(current_node.state),
                "policy": policy.tolist()
            })

        if solution.get("place_result", True):
            link_ok = self.controller.link_mapper.link_mapping(
                v_net, p_net, solution=solution, shortest_method=self.shortest_method,
                k=self.k_shortest, inplace=True)
            if not link_ok:
                solution["route_result"] = False

        outcome = 1 if solution.get("result", False) else -1
        self._store_episode(trajectory, outcome)
        return solution

    def _compute_policy(self, node: Node) -> torch.Tensor:
        visits = torch.tensor([child.visit_times for child in node.children], dtype=torch.float32)
        if visits.sum() == 0:
            return torch.ones(len(node.children)) / max(len(node.children), 1)
        return visits / visits.sum()

    def _store_episode(self, trajectory: List[dict], outcome: int) -> None:
        data = {"trajectory": trajectory, "outcome": outcome}
        path = os.path.join(self.replay_dir, f"{random.random():.6f}.json")
        with open(path, "w") as f:
            json.dump(data, f)
        self._cleanup()

    def _serialize_state(self, state: State) -> dict:
        """Serialize environment state to JSON friendly format."""
        return {
            "v_net": nx.node_link_data(state.v_net),
            "p_net": nx.node_link_data(state.p_net),
            "selected": state.selected_p_net_nodes,
            "v_node_id": state.v_node_id,
        }

    def _cleanup(self, keep: int = 500000) -> None:
        files = sorted([f for f in os.listdir(self.replay_dir) if f.endswith(".json")])
        for f in files[:-keep]:
            os.remove(os.path.join(self.replay_dir, f))

    def learn_step(self) -> None:
        """Placeholder for the learner's update step."""
        if not os.path.exists(self.policy_path):
            return
        # Learning logic would load trajectories and update the policy.
        pass

    # --- AlphaZero overrides of MCTS methods ---
    def select_and_expand(self, node: Node):
        while not node.state.is_terminal():
            if node.is_complete_expand():
                node = self.best_child(node, True)
                if node is None:
                    break
            else:
                candidate_state = node.state.random_select_next_state()
                prior, value = self._policy_value(candidate_state)
                next_node = Node(node, candidate_state, prior=prior)
                next_node.value = value
                return next_node
        return node

    def simulate(self, node: Node):
        _, value = self._policy_value(node.state)
        return value

    def best_child(self, node: Node, is_exploration: bool):
        best_score = -float('inf')
        best_child_node = None
        total_visits = math.sqrt(max(node.visit_times, 1))
        c = self.exploration_constant if is_exploration else 0.0
        for child in node.children:
            q = child.value / max(child.visit_times, 1)
            u = c * child.prior * total_visits / (1 + child.visit_times)
            score = q + u
            if score > best_score:
                best_score = score
                best_child_node = child
        return best_child_node

    # --- Neural policy helpers ---
    def _policy_value(self, state: State) -> tuple[float, float]:
        obs = self._state_to_obs(state)
        with torch.no_grad():
            logits = self.policy.act(obs)
            value = self.policy.evaluate(obs)
            prob = torch.softmax(logits, dim=-1)[0]
        action_idx = state.p_node_id
        prior = prob[action_idx].item() if action_idx < prob.numel() else 0.0
        return prior, float(value.item())

    def _state_to_obs(self, state: State) -> dict:
        from virne.solver.learning.utils import load_pyg_data_from_network
        p_data = load_pyg_data_from_network(state.p_net)
        v_data = load_pyg_data_from_network(state.v_net)
        encoder_in = v_data.x.unsqueeze(0)
        encoder_outputs = self.policy.encode({'v_net_x': encoder_in})
        history_len = len(state.selected_p_net_nodes) + 1
        hist = torch.zeros(1, history_len, p_data.num_node_features)
        for i, idx in enumerate(state.selected_p_net_nodes):
            if idx >= 0 and idx < p_data.num_nodes:
                hist[0, i + 1] = p_data.x[idx]
        action_mask = torch.ones(1, self.policy.actor.decoder.num_actions, dtype=torch.bool)
        return {
            'p_net': p_data,
            'history_features': hist,
            'encoder_outputs': encoder_outputs,
            'curr_v_node_id': torch.tensor([state.v_node_id + 1]),
            'vnfs_remaining': torch.tensor([state.v_net.num_nodes - state.v_node_id - 1]),
            'action_mask': action_mask,
            'v_net_x': encoder_in,
        }
