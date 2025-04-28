# ==============================================================================
# instance_rl_environment.py
# ==============================================================================


import copy
import numpy as np
import networkx as nx
import torch

from virne.base import Solution
from .rl_enviroment_base import RLBaseEnv
from .online_rl_environment import *
from ..obs_handler import ObservationHandler
from ...rank.node_rank import rank_nodes
from virne.config import set_sim_info_to_object


class InstanceRLEnv(RLBaseEnv):

    def __init__(self, p_net, v_net, controller, recorder, counter, **kwargs):
        self.p_net = p_net
        self.v_net = v_net
        self.counter = counter
        self.recorder = recorder
        self.controller = controller
        super(InstanceRLEnv, self).__init__(**kwargs)
        self.p_net_backup = copy.deepcopy(self.p_net)
        self.solution = Solution(v_net)
        # ranking strategy
        self.reusable = kwargs.get('reusable', False)
        self.node_ranking_method = kwargs.get('node_ranking_method', 'order')
        self.link_ranking_method = kwargs.get('link_ranking_method', 'order')
        # node mapping
        self.matching_mathod = kwargs.get('matching_mathod', 'greedy')
        # link mapping
        self.shortest_method = kwargs.get('shortest_method', 'bfs_shortest')
        self.k_shortest = kwargs.get('k_shortest', 10)
        # calcuate graph metrics
        # self.node_ranking_method = 'nps'
        self.ranked_v_net_nodes = rank_nodes(self.v_net, self.node_ranking_method)
        self.solution['v_net_reward'] = 0 
        self.solution['num_interactions'] = 0  
        self.solution['failed'] = False  
        self.device = kwargs.get("device", torch.device("cpu"))
        
        self._distance_cache = {} # Stores {p_node_id: full_distance_dict}
        self._normalized_distance_vector_cache = {} # Stores {p_node_id: np.array}
        self.attempt_blacklist = defaultdict(set)
        self.retry_budget = defaultdict(int)  # Tracks how many retries have been used for each vnode
        self.max_retry_budget = defaultdict(lambda: 6)  # You can change 3 to anything or set dynamically later


        # set_sim_info_to_object(kwargs, self)
    def _get_normalized_distance_feature(self, source_p_node_id):
        """
        Returns a normalized shortest-path distance vector from the given source physical node
        to all other nodes in the physical network. Values are cached for reuse.
        """
        # Access diameter directly from p_net property
        current_diameter = self.p_net.diameter # Access the cached property

        if source_p_node_id is None or source_p_node_id not in self.p_net.nodes:
            return None

        # 1. Return cached normalized result if available
        if source_p_node_id in self._normalized_distance_vector_cache:
            return self._normalized_distance_vector_cache[source_p_node_id]

        # 2. Retrieve or compute raw distances
        if source_p_node_id in self._distance_cache:
            dist_dict = self._distance_cache[source_p_node_id]
        else:
            try:
                dist_dict = nx.single_source_shortest_path_length(self.p_net, source=source_p_node_id)
                self._distance_cache[source_p_node_id] = dist_dict
            except nx.NodeNotFound:
                print(f"[Distance] Node {source_p_node_id} not found.")
                return None
            except Exception as e:
                print(f"[Distance] Error computing from node {source_p_node_id}: {e}")
                return None

        # 3. Build full distance array with defaults
        num_p_nodes = self.p_net.num_nodes
        distances = np.full(num_p_nodes, np.inf, dtype=np.float32)
        for target_node, dist in dist_dict.items():
            if 0 <= target_node < num_p_nodes:
                distances[target_node] = dist

        # Ensure self-distance is zero (nx usually handles this, but good safety check)
        if 0 <= source_p_node_id < num_p_nodes:
            distances[source_p_node_id] = 0

        # 4. Replace infinities and normalize
        # Use the diameter obtained from self.p_net.diameter
        distances[distances == np.inf] = current_diameter + 1.0
        normalized = distances / max(1.0, float(current_diameter)) # Use the fetched diameter
        normalized_vector = normalized.reshape(-1, 1)

        # 5. Cache and return
        self._normalized_distance_vector_cache[source_p_node_id] = normalized_vector
        return normalized_vector
    
    def reset(self):
        self.solution.reset()
        self.p_net = copy.deepcopy(self.p_net_backup)
        
        self._distance_cache.clear()
        self._normalized_distance_vector_cache.clear()  
        
        self.attempt_blacklist.clear()
        self.retry_budget.clear()
        self.max_retry_budget.clear()
        
        return super().reset()

    def reject(self, is_early=True):
        self.solution['early_rejection'] = is_early
        solution_info = self.solution.to_dict()
        done = True
        return self.get_observation(), self.compute_reward(self.solution), done, self.get_info(solution_info)

    def revoke(self):
        assert len(self.placed_v_net_nodes) != 0
        self.solution['place_result'] = True
        self.solution['route_result'] = True
        self.solution['revoke_times'] += 1

        last_v_node_id = self.placed_v_net_nodes[-1]
        paired_p_node_id = self.selected_p_net_nodes[-1]

        # ── Invalidate candidate cache ──
        self._cached_candidates = None
        self._cached_candidates_vnode = None

        # ── Undo placement and routing ──
        self.controller.undo_place_and_route(
            self.v_net, self.p_net,
            last_v_node_id, paired_p_node_id,
            self.solution
        )

        solution_info = self.counter.count_partial_solution(self.v_net, self.solution)
        self.revoked_actions_dict[last_v_node_id].append(paired_p_node_id)

        # ── Return raw observation (agent will re-inject encoder_outputs and preprocess externally) ──
        obs = self.get_observation()
        return obs, self.compute_reward(self.solution, revoke=True), False, self.get_info(solution_info)


