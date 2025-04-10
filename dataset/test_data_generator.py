# ------------------------
# test_data_generator.py
# ------------------------  
import unittest
import os
import shutil
import torch
import pandas as pd
import networkx as nx
import numpy as np
from collections import defaultdict
import sys
from io import StringIO
from unittest.mock import patch
import warnings
import random

from data_generator import DataGenerator  # Assuming data_generator.py is in the same directory

class TestDataGenerator(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        # 1. SEEDING
        random.seed(42)
        np.random.seed(42)
        torch.manual_seed(42)

        cls.test_dir = "test_results"
        cls.results_folder = os.path.join(cls.test_dir, "results-test")
        cls.p_net_path = os.path.join(cls.results_folder, "p_net.gml")
        cls.v_net_folder = os.path.join(cls.results_folder, "v_nets")
        cls.csv_path = os.path.join(cls.results_folder, "results.csv")
        cls.output_folder = os.path.join(cls.test_dir, "test_training_data")
        cls.output_file_prefix = "training_data_R_test"

        os.makedirs(cls.v_net_folder, exist_ok=True)
        os.makedirs(cls.output_folder, exist_ok=True)
        os.makedirs(cls.results_folder, exist_ok=True)

        # 2. CREATE A CONSISTENT PHYSICAL NETWORK with raw capacities.
        cls.p_graph = nx.Graph()
        cls.p_graph.add_node('0', cpu=10, gpu=5)  # raw capacities
        cls.p_graph.add_node('1', cpu=8, gpu=7)
        cls.p_graph.add_edge('0', '1', bw=20)
        nx.write_gml(cls.p_graph, cls.p_net_path)

        # 3. CREATE VNETS *BEFORE* CSV DATA (demands are raw)
        cls.v_net_data = {}
        cls.create_v_net(1, [('0', {'cpu': 2, 'gpu': 1}), ('1', {'cpu': 3, 'gpu': 2})], [('0', '1', {'bw': 5})])
        cls.create_v_net(2, [('0', {'cpu': 5, 'gpu': 3})], [])
 
        # 4. CSV DATA
        data = {
            'v_net_id': [1, 1, 2],
            'description': ['Success', 'Leave Event', 'Success'],
            'v_net_arrival_time': [0, 1, 1],
            'v_net_lifetime': [2, 2, 3],
            'event_time': [0, 1, 1],
            'node_slots': [
                "{'0': '0', '1': '1'}",  # v_net 1
                "{}",                   # Leave event row
                "{'0': '0'}"            # v_net 2 with one node
            ],
            'link_paths': [
                "{('0', '1'): ['(0, 1)']}",  # v_net 1
                "{}",                        # Leave event row
                "{}"                         # v_net 2 (no links)
            ],
            'result': [True, True, True]
        }

        cls.df = pd.DataFrame(data)
        cls.df.to_csv(cls.csv_path, index=False)

        cls.original_argv = sys.argv

    @classmethod
    def tearDownClass(cls):
        sys.argv = cls.original_argv
        shutil.rmtree(cls.test_dir, ignore_errors=True)

    @classmethod
    def create_v_net(cls, v_net_id, nodes, edges):
        v_graph = nx.Graph()
        for node, data in nodes:
            v_graph.add_node(str(node), **data)  # Ensure node IDs are strings
        for u, v, data in edges:
            v_graph.add_edge(str(u), str(v), **data)
        v_net_path = os.path.join(cls.v_net_folder, f"v_net-{v_net_id:05d}.gml")
        nx.write_gml(v_graph, v_net_path)
        cls.v_net_data[v_net_id] = (nodes, edges)

    def setUp(self):
        random.seed(42)
        np.random.seed(42)
        torch.manual_seed(42)
        self.generator = DataGenerator(self.test_dir, "test", output_folder=self.output_folder)

    def test_physical_network_loading(self):
        self.assertEqual(len(self.generator.physical_graph.nodes), 2)
        self.assertEqual(len(self.generator.physical_graph.edges), 1)
        self.assertTrue(all(isinstance(n, str) for n in self.generator.physical_graph.nodes))
        # Check that raw node resources equal the original values.
        self.assertEqual(self.generator.total_node_resources['0']['cpu'], 10.0)
        self.assertEqual(self.generator.total_node_resources['0']['gpu'], 5.0)
        self.assertEqual(self.generator.total_node_resources['1']['cpu'], 8.0)
        self.assertEqual(self.generator.total_node_resources['1']['gpu'], 7.0)

    def test_vnet_loading_and_normalization(self):
        # Since normalization is postponed, demands are loaded as raw values.
        for v_net_id, (nodes, edges) in self.v_net_data.items():
            node_demands, edge_demands = self.generator.load_vnet_demands(v_net_id)
            for (node_id, node_data) in nodes:
                for r in ['cpu', 'gpu']:
                    expected = node_data.get(r, 0.0)  # raw demand
                    self.assertAlmostEqual(node_demands[str(node_id)][r], expected)
            for (u, v, edge_data) in edges:
                key = tuple(sorted([str(u), str(v)]))
                expected_bw = edge_data['bw']  # raw bandwidth
                self.assertAlmostEqual(edge_demands[key], expected_bw)

    def test_parse_graph_data(self):
        node_slots_str = "{0: 0, 1: 1}"
        link_paths_str = "{(0, 1): [0, 1]}"
        node_slots, link_paths = self.generator.parse_graph_data(node_slots_str, link_paths_str)
        self.assertEqual(node_slots, {'0': '0', '1': '1'})
        self.assertEqual(link_paths, {('0', '1'): ['0', '1']})

        node_slots, link_paths = self.generator.parse_graph_data("", "")
        self.assertEqual(node_slots, {})
        self.assertEqual(link_paths, {})

    def test_compute_active_vnets(self):
        self.generator.df = pd.read_csv(self.csv_path, dtype=str)
        active_vnets = self.generator.compute_active_vnets_upto(0)
        self.assertEqual(len(active_vnets), 1)
        self.assertEqual(active_vnets[0]['v_net_id'], 1)

        active_vnets = self.generator.compute_active_vnets_upto(1)
        self.assertEqual(len(active_vnets), 1)
        self.assertTrue(active_vnets[0]['expired'])

        active_vnets = self.generator.compute_active_vnets_upto(2)
        self.assertEqual(len(active_vnets), 2)
        self.assertTrue(active_vnets[0]['expired'])
        self.assertFalse(active_vnets[1]['expired'])
        self.assertEqual(active_vnets[1]['v_net_id'], 2)

    def test_accumulate_resources(self):
        active_vnets = self.generator.compute_active_vnets_upto(0)
        used_node_resources, used_edge_bandwidth = self.generator.accumulate_resources(active_vnets)
        expected_node = defaultdict(lambda: defaultdict(float))
        expected_node['0']['cpu'] = 2.0
        expected_node['0']['gpu'] = 1.0
        expected_node['1']['cpu'] = 3.0
        expected_node['1']['gpu'] = 2.0
        self.assertEqual(dict(used_node_resources), dict(expected_node))
        expected_bw = defaultdict(float)
        expected_bw[('0', '1')] = 5.0
        self.assertEqual(dict(used_edge_bandwidth), dict(expected_bw))

    def test_check_path_availability(self):
        used_bw = defaultdict(float)
        active_vnets = self.generator.compute_active_vnets_upto(0)
        used_node_resources, used_edge_bandwidth = self.generator.accumulate_resources(active_vnets)
        # Using raw capacity values: edge '0'-'1' has 20 units.
        self.assertTrue(self.generator.check_path_availability('0', '1', 10, used_edge_bandwidth)[0])
        self.assertFalse(self.generator.check_path_availability('0', '1', 25, used_edge_bandwidth)[0])
        self.assertFalse(self.generator.check_path_availability('0', '2', 1, used_edge_bandwidth)[0])

    def test_main_data_generation_loop(self):
        with patch('sys.stdout', new_callable=StringIO) as mock_stdout:
            self.generator.generate_samples()
            self.generator.save_output()
            output = mock_stdout.getvalue()
            self.assertIn("Generated", output)
            self.assertIn("samples from", output)

        output_files = [f for f in os.listdir(self.output_folder) if f.startswith(self.output_file_prefix)]
        self.assertEqual(len(output_files), 1)

        with warnings.catch_warnings():
            warnings.filterwarnings("ignore", category=FutureWarning)
            samples = torch.load(os.path.join(self.output_folder, output_files[0]))
        self.assertGreater(len(samples), 0)
        sample = samples[0]
        self.assertIn('p_net_x', sample)
        self.assertEqual(sample['p_net_x'].dtype, torch.float32)
        for file in output_files:
            os.remove(os.path.join(self.output_folder, file))

    def test_no_valid_actions(self):
        self.create_v_net(3, [('0', {'cpu': 9999, 'gpu': 1})], [])
        modified_data = self.df.copy()
        modified_data.loc[len(modified_data)] = [3, 'Success', 2, 2, 2, "{0: 0}", "{}", True]
        modified_data.to_csv(self.csv_path, index=False)
        self.generator.df = pd.read_csv(self.csv_path, dtype=str)
        with patch('sys.stdout', new_callable=StringIO):
            self.generator.generate_samples()
            self.generator.save_output()
        output_files = [f for f in os.listdir(self.output_folder) if f.startswith(self.output_file_prefix)]
        with warnings.catch_warnings():
            warnings.filterwarnings("ignore", category=FutureWarning)
            samples = torch.load(os.path.join(self.output_folder, output_files[0]))
        valid_samples = [sample for sample in samples if sample["action"].item() != -1] #filter out failure samples
        self.assertEqual(len(valid_samples), 3)
        for file in output_files:
            os.remove(os.path.join(self.output_folder, file))

    def test_invalid_action_forced_valid(self):
        self.create_v_net(4, [('0', {'cpu': 999, 'gpu': 1})], [])
        modified_data = self.df.copy()
        modified_data.loc[len(modified_data)] = [4, 'Success', 2, 2, 2, "{0: 0}", "{}", True]
        modified_data.to_csv(self.csv_path, index=False)
        self.generator.df = pd.read_csv(self.csv_path, dtype=str)
        with patch('sys.stdout', new_callable=StringIO) as mock_stdout:
            self.generator.generate_samples()
            self.generator.save_output()
            self.assertIn("Zero-valid-node situations", mock_stdout.getvalue())
            self.assertIn("Invalid actions encountered", mock_stdout.getvalue())
        output_files = [f for f in os.listdir(self.output_folder) if f.startswith(self.output_file_prefix)]
        for file in output_files:
            os.remove(os.path.join(self.output_folder, file))

    def test_edge_cases(self):
        self.create_v_net(5, [('0', {'cpu': 0, 'gpu': 1})], [])
        self.create_v_net(6, [('0', {'cpu': 1, 'gpu': 1}), ('1', {'cpu': 1, 'gpu': 1})],
                          [('0', '1', {'bw': 0})])
        modified_data = self.df.copy()
        modified_data.loc[len(modified_data)] = [5, 'Success', 3, 2, 3, "{0: 0}", "{}", True]
        modified_data.loc[len(modified_data)] = [6, 'Success', 4, 2, 4, "{0: 0, 1: 1}", "{(0, 1): [0, 1]}", True]
        modified_data.to_csv(self.csv_path, index=False)
        self.generator.df = pd.read_csv(self.csv_path, dtype=str)
        with patch('sys.stdout', new_callable=StringIO):
            self.generator.generate_samples()
            self.generator.save_output()
        output_files = [f for f in os.listdir(self.output_folder) if f.startswith(self.output_file_prefix)]
        with warnings.catch_warnings():
            warnings.filterwarnings("ignore", category=FutureWarning)
            samples = torch.load(os.path.join(self.output_folder, output_files[0]))
        # VNet 1: 2 samples, VNet 2: 1 sample, VNet 5: 1 sample, VNet 6: 2 samples.
        self.assertEqual(len(samples), 6)
        for file in output_files:
            os.remove(os.path.join(self.output_folder, file))

    def test_command_line_argument(self):
        with patch('sys.stdout', new_callable=StringIO) as mock_stdout:
            generator = DataGenerator(self.test_dir, "test")  # No sys.argv needed
            self.assertIn("Generating dataset from:", mock_stdout.getvalue())

    def test_missing_csv_file(self):
        os.rename(self.csv_path, self.csv_path + ".tmp")
        try:
            with self.assertRaises(FileNotFoundError):
                DataGenerator(self.test_dir, "test")
        finally:
            os.rename(self.csv_path + ".tmp", self.csv_path)

    def test_invalid_gml_file(self):
        corrupted_path = os.path.join(self.results_folder, "corrupted_p_net.gml")
        with open(corrupted_path, "w") as f:
            f.write("Invalid GML")
        original_path = self.generator.p_path
        self.generator.p_path = corrupted_path
        with self.assertRaises(nx.NetworkXError):
            self.generator.initialize()
        self.generator.p_path = original_path

    def test_dataframe_cleanup(self):
        self.assertEqual(self.generator.df['node_slots'].iloc[0], "{'0': '0', '1': '1'}")
        self.assertEqual(self.generator.df['link_paths'].iloc[0], "{('0', '1'): ['(0, 1)']}")

    def test_data_structure_shapes(self):
        self.generator.generate_samples()
        self.generator.save_output()
        output_files = [f for f in os.listdir(self.output_folder) if f.startswith(self.output_file_prefix)]
        with warnings.catch_warnings():
            warnings.filterwarnings("ignore", category=FutureWarning)
            samples = torch.load(os.path.join(self.output_folder, output_files[0]))
        for sample in samples:
            self.assertEqual(sample['p_net_x'].shape[0], len(self.p_graph.nodes))
            self.assertEqual(sample['p_net_x'].shape[1], self.generator.p_net_feature_dim)
            self.assertEqual(sample['p_net_edge_index'].shape[0], 2)
        for file in output_files:
            os.remove(os.path.join(self.output_folder, file))

    def test_check_path_availability_multi_hop(self):
        complex_p_graph = nx.Graph()
        complex_p_graph.add_node('0', cpu=10, gpu=5)
        complex_p_graph.add_node('1', cpu=8, gpu=7)
        complex_p_graph.add_node('2', cpu=8, gpu=7)
        complex_p_graph.add_edge('0', '1', bw=20)
        complex_p_graph.add_edge('1', '2', bw=20)
        original_p_graph = self.generator.physical_graph
        original_edge_bandwidth = self.generator.total_edge_bandwidth
        original_max_bandwidth = self.generator.max_bandwidth
        original_p_nodes = self.generator.p_nodes
        original_num_p_nodes = self.generator.num_p_nodes
        original_p_node_to_idx = self.generator.p_node_to_idx
        original_p_net_edge_index = self.generator.p_net_edge_index
        self.generator.physical_graph = complex_p_graph
        self.generator.total_edge_bandwidth = {
            tuple(sorted([str(u), str(v)])): float(data.get('bw', 0.0))
            for u, v, data in complex_p_graph.edges(data=True)
        }
        self.generator.max_bandwidth = max(self.generator.total_edge_bandwidth.values()) if self.generator.total_edge_bandwidth else 1.0
        self.generator.p_nodes = sorted(complex_p_graph.nodes(), key=lambda x: int(x))
        self.generator.num_p_nodes = len(self.generator.p_nodes)
        self.generator.p_node_to_idx = {node: idx for idx, node in enumerate(self.generator.p_nodes)}
        self.generator.p_net_edge_index = np.array([
            [self.generator.p_node_to_idx[u], self.generator.p_node_to_idx[v]]
            for u, v in complex_p_graph.edges()
        ]).T
        used_bw = defaultdict(float)
        used_bw[tuple(sorted(('0', '1')))] = 2.0
        used_bw[tuple(sorted(('1', '2')))] = 2.0
        src = '0'
        dst = '2'
        self.assertTrue(self.generator.check_path_availability(src, dst, 18, used_bw)[0])
        self.assertFalse(self.generator.check_path_availability(src, dst, 19, used_bw)[0])
        complex_p_graph.add_node('3', cpu=10, gpu=5)
        self.assertFalse(self.generator.check_path_availability('0', '3', 10, used_bw)[0])
        self.generator.physical_graph = original_p_graph
        self.generator.total_edge_bandwidth = original_edge_bandwidth
        self.generator.max_bandwidth = original_max_bandwidth
        self.generator.p_nodes = original_p_nodes
        self.generator.num_p_nodes = original_num_p_nodes
        self.generator.p_node_to_idx = original_p_node_to_idx
        self.generator.p_net_edge_index = original_p_net_edge_index


    def test_history_actions(self):
        self.create_v_net(7, [('0', {'cpu': 1, 'gpu': 1}),
                            ('1', {'cpu': 1, 'gpu': 1})],
                        [('0', '1', {'bw': 5})])
        modified_data = self.df.copy()
        modified_data.loc[len(modified_data)] = [
            7, 'Success', 2, 4, 2,
            "{'0': '0', '1': '1'}",
            "{('0', '1'): ['(0, 1)']}",
            True
        ]
        modified_data.to_csv(self.csv_path, index=False)
        self.generator.df = pd.read_csv(self.csv_path, dtype=str)
        self.generator.generate_samples()
        self.generator.save_output()
        output_files = [f for f in os.listdir(self.output_folder) if f.startswith(self.output_file_prefix)]
        with warnings.catch_warnings():
            warnings.filterwarnings("ignore", category=FutureWarning)
            samples = torch.load(os.path.join(self.output_folder, output_files[0]))
        
        # Filter samples for VNet 7 using v_net_id
        vnet7_samples = [s for s in samples if s['v_net_id'] == 7]
        self.assertTrue(len(vnet7_samples) == 2, f"Expected exactly 2 samples for VNet 7, got {len(vnet7_samples)}")
        
        history_lengths = [len(vnet7_samples[0]['history_actions'])]
        expected_length = history_lengths[0]

        for i in range(1, len(vnet7_samples)):
            expected_length += 1
            actual_length = len(vnet7_samples[i]['history_actions'])
            print(f"Sample {i}: Expected={expected_length}, Actual={actual_length}")
            self.assertEqual(actual_length, expected_length,
                            f"History length mismatch at sample {i}:\n"
                            f"Expected: {expected_length}, Got: {actual_length}\n"
                            f"History Lengths: {history_lengths}")
            history_lengths.append(actual_length)

        for file in output_files:
            os.remove(os.path.join(self.output_folder, file))

    def test_resource_exhaustion(self):
        self.create_v_net(8, [('0', {'cpu': 9.0, 'gpu': 4.0})], [])  # Nearly exhaust node 0
        modified_data = self.df.copy()
        modified_data.loc[len(modified_data)] = [8, 'Success', 5, 2, 5, "{0: 0}", "{}", True]
        modified_data.to_csv(self.csv_path, index=False)
        self.generator.df = pd.read_csv(self.csv_path, dtype=str)
        with patch('sys.stdout', new_callable=StringIO):
            self.generator.generate_samples()
            self.generator.save_output()
        output_files = [f for f in os.listdir(self.output_folder) if f.startswith(self.output_file_prefix)]
        with warnings.catch_warnings():
            warnings.filterwarnings("ignore", category=FutureWarning)
            samples = torch.load(os.path.join(self.output_folder, output_files[0]))
        last_sample = samples[-1]
        self.assertEqual(last_sample['action_mask'].sum(), 0)  # Both nodes should be available.
        for file in output_files:
            os.remove(os.path.join(self.output_folder, file))
 
    def test_invalid_link_paths(self):
        self.create_v_net(9, [('0', {'cpu': 1, 'gpu': 1}), ('1', {'cpu': 1, 'gpu': 1})], [('0', '1', {'bw': 5})])
        modified_data = self.df.copy()
        modified_data.loc[len(modified_data)] = [
            9, 'Success', 5, 2, 5,
            "{'0': '0', '1': '1'}",
            "{('0', '1'): ['(0, 999)']}",
            True
        ]
        modified_data.to_csv(self.csv_path, index=False)
        self.generator.df = pd.read_csv(self.csv_path, dtype=str)
        for edge in self.generator.total_edge_bandwidth:
            self.generator.total_edge_bandwidth[edge] = 2.0
        with patch('sys.stdout', new_callable=StringIO) as mock_stdout:
            self.generator.generate_samples()
            output = mock_stdout.getvalue()
            print(f"Captured Output:\n{output}")  # Debugging print
            # Ensure there is at least one invalid sample where action == -1
            invalid_samples = [sample for sample in self.generator.samples if sample["action"].item() == -1]
            self.assertGreater(len(invalid_samples), 0, "Expected at least one invalid sample due to an infeasible path.")
            valid_samples = [sample for sample in self.generator.samples if sample["action"].item() != -1]
            self.assertEqual(len(valid_samples), 3)
            self.generator.save_output() 


    def test_transformer_input_format(self):
        self.generator.generate_samples()
        samples = self.generator.samples
        for sample in samples:
            self.assertEqual(sample['p_net_x'].shape, (self.generator.num_p_nodes, self.generator.p_net_feature_dim))
            self.assertTrue(torch.all(sample['action_mask'] >= 0) and torch.all(sample['action_mask'] <= 1))

    def test_timing_and_expiration(self):
        modified_data = pd.DataFrame({
            'v_net_id': [1, 2],
            'description': ['Success', 'Success'],
            'v_net_arrival_time': [0, 1],
            'v_net_lifetime': [2, 2],
            'event_time': [0, 3],
            'node_slots': ["{0: 0}", "{0: 1}"],
            'link_paths': ["{}", "{}"],
            'result': [True, True]
        })
        modified_data.to_csv(self.csv_path, index=False)
        self.generator.df = pd.read_csv(self.csv_path, dtype=str)
        active_vnets = self.generator.compute_active_vnets_upto(1)
        self.assertEqual(len([v for v in active_vnets if not v['expired']]), 1)

    def test_resource_overlap(self):
        active_vnets = [{'v_net_id': 1, 'node_slots': {'0': '0'}, 'link_paths': {}},
                        {'v_net_id': 2, 'node_slots': {'0': '0'}, 'link_paths': {}}]
        used_node, _ = self.generator.accumulate_resources(active_vnets)
        cpu_used = used_node['0']['cpu']
        self.assertAlmostEqual(cpu_used, 2 + 5)

    def test_multiple_vnets_same_time(self):
        self.create_v_net(10, [('0', {'cpu': 2, 'gpu': 1})], [])
        self.create_v_net(11, [('1', {'cpu': 3, 'gpu': 2})], [])
        modified_data = self.df.copy()
        modified_data.loc[len(modified_data)] = [10, 'Success', 5, 2, 5, "{'0': '0'}", "{}", True]
        modified_data.loc[len(modified_data)] = [11, 'Success', 5, 2, 5, "{'1': '1'}", "{}", True]  # Same event_time
        modified_data.to_csv(self.csv_path, index=False)
        self.generator.df = pd.read_csv(self.csv_path, dtype=str)
        self.generator.generate_samples()
        self.generator.save_output()
        output_files = [f for f in os.listdir(self.output_folder) if f.startswith(self.output_file_prefix)]
        with warnings.catch_warnings():
            warnings.filterwarnings("ignore", category=FutureWarning)
            samples = torch.load(os.path.join(self.output_folder, output_files[0]))
        self.assertEqual(len(samples), 5)
        for file in output_files:
            os.remove(os.path.join(self.output_folder, file))

    def test_vnet_with_no_edges(self):
        self.create_v_net(14, [('0', {'cpu': 1, 'gpu': 1})], [])
        modified_data = self.df.copy()
        modified_data.loc[len(modified_data)] = [14, 'Success', 8, 2, 8, "{'0': '0'}", "{}", True]
        modified_data.to_csv(self.csv_path, index=False)
        self.generator.df = pd.read_csv(self.csv_path, dtype=str)
        self.generator.generate_samples()
        self.generator.save_output()
        output_files = [f for f in os.listdir(self.output_folder) if f.startswith(self.output_file_prefix)]
        with warnings.catch_warnings():
            warnings.filterwarnings("ignore", category=FutureWarning)
            samples = torch.load(os.path.join(self.output_folder, output_files[0]))
        # Expected: VNet 1 yields 2 samples, VNet 2 yields 1 sample, and VNet 14 yields 1 sample.
        self.assertEqual(len(samples), 4)
        for file in output_files:
            os.remove(os.path.join(self.output_folder, file))

    def test_vnet_with_disconnected_nodes(self):
        self.create_v_net(15, [('0', {'cpu': 1, 'gpu': 1}), ('1', {'cpu': 1, 'gpu': 1})], [])
        modified_data = self.df.copy()
        modified_data.loc[len(modified_data)] = [15, 'Success', 9, 2, 9, "{'0': '0', '1': '1'}", "{('0','1'): ['0','1']}", True]
        modified_data.to_csv(self.csv_path, index=False)
        self.generator.df = pd.read_csv(self.csv_path, dtype=str)
        self.generator.generate_samples()
        self.generator.save_output()
        output_files = [f for f in os.listdir(self.output_folder) if f.startswith(self.output_file_prefix)]
        with warnings.catch_warnings():
            warnings.filterwarnings("ignore", category=FutureWarning)
            samples = torch.load(os.path.join(self.output_folder, output_files[0]))
        # Expect 5 samples: 2 from VNet 15 (one per node) plus the ones from previous VNets.
        self.assertEqual(len(samples), 5)
        for file in output_files:
            os.remove(os.path.join(self.output_folder, file))

    def test_empty_vnet(self):
        self.create_v_net(16, [], [])  # Empty VNet
        modified_data = self.df.copy()
        modified_data.loc[len(modified_data)] = [16, 'Success', 10, 2, 10, "{}", "{}", True]
        modified_data.to_csv(self.csv_path, index=False)
        self.generator.df = pd.read_csv(self.csv_path, dtype=str)
        self.generator.generate_samples()
        self.generator.save_output()
        output_files = [f for f in os.listdir(self.output_folder) if f.startswith(self.output_file_prefix)]
        with warnings.catch_warnings():
            warnings.filterwarnings("ignore", category=FutureWarning)
            samples = torch.load(os.path.join(self.output_folder, output_files[0]))
        # Expected: Only samples from VNets with nodes.
        self.assertEqual(len(samples), 3)
        for file in output_files:
            os.remove(os.path.join(self.output_folder, file))
    
    def test_large_vnet(self):
        # Test with as many V-Net nodes as P-Net nodes.
        num_v_nodes = self.generator.num_p_nodes
        nodes = [(str(i), {'cpu': 1, 'gpu': 1}) for i in range(num_v_nodes)]
        edges = [(str(i), str(i+1), {'bw': 5}) for i in range(num_v_nodes - 1)]
        self.create_v_net(17, nodes, edges)

        modified_data = self.df.copy()
        # Map each V-Net node to a distinct P-Net node.
        node_slots_str = "{" + ", ".join([f"'{i}': '{i}'" for i in range(num_v_nodes)]) + "}"
        link_paths_str = "{" + ", ".join([f"('{i}', '{i+1}'): ['({i}, {i+1})']" for i in range(num_v_nodes - 1)]) + "}"
        
        modified_data.loc[len(modified_data)] = [17, 'Success', 11, 10, 11, node_slots_str, link_paths_str, True]
        modified_data.to_csv(self.csv_path, index=False)
        self.generator.df = pd.read_csv(self.csv_path, dtype=str)
        
        # Run the sample generation.
        self.generator.generate_samples()
        self.generator.save_output()
        output_files = [f for f in os.listdir(self.output_folder) if f.startswith(self.output_file_prefix)]
        with warnings.catch_warnings():
            warnings.filterwarnings("ignore", category=FutureWarning)
            samples = torch.load(os.path.join(self.output_folder, output_files[0]))
        
        # There are pre-existing samples plus one sample per V-Net node in VNet 17.
        self.assertEqual(len(samples), 3 + num_v_nodes)
        
        # For global history, determine the history length before processing VNet 17.
        # Assume the last sample before VNet 17 is at index 2.
        prev_history_length = len(samples[2]['history_actions'])
        
        for i in range(num_v_nodes):
            # The expected history length is the previous history plus (i+1) new decisions.
            expected_length = prev_history_length + (i + 1)
            self.assertEqual(len(samples[3+i]['history_actions']), expected_length)
            self.assertEqual(samples[3+i]['v_net_x'].shape[0], num_v_nodes)
            self.assertNotEqual(samples[3+i]['action'].item(), self.generator.start_token)
            self.assertTrue(samples[3+i]['action'].item() < self.generator.num_p_nodes)
        
        for file in output_files:
            os.remove(os.path.join(self.output_folder, file))


if __name__ == '__main__':
    unittest.main()
