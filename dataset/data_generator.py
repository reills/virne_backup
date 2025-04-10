import os
import sys
import ast 
import torch
import numpy as np
import pandas as pd
import networkx as nx
from datetime import datetime
from collections import defaultdict
from torch_geometric.data import Data
from typing import Dict, Tuple, List, Any, Optional

class DataGenerator:
    def __init__(self, base_dir: str, folder_number: str, output_folder: str = None) -> None:
        self.base_dir = base_dir
        self.folder_number = folder_number
        self.v_net_id_col = "v_net_id"
        self.description_col = "description"
        self.arrival_col = "v_net_arrival_time"
        self.lifetime_col = "v_net_lifetime"
        self.event_time_col = "event_time"
        self.node_slots_col = "node_slots"
        self.link_paths_col = "link_paths"
        self.result_col = "result"
        self.root = os.path.join(base_dir, f"results-{folder_number}")
        self.v_folder = os.path.join(self.root, "v_nets")
        self.p_path = os.path.join(self.root, "p_net.gml")
        print(f"Looking for physical network file at: {self.p_path}")
        self.output_folder = output_folder if output_folder else os.path.join(base_dir, "training-data")
        os.makedirs(self.output_folder, exist_ok=True)
        self.samples: List[Dict[str, Any]] = []
        self.initialize()

  
    def initialize(self) -> None:
        # Load CSV file.
        csv_files = [f for f in os.listdir(self.root) if f.endswith(".csv")]
        if not csv_files:
            raise FileNotFoundError(f"No CSV files found in {self.root}")
        self.csv_filename = os.path.join(self.root, csv_files[0])
        print(f"Generating dataset from: {self.csv_filename}")

        # Load physical network.
        self.physical_graph = nx.read_gml(self.p_path)
        self.physical_graph = nx.relabel_nodes(self.physical_graph, lambda x: str(x))
        self.total_node_resources = {
            n: {k: float(v) for k, v in data.items() 
                if k.lower() not in ['id', 'label', 'pos'] and 'max' not in k.lower()}
            for n, data in self.physical_graph.nodes(data=True)
        }
        self.resource_keys = sorted(next(iter(self.total_node_resources.values())).keys())
        self.max_node_resources = {
            r: max(self.total_node_resources[n][r] for n in self.total_node_resources)
            for r in self.resource_keys
        }
        self.total_edge_bandwidth = {
            tuple(sorted([str(u), str(v)])): float(data.get('bw', 0.0))
            for u, v, data in self.physical_graph.edges(data=True)
        }
        self.max_bandwidth = max(self.total_edge_bandwidth.values()) if self.total_edge_bandwidth else 1.0

        # Create list of edges and physical node indices.
        self.edge_list = list(self.total_edge_bandwidth.keys())
        self.p_nodes = sorted(self.physical_graph.nodes(), key=lambda x: int(x))
        self.num_p_nodes = len(self.p_nodes)
        self.p_node_to_idx = {node: idx for idx, node in enumerate(self.p_nodes)}
        self.p_net_edge_index = np.array([
            [self.p_node_to_idx[u], self.p_node_to_idx[v]] 
            for u, v in self.edge_list
        ]).T if self.edge_list else np.zeros((2, 0), dtype=int)

        # Precompute mapping from edge to its index.
        self.edge_to_idx = {edge: i for i, edge in enumerate(self.edge_list)}

        # Load CSV data.
        self.df = pd.read_csv(self.csv_filename, dtype=str )
        self.df[self.node_slots_col] = self.df[self.node_slots_col].str.replace(
            r'np\.int64\((\d+)\)', r'\1', regex=True)
        self.df[self.link_paths_col] = self.df[self.link_paths_col].str.replace(
            r'np\.int64\((\d+)\)', r'\1', regex=True)

        # History and counters.
        self.start_token = self.num_p_nodes
        self.global_history = [self.num_p_nodes]
        self.invalid_count = 0
        self.zero_valid_count = 0
        self.total_steps = 0
        self.total_actions = 0
        self.action_mask_percentages: List[float] = []
        self.valid_action_percentage = 0.0
        self.window_size = 100

        # Feature dimensions.
        self.p_net_feature_dim = len(self.resource_keys) + 9
        self.v_net_feature_dim = len(self.resource_keys) + 5

        # Pre-calculate maximum degree and capacity.
        all_degrees = [deg for _, deg in self.physical_graph.degree()]
        self.max_degree = max(all_degrees)
        all_capacities = [
            sum(float(v) for k, v in data.items() if k.lower() not in ['id', 'label', 'pos'])
            for _, data in self.physical_graph.nodes(data=True)
        ]
        self.max_capacity = max(all_capacities)
        self.p_degrees = np.array([self.physical_graph.degree(p) for p in self.p_nodes]).reshape(-1, 1)
        self.betweenness_dict = nx.betweenness_centrality(self.physical_graph)
        self.max_betweenness = max(self.betweenness_dict.values()) or 1.0
        self.max_neighbor_bw = max([
            np.mean([self.total_edge_bandwidth.get(tuple(sorted([p, adj])), 0.0) 
                     for adj in self.physical_graph.adj[p]])
            for p in self.p_nodes
        ]) or 1.0

    def get_vnet_gml_path(self, v_net_id: int) -> str:
        return os.path.join(self.v_folder, f"v_net-{v_net_id:05d}.gml")

    def parse_graph_data(self, node_slots_str: str, link_paths_str: str) -> Tuple[Dict[str, str], Dict]:
        node_slots = ast.literal_eval(node_slots_str) if node_slots_str else {}
        link_paths = ast.literal_eval(link_paths_str) if link_paths_str else {}
        node_slots = {str(vn): str(pn) for vn, pn in node_slots.items()}
        fixed_link_paths = {}
        for (vsrc, vdst), ppath in link_paths.items():
            fixed_link_paths[(str(vsrc), str(vdst))] = [str(x) for x in ppath]
        return node_slots, fixed_link_paths

    def load_vnet_demands(self, v_net_id: int) -> Tuple[Dict[str, float], Dict[Tuple[str, str], float]]:
        path = self.get_vnet_gml_path(v_net_id)
        v_net = nx.read_gml(path)
        node_demands = {
            str(n): {k: float(v) for k, v in data.items() 
                     if k.lower() not in ['id', 'label', 'pos']}
            for n, data in v_net.nodes(data=True)
        }
        edge_demands = {
            tuple(sorted([str(u), str(v)])): float(data.get('bw', 0.0))
            for u, v, data in v_net.edges(data=True)
        }
        return node_demands, edge_demands

    def compute_active_vnets_upto(self, index: int) -> List[Dict]:
        active_vnets = []
        for i in range(index + 1):
            row = self.df.iloc[i]
            event_t = float(row[self.event_time_col])
            # Mark expired VNets.
            for v in active_vnets:
                if event_t >= (v['arrival_time'] + v['lifetime']):
                    v['expired'] = True
            if row[self.description_col].strip() == 'Success' and str(row[self.result_col]) == "True":
                v_net_id = int(row[self.v_net_id_col])
                n_slots, l_paths = self.parse_graph_data(row[self.node_slots_col], row[self.link_paths_col])
                active_vnets.append({
                    'v_net_id': v_net_id,
                    'arrival_time': float(row[self.arrival_col]),
                    'lifetime': float(row[self.lifetime_col]),
                    'node_slots': n_slots,
                    'link_paths': l_paths,
                    'expired': False
                })
            elif row[self.description_col].strip() == 'Leave Event':
                v_net_id = int(row[self.v_net_id_col])
                for v in active_vnets:
                    if v['v_net_id'] == v_net_id:
                        v['expired'] = True
        return active_vnets

    def accumulate_resources(self, active_vnets: List[Dict]) -> Tuple[Dict, Dict]:
        used_node_resources = defaultdict(lambda: defaultdict(float))
        used_edge_bandwidth = defaultdict(float)
        for vnet in active_vnets:
            if vnet.get('expired'):
                continue
            v_net_id = vnet['v_net_id']
            node_slots = vnet['node_slots']
            link_paths = vnet['link_paths']
            node_demands, edge_demands = self.load_vnet_demands(v_net_id)
            for v_node, p_node in node_slots.items():
                for r, val in node_demands.get(v_node, {}).items():
                    used_node_resources[p_node][r] += float(val)
            for (vsrc, vdst), path in link_paths.items():
                bw = edge_demands.get(tuple(sorted([vsrc, vdst])), 0.0)
                norm_path = self.flatten_link_path(path)
                for i in range(len(norm_path) - 1):
                    edge = tuple(sorted([norm_path[i], norm_path[i+1]]))
                    used_edge_bandwidth[edge] += bw
        return used_node_resources, used_edge_bandwidth

    @staticmethod
    def flatten_link_path(provided_path: List[Any]) -> List[str]:
        nodes = []
        for item in provided_path:
            s = str(item).strip()
            if (s.startswith("'") and s.endswith("'")) or (s.startswith('"') and s.endswith('"')):
                s = s[1:-1]
            if s.startswith("(") and s.endswith(")"):
                s = s[1:-1]
            parts = [p.strip() for p in s.split(',')]
            try:
                nums = [int(p) for p in parts]
            except ValueError as e:
                print(f"Error converting item to integers: {item}, {e}")
                return []
            if not nodes:
                nodes.extend([nums[0], nums[1]])
            else:
                nodes.append(nums[1])
        return [str(n) for n in nodes]
    
    def _get_provided_path(self, prev_v_node: str, curr_v_node: str, link_paths: Dict) -> Optional[List]:
        """Retrieve and flatten the provided path for a virtual edge between two nodes."""
        key = (str(prev_v_node), str(curr_v_node))
        rev_key = (str(curr_v_node), str(prev_v_node))
        raw_path = link_paths.get(key) or list(reversed(link_paths.get(rev_key, [])))
        return self.flatten_link_path(raw_path) if raw_path else None


    def check_path_availability(self, src_p_node: str, dst_p_node: str, required_bw: float, 
                                used_edge_bandwidth: Dict) -> Tuple[bool, List[str]]:
        debug_info = []
        try:
            feasible_edges = [
                (u, v) for (u, v), cap in self.total_edge_bandwidth.items()
                if (cap - used_edge_bandwidth.get((u, v), 0.0)) >= required_bw
            ]
            debug_info.append(f"DEBUG: Checking path from {src_p_node} to {dst_p_node} with required_bw={required_bw}")
            subgraph = self.physical_graph.edge_subgraph(feasible_edges)
            path = nx.shortest_path(subgraph, source=src_p_node, target=dst_p_node)
            debug_info.append(f"DEBUG: Found path: {path}")
            return True, debug_info
        except (nx.NetworkXNoPath, nx.NodeNotFound) as e:
            debug_info.append(f"DEBUG: Failed to find path from {src_p_node} to {dst_p_node}: {e}")
            return False, debug_info

    def update_node_bandwidth(self, node: str, used_bw: Dict, p_net_x: np.ndarray) -> None:
        node_idx = self.p_node_to_idx[node]
        bw_values = [
            self.total_edge_bandwidth.get(tuple(sorted([node, adj])), 0.0) - used_bw.get(tuple(sorted([node, adj])), 0.0)
            for adj in self.physical_graph.adj[node]
        ]
        aggregated = sum(bw_values)
        mean_bw = np.mean(bw_values) if bw_values else 0.0
        # Update aggregated bandwidth and neighbor average (columns -3 and -1 respectively).
        p_net_x[node_idx, -3] = aggregated
        p_net_x[node_idx, -1] = mean_bw
        
    
    def build_v_net_features(self, v_net_id: int, node_slots: Dict[str, str]) -> Tuple[np.ndarray, Dict, np.ndarray]:
        node_demands, edge_demands = self.load_vnet_demands(v_net_id)
        v_nodes = list(node_slots.keys())
        v_net_graph = nx.read_gml(self.get_vnet_gml_path(v_net_id))

        if v_nodes:
            v_resource_features = np.array([
                [node_demands[v].get(r, 0.0) for r in self.resource_keys] for v in v_nodes
            ])
            #v_degrees = np.array([v_net_graph.degree(v) for v in v_nodes]).reshape(-1, 1)
            v_total_capacity = np.array([sum(node_demands[v].values()) for v in v_nodes]).reshape(-1, 1)
            v_total_bw = np.array([
                sum(edge_demands.get(tuple(sorted([v, adj])), 0.0) for adj in v_net_graph.adj[v])
                for v in v_nodes
            ]).reshape(-1, 1)
            #v_betweenness = np.array([nx.betweenness_centrality(v_net_graph)[v] for v in v_nodes]).reshape(-1, 1)
            v_bw_variance = np.array([
                np.std([edge_demands.get(tuple(sorted([v, adj])), 0.0) for adj in v_net_graph.adj[v]])
                for v in v_nodes
            ]).reshape(-1, 1)
        else:
            num_resources = len(self.resource_keys)
            v_resource_features = np.empty((0, num_resources))
            #v_degrees = np.empty((0, 1))
            v_total_capacity = np.empty((0, 1))
            v_total_bw = np.empty((0, 1))
            #v_betweenness = np.empty((0, 1))
            v_bw_variance = np.empty((0, 1))

        #v_net_x = np.hstack([v_resource_features, v_degrees, v_total_capacity, v_total_bw, v_betweenness, v_bw_variance])
        v_net_x = np.hstack([v_resource_features, v_total_capacity, v_total_bw, v_bw_variance])

        v_node_to_idx = {v: i for i, v in enumerate(v_nodes)}
        v_net_edge_index = np.array([
            [v_node_to_idx[u], v_node_to_idx[v]] 
            for u, v in v_net_graph.edges() 
            if u in v_node_to_idx and v in v_node_to_idx
        ]).T if v_net_graph.edges() else np.zeros((2, 0), dtype=int)
        
        total_v_nodes = len(v_nodes)
        return v_net_x, {"v_nodes": v_nodes, "node_demands": node_demands, "edge_demands": edge_demands}, v_net_edge_index, total_v_nodes

    def build_initial_p_net_features(self, used_node: Dict, used_bw: Dict) -> Tuple[np.ndarray, np.ndarray]:
        """
        Builds initial physical network features with dynamic congestion enhancements.
        
        Args:
            used_node (Dict): Dictionary of used resources per physical node.
            used_bw (Dict): Dictionary of used bandwidth per physical link.
        
        Returns:
            Tuple[np.ndarray, np.ndarray]: Physical network feature matrix (p_net_x) and edge attributes (edge_attr).
        """
        # Compute available resources and original features
        avail_resources = {
            p: {r: self.total_node_resources[p][r] - used_node[p].get(r, 0.0) for r in self.resource_keys}
            for p in self.p_nodes
        }
        p_resource_features = np.array([
            [avail_resources[p][r] for r in self.resource_keys] for p in self.p_nodes
        ])
        p_total_capacity = np.array([sum(avail_resources[p].values()) for p in self.p_nodes]).reshape(-1, 1)
        avail_bw = {edge: self.total_edge_bandwidth[edge] - used_bw.get(edge, 0.0) for edge in self.total_edge_bandwidth}
        p_aggregated_bw = np.array([
            sum(avail_bw.get(tuple(sorted([p, adj])), 0.0) for adj in self.physical_graph.adj[p])
            for p in self.p_nodes
        ]).reshape(-1, 1)
        p_betweenness = np.array([self.betweenness_dict[p] for p in self.p_nodes]).reshape(-1, 1)
        p_neighbor_bw = np.array([
            np.mean([avail_bw.get(tuple(sorted([p, adj])), 0.0) for adj in self.physical_graph.adj[p]]) 
            for p in self.p_nodes
        ]).reshape(-1, 1)

        # New Feature 1: Node Utilization (average % of resources used)
        node_utilization = np.array([
            np.mean([
                (used_node[p].get(r, 0.0) / self.total_node_resources[p][r]) * 100
                if self.total_node_resources[p][r] > 0 else 0.0
                for r in self.resource_keys
            ])
            for p in self.p_nodes
        ]).reshape(-1, 1)

        # Compute link utilization for all edges
        link_utilization = {}
        for edge in self.edge_list:
            total_bw = self.total_edge_bandwidth[edge]
            used = used_bw.get(edge, 0.0)
            util = (used / total_bw) * 100 if total_bw > 0 else 0.0
            link_utilization[edge] = util

        # New Feature 2: Average Link Utilization per node (based on adjacent links)
        p_avg_link_util = np.array([
            np.mean([link_utilization.get(tuple(sorted([p, adj])), 0.0) for adj in self.physical_graph.adj[p]])
            for p in self.p_nodes
        ]).reshape(-1, 1)

        # New Feature 3: Link Variance (global std dev of link utilizations)
        all_link_utils = list(link_utilization.values())
        link_variance = np.std(all_link_utils) if all_link_utils else 0.0
        link_variance_feature = np.full((len(self.p_nodes), 1), link_variance)

        # New Feature 4: Critical Links (count of links > 80% utilization)
        critical_links = sum(1 for util in all_link_utils if util > 80)
        critical_links_feature = np.full((len(self.p_nodes), 1), critical_links)

        # Combine all features into p_net_x
        p_net_x = np.hstack([
            p_resource_features,       # Available resources per type
            self.p_degrees,            # Node degrees
            p_total_capacity,          # Total available capacity
            p_aggregated_bw,           # Aggregated adjacent bandwidth
            p_betweenness,             # Betweenness centrality
            p_neighbor_bw,             # Average neighbor bandwidth
            node_utilization,          # Avg resource utilization %
            p_avg_link_util,           # Avg adjacent link utilization %
            link_variance_feature,     # Std dev of link utilizations
            critical_links_feature     # Number of critical links
        ])

        # Enhanced edge_attr: available bandwidth + link utilization
        edge_attr = np.array([
            [avail_bw[edge], link_utilization[edge]]
            for edge in self.edge_list
        ])

        return p_net_x, edge_attr
    
    def update_p_net_features(self, p_net_x: np.ndarray, edge_attr: np.ndarray, chosen_phys: str, v_node_demand: Dict, 
                          link_paths: Dict, v_nodes: List[str], t: int, edge_demands: Dict, 
                          used_bw: Dict) -> Tuple[np.ndarray, np.ndarray]:
        # Define number of resource types for column indexing
        num_resources = len(self.resource_keys)
        chosen_idx = self.p_node_to_idx[chosen_phys]
        
        # **Update resource features for the chosen physical node**
        for r_idx, r in enumerate(self.resource_keys):
            p_net_x[chosen_idx, r_idx] -= v_node_demand.get(r, 0.0)
        
        # **Update total capacity for the chosen node**
        p_net_x[chosen_idx, num_resources + 1] = np.sum(p_net_x[chosen_idx, :num_resources])
        
        # **Update node utilization for the chosen node**
        total_resources = self.total_node_resources[chosen_phys]
        utilizations = [
            ((total_resources[r] - p_net_x[chosen_idx, r_idx]) / total_resources[r] * 100)
            for r_idx, r in enumerate(self.resource_keys) if total_resources[r] > 0
        ]
        avg_util = np.mean(utilizations) if utilizations else 0.0
        p_net_x[chosen_idx, num_resources + 5] = avg_util
        
        # Initialize set to track nodes affected by routing
        affected_nodes = set()
        
        # **Update link-related features if routing is involved (t > 0)**
        if t > 0:
            for prev_t in range(t):
                prev_v_node = v_nodes[prev_t]
                prev_phys = self.node_slots[prev_v_node]
                v_edge = tuple(sorted([prev_v_node, v_nodes[t]]))
                req_bw = edge_demands.get(v_edge, 0.0)
                if req_bw > 0:
                    # Get the provided path for the virtual edge
                    provided_path = self._get_provided_path(prev_v_node, v_nodes[t], link_paths)
                    
                    if provided_path:
                        # Update bandwidth usage and edge attributes for each link in the path
                        for i in range(len(provided_path) - 1):
                            edge = tuple(sorted([provided_path[i], provided_path[i + 1]]))
                            if edge not in self.edge_to_idx:
                                # Skip if edge is not in the physical network (no feasible path)
                                continue
                            used_bw[edge] += req_bw
                            edge_idx = self.edge_to_idx[edge]
                            total_bw = self.total_edge_bandwidth[edge]
                            avail_bw = total_bw - used_bw[edge]
                            util = (used_bw[edge] / total_bw) * 100 if total_bw > 0 else 0.0
                            edge_attr[edge_idx, 0] = avail_bw  # Available bandwidth
                            edge_attr[edge_idx, 1] = util      # Link utilization
                            # Add nodes to affected_nodes
                            affected_nodes.add(provided_path[i])
                            affected_nodes.add(provided_path[i + 1])
        
        # **Update bandwidth-related features for affected nodes**
        for node in affected_nodes:
            p_idx = self.p_node_to_idx[node]
            # Get adjacent edges, ensuring they exist in edge_to_idx
            adjacent_edges = [tuple(sorted([node, adj])) for adj in self.physical_graph.adj[node] 
                            if tuple(sorted([node, adj])) in self.edge_to_idx]
            if adjacent_edges:
                # Aggregated bandwidth: sum of available bandwidth of adjacent links
                p_aggregated_bw = sum(edge_attr[self.edge_to_idx[edge], 0] for edge in adjacent_edges)
                # Neighbor bandwidth: mean of available bandwidth of adjacent links
                p_neighbor_bw = np.mean([edge_attr[self.edge_to_idx[edge], 0] for edge in adjacent_edges])
                # Average link utilization: mean of utilization of adjacent links
                p_avg_link_util = np.mean([edge_attr[self.edge_to_idx[edge], 1] for edge in adjacent_edges])
            else:
                p_aggregated_bw = 0.0
                p_neighbor_bw = 0.0
                p_avg_link_util = 0.0
            p_net_x[p_idx, num_resources + 2] = p_aggregated_bw
            p_net_x[p_idx, num_resources + 4] = p_neighbor_bw
            p_net_x[p_idx, num_resources + 6] = p_avg_link_util
        
        # **Update global features: link variance and critical links**
        all_utils = edge_attr[:, 1]  # All link utilizations
        link_variance = np.std(all_utils)          # Standard deviation of link utilizations
        critical_links = np.sum(all_utils > 80)    # Count of links with utilization > 80%
        p_net_x[:, num_resources + 7] = link_variance
        p_net_x[:, num_resources + 8] = critical_links
        
        return p_net_x, edge_attr
    
    def create_sample(self, p_net_x, edge_attr, v_net_x, v_net_edge_index, history_window, action_mask, action, v_net_id, target_value=None):
        """
        Create a sample dictionary for a given step in the virtual network embedding process.
        
        Returns:
            dict: Sample dictionary with tensorized data.
        """
        sample = {
            "p_net_x": torch.tensor(p_net_x, dtype=torch.float32),
            "p_net_edge_index": torch.tensor(self.p_net_edge_index, dtype=torch.long),
            "edge_attr": torch.tensor(edge_attr, dtype=torch.float32),
            "v_net_x": torch.tensor(v_net_x, dtype=torch.float32),
            "v_net_edge_index": torch.tensor(v_net_edge_index, dtype=torch.long),
            "history_actions": torch.tensor(history_window, dtype=torch.long),
            "action_mask": torch.tensor(action_mask, dtype=torch.float32),
            "action": torch.tensor(action, dtype=torch.long),
            "v_net_id": v_net_id,
            "target_value": target_value
        }
        return sample

    def is_virtual_network_valid(self, vnet_info: dict, v_nodes: List[str], node_slots: dict, used_bw: dict) -> bool: 
        if len(v_nodes) <= 1:
            return True

        for t in range(1, len(v_nodes)):
            for prev_t in range(t):
                v_edge = tuple(sorted([v_nodes[prev_t], v_nodes[t]]))
                req_bw = vnet_info["edge_demands"].get(v_edge, 0.0)
                if req_bw > 0:
                    prev_phys = node_slots[v_nodes[prev_t]]
                    curr_phys = node_slots[v_nodes[t]]
                    success, _ = self.check_path_availability(prev_phys, curr_phys, req_bw, used_bw) 
                    if not success:
                        #print(f"No feasible path for link between {prev_phys} and {curr_phys}")
                        return False
        return True

    def process_virtual_network(self, row, used_node: Dict, used_bw: Dict) -> None:
        """Process a virtual network and assign per-step rewards aligned with actual RL logic."""
        v_net_id = int(row[self.v_net_id_col])
        try:
            self.node_slots, link_paths = self.parse_graph_data(row[self.node_slots_col], row[self.link_paths_col])
        except Exception:
            return  # Skip if malformed

        v_net_x, vnet_info, v_net_edge_index, total_v_nodes = self.build_v_net_features(v_net_id, self.node_slots)
        v_nodes = vnet_info["v_nodes"]

        if not v_nodes or total_v_nodes == 0:
            return

        samples_temp = []
        p_net_x_local, edge_attr = self.build_initial_p_net_features(used_node, used_bw)
        valid = True
        failure_step = None

        for t, v_node in enumerate(v_nodes):
            self.total_steps += 1
            chosen_phys = self.node_slots.get(v_node, "-1")

            if chosen_phys == "-1":
                valid = False
                failure_step = t
                action_mask = np.zeros(self.num_p_nodes, dtype=np.float32)
                sample = self.create_sample(
                    p_net_x_local, edge_attr, v_net_x, v_net_edge_index,
                    self.global_history[-self.window_size:], action_mask, -1, v_net_id
                )
                samples_temp.append((t, sample))
                break

            v_node_demand = vnet_info["node_demands"].get(v_node, {})
            chosen_idx = self.p_node_to_idx[chosen_phys]

            # Build action mask
            action_mask = np.zeros(self.num_p_nodes, dtype=np.float32)
            for p_idx, p_node in enumerate(self.p_nodes):
                if not all(p_net_x_local[p_idx, r_idx] >= v_node_demand.get(r, 0.0)
                        for r_idx, r in enumerate(self.resource_keys)):
                    continue
                candidate_link_ok = True
                if t > 0:
                    for prev_t in range(t):
                        prev_v_node = v_nodes[prev_t]
                        prev_phys = self.node_slots.get(prev_v_node)
                        v_edge = tuple(sorted([prev_v_node, v_node]))
                        req_bw = vnet_info["edge_demands"].get(v_edge, 0.0)
                        if req_bw > 0:
                            success, _ = self.check_path_availability(prev_phys, p_node, req_bw, used_bw)
                            if not success:
                                candidate_link_ok = False
                                break
                if candidate_link_ok:
                    action_mask[p_idx] = 1.0

            if not all(p_net_x_local[chosen_idx, r_idx] >= v_node_demand.get(r, 0.0)
                    for r_idx, r in enumerate(self.resource_keys)):
                valid = False
                failure_step = t
                sample = self.create_sample(
                    p_net_x_local, edge_attr, v_net_x, v_net_edge_index,
                    self.global_history[-self.window_size:], action_mask, -1, v_net_id
                )
                samples_temp.append((t, sample))
                break

            # Store sample
            chosen_action = chosen_idx
            action_mask[chosen_action] = 1.0
            self.valid_action_percentage = (action_mask.sum() / self.num_p_nodes) * 100
            self.action_mask_percentages.append(self.valid_action_percentage)
            self.global_history.append(chosen_action)
            history_window = self.global_history[-self.window_size:]
            sample = self.create_sample(
                p_net_x_local, edge_attr, v_net_x, v_net_edge_index,
                history_window, action_mask, chosen_action, v_net_id
            )
            samples_temp.append((t, sample))

            # Update physical network state
            p_net_x_local, edge_attr = self.update_p_net_features(
                p_net_x_local, edge_attr, chosen_phys, v_node_demand, link_paths, v_nodes, t,
                vnet_info["edge_demands"], used_bw
            )

        # === Reward Assignment ===
        vnodes = total_v_nodes
        revokes = 0  # always 0 for expert traces

        # Estimate v_net_r2c_ratio
        v_total_demand = v_net_x[:, :len(self.resource_keys)].sum()
        try:
            node_dict = ast.literal_eval(row[self.node_slots_col])
            p_total_capacity = sum(sum(self.total_node_resources.get(p, {}).get(r, 0.0) for r in self.resource_keys)
                                for p in node_dict.values())
        except Exception:
            p_total_capacity = 1.0  # fallback
        r2c_ratio = float(v_total_demand) / max(1.0, float(p_total_capacity))
        value = r2c_ratio * 10
        revoke_pct = revokes / 92

        is_complete_success = valid and len(samples_temp) == vnodes

        if not valid:
            fail_t, sample = samples_temp[-1]
            reward = -10.0 if fail_t < vnodes - 1 else -3.0  # Case 1 vs Case 5
            sample["target_value"] = torch.tensor(reward, dtype=torch.float32)
            self.samples.append(sample)
        else:
            for t, sample in samples_temp:
                completion_pct = (t + 1) / vnodes
                completion_reward = completion_pct / vnodes
                penalty = completion_reward * revoke_pct
                bonus = completion_reward - penalty
                if t == vnodes - 1:
                    bonus = max(0, value - revoke_pct)
                    reward = value + bonus
                else:
                    reward = (value * completion_reward) + bonus
                sample["target_value"] = torch.tensor(reward, dtype=torch.float32)
                self.samples.append(sample)

    
     
    # --------------------------------------------------
    # Updated generate_samples that uses process_virtual_network
    # --------------------------------------------------
    def generate_samples(self) -> None:
        for idx in range(len(self.df)):
            row = self.df.iloc[idx]
            event_time = float(row[self.event_time_col])
            active_vnets = self.compute_active_vnets_upto(idx - 1)
            used_node, used_bw = self.accumulate_resources(active_vnets)
             
            sys.stdout.write(
                f"\rProcessing row {idx+1:4d}/{len(self.df):4d} | Valid Actions: {self.valid_action_percentage:6.1f}% "
            )
            sys.stdout.flush()

            event_description = row[self.description_col].strip()
            if event_description == "Leave Event":
                self.handle_leave_event(row)
                continue 

            self.process_virtual_network(row, used_node, used_bw)
            
    
    def handle_leave_event(self, row):
        v_net_id = int(row[self.v_net_id_col])
        current_index = row.name  
        active_vnets = self.compute_active_vnets_upto(current_index)
        used_node_resources, used_edge_bandwidth = self.accumulate_resources(active_vnets)
        self.current_used_node_resources = used_node_resources
        self.current_used_edge_bandwidth = used_edge_bandwidth 
    
    
    def post_normalize_samples(self) -> None:
        norm_vector_v = torch.tensor(
            [self.max_node_resources[r] for r in self.resource_keys] +
            [self.max_capacity, self.max_bandwidth, self.max_bandwidth],
            dtype=torch.float32
        )
        norm_vector_p = torch.tensor(
            [self.max_node_resources[r] for r in self.resource_keys] +
            [self.max_degree, self.max_capacity, self.max_bandwidth, self.max_betweenness, self.max_neighbor_bw,100.0, 100.0, 50.0, len(self.edge_list)],
            dtype=torch.float32
        )
        
        for sample in self.samples:
            sample["p_net_x"] = sample["p_net_x"] / norm_vector_p
            sample["v_net_x"] = sample["v_net_x"] / norm_vector_v
            sample["edge_attr"] = sample["edge_attr"] / self.max_bandwidth
            
    def save_output(self) -> None:
        if self.samples:
            self.post_normalize_samples()
            timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
            output_file = os.path.join(self.output_folder, f"training_data_{self.folder_number}_{timestamp}.pt")
            torch.save(self.samples, output_file)
            print(f"\nGenerated {len(self.samples)} samples from {self.csv_filename}.")
            print(f"Saved dataset to: {output_file}")
            print(f"Total Actions Processed: {self.total_actions}")
            print(f"Invalid actions encountered: {self.invalid_count}")
            print(f"Zero-valid-node situations: {self.zero_valid_count}")
            if self.action_mask_percentages:
                avg = sum(self.action_mask_percentages) / len(self.action_mask_percentages)
                print(f"\n📊 Average % of Nodes with Available Actions: {avg:.2f}%")
            else:
                print("\n⚠️ No valid action masks were recorded.")
        else:
            print("No samples generated, skipping save.")

    
    def process_oneshot_virtual_network(self, row, used_node: Dict, used_bw: Dict) -> None:
        v_net_id = int(row[self.v_net_id_col])
        self.node_slots, link_paths = self.parse_graph_data(row[self.node_slots_col], row[self.link_paths_col])
        v_net_x, vnet_info, v_net_edge_index, total_v_nodes = self.build_v_net_features(v_net_id, self.node_slots)

        if total_v_nodes != 8:
            self.zero_valid_count += 1
            return

        v_nodes = vnet_info["v_nodes"]
        edge_demands = vnet_info["edge_demands"]
        node_demands = vnet_info["node_demands"]

        if not self.is_virtual_network_valid(vnet_info, v_nodes, self.node_slots, used_bw):
            self.invalid_count += 1
            return

        # Initialize physical state based on current resource usage
        p_net_x, edge_attr = self.build_initial_p_net_features(used_node, used_bw)

        # Save original for compatibility — we’ll just use the base graph once
        p_net_edge_index = torch.tensor(self.p_net_edge_index, dtype=torch.long)
        p_net_x_0 = torch.tensor(p_net_x.copy(), dtype=torch.float32)
        edge_attr_0 = torch.tensor(edge_attr.copy(), dtype=torch.float32)

        # Time-dependent features
        pnet_states = []
        edge_attrs = []
        action_masks = []
        actions = []
        history_actions = []

        for t, v_node in enumerate(v_nodes):
            chosen_phys = self.node_slots[v_node]
            v_node_demand = node_demands[v_node]
            chosen_idx = self.p_node_to_idx[chosen_phys]

            # Build action mask
            action_mask = np.zeros(self.num_p_nodes, dtype=np.float32)
            for p_idx, p_node in enumerate(self.p_nodes):
                if not all(p_net_x[p_idx, r_idx] >= v_node_demand.get(r, 0.0) for r_idx, r in enumerate(self.resource_keys)):
                    continue
                candidate_link_ok = True
                for prev_t in range(t):
                    prev_v_node = v_nodes[prev_t]
                    prev_phys = self.node_slots[prev_v_node]
                    v_edge = tuple(sorted([prev_v_node, v_node]))
                    req_bw = edge_demands.get(v_edge, 0.0)
                    if req_bw > 0:
                        success, _ = self.check_path_availability(prev_phys, p_node, req_bw, used_bw)
                        if not success:
                            candidate_link_ok = False
                            break
                if candidate_link_ok:
                    action_mask[p_idx] = 1.0

            pnet_states.append(torch.tensor(p_net_x.copy(), dtype=torch.float32))
            edge_attrs.append(torch.tensor(edge_attr.copy(), dtype=torch.float32))
            action_masks.append(torch.tensor(action_mask, dtype=torch.float32))
            actions.append(torch.tensor(chosen_idx, dtype=torch.long))

            windowed_history = self.global_history[-self.window_size:]
            padded_history = [self.num_p_nodes] * (self.window_size - len(windowed_history)) + windowed_history
            history_actions.append(torch.tensor(padded_history, dtype=torch.long))


            self.global_history.append(chosen_idx)  # Append AFTER storing the history


            # Update physical state
            p_net_x, edge_attr = self.update_p_net_features(
                p_net_x, edge_attr, chosen_phys, v_node_demand, link_paths, v_nodes, t,
                edge_demands, used_bw
            )

        sample = {
            "p_net_x": p_net_x_0,                             # [N_p, d_p] → shared across steps
            "edge_attr": edge_attr_0,                         # [E, d_e]   → shared across steps
            "p_net_edge_index": p_net_edge_index,             # [2, E]     → shared
            "v_net_x": torch.tensor(v_net_x, dtype=torch.float32).squeeze(0),  # [8, d_v]
            "v_net_edge_index": torch.tensor(v_net_edge_index, dtype=torch.long),
            "action_mask": torch.stack(action_masks),         # [8, N_p]
            "action": torch.stack(actions),                   # [8]
            "history_actions": torch.stack(history_actions),  # [8, window_size]
            "v_net_id": v_net_id,
            "target_value": torch.tensor(1.0, dtype=torch.float32)
        }

        self.samples.append(sample)



        

    def generate_oneshot_samples(self) -> None:
        """Processes dataset into transformer-friendly full 8-node placement examples."""
        self.global_history = []
        for idx in range(len(self.df)):
            self.total_actions+=1
            row = self.df.iloc[idx]
            event_time = float(row[self.event_time_col])
            active_vnets = self.compute_active_vnets_upto(idx - 1)
            used_node, used_bw = self.accumulate_resources(active_vnets)

            sys.stdout.write(
                f"\r[Oneshot] Row {idx+1:4d}/{len(self.df):4d} | Samples: {len(self.samples):5d}"
            )
            sys.stdout.flush()

            event_description = row[self.description_col].strip()
            if event_description == "Leave Event":
                continue

            if str(row[self.result_col]).strip().lower() != "true":
                continue

            self.process_oneshot_virtual_network(row, used_node, used_bw)


def main() -> None:
    if len(sys.argv) != 2:
        print("Usage: python data_generator.py <result-folder-number>")
        sys.exit(1)
    generator = DataGenerator("/home/stephen-reilly/dev/virne/dataset/", sys.argv[1])
    generator.generate_samples()
    #generator.generate_oneshot_samples()
    generator.save_output()

if __name__ == "__main__":
    main()
