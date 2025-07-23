# Split actor component from AlphaZeroSFCSolver
from __future__ import annotations

import json
import math
import os
import random
from typing import List

import numpy as np
import torch

from virne.core import Solution
from virne.solver.base_solver import Solver
from .net import ActorCritic
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


class AlphaZeroActor(Solver):
    """Actor process that generates trajectories using MCTS."""

    def __init__(self, controller, recorder, counter, logger, config,
                 replay_dir: str = "replay_buffer", models_dir: str = None, **kwargs):
        super().__init__(controller, recorder, counter, logger, config, **kwargs)
        self.replay_dir = replay_dir
        
        # Policy path should be in models directory, not replay buffer
        if models_dir:
            self.policy_path = os.path.join(models_dir, "policy_latest.pt")
        else:
            self.policy_path = os.path.join(self.replay_dir, "policy_latest.pt")
            
        os.makedirs(self.replay_dir, exist_ok=True)
        if models_dir:
            os.makedirs(models_dir, exist_ok=True)
        # MCTS configuration parameters from config
        self.computation_budget = getattr(config.training, 'computation_budget', 50)
        self.c_puct = getattr(config.training, 'c_puct', 1.0)
        # Link mapping parameters (inherited from MctsSolver)
        self.shortest_method = kwargs.get('shortest_method', 'bfs_shortest')
        self.k_shortest = kwargs.get('k_shortest', 10)

        self.device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
        self.policy = ActorCritic(
            p_net_num_nodes=config.simulation.p_net_setting_num_nodes,
            p_net_feature_dim=config.simulation.p_net_setting_num_node_resource_attrs,
            v_net_feature_dim=config.simulation.v_sim_setting_num_node_resource_attrs,
            p_net_edge_dim=config.simulation.p_net_setting_num_link_resource_attrs,
        ).to(self.device)
        
        # Load pretrained weights if specified (same logic as learner)
        model_loaded = False
        alphazero_model_path = getattr(config.training, 'alphazero_model_path', '')
        resume_training = getattr(config.training, 'resume_training', True)
        
        # Priority 1: Specific model path
        if alphazero_model_path and os.path.exists(alphazero_model_path):
            self.policy.load_state_dict(torch.load(alphazero_model_path, map_location=self.device))
            self.logger.info(f"Actor loaded AlphaZero model from: {alphazero_model_path}")
            model_loaded = True
        # Priority 2: Resume from latest policy
        elif resume_training and os.path.exists(self.policy_path):
            self.policy.load_state_dict(torch.load(self.policy_path, map_location=self.device))
            self.logger.info(f"Actor resumed from: {self.policy_path}")
            model_loaded = True
        
        if not model_loaded:
            self.logger.info("Actor starting from scratch (no pretrained model loaded)")
            
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
            # Run MCTS search to update current_node's children with visit statistics
            self.search(current_node, v_node_id)
            
            # Select the best child based on visit counts
            best_child = self._select_best_child(current_node, temperature=0)
            if best_child is None or best_child.state.p_node_id == -1:
                solution["place_result"] = False
                break
            
            # Store the action taken
            solution["node_slots"].update({v_node_id: best_child.state.p_node_id})
            
            # Create timestep data using the current root (before moving to child)
            timestep_data = self._create_timestep_data(current_node, v_node_id, best_child.state.p_node_id)
            trajectory.append(timestep_data)
            
            # Promote the best child as the new root for next iteration
            # Detach from parent to avoid memory buildup
            best_child.parent = None
            current_node = best_child

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
    # AlphaZero MCTS Implementation
    # ------------------------------------------------------------------
    
    def search(self, root_node: Node, v_node_id: int) -> None:
        """AlphaZero MCTS search that uses neural network guidance.
        
        Performs simulations and updates the root node's children with visit statistics.
        Does not return anything - the caller should select the best child afterwards.
        """
        # If this is the first call, expand the root node
        if not root_node.children and not root_node.state.is_terminal():
            self._expand_node(root_node, v_node_id)
        
        # Run MCTS simulations
        for _ in range(self.computation_budget):
            self._run_simulation(root_node, v_node_id)
    
    def _run_simulation(self, root_node: Node, v_node_id: int) -> None:
        """Run a single MCTS simulation from root to leaf."""
        path = []
        node = root_node
        
        # 1. Selection - traverse down the tree using PUCT
        while not node.state.is_terminal() and node.children:
            node = self._select_child_puct(node)
            path.append(node)
        
        # 2. Expansion and Evaluation
        if not node.state.is_terminal():
            # Expand the node using neural network
            self._expand_node(node, v_node_id)
            # Note: We evaluate the expanded leaf node itself, not a random child
        
        # 3. Backup - propagate value from the leaf node up the path
        value = self._evaluate_leaf(node, v_node_id)
        self._backup(path, value)
    
    def _select_child_puct(self, node: Node) -> Node:
        """Select child using PUCT (Polynomial Upper Confidence Trees)."""
        if not node.children:
            return None
            
        total_visits = sum(child.visit_times for child in node.children)
        sqrt_total = math.sqrt(total_visits + 1)
        
        best_score = -float('inf')
        best_child = None
        
        for child in node.children:
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
        
        return best_child if best_child else node.children[0]
    
    def _evaluate_leaf(self, node: Node, v_node_id: int) -> float:
        """Evaluate a leaf node using the neural network value head."""
        obs = self._state_to_obs(node.state, v_node_id)
        with torch.no_grad():
            value = self.policy.evaluate(obs)
        return float(value.item())
    
    def _backup(self, path: List[Node], value: float) -> None:
        """Backup the value through the path."""
        for node in reversed(path):
            node.visit_times += 1
            node.value += value
    
    def _select_best_child(self, node: Node, temperature: float = 1.0) -> Node:
        """Select best child based on visit counts."""
        if not node.children:
            return None
        
        if temperature == 0:
            # Greedy selection
            return max(node.children, key=lambda child: child.visit_times)
        else:
            # Temperature-based selection
            visits = np.array([child.visit_times for child in node.children])
            if temperature != 1.0:
                visits = visits ** (1.0 / temperature)
            
            probs = visits / visits.sum()
            idx = np.random.choice(len(node.children), p=probs)
            return node.children[idx]
    
    # ------------------------------------------------------------------
    def _state_to_obs(self, state: State, v_node_id: int = None) -> dict:
        # If v_node_id is not provided, use the next virtual node to place
        if v_node_id is None:
            v_node_id = state.v_node_id + 1
        
        return state_to_obs(
            state,
            self.policy,
            self.controller,
            self.device,
            p_data=self._p_data,
            v_data=self._v_data,
            encoder_outputs=self._encoder_outputs,
            v_node_id=v_node_id,
        )

    def _compute_policy(self, node: Node) -> torch.Tensor:
        visits = torch.tensor([child.visit_times for child in node.children], dtype=torch.float32)
        if visits.sum() == 0:
            return torch.ones(len(node.children)) / max(len(node.children), 1)
        return visits / visits.sum()


    def _expand_node(self, node: Node, v_node_id: int) -> None:
        obs = self._state_to_obs(node.state, v_node_id)
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

    def _cleanup(self, keep: int = None) -> None:
        """Clean up old replay buffer files, keeping only the most recent ones."""
        if keep is None:
            keep = getattr(self.config.training, 'replay_buffer_max_size', 500000)
        
        files = sorted([f for f in os.listdir(self.replay_dir) if f.endswith(".json")])
        if len(files) > keep:
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
    
    def _create_timestep_data(self, node: Node, v_node_id: int, action_taken: int) -> dict:
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
            v_node_id=v_node_id,
            filter=state.selected_p_net_nodes,
        )
        action_mask = [False] * state.p_net.num_nodes
        for node_id in candidate_nodes:
            if 0 <= node_id < len(action_mask):
                action_mask[node_id] = True
        
        # Get policy from MCTS visit counts and value from root
        policy = self._compute_policy_vector(node)
        value = self._compute_value(node, v_node_id)
        
        return {
            "dynamic_state": dynamic_state,
            "action_mask": action_mask,
            "policy": policy,
            "value": value,
            "action_taken": action_taken
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
    
    def _compute_value(self, node: Node, v_node_id: int) -> float:
        """Compute value estimate from MCTS root node."""
        if node.visit_times == 0:
            # If no visits, get neural network value estimate
            obs = self._state_to_obs(node.state, v_node_id)
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
    
    def solve_vnr_with_mcts(self, v_net, p_net, solution, controller):
        """Consolidated MCTS VNR solving method used by both solver and workers."""
        from virne.solver.learning.utils import load_pyg_data_from_network

        # Prepare data for neural network
        self._p_data = load_pyg_data_from_network(p_net).to(self.device)
        self._v_data = load_pyg_data_from_network(v_net).to(self.device)
        self._encoder_outputs = self.policy.encode({"v_net_x": self._v_data.x.unsqueeze(0)})

        # Create initial state
        current_node = Node(None, State(p_net, v_net, controller, self.recorder, self.counter))
        
        # Generate training data for this episode
        static_environment = self._create_static_environment(p_net, v_net)
        trajectory = []

        # Use MCTS to decide placement for each virtual node
        for v_node_id in range(v_net.num_nodes):
            # Run MCTS search to get the best physical node for this virtual node
            self.search(current_node, v_node_id)
            
            # Select the best child based on visit counts
            best_child = self._select_best_child(current_node, temperature=0)
            if best_child is None or best_child.state.p_node_id == -1:
                return False
                
            p_node_id = best_child.state.p_node_id
            
            # Use the controller to actually place the node (standard VNE way)
            place_result, place_info = controller.node_mapper.place(
                v_net, p_net, v_node_id, p_node_id, solution=solution
            )
            
            if not place_result:
                return False
                
            # Store trajectory data for learning
            timestep_data = self._create_timestep_data(current_node, v_node_id, p_node_id)
            trajectory.append(timestep_data)
            
            # Move to the next state
            best_child.parent = None
            current_node = best_child

        # Store episode for learning
        final_reward = self._compute_final_reward(solution, v_net, p_net)
        self._store_episode_new_format(static_environment, trajectory, final_reward)
        self._cleanup()
        
        return True