class JointPRStepInstanceRLEnv(InstanceRLEnv):
    
    def __init__(self, p_net, v_net, controller, recorder, counter, **kwargs):
        super(JointPRStepInstanceRLEnv, self).__init__(p_net, v_net, controller, recorder, counter, **kwargs)
 
    def check_last_chance(self ):
        candidates = self._cached_candidates

        # Remove previously revoked candidates
        key = (str(self.solution.node_slots), self.curr_v_node_id)
        revoked = self.revoked_actions_dict.get(key, [])
        failed = self.attempt_blacklist.get(self.curr_v_node_id, set())
        
        #print(f"[MASK] VNode {self.curr_v_node_id} candidates BEFORE mask: {candidates}")
        candidates = [p for p in candidates if p not in revoked and p not in failed]
        
        #print(f' still available {len(candidates)}: {candidates}')
        return len(candidates) == 0 
    
    def step(self, action):
        """
        Joint Place and Route with action p_net node.

        All possible case
            Uncompleted Success: (Node place and Link route successfully)
            Completed Success: (Node Mapping & Link Mapping)
            Falilure: (Node place failed or Link route failed)
        """
        self.solution['num_interactions'] += 1
        p_node_id = int(action)
        self.solution.selected_actions.append(p_node_id)
 
       # Case: Reject
        if self.if_rejection(action): 
            self.attempt_blacklist.clear() 
            return self.reject(is_early=True)
        
        # Case: Revoke 
        if self.if_revocable(action):  
            last_v_node_id = self.placed_v_net_nodes[-1] if self.placed_v_net_nodes else None  

            if not self.placed_v_net_nodes:
                print(f"[WARN] Called step() but no placements made yet. Placevnetnodes:{self.placed_v_net_nodes},Action={action},selectedpnodes:{self.selected_p_net_nodes}")
                return self.reject(is_early=True)     
          
            self.attempt_blacklist[last_v_node_id].clear()
            self.retry_budget[last_v_node_id] = 0
            return self.revoke()
         
        # Case: Try to Place and Route
        assert p_node_id in list(self.p_net.nodes)
            
        place_and_route_result, place_and_route_info = self.controller.place_and_route(
                                                                            self.v_net, 
                                                                            self.p_net, 
                                                                            self.curr_v_node_id, 
                                                                            p_node_id,
                                                                            self.solution, 
                                                                            shortest_method=self.shortest_method, 
                                                                            k=self.k_shortest,
                                                                            check_feasibility=self.check_feasibility)
        # Step Failure
        if not place_and_route_result: 
            # Placement failed — retryable 
            self.attempt_blacklist[self.curr_v_node_id].add(p_node_id)
            reward = self.compute_reward(self.solution)  
            self.retry_budget[self.curr_v_node_id] += 1
            retry_used = self.retry_budget[self.curr_v_node_id]
            retry_cap = self.max_retry_budget[self.curr_v_node_id]
            done = self.check_last_chance()  
            #print(f"PLACE FAILED [CHECK LAST CHANCE] FAILED = {done}  ")
            self.solution['failed'] = done
            solution_info = self.counter.count_partial_solution(self.v_net, self.solution)
            return self.get_observation(), reward, done, self.get_info(solution_info) 
 
        # Placement and Route Success
        self.attempt_blacklist[self.curr_v_node_id].clear()
        self.solution['last_placement_failed'] = False
        self.retry_budget[self.curr_v_node_id] = 0
        self.max_retry_budget[self.curr_v_node_id] = 3  # Optional: reset to default, or keep if dynamic
  
        #finished placing and routing full SFC 
        if self.num_placed_v_net_nodes == self.v_net.num_nodes:
            self.solution['result'] = True  
            done = True
            solution_info = self.counter.count_solution(self.v_net, self.solution)
        # still more chains to place
        else: 
            done = False
            solution_info = self.counter.count_partial_solution(self.v_net, self.solution)
                     
        self._cached_candidates = None
        self._cached_candidates_vnode = None
        return self.get_observation(), self.compute_reward(self.solution), done, self.get_info(solution_info)
    

