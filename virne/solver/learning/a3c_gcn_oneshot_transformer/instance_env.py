# ==============================================================================
# instance_env.py
# ==============================================================================
import numpy as np
import networkx as nx
import os
import warnings
import torch
from gym import spaces
from virne.solver.learning.rl_base import JointPRStepInstanceRLEnv, PlaceStepInstanceRLEnv
 
class InstanceEnv(JointPRStepInstanceRLEnv):

    def __init__(self, p_net, v_net, controller, recorder, counter, global_history, **kwargs):
        super(InstanceEnv, self).__init__(p_net, v_net, controller, recorder, counter, **kwargs)
        num_p_net_node_attrs = len(self.p_net.get_node_attrs(['resource', 'extrema']))
        num_p_net_link_attrs = len(self.p_net.get_link_attrs(['resource', 'extrema']))
        num_p_net_features = num_p_net_node_attrs + 1
        self.window_size=100
        self.global_history = global_history  
        self.pad_token = kwargs.get("pad_token", None) 
        self.max_revokes=8
        self.calcuate_graph_metrics()

    
    def compute_reward(self, solution):
        """Reward function for one-shot VNet deployment."""

        vnodes = self.v_net.num_nodes
        vlinks = self.v_net.num_links
        total_reward = 0.0

        if solution['result']:
            # Success: all nodes placed and links routed
            total_reward = 2.0
        elif solution['place_result'] and not solution['route_result']:
            # Node placement okay, routing failed
            total_reward = -0.75
        elif solution['route_result']:  # Partial routing success
            routed_links = len(solution['link_paths'])
            total_reward = 1.0 + (routed_links / vlinks)  # Slightly scaled
        else:
            # Total failure
            total_reward = -1.0

        # Optional: scale to match your old scheme
        return total_reward


    
    def get_observation(self):
        """
        Returns the observation as a dictionary containing:
            - p_net_x and its edge index and edge attributes.
            - v_net_x and its edge index.
            - action_mask and history_actions. 
        """
        p_net_obs = self._get_p_net_obs()
        v_net_obs = self._get_v_net_obs()
        history_actions = self.get_history_actions()
        return {
            'p_net_x': p_net_obs['x'], 
            'p_net_edge_index': p_net_obs['edge_index'],
            'edge_attr': p_net_obs['edge_attr'],
            'v_net_x': v_net_obs['x'],
            'v_net_edge_index': v_net_obs['edge_index'],
            'action_mask': self.generate_action_mask(),
            'history_actions': history_actions,
        }

    def _get_v_net_obs(self):
        """
        Construct virtual network observation matrix with:
        - Node resource features (normalized)
        - Aggregated link bandwidth per node (normalized)
        - Edge index for GNN input
        """
        if self.curr_v_node_id >= self.v_net.num_nodes:
            return {
                'x': np.empty((0, 0), dtype=np.float32),
                'edge_index': np.empty((2, 0), dtype=np.int64)
            }

        # 1. Node resource features (e.g., CPU, RAM), already normalized
        node_data = self.obs_handler.get_node_attrs_obs(
            self.v_net, 
            node_attr_types=['resource'], 
            node_attr_benchmarks=self.node_attr_benchmarks
        )
        
        # 2. Aggregated bandwidth from adjacent virtual links (normalized)
        edge_bw_agg = self.obs_handler.get_link_aggr_attrs_obs(
            self.v_net, 
            link_attr_types=['resource'], 
            aggr='sum', 
            link_sum_attr_benchmarks=self.link_sum_attr_benchmarks
        )

        # Final virtual node feature matrix
        v_net_x = np.concatenate((node_data, edge_bw_agg), axis=-1)

        # Graph connectivity (for GNN)
        v_net_edge_index = self.obs_handler.get_link_index_obs(self.v_net)
        
        return {
            'x': v_net_x,
            'edge_index': v_net_edge_index
        }


    def _get_p_net_obs(self):
        """
        Construct physical network observation matrix with the following features:
        - Normalized available resources per node
        - Node degree (normalized)
        - Aggregated available bandwidth from adjacent links
        - Average available bandwidth over neighboring links (normalized)
        - Average node resource utilization (0–1)
        - Average link utilization around each node (0–1)
        """
        # 1. Resource features (e.g., CPU, RAM, GPU), already normalized
        resource_features = self.obs_handler.get_node_attrs_obs(
            self.p_net, 
            node_attr_types=['resource'], 
            node_attr_benchmarks=self.node_attr_benchmarks
        )
        
        # 2. Node degree (normalized)
        p_degrees = self.obs_handler.get_node_degree_obs(
            self.p_net, 
            self.obs_handler.get_degree_benchmark(self.p_net)
        )

        # 3. Aggregated available bandwidth from adjacent links (normalized)
        p_bw_agg = self.obs_handler.get_link_aggr_attrs_obs(
            self.p_net, 
            link_attr_types=['resource'], 
            aggr='sum', 
            link_sum_attr_benchmarks=self.obs_handler.get_link_sum_attr_benchmarks(self.p_net)
        )

        # 4. Neighbor bandwidth average (normalized by max link BW)
        link_benchmarks = self.obs_handler.get_link_attr_benchmarks(self.p_net)
        max_bw = link_benchmarks.get('bw', 1.0)
        neighbor_bw_avg = []
        for node in range(self.p_net.num_nodes):
            neighbors = list(self.p_net.adj[node])
            if neighbors:
                bw_values = [
                    self.p_net.links[tuple(sorted((node, nb)))]['bw'] 
                    for nb in neighbors
                ]
                neighbor_bw_avg.append(np.mean(bw_values))
            else:
                neighbor_bw_avg.append(0.0)
        neighbor_bw_avg = np.array(neighbor_bw_avg, dtype=np.float32).reshape((-1, 1))
        if max_bw > 0:
            neighbor_bw_avg /= max_bw

        # 5. Node utilization (converted from percentage to [0, 1])
        node_utilization = self.obs_handler.get_node_utilization_obs(self.p_net) / 100.0

        # 6. Average link utilization per node (also scaled to [0, 1])
        p_avg_link_util = self.obs_handler.get_avg_link_utilization_obs(self.p_net) / 100.0
        
         
              
        # Final node feature matrix
        p_net_x = np.hstack([
            resource_features,
            p_degrees,
            p_bw_agg,
            neighbor_bw_avg,
            node_utilization,
            p_avg_link_util, 
        ])

        # Graph connectivity (for GNN)
        edge_index = self.obs_handler.get_link_index_obs(self.p_net)

        # Edge features: duplicated for bidirectional edges
        edge_attr_half = self.obs_handler.get_link_attrs_utils_obs(
            self.p_net,
            link_attr_benchmarks=link_benchmarks
        )
        edge_attr = np.concatenate([edge_attr_half, edge_attr_half], axis=0)

        return {
            'x': p_net_x,
            'edge_index': edge_index,
            'edge_attr': edge_attr
        }
        
    def get_history_actions(self):
        full_hist = self.global_history
        tail_hist = full_hist[-self.window_size:]
        
        # If too short, pad with dummy node id (like num_nodes)
        padded = [self.p_net.number_of_nodes()] * (self.window_size - len(tail_hist)) + tail_hist
        
        # repeated = np.tile(np.array(padded, dtype=np.int64), (8, 1))  # FIX THIS
        repeated = np.tile(np.array(padded, dtype=np.int64), (self.v_net.num_nodes, 1))  # Correct

        
        # Add batch dimension → (1, 8, window_size)
        return np.expand_dims(repeated, axis=0)


