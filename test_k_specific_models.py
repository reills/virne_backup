#!/usr/bin/env python3
"""
Test K-Specific Models - Parallel & Multi-Run Version

This script tests models with parallel processing and averages results over multiple runs.
- Runs small, medium, large networks in parallel
- Averages accuracy over 5 runs per model
- Results tracked from actual dataset CSV files

Usage:
    python test_k_specific_models.py --auto-find
    python test_k_specific_models.py --registry path/to/registry.json --models small_k1 medium_k1
"""

import os
import sys
import yaml
import json
import shutil
import subprocess
import time
import glob
import argparse
import concurrent.futures
from pathlib import Path
from typing import Dict, List
import pandas as pd
from datetime import datetime
import threading

class KSpecificTester:
    def __init__(self, base_dir: str = "/home/stephen-reilly/dev/virne"):
        self.base_dir = Path(base_dir)
        self.config_file = self.base_dir / "virne" / "config.py"
        self.p_net_settings = self.base_dir / "virne" / "settings" / "p_net_setting.yaml"
        self.v_sim_settings = self.base_dir / "virne" / "settings" / "v_sim_setting.yaml"
        
        self.num_test_runs = 5  # Average over 5 runs
        self.conda_env = "nfv"
        self.solver_name = "a3c_gcn_pre_train_transformer"
        
        # Thread-safe lock for file operations
        self.config_lock = threading.Lock()
        
        # Network configurations
        self.network_configs = {
            "small": {
                "p_net": {"num_nodes": 14, "link_attrs_high": 150, "link_attrs_low": 150, "node_attrs_high": 500, "node_attrs_low": 500},
                "v_sim": {"v_net_size_low": 3, "v_net_size_high": 3, "node_attrs_low": 15, "node_attrs_high": 15}
            },
            "medium": {
                "p_net": {"num_nodes": 47, "link_attrs_high": 100, "link_attrs_low": 100, "node_attrs_high": 250, "node_attrs_low": 250},
                "v_sim": {"v_net_size_low": 4, "v_net_size_high": 4, "node_attrs_low": 20, "node_attrs_high": 20}
            },
            "large": {
                "p_net": {"num_nodes": 100, "link_attrs_high": 80, "link_attrs_low": 80, "node_attrs_high": 100, "node_attrs_low": 100},
                "v_sim": {"v_net_size_low": 7, "v_net_size_high": 7, "node_attrs_low": 30, "node_attrs_high": 30}
            }
        }
        
        # Results storage
        self.results_dir = self.base_dir / "k_specific_testing"
        self.results_dir.mkdir(parents=True, exist_ok=True)
        
        timestamp = datetime.now().strftime("%m.%d.%Y_%H%M%S")
        self.results_file = self.results_dir / f"k_specific_results_{timestamp}.csv"
        self.test_results = []
        
        print(f"Test results will be saved to: {self.results_file}")
        print(f"Running {self.num_test_runs} tests per model for averaging")
        
    def backup_configs(self, worker_id: str = ""):
        """Backup original configuration files with worker ID"""
        suffix = f"_{worker_id}" if worker_id else ""
        shutil.copy2(self.config_file, f"{self.config_file}.backup{suffix}")
        shutil.copy2(self.p_net_settings, f"{self.p_net_settings}.backup{suffix}")
        shutil.copy2(self.v_sim_settings, f"{self.v_sim_settings}.backup{suffix}")
        
    def restore_configs(self, worker_id: str = ""):
        """Restore original configuration files with worker ID"""
        suffix = f"_{worker_id}" if worker_id else ""
        if os.path.exists(f"{self.config_file}.backup{suffix}"):
            shutil.copy2(f"{self.config_file}.backup{suffix}", self.config_file)
            shutil.copy2(f"{self.p_net_settings}.backup{suffix}", self.p_net_settings)
            shutil.copy2(f"{self.v_sim_settings}.backup{suffix}", self.v_sim_settings)
    
    def find_latest_registry(self) -> str:
        """Find the latest trained_models_registry.json file"""
        pattern = self.base_dir / "k_specific_training" / "run_*" / "trained_models_registry.json"
        registry_files = glob.glob(str(pattern))
        if not registry_files:
            return ""
        registry_files.sort(key=os.path.getctime, reverse=True)
        return registry_files[0]
    
    def load_registry(self, registry_path: str) -> Dict:
        """Load the trained models registry"""
        if not os.path.exists(registry_path):
            raise FileNotFoundError(f"Registry file not found: {registry_path}")
            
        with open(registry_path, 'r') as f:
            registry = json.load(f)
            
        print(f"Loaded registry with {len(registry)} trained models")
        return registry
    
    def modify_config_py(self, k_shortest: int, dataset_dir: str, model_path: str):
        """Modify config.py for testing - completely thread-safe with global lock"""
        import time
        with self.config_lock:
            # Small delay to avoid race conditions
            time.sleep(0.1)
            
            with open(self.config_file, 'r') as f:
                content = f.read()
            
            import re
            content = re.sub(r"solver_name: str = '[^']*'", f"solver_name: str = '{self.solver_name}'", content)
            content = re.sub(r'k_shortest: int = \d+', f'k_shortest: int = {k_shortest}', content)
            content = re.sub(r'num_epochs: int = \d+', f'num_epochs: int = 1', content)  # Single epoch per run
            content = re.sub(r'num_train_epochs: int = \d+', f'num_train_epochs: int = 0', content)
            content = re.sub(r'renew_v_net_simulator: bool = \w+', f'renew_v_net_simulator: bool = False', content)
            content = re.sub(r'use_fixed_dataset: bool = \w+', f'use_fixed_dataset: bool = True', content)
            content = re.sub(r'dir_save_dataset: str = "[^"]*"', f'dir_save_dataset: str = "{dataset_dir}"', content)
            content = re.sub(r"pretrained_model_path: str = '[^']*'", f"pretrained_model_path: str = '{model_path}'", content)
            
            with open(self.config_file, 'w') as f:
                f.write(content)
            
            time.sleep(0.1)  # Give time for file to be written
            
    def modify_p_net_settings(self, network_size: str, dataset_dir: str):
        """Modify p_net_setting.yaml - completely thread-safe with global lock"""
        import time
        with self.config_lock:
            time.sleep(0.1)
            
            with open(self.p_net_settings, 'r') as f:
                config = yaml.safe_load(f)
            
            net_config = self.network_configs[network_size]["p_net"]
            config["num_nodes"] = net_config["num_nodes"]
            config["save_dir"] = dataset_dir
            
            for attr in config["link_attrs_setting"]:
                if attr["type"] == "resource":
                    attr["high"] = net_config["link_attrs_high"]
                    attr["low"] = net_config["link_attrs_low"]
                    
            for attr in config["node_attrs_setting"]:
                if attr["type"] == "resource":
                    attr["high"] = net_config["node_attrs_high"]
                    attr["low"] = net_config["node_attrs_low"]
            
            with open(self.p_net_settings, 'w') as f:
                yaml.dump(config, f, default_flow_style=False)
                
            time.sleep(0.1)
                
    def modify_v_sim_settings(self, network_size: str, dataset_dir: str):
        """Modify v_sim_setting.yaml - completely thread-safe with global lock"""
        import time
        with self.config_lock:
            time.sleep(0.1)
            
            with open(self.v_sim_settings, 'r') as f:
                config = yaml.safe_load(f)
            
            net_config = self.network_configs[network_size]["v_sim"]
            config["save_dir"] = dataset_dir
            config["v_net_size"]["low"] = net_config["v_net_size_low"]
            config["v_net_size"]["high"] = net_config["v_net_size_high"]
            
            for attr in config["node_attrs_setting"]:
                if attr["type"] == "resource":
                    attr["low"] = net_config["node_attrs_low"]  
                    attr["high"] = net_config["node_attrs_high"]
            
            with open(self.v_sim_settings, 'w') as f:
                yaml.dump(config, f, default_flow_style=False)
                
            time.sleep(0.1)
    
    def get_accuracy_from_last_n_csvs(self, dataset_dir: str, n: int = 5) -> Dict:
        """Get averaged accuracy from the last N CSV files"""
        dataset_path = Path(dataset_dir)
        
        # Find CSV files with the solver name
        csv_pattern = f"{self.solver_name}-*.csv"
        csv_files = list(dataset_path.glob(csv_pattern))
        
        if not csv_files:
            return {"accuracy": 0.0, "success": False, "error": "No CSV files found"}
        
        # Get the N most recent CSV files
        csv_files_sorted = sorted(csv_files, key=os.path.getctime, reverse=True)
        recent_files = csv_files_sorted[:n]
        
        if len(recent_files) < n:
            print(f"  Warning: Only found {len(recent_files)} files, expected {n}")
        
        accuracies = []
        total_v_nets = []
        total_successes = []
        
        for csv_file in recent_files:
            try:
                df = pd.read_csv(csv_file)
                if len(df) == 0:
                    continue
                
                # Get the last row for final results
                last_row = df.iloc[-1]
                v_net_count = int(last_row['v_net_count'])
                success_count = int(last_row['success_count'])
                
                if v_net_count > 0:
                    accuracy = success_count / v_net_count
                    accuracies.append(accuracy)
                    total_v_nets.append(v_net_count)
                    total_successes.append(success_count)
                    
            except Exception as e:
                print(f"  Warning: Error reading {csv_file}: {e}")
                continue
        
        if not accuracies:
            return {"accuracy": 0.0, "success": False, "error": "No valid CSV data found"}
        
        avg_accuracy = sum(accuracies) / len(accuracies)
        total_v_net_count = sum(total_v_nets)
        total_success_count = sum(total_successes)
        
        return {
            "accuracy": avg_accuracy,
            "success": True,
            "v_net_count": total_v_net_count,
            "success_count": total_success_count,
            "num_runs": len(accuracies),
            "individual_accuracies": accuracies
        }
    
    def test_model_single(self, model_key: str, model_info: Dict, run_number: int = 1) -> bool:
        """Test a model once and return success status"""
        network_size = model_info["network_size"]
        k_shortest = model_info["k_shortest"]
        dataset_dir = model_info["dataset_dir"]
        model_path = model_info["model_path"]
        
        worker_id = f"{network_size}_{k_shortest}_{run_number}"
        
        try:
            # Configure for testing
            self.modify_p_net_settings(network_size, dataset_dir)
            self.modify_v_sim_settings(network_size, dataset_dir)
            self.modify_config_py(k_shortest, dataset_dir, model_path)
            
            # Run the test
            os.chdir(self.base_dir)
            cmd = f"conda run -n {self.conda_env} python -m virne.main"
            
            result = subprocess.run(cmd, shell=True, capture_output=True, text=True)
            
            if result.returncode == 0:
                print(f"  ✓ Run {run_number} completed for {model_key}")
                return True
            else:
                print(f"  ✗ Run {run_number} failed for {model_key}: {result.stderr[:50]}")
                return False
                
        except Exception as e:
            print(f"  ✗ Run {run_number} exception for {model_key}: {e}")
            return False
    
    def test_model_multiple_runs(self, model_key: str, model_info: Dict) -> Dict:
        """Test a model multiple times and return averaged results"""
        network_size = model_info["network_size"]
        k_shortest = model_info["k_shortest"]
        dataset_dir = model_info["dataset_dir"]
        model_path = model_info["model_path"]
        
        print(f"\n{'='*50}")
        print(f"TESTING: {model_key} ({self.num_test_runs} runs)")
        print(f"Network: {network_size}, K: {k_shortest}")
        print(f"Dataset: {dataset_dir}")
        print(f"Model: {model_path}")
        print(f"{'='*50}")
        
        # Verify model exists
        if not os.path.exists(model_path):
            return {
                "network_size": network_size, "k_value": k_shortest, "accuracy": 0.0,
                "success": False, "error": "Model file not found"
            }
        
        # Run multiple tests
        successful_runs = 0
        start_time = time.time()
        
        for run in range(1, self.num_test_runs + 1):
            if self.test_model_single(model_key, model_info, run):
                successful_runs += 1
        
        duration = time.time() - start_time
        
        if successful_runs > 0:
            # Get averaged accuracy from last N CSV files
            accuracy_result = self.get_accuracy_from_last_n_csvs(dataset_dir, self.num_test_runs)
            net_config = self.network_configs[network_size]
            
            test_result = {
                "network_size": network_size,
                "k_value": k_shortest,
                "accuracy": accuracy_result["accuracy"],
                "p_net_nodes": net_config["p_net"]["num_nodes"],
                "p_net_node_resources": f"{net_config['p_net']['node_attrs_low']}-{net_config['p_net']['node_attrs_high']}",
                "p_net_link_resources": f"{net_config['p_net']['link_attrs_low']}-{net_config['p_net']['link_attrs_high']}",
                "v_net_size": f"{net_config['v_sim']['v_net_size_low']}-{net_config['v_sim']['v_net_size_high']}",
                "v_net_node_resources": f"{net_config['v_sim']['node_attrs_low']}-{net_config['v_sim']['node_attrs_high']}",
                "success_count": accuracy_result.get("success_count", 0),
                "v_net_count": accuracy_result.get("v_net_count", 0),
                "successful_runs": successful_runs,
                "total_runs": self.num_test_runs,
                "duration": duration,
                "model_path": model_path,
                "success": accuracy_result["success"]
            }
            
            if accuracy_result["success"]:
                individual_accs = accuracy_result.get("individual_accuracies", [])
                acc_str = f"{accuracy_result['accuracy']:.4f}"
                if len(individual_accs) > 1:
                    acc_range = f"[{min(individual_accs):.4f}-{max(individual_accs):.4f}]"
                    acc_str += f" {acc_range}"
                print(f"✓ RESULT: {acc_str} accuracy from {successful_runs}/{self.num_test_runs} runs")
            else:
                print(f"✗ ERROR: {accuracy_result.get('error', 'Unknown error')}")
                test_result["error"] = accuracy_result.get('error', 'Unknown error')
        else:
            # All runs failed
            net_config = self.network_configs[network_size]
            test_result = {
                "network_size": network_size, "k_value": k_shortest, "accuracy": 0.0,
                "p_net_nodes": net_config["p_net"]["num_nodes"],
                "p_net_node_resources": f"{net_config['p_net']['node_attrs_low']}-{net_config['p_net']['node_attrs_high']}",
                "p_net_link_resources": f"{net_config['p_net']['link_attrs_low']}-{net_config['p_net']['link_attrs_high']}",
                "v_net_size": f"{net_config['v_sim']['v_net_size_low']}-{net_config['v_sim']['v_net_size_high']}",
                "v_net_node_resources": f"{net_config['v_sim']['node_attrs_low']}-{net_config['v_sim']['node_attrs_high']}",
                "success_count": 0, "v_net_count": 0, "successful_runs": 0,
                "total_runs": self.num_test_runs, "duration": duration,
                "model_path": model_path, "success": False,
                "error": "All test runs failed"
            }
            print(f"✗ ALL RUNS FAILED for {model_key}")
        
        return test_result
    
    def test_network_models_sequential(self, network_size: str, model_list: List, worker_id: int):
        """Test all models for a network size sequentially"""
        results = []
        total_models = len(model_list)
        
        print(f"\n[Worker {worker_id}] Starting {network_size} network: {total_models} models")
        
        for i, (model_key, model_info) in enumerate(model_list, 1):
            print(f"\n[Worker {worker_id}] [{i}/{total_models}] Testing {model_key}")
            result = self.test_model_multiple_runs(model_key, model_info)
            results.append(result)
            
        print(f"\n[Worker {worker_id}] Completed {network_size} network: {total_models} models")
        return results
    
    def test_models_sequential_by_network(self, registry: Dict, selected_models: List[str] = None):
        """Test models sequentially by network size to avoid config conflicts"""
        if selected_models:
            models_to_test = {k: v for k, v in registry.items() if k in selected_models}
        else:
            models_to_test = registry
            
        print(f"\nTesting {len(models_to_test)} models sequentially by network size...")
        print(f"Each model will be tested {self.num_test_runs} times for averaging")
        
        # Group models by network size
        models_by_network = {"small": [], "medium": [], "large": []}
        for model_key, model_info in models_to_test.items():
            network_size = model_info["network_size"]
            if network_size in models_by_network:
                models_by_network[network_size].append((model_key, model_info))
        
        print(f"Models per network: Small={len(models_by_network['small'])}, Medium={len(models_by_network['medium'])}, Large={len(models_by_network['large'])}")
        print("Strategy: Networks run sequentially to avoid config conflicts, 5 runs per model")
        
        self.backup_configs()
        all_results = []
        
        try:
            # Process each network size sequentially
            for network_size in ["small", "medium", "large"]:
                model_list = models_by_network[network_size]
                if not model_list:
                    continue
                    
                print(f"\n{'='*60}")
                print(f"Processing {network_size.upper()} network: {len(model_list)} models")
                print(f"{'='*60}")
                
                for i, (model_key, model_info) in enumerate(model_list, 1):
                    print(f"\n[{i}/{len(model_list)}] Testing {model_key}")
                    result = self.test_model_multiple_runs(model_key, model_info)
                    all_results.append(result)
                    
                    # Save intermediate results after each model
                    self.test_results = all_results
                    self.save_results()
                    
                print(f"\n✓ Completed {network_size} network: {len(model_list)} models")
        
        except Exception as e:
            print(f"\n✗ ERROR during testing: {e}")
            
        finally:
            self.restore_configs()
        
        self.test_results = all_results
        self.print_summary()
        
    def save_results(self):
        """Save test results to single CSV file"""
        if self.test_results:
            df = pd.DataFrame(self.test_results)
            # Reorder columns for clarity
            column_order = [
                'network_size', 'k_value', 'accuracy', 
                'p_net_nodes', 'p_net_node_resources', 'p_net_link_resources',
                'v_net_size', 'v_net_node_resources',
                'success_count', 'v_net_count', 'successful_runs', 'total_runs', 'success'
            ]
            # Add any remaining columns
            remaining_cols = [col for col in df.columns if col not in column_order]
            df = df[column_order + remaining_cols]
            
            df.to_csv(self.results_file, index=False)
            print(f"Results saved to: {self.results_file}")
    
    def print_summary(self):
        """Print test summary"""
        print(f"\n{'='*60}")
        print("K-SPECIFIC TESTING COMPLETED")
        print(f"{'='*60}")
        
        successful = [r for r in self.test_results if r["success"]]
        failed = [r for r in self.test_results if not r["success"]]
        
        print(f"Total tests: {len(self.test_results)}")
        print(f"Successful: {len(successful)}")
        print(f"Failed: {len(failed)}")
        
        if successful:
            print(f"\nSUCCESSFUL TESTS:")
            for result in sorted(successful, key=lambda x: (x['network_size'], x['k_value'])):
                runs_info = f"({result.get('successful_runs', '?')}/{result.get('total_runs', '?')} runs)"
                print(f"  {result['network_size']}_k{result['k_value']}: {result['accuracy']:.4f} {runs_info}")
        
        if failed:
            print(f"\nFAILED TESTS:")
            for result in failed:
                error = result.get('error', 'Unknown error')
                print(f"  {result['network_size']}_k{result.get('k_value', '?')}: {error[:50]}")
        
        print(f"\nResults saved to: {self.results_file}")

