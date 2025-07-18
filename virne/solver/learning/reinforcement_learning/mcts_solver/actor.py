# Split actor component from AlphaZeroSFCSolver
from __future__ import annotations

import json
import os
import random
from typing import List

import numpy as np
import torch

from virne.core import Solution
from .net import ActorCritic
from .mcts import MctsSolver
from .node import Node, State
from .common import state_to_obs, serialize_state


class NumpyEncoder(json.JSONEncoder):
    """Custom JSON encoder for numpy data types."""
    def default(self, obj):
        if isinstance(obj, np.integer):
            return int(obj)
        elif isinstance(obj, np.floating):
            return float(obj)
        elif isinstance(obj, np.ndarray):
            return obj.tolist()
        return super().default(obj)


class AlphaZeroActor(MctsSolver):
    """Actor process that generates trajectories using MCTS."""

    def __init__(self, controller, recorder, counter, logger, config,
                 replay_dir: str = "replay_buffer", **kwargs):
        super().__init__(controller, recorder, counter, logger, config, **kwargs)
        self.replay_dir = replay_dir
        self.policy_path = os.path.join(self.replay_dir, "policy_latest.pt")
        os.makedirs(self.replay_dir, exist_ok=True)

        self.device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
        self.policy = ActorCritic(
            p_net_num_nodes=config.simulation.p_net_setting_num_nodes,
            p_net_feature_dim=config.simulation.p_net_setting_num_node_resource_attrs,
            v_net_feature_dim=config.simulation.v_sim_setting_num_node_resource_attrs,
            p_net_edge_dim=config.simulation.p_net_setting_num_link_resource_attrs,
        ).to(self.device)
        if os.path.exists(self.policy_path):
            self.policy.load_state_dict(torch.load(self.policy_path, map_location=self.device))
        self.policy.eval()

        # Caches used during one solve episode
        self._p_data = None
        self._v_data = None
        self._encoder_outputs = None

    # ------------------------------------------------------------------
    def solve(self, instance):
        """Run MCTS guided by the current policy and store the episode."""
        v_net, p_net = instance["v_net"], instance["p_net"]

        from virne.solver.learning.utils import load_pyg_data_from_network

        self._p_data = load_pyg_data_from_network(p_net).to(self.device)
        self._v_data = load_pyg_data_from_network(v_net).to(self.device)
        self._encoder_outputs = self.policy.encode({"v_net_x": self._v_data.x.unsqueeze(0)})

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
                "policy": policy.tolist(),
            })

        if solution.get("place_result", True):
            link_ok = self.controller.link_mapper.link_mapping(
                v_net, p_net, solution=solution,
                shortest_method=self.shortest_method, k=self.k_shortest, inplace=True)
            if not link_ok:
                solution["route_result"] = False

        outcome = 1 if solution.get("result", False) else -1
        self._store_episode(trajectory, outcome)
        return solution

    # ------------------------------------------------------------------
    def _state_to_obs(self, state: State) -> dict:
        return state_to_obs(
            state,
            self.policy,
            self.controller,
            self.device,
            p_data=self._p_data,
            v_data=self._v_data,
            encoder_outputs=self._encoder_outputs,
        )

    def _compute_policy(self, node: Node) -> torch.Tensor:
        visits = torch.tensor([child.visit_times for child in node.children], dtype=torch.float32)
        if visits.sum() == 0:
            return torch.ones(len(node.children)) / max(len(node.children), 1)
        return visits / visits.sum()

    def _policy_value(self, state: State) -> tuple[float, float]:
        obs = self._state_to_obs(state)
        with torch.no_grad():
            logits = self.policy.act(obs)
            value = self.policy.evaluate(obs)
            prob = torch.softmax(logits, dim=-1)[0]
        action_idx = state.p_node_id
        prior = prob[action_idx].item() if action_idx < prob.numel() else 0.0
        return prior, float(value.item())

    def _expand_node(self, node: Node) -> None:
        obs = self._state_to_obs(node.state)
        with torch.no_grad():
            logits = self.policy.act(obs)
            probs = torch.softmax(logits, dim=-1)[0]
        candidate_states = node.state.get_candidate_states()
        for state in candidate_states:
            p_idx = state.p_node_id
            prior = probs[p_idx].item() if 0 <= p_idx < probs.numel() else 0.0
            Node(node, state, prior=prior)

    # ------------------------------------------------------------------
    def _store_episode(self, trajectory: List[dict], outcome: int) -> None:
        data = {"trajectory": trajectory, "outcome": outcome}
        path = os.path.join(self.replay_dir, f"{random.random():.6f}.json")
        with open(path, "w") as f:
            json.dump(data, f, cls=NumpyEncoder)
        self._cleanup()

    def _cleanup(self, keep: int = 500000) -> None:
        files = sorted([f for f in os.listdir(self.replay_dir) if f.endswith(".json")])
        for f in files[:-keep]:
            os.remove(os.path.join(self.replay_dir, f))

    def _serialize_state(self, state: State) -> dict:
        return serialize_state(state)