class SolutionStepInstanceRLEnv(InstanceRLEnv):
    
    def __init__(self, p_net, v_net, controller, recorder, counter, **kwargs):
        super(SolutionStepInstanceRLEnv, self).__init__(p_net, v_net, controller, recorder, counter, **kwargs)

    def step(self, solution):
        # Success
        if solution['result']:
            self.solution = solution
            self.solution['description'] = 'Success'
        # Failure
        else:
            solution = Solution(self.v_net)
        return self.get_observation(), self.compute_reward(), True, self.get_info(solution.to_dict())

    def get_observation(self):
        return {'v_net': self.v_net, 'p_net': self.p_net}

    def compute_reward(self):
        return 0



class PlaceStepInstanceRLEnv(InstanceRLEnv):

    def __init__(self, p_net, v_net, controller, recorder, counter, **kwargs):
        super(PlaceStepInstanceRLEnv, self).__init__(p_net, v_net, controller, recorder, counter, **kwargs)

    def step(self, action):
        """
        Two stage: Node Mapping and Link Mapping

        All possible case
            Early Rejection: (rejection_action)
            Uncompleted Success: (Node place)
            Completed Success: (Node Mapping & Link Mapping)
            Falilure: (not Node place, not Link mapping)
        """
        p_node_id = int(action)
        done = True
        # Case: Reject
        if self.if_rejection(action):
            return self.reject()
        # Case: Revoke
        if self.if_revocable(action) : 
            if( self.solution['revoke_times'] > 10):
                return self.reject(False)
            return self.revoke()
        # Case: Place in one same node
        elif not self.reusable and p_node_id in self.selected_p_net_nodes:
            self.solution['place_result'] = False
            solution_info = self.solution.to_dict()
        # Case: Try to Place
        else:
            assert p_node_id in list(self.p_net.nodes)
            # Stage 1: Node Mapping
            node_place_result, node_place_info = self.controller.place(self.v_net, self.p_net, self.curr_v_node_id, p_node_id, self.solution)
            # Case 1: Node Place Success / Uncompleted
            if node_place_result and self.num_placed_v_net_nodes < self.v_net.num_nodes:
                done = False
                solution_info = self.solution.to_dict()
                return self.get_observation(), self.compute_reward(self.solution), False, self.get_info(self.solution.to_dict())
            # Case 2: Node Place Failure
            if not node_place_result:
                self.solution['place_result'] = False
                solution_info = self.counter.count_solution(self.v_net, self.solution)
                # solution_info = self.solution.to_dict()
            # Stage 2: Link Mapping
            # Case 3: Try Link Mapping
            if node_place_result and self.num_placed_v_net_nodes == self.v_net.num_nodes:
                link_mapping_result = self.controller.link_mapping(self.v_net, 
                                                                    self.p_net, 
                                                                    solution=self.solution, 
                                                                    sorted_v_links=list(self.v_net.links), 
                                                                    shortest_method=self.shortest_method, 
                                                                    k=self.k_shortest, 
                                                                    inplace=True,
                                                                    check_feasibility=self.check_feasibility)
                # Link Mapping Failure
                if not link_mapping_result:
                    self.solution['route_result'] = False
                    solution_info = self.counter.count_solution(self.v_net, self.solution)
                    # solution_info = self.solution.to_dict()
                # Success
                else:
                    self.solution['result'] = True
                    solution_info = self.counter.count_solution(self.v_net, self.solution)
        if done:
            pass
        return self.get_observation(), self.compute_reward(solution_info), done, self.get_info(solution_info)

    def compute_reward(self, solution):
        """Calculate deserved reward according to the result of taking action."""
        reward_weight = 0.1
        if solution['result'] :
            # node_load_balance = self.get_node_load_balance(self.selected_p_net_nodes[-1])
            reward = solution['v_net_r2c_ratio']
        elif solution['place_result'] and solution['route_result']:
            # curr_place_progress = self.get_curr_place_progress()
            # node_load_balance = self.get_node_load_balance(self.selected_p_net_nodes[-1])
            # reward = curr_place_progress * (solution['v_net_r2c_ratio']) #  - 0.01 * node_load_balance
            # reward = curr_place_progress * ((solution['v_net_r2c_ratio']) + 0.01 * node_load_balance)
            # weight = (1 + len(self.v_net.adj[curr_v_node_id - 1])) / (self.v_net.num_nodes + self.v_net.num_links)
            # reward = 0.01
            # weight = (1 + len(self.v_net.adj[curr_v_node_id - 1])) / 10
            # reward = weight * solution['v_net_r2c_ratio']
            # + 0.01 * node_load_balance
            reward = 0.
        else:
            curr_place_progress = self.get_curr_place_progress()
            # reward = - self.get_curr_place_progress()
            # weight = (1 + len(self.v_net.adj[curr_v_node_id - 1])) / (self.v_net.num_nodes + self.v_net.num_links)
            # weight = (1 + len(self.v_net.adj[curr_v_node_id])) / 10
            reward = - curr_place_progress
            # reward = - 0.1
            # reward = -1. * weight
        # reward = solution['v_net_r2c_ratio'] if solution['result'] else 0
        # reward = self.v_net.num_nodes / 10 * reward
        # reward = self.v_net.total_resource_demand / 500 * reward
        self.solution['v_net_reward'] += reward
        return reward


