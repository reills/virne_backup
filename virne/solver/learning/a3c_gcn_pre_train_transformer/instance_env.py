# ==============================================================================
# instance_env.py
# ==============================================================================


import numpy as np
import networkx as nx
from gym import spaces
from virne.solver.learning.rl_base import JointPRStepInstanceRLEnv, PlaceStepInstanceRLEnv


class InstanceEnv(JointPRStepInstanceRLEnv):

    def __init__(self, p_net, v_net, controller, recorder, counter, **kwargs):
        super(InstanceEnv, self).__init__(p_net, v_net, controller, recorder, counter, **kwargs)
        num_p_net_node_attrs = len(self.p_net.get_node_attrs(['resource', 'extrema']))
        num_p_net_link_attrs = len(self.p_net.get_link_attrs(['resource', 'extrema']))
        num_p_net_features = num_p_net_node_attrs + 1
        # self.observation_space = spaces.Dict({
        #     'p_net_x': spaces.Box(low=0, high=1, shape=(self.p_net.num_nodes, num_p_net_features), dtype=np.float32),
        #     'p_net_edge_index': spaces.Box(low=0, high=self.p_net.num_nodes, shape=(2, self.p_net.num_links), dtype=np.int32),
        #     'p_net_edge_attr': spaces.Box(low=0, high=self.p_net.num_nodes, shape=(self.p_net.num_links, 2), dtype=np.int32),
        #     'v_node': spaces.Box(low=0, high=100, shape=(int(num_p_net_node_attrs/2) + int(num_p_net_link_attrs/2) + 2, ), dtype=np.float32)
        # }) 


    def compute_reward(self, solution):
        """Calculate deserved reward according to the result of taking action."""
        #finished placing entire vnet
        if solution['result'] :
            reward = solution['v_net_r2c_ratio']
        #partial placement
        elif solution['place_result'] and solution['route_result']:
            reward = 1 / self.v_net.num_nodes
        #failure
        else:
            reward = - 1 / self.v_net.num_nodes
        self.solution['v_net_reward'] += reward   
        
        return reward  # Return the reward *for this step*

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
        Build v_net_x with four components:
        1. Resource features from the virtual network (using obs_handler)
        2. Virtual node degrees (computed using obs_handler)
        3. Virtual total capacity (sum of resource features)
        4. Total required bandwidth (sum of bandwidth demands from connected edges)
        5. Betweenness centrality
        6. Bandwidth variance
        """
        if self.curr_v_node_id >= self.v_net.num_nodes:
            return {'x': np.empty((0, 4), dtype=np.float32)}
        
        # Resource features
        resource_features = self.obs_handler.get_node_attrs_obs(
            self.v_net, 
            node_attr_types=['resource'], 
            node_attr_benchmarks=self.node_attr_benchmarks
        )
        
        # Virtual node degrees
        degrees = self.obs_handler.get_node_degree_obs(
            self.v_net, 
            self.obs_handler.get_degree_benchmark(self.v_net)
        )
        
        # Total capacity
        total_capacity = np.sum(resource_features, axis=1, keepdims=True)
        
        # Total required bandwidth (sum of 'bw' demands from connected edges)
        # Get edge demands similar to load_vnet_demands
        edge_demands = {
            tuple(sorted([str(u), str(v)])): float(data.get('bw', 0.0))
            for u, v, data in self.v_net.edges(data=True)
        }
        v_nodes = list(self.v_net.nodes())
        v_bw_agg = np.array([
            sum(edge_demands.get(tuple(sorted([str(v), str(adj)])), 0.0) 
                for adj in self.v_net.adj[v])
            for v in v_nodes
        ]).reshape(-1, 1)
        
        # Betweenness centrality
        bc_dict = nx.betweenness_centrality(self.v_net)
        bc = np.array([bc_dict[node] for node in range(self.v_net.num_nodes)], 
                    dtype=np.float32).reshape(-1, 1)

        # Bandwidth variance
        bw_var = []
        for node in range(self.v_net.num_nodes):
            demands = [self.v_net.links[(node, neighbor)]['bw'] 
                    for neighbor in self.v_net.adj[node]]
            bw_var.append(np.var(demands) if demands else 0.0)
        bw_var = np.array(bw_var, dtype=np.float32).reshape(-1, 1)

        # Concatenate features: all should be 2D arrays now
        v_net_x = np.hstack([resource_features, degrees, total_capacity, v_bw_agg, bc, bw_var])

        # Get virtual network edge index
        v_net_edge_index = self.obs_handler.get_link_index_obs(self.v_net)

        return {'x': v_net_x, 'edge_index': v_net_edge_index}

    def _get_p_net_obs(self):
        """
        Build p_net_x with four components:
        1. Resource features from the physical network (using obs_handler)
        2. Physical node degrees (computed using obs_handler)
        3. Physical total available capacity (sum of resource features)
        4. Aggregated available bandwidth (sum of available bandwidth from connected edges)
        5. Betweenness centrality.
        6. Neighbor bandwidth average.
        """
        # Resource features
        resource_features = self.obs_handler.get_node_attrs_obs(
            self.p_net, 
            node_attr_types=['resource'], 
            node_attr_benchmarks=self.node_attr_benchmarks
        )
        
        # Physical node degrees
        p_degrees = self.obs_handler.get_node_degree_obs(
            self.p_net, 
            self.obs_handler.get_degree_benchmark(self.p_net)
        )
        
        # Total available capacity
        p_total_capacity = np.sum(resource_features, axis=1, keepdims=True)
        
        # Aggregated available bandwidth (sum of 'bw' from connected edges)
        p_bw_agg = self.obs_handler.get_link_aggr_attrs_obs(
            self.p_net, 
            link_attr_types=['resource'], 
            aggr='sum', 
            link_sum_attr_benchmarks=self.obs_handler.get_link_sum_attr_benchmarks(self.p_net)
        )
        
        # 5. Betweenness centrality for physical network
        bc_dict = nx.betweenness_centrality(self.p_net)
        bc = np.array([bc_dict[node] for node in range(self.p_net.num_nodes)], dtype=np.float32).reshape((-1, 1))

        # 6. Neighbor bandwidth average: for each node, average the 'bw' over its neighboring edges
        neighbor_bw_avg = []
        for node in range(self.p_net.num_nodes):
            neighbors = list(self.p_net.adj[node])
            if neighbors:
                bw_values = []
                for nb in neighbors:
                    # Assumes each edge has a 'bw' attribute
                    bw_values.append(self.p_net.links[(node, nb)]['bw'])
                neighbor_bw_avg.append(np.mean(bw_values))
            else:
                neighbor_bw_avg.append(0.0)
        neighbor_bw_avg = np.array(neighbor_bw_avg, dtype=np.float32).reshape((-1, 1))

        # Concatenate features: resulting shape is (num_nodes, 6)
        p_net_x_local = np.hstack([resource_features, p_degrees, p_total_capacity, p_bw_agg, bc, neighbor_bw_avg])

        # Edge index for the physical network
        edge_index = self.obs_handler.get_link_index_obs(self.p_net)

        # Compute edge attributes; here we use the obs_handler function to get (normalized) link attributes.
        edge_attr = self.obs_handler.get_link_attrs_obs(
            self.p_net,
            link_attr_types=['resource'],
            link_attr_benchmarks=self.obs_handler.get_link_attr_benchmarks(self.p_net)
        )

        return {'x': p_net_x_local, 'edge_index': edge_index, 'edge_attr': edge_attr}


    def get_history_actions(self):
        """
        Return the sequence of previously placed physical node IDs as int64 array.
        This is used by the transformer decoder.
        """
        return np.array(self.selected_p_net_nodes, dtype=np.int64)


#OLD WAY IGNORE
#  def _get_p_net_obs(self):
#         """
#         node_resource, average_distance, p_net_degreees, p_net_nodes_states, v_node_features
#         """
#         # node data
#         node_data = self.obs_handler.get_node_attrs_obs(self.p_net, node_attr_types=['resource', 'extrema'], node_attr_benchmarks=self.node_attr_benchmarks)
#         edge_aggr_data = self.obs_handler.get_link_aggr_attrs_obs(self.p_net, link_attr_types=['resource', 'extrema'], aggr='sum', link_sum_attr_benchmarks=self.link_sum_attr_benchmarks)
#         selected_nodes = np.zeros(self.p_net.num_nodes, dtype=np.float32)
#         selected_nodes[self.selected_p_net_nodes] = 1.
#         node_data = np.concatenate((node_data, edge_aggr_data, np.expand_dims(selected_nodes, axis=-1)), axis=-1)
#         # edge_index
#         edge_index = self.obs_handler.get_link_index_obs(self.p_net)
#         # data
#         p_net_obs = {
#             'x': node_data,
#             'edge_index': edge_index,
#         }
#         return p_net_obs

