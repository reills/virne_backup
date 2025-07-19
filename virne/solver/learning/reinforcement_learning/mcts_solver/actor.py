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

        # Create static environment data
        static_environment = self._create_static_environment(p_net, v_net)
        
        current_node = Node(None, State(p_net, v_net, self.controller, self.recorder, self.counter))
        solution = Solution.from_v_net(v_net)
        trajectory: List[dict] = []

        for v_node_id in range(v_net.num_nodes):
            # Get MCTS search results
            current_node = self.search(current_node)
            if current_node is None or current_node.state.p_node_id == -1:
                solution["place_result"] = False
                break
            
            solution["node_slots"].update({v_node_id: current_node.state.p_node_id})
            
            # Create timestep data with all required information
            timestep_data = self._create_timestep_data(current_node, v_node_id)
            trajectory.append(timestep_data)

        if solution.get("place_result", True):
            link_ok = self.controller.link_mapper.link_mapping(
                v_net, p_net, solution=solution,
                shortest_method=self.shortest_method, k=self.k_shortest, inplace=True)
            if not link_ok:
                solution["route_result"] = False

        # Calculate final reward
        final_reward = self._compute_final_reward(solution, v_net, p_net)
        self._store_episode_new_format(static_environment, trajectory, final_reward)
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
    def _store_episode_new_format(self, static_environment: dict, trajectory: List[dict], final_reward: float) -> None:
        """Store episode in new efficient JSON format."""
        data = {
            "static_environment": static_environment,
            "trajectory": trajectory,
            "final_reward": final_reward
        }
        path = os.path.join(self.replay_dir, f"{random.random():.6f}.json")
        with open(path, "w") as f:
            json.dump(data, f, cls=NumpyEncoder)
        self._cleanup()

    def _store_episode(self, trajectory: List[dict], outcome: int) -> None:
        """Legacy method for backward compatibility."""
        data = {"trajectory": trajectory, "outcome": outcome}
        path = os.path.join(self.replay_dir, f"{random.random():.6f}.json")
        with open(path, "w") as f:
            json.dump(data, f, cls=NumpyEncoder)
        self._cleanup()

    def _cleanup(self, keep: int = 500000) -> None:
        files = sorted([f for f in os.listdir(self.replay_dir) if f.endswith(".json")])
        for f in files[:-keep]:
            os.remove(os.path.join(self.replay_dir, f))

    def _create_static_environment(self, p_net, v_net) -> dict:
        """Create static environment data containing unchanging network info."""
        # Extract physical network structure with max capacities
        physical_network = {
            "nodes": [
                {
                    "id": node_id,
                    "max_cpu": p_net.nodes[node_id].get("max_cpu", p_net.nodes[node_id].get("cpu", 0))
                }
                for node_id in p_net.nodes
            ],
            "links": [
                {
                    "source": u,
                    "target": v,
                    "max_bw": p_net.edges[u, v].get("max_bw", p_net.edges[u, v].get("bw", 0))
                }
                for u, v in p_net.edges
            ]
        }
        
        # Extract SFC request (virtual network)
        sfc_request = {
            "nodes": [
                {
                    "id": node_id,
                    "cpu_demand": v_net.nodes[node_id].get("cpu", 0)
                }
                for node_id in v_net.nodes
            ],
            "links": [
                {
                    "source": u,
                    "target": v,
                    "bw_demand": v_net.edges[u, v].get("bw", 0)
                }
                for u, v in v_net.edges
            ]
        }
        
        return {
            "physical_network": physical_network,
            "sfc_request": sfc_request
        }
    
    def _create_timestep_data(self, node: Node, v_node_id: int) -> dict:
        """Create timestep data with dynamic state, policy, value, and action info."""
        state = node.state
        
        # Dynamic state: only current resource utilization\n        # Note: state.p_net contains remaining/available resources, so used = max - available
        dynamic_state = {
            "p_node_cpu_used": {
                str(i): state.p_net.nodes[i].get("max_cpu", 0) - state.p_net.nodes[i].get("cpu", 0) 
                for i in state.p_net.nodes
            },
            "p_link_bw_used": {
                f"{u}-{v}": state.p_net.edges[u, v].get("max_bw", 0) - state.p_net.edges[u, v].get("bw", 0)
                for u, v in state.p_net.edges
            }
        }
        
        # Generate action mask
        candidate_nodes = self.controller.find_candidate_nodes(
            v_net=state.v_net,
            p_net=state.p_net,
            v_node_id=state.v_node_id + 1,
            filter=state.selected_p_net_nodes,
        )
        action_mask = [False] * state.p_net.num_nodes
        for node_id in candidate_nodes:
            if 0 <= node_id < len(action_mask):
                action_mask[node_id] = True
        
        # Get policy from MCTS visit counts and value from root
        policy = self._compute_policy_vector(node)
        value = self._compute_value(node)
        
        return {
            "dynamic_state": dynamic_state,
            "action_mask": action_mask,
            "policy": policy,
            "value": value,
            "action_taken": state.p_node_id
        }
    
    def _compute_policy_vector(self, node: Node) -> List[float]:
        """Compute normalized policy vector from MCTS visit counts."""
        policy = [0.0] * node.state.p_net.num_nodes
        
        if not node.children:
            return policy
        
        # Get visit counts for each child
        total_visits = sum(child.visit_times for child in node.children)
        if total_visits == 0:
            return policy
        
        for child in node.children:
            if 0 <= child.state.p_node_id < len(policy):
                policy[child.state.p_node_id] = child.visit_times / total_visits
        
        return policy
    
    def _compute_value(self, node: Node) -> float:
        """Compute value estimate from MCTS root node."""
        if node.visit_times == 0:
            # If no visits, get neural network value estimate
            obs = self._state_to_obs(node.state)
            with torch.no_grad():
                value = self.policy.evaluate(obs)
            return float(value.item())
        return node.value / node.visit_times
    
    def _compute_final_reward(self, solution: Solution, v_net, p_net) -> float:
        """Compute the final reward for the trajectory."""
        if solution.get("result", False):
            v_net_cost = self.counter.calculate_v_net_cost(v_net, solution)
            v_net_revenue = self.counter.calculate_v_net_revenue(v_net)
            return 1000 + v_net_revenue - v_net_cost
        else:
            return -1000.0  # Failure penalty
    
    def _serialize_state(self, state: State) -> dict:
        """Legacy method for backward compatibility."""
        return serialize_state(state)