class NodePairStepInstanceRLEnv(JointPRStepInstanceRLEnv):
    
    def __init__(self, p_net, v_net, controller, recorder, counter, **kwargs):
        super(JointPRStepInstanceRLEnv, self).__init__(p_net, v_net, controller, recorder, counter, **kwargs)
        self._curr_v_node_id = 0
        self.candidates_dict = self.controller.construct_candidates_dict(self.v_net, self.p_net)

    @property
    def curr_v_node_id(self):
        return self._curr_v_node_id

    def generate_action_mask(self):
        mask = np.zeros([self.v_net.num_nodes, self.p_net.num_nodes])
        for v_node_id, p_candicates in self.candidates_dict.items():
            mask[v_node_id][p_candicates] = 1
        # Each virtual node only can be changed once
        for v_node_id, p_id in self.solution['node_slots'].items():
            mask[:, p_id] = 0
            mask[v_node_id, :] = 0
        if mask.sum() == 0:
            mask[0][0] = 1
        mask = mask.T
        return mask.flatten()

    def step(self, action):
        """
        Joint Place and Route with action p_net node.

        All possible case
            Uncompleted Success: (Node place and Link route successfully)
            Completed Success: (Node Mapping & Link Mapping)
            Falilure: (Node place failed or Link route failed)
        """
        # The action is sampled from a heatmap with the shape of [p_net.num_nodes, v_net.num_nodes]
        p_node_id = action // self.v_net.num_nodes
        v_node_id = action % self.v_net.num_nodes

        self._curr_v_node_id = v_node_id
        # print(f'action ({action}) - v_node_id: {v_node_id}, p_node_id: {p_node_id}')
        if v_node_id in self.solution['node_slots']:
            print(f'v_node_id {v_node_id} has been placed') if v_node_id != 0 else None
            self.solution['place_result'] = False
            solution_info = self.counter.count_solution(self.v_net, self.solution)
            done = True
            return self.get_observation(), self.compute_reward(self.solution), done, self.get_info(solution_info)
        return super().step(p_node_id)


class NodeSlotsStepInstanceRLEnv(InstanceRLEnv):
    
    def __init__(self, p_net, v_net, controller, recorder, counter, **kwargs):
        super(NodeSlotsStepInstanceRLEnv, self).__init__(p_net, v_net, controller, recorder, counter, **kwargs)

    def step(self, node_slots):
        if len(node_slots) == self.v_net.num_nodes:
            self.controller.deploy_with_node_slots(
                self.v_net, self.p_net, 
                node_slots, self.solution, 
                inplace=True, 
                shortest_method=self.shortest_method, 
                k_shortest=self.k_shortest,
                check_feasibility=self.check_feasibility
            )
            self.counter.count_solution(self.v_net, self.solution)
            # Success
            if self.solution['result']:
                self.solution['description'] = 'Success'
        return self.get_observation(), self.compute_reward(self.solution), True, self.get_info(self.solution.to_dict())