def main():
    parser = argparse.ArgumentParser(description='Test K-Specific Models - Parallel Multi-Run')
    parser.add_argument('--registry', type=str, help='Path to trained_models_registry.json')
    parser.add_argument('--auto-find', action='store_true', help='Auto-find latest registry')
    parser.add_argument('--models', type=str, nargs='*', help='Specific models to test')
    parser.add_argument('--base-dir', default='/home/stephen-reilly/dev/virne', help='Base directory')
    parser.add_argument('--workers', type=int, default=3, help='Max parallel workers (default: 3)')
    parser.add_argument('--runs', type=int, default=5, help='Number of runs per model (default: 5)')
    
    args = parser.parse_args()
    
    if not args.registry and not args.auto_find:
        print("Error: Must specify --registry or --auto-find")
        sys.exit(1)
    
    tester = KSpecificTester(base_dir=args.base_dir)
    tester.num_test_runs = args.runs
    
    try:
        # Find or load registry
        if args.auto_find:
            registry_path = tester.find_latest_registry()
            if not registry_path:
                print("Error: No registry found. Run train_k_specific_models.py first.")
                sys.exit(1)
        else:
            registry_path = args.registry
            
        registry = tester.load_registry(registry_path)
        
        print(f"Registry: {registry_path}")
        print(f"Models to test: {args.models if args.models else 'all'}")
        print(f"Parallel workers: {args.workers}")
        print(f"Runs per model: {args.runs}")
        
        # Test models sequentially by network to avoid config conflicts
        tester.test_models_sequential_by_network(registry, args.models)
        
    except KeyboardInterrupt:
        print("\nTesting interrupted")
    except Exception as e:
        print(f"Error: {e}")
        raise

if __name__ == "__main__":
    main()