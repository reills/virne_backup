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
from pathlib import Path
 
 
class InstanceEnv(JointPRStepInstanceRLEnv):

    def __init__(self, p_net, v_net, controller, recorder, counter, **kwargs):
        super(InstanceEnv, self).__init__(p_net, v_net, controller, recorder, counter, **kwargs)
        num_p_net_node_attrs = len(self.p_net.get_node_attrs(['resource', 'extrema']))
        num_p_net_link_attrs = len(self.p_net.get_link_attrs(['resource', 'extrema']))
        num_p_net_features = num_p_net_node_attrs + 1
        self.pad_token = kwargs.get("pad_token", None) 
        self.max_revokes=8
        self.calcuate_graph_metrics()
        self.phase = kwargs.get("phase", 1) #for curriculum learning? 

 
    def get_observation(self ):
        """
        Returns the observation as a dictionary.
        If a transformer policy is provided, injects encoder_outputs.
        """
        p_net_obs = self._get_p_net_obs()
        v_net_obs = self._get_v_net_obs()
        history_actions = self.get_history_actions()
        
        if not hasattr(self, '_cached_candidates') or self._cached_candidates_vnode != self.curr_v_node_id:
            p_node_prev = self.selected_p_net_nodes[-1] if self.selected_p_net_nodes else None
            self._cached_candidates = self.controller.find_candidate_nodes(
                self.v_net, self.p_net, self.curr_v_node_id,
                filter=self.selected_p_net_nodes,
                p_node_prev=p_node_prev,
                solution=self.solution
            )
            self._cached_candidates_vnode = self.curr_v_node_id

        obs = {
            'p_net_x': p_net_obs['x'],
            'p_net_edge_index': p_net_obs['edge_index'],
            'edge_attr': p_net_obs['edge_attr'],
            'v_net_x': v_net_obs['x'],
            'v_net_edge_index': v_net_obs['edge_index'],
            'action_mask': self.generate_action_mask(),
            'history_actions': history_actions,
            'curr_v_node_id': self.curr_v_node_id,
            'vnfs_remaining': self.v_net.num_nodes - self.curr_v_node_id,
        }

        return obs

    def generate_action_mask(self):
        """Generates a valid action mask based on placement feasibility and curriculum phase."""
        #print(f"[PHASE] Phase = {self.phase} | Placed = {self.num_placed_v_net_nodes} | Interactions = {self.solution['num_interactions']}")

        # Get candidates from controller (based on physical constraints and path feasibility)
        p_node_prev = self.selected_p_net_nodes[-1] if self.selected_p_net_nodes else None
        #print(f"{p_node_prev} was the previously placed node")
        candidates = self._cached_candidates

        # Remove previously revoked candidates
        key = (str(self.solution.node_slots), self.curr_v_node_id)
        revoked = self.revoked_actions_dict.get(key, [])
        failed = self.attempt_blacklist.get(self.curr_v_node_id, set())
        
        #print(f"[MASK] VNode {self.curr_v_node_id} candidates BEFORE mask: {candidates}")
        candidates = [p for p in candidates if p not in revoked and p not in failed]
        
        #print(f"[MASK] Revoked: {revoked} | Failed: {failed}")

        # ---- Curriculum-aware Revoke / Reject Masking ----
        threshold_ok = self.solution['revoke_times'] < self.max_revokes

        # PHASE 2+: Allow revoke if we've placed any nodes and under max_revokes
        if self.phase >= 2 and self.allow_revocable and self.num_placed_v_net_nodes > 0 and threshold_ok:
            candidates.append(self.revocable_action)

        # PHASE 3+: Allow reject once at least 1 action attempted
        if self.phase >= 3 and self.allow_rejection and self.solution['num_interactions'] > 0:
            candidates.append(self.rejection_action)

        # ---- Build binary action mask ----
        mask = np.zeros(self.num_actions, dtype=bool)
        indices = [a for a in candidates if 0 <= a < self.num_actions]
        mask[indices] = True

        # ---- Fallback: allow reject if absolutely no other option ----
        if not mask.any():
            #print(f"[WARN] No valid actions for VNode {self.curr_v_node_id} (revokes={self.solution['revoke_times']})")
            if self.allow_rejection and 0 <= self.rejection_action < self.num_actions:
                mask[self.rejection_action] = True
                #print("[WARN] Fallback to REJECTION action.")
            else:
                print("[ERROR] No valid fallback. Agent is stuck.")

        return mask

 
    def compute_reward(self, solution, revoke=False):
        if revoke:
            # Small penalty for backtracking
            reward = -0.2 / self.v_net.num_nodes
        elif solution['early_rejection']:
            # Harsh penalty for giving up
            reward = -1.0
        elif not solution['place_result'] or not solution['route_result']:
            # Step failed
            reward = -0.5 / self.v_net.num_nodes
        elif solution['result']:
            # Final success
            reward = solution['v_net_r2c_ratio']
        else:
            # Intermediate success
            reward = 1.0 / self.v_net.num_nodes

        self.solution['v_net_reward'] += reward
        return reward
 
    
    
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
        
        # --- Distance Feature: From previously placed VNF to all physical nodes ---
        p_prev = None
        curr_v_node_id = self.curr_v_node_id  # Property access
        current_v_idx = -1

        ranked_node_array = self.v_net.ranked_nodes
        ranked_list = list(ranked_node_array)
        current_v_idx = ranked_list.index(curr_v_node_id)
         
        if current_v_idx > 0:
            prev_v_node_id = self.v_net.ranked_nodes[current_v_idx - 1]
            # Ensure solution and node_slots exist
            if prev_v_node_id in self.solution['node_slots']:
                 p_prev = prev_v_node_id 

        # Step 3: Compute using the instance method or fallback to zeros
        distance_feature = self._get_normalized_distance_feature(p_prev) # <<< CORRECTED CALL
        if distance_feature is None:
            # Optional: Log only if p_prev was valid but calculation failed
            if p_prev is not None:
                print(f"Warning: Distance calc failed for p_prev={p_prev}. Using zeros.")
            distance_feature = np.zeros((self.p_net.num_nodes, 1), dtype=np.float32)
              
        # Final node feature matrix
        p_net_x = np.hstack([
            resource_features,
            p_degrees,
            p_bw_agg,
            neighbor_bw_avg,
            node_utilization,
            p_avg_link_util,
            distance_feature
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
        """
        Return the sequence of previously placed physical node IDs as int64 array.
        This is used by the transformer decoder.
        """
        return np.array(self.selected_p_net_nodes, dtype=np.int64)