#     def _get_v_net_obs(self):
#         if self.curr_v_node_id  >= self.v_net.num_nodes:
#             return []
#         node_data = self.obs_handler.get_node_attrs_obs(self.v_net, node_attr_types=['resource'], node_attr_benchmarks=self.node_attr_benchmarks)
#         edge_aggr_data = self.obs_handler.get_link_aggr_attrs_obs(self.v_net, link_attr_types=['resource'], aggr='sum', link_sum_attr_benchmarks=self.link_sum_attr_benchmarks)
#         node_data = np.concatenate((node_data, edge_aggr_data), axis=-1)
#         return {'x': node_data}


# sample observation from dataset for pretraining IGNORE

# dataset = torch.load(dataset_path)
# {'p_net_x': tensor([[0.6600, 0.3333, 0.3300],
#         [0.5500, 0.5238, 0.2750],
#         [0.6100, 0.5714, 0.3050],
#         [0.3700, 0.4762, 0.1850],
#         [0.7700, 0.5714, 0.3850],
#         [0.6600, 0.1905, 0.3300],
#         [0.8800, 0.3333, 0.4400],
#         [0.6300, 0.4286, 0.3150],
#         [0.5700, 0.2381, 0.2850],
#         [0.7900, 0.5238, 0.3950],
#         [0.1100, 0.7143, 0.0550],
#         [0.3300, 0.5238, 0.1650],
#         [0.6200, 0.2857, 0.3100],
#         [0.5200, 0.6190, 0.2600],
#         [0.8100, 0.3810, 0.4050],
#         [0.3300, 0.4286, 0.1650],
#         [0.5300, 0.8095, 0.2650],
#         [0.9400, 0.3333, 0.4700],
#         [0.6700, 0.7619, 0.3350],
#         [0.9600, 0.4286, 0.4800],
#         [0.8500, 0.3810, 0.4250],
#         [0.6500, 0.5238, 0.3250],
#         [0.8100, 0.3333, 0.4050],
#         [0.8700, 0.6190, 0.4350],
#         [0.4800, 1.0000, 0.2400],
#         [0.0900, 0.7619, 0.0450],
#         [0.7000, 0.4762, 0.3500],
#         [0.6300, 0.6190, 0.3150],
#         [0.5100, 0.4762, 0.2550],
#         [0.4900, 0.5714, 0.2450],
#         [0.6000, 0.4286, 0.3000],
#         [0.5100, 0.4762, 0.2550],
#         [0.7200, 0.6190, 0.3600],
#         [0.5400, 0.4762, 0.2700],
#         [0.6900, 0.6667, 0.3450],
#         [0.0900, 0.9048, 0.0450],
#         [0.5600, 0.3810, 0.2800],
#         [0.9000, 0.3810, 0.4500],
#         [0.4600, 0.5238, 0.2300],
#         [0.9100, 0.3333, 0.4550],
#         [0.6000, 0.5238, 0.3000],
#         [0.3700, 0.5714, 0.1850],
#         [0.5300, 0.4286, 0.2650],
#         [0.3400, 0.5714, 0.1700],
#         [0.7900, 0.6190, 0.3950],
#         [0.3600, 0.7143, 0.1800],
#         [0.4000, 0.3333, 0.2000],
#         [0.5900, 0.6190, 0.2950],
#         [0.6300, 0.4286, 0.3150],
#         [0.5900, 0.5238, 0.2950],
#         [0.6500, 0.2857, 0.3250],
#         [0.9100, 0.5238, 0.4550],
#         [0.5000, 0.6190, 0.2500],
#         [0.9500, 0.4286, 0.4750],
#         [0.5400, 0.8095, 0.2700],
#         [0.3300, 0.7619, 0.1650],
#         [0.6500, 0.2381, 0.3250],
#         [0.6200, 0.7619, 0.3100],
#         [0.6400, 0.4762, 0.3200],
#         [0.7500, 0.2857, 0.3750],
#         [0.9300, 0.6667, 0.4650],
#         [0.6300, 0.3333, 0.3150],
#         [0.9100, 0.4286, 0.4550],
#         [0.3700, 0.6667, 0.1850],
#         [0.6800, 0.7143, 0.3400],
#         [0.8200, 0.5714, 0.4100],
#         [0.6600, 0.4762, 0.3300],
#         [0.8500, 0.4286, 0.4250],
#         [0.2300, 0.5238, 0.1150],
#         [0.9000, 0.6190, 0.4500],
#         [0.5400, 0.7619, 0.2700],
#         [0.1700, 0.5238, 0.0850],
#         [1.0000, 0.2857, 0.5000],
#         [0.4000, 0.4286, 0.2000],
#         [0.8000, 0.4762, 0.4000],
#         [0.1200, 0.7143, 0.0600],
#         [0.5600, 0.5238, 0.2800],
#         [0.5400, 0.3810, 0.2700],
#         [0.7000, 0.5714, 0.3500],
#         [0.0400, 0.7619, 0.0200],
#         [0.1700, 0.7619, 0.0850],
#         [0.8000, 0.4762, 0.4000],
#         [0.0100, 0.5714, 0.0050],
#         [0.6300, 0.3333, 0.3150],
#         [0.6400, 0.1905, 0.3200],
#         [0.7200, 0.6190, 0.3600],
#         [0.8300, 0.4286, 0.4150],
#         [0.5300, 0.1905, 0.2650],
#         [0.6500, 0.6667, 0.3250],
#         [0.9800, 0.5714, 0.4900],
#         [0.3500, 0.5714, 0.1750],
#         [0.7400, 0.5714, 0.3700],
#         [0.7500, 0.2381, 0.3750],
#         [0.5100, 0.7143, 0.2550],
#         [0.6300, 0.3333, 0.3150],
#         [0.6900, 0.3333, 0.3450],
#         [0.2000, 0.7143, 0.1000],
#         [0.6300, 0.5714, 0.3150],
#         [0.5900, 0.1905, 0.2950],
#         [0.9000, 0.7619, 0.4500]]), 'p_net_edge_index': tensor([[ 0,  0,  0,  ..., 93, 93, 93],
#         [11, 41, 43,  ..., 95, 97, 99]]), 'v_net_x': tensor([[0.1500, 0.1429, 0.0750],
#         [0.3700, 0.1429, 0.1850],
#         [0.4500, 0.0952, 0.2250],
#         [0.0400, 0.1429, 0.0200],
#         [0.3500, 0.0952, 0.1750],
#         [0.1900, 0.1429, 0.0950],
#         [0.1900, 0.1429, 0.0950],
#         [0.2300, 0.1429, 0.1150]]), 'history_actions': tensor([100,  13,  96,  73,  25,  36,  75,  41,  35,  75,  71,  56,  15,   4,
#          55,   6,  80,  54,  46,  82,  31,  90,  25,  27,  44,  24,  35,  63,
#          45,  26,  13,  96,  29,  79,  94,  81,  38,  63,  70,  11,  68,  71,
#           3,  10,  42,  43,  33,  12,  25,  33]), 'action_mask': tensor([1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 0., 1., 1., 1., 1., 1., 1., 1.,
#         1., 1., 1., 1., 1., 1., 1., 0., 1., 1., 1., 1., 1., 1., 1., 1., 1., 0.,
#         1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1.,
#         1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1.,
#         1., 1., 1., 0., 1., 1., 1., 0., 1., 1., 0., 1., 1., 1., 1., 1., 1., 1.,
#         1., 1., 1., 1., 1., 1., 1., 1., 1., 1.]), 'action': tensor(33)}