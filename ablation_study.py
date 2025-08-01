#!/usr/bin/env python3
"""
K-Shortest Path Ablation Study Automation Script

This script automates the complete workflow with flexible options:
1. Train models for each network size (if needed)
2. Run k_shortest ablation experiments using trained models

Usage modes:
- Full study: Train models + run ablation experiments
- Phase 2 only: Use existing trained models and run ablation experiments only

Uses conda environment 'nfv' and ensures proper dataset/model reuse.
"""

import os
import sys
import yaml
import json
import shutil
import subprocess
import time
from pathlib import Path
from typing import Dict, List, Tuple
import pandas as pd
import glob
import argparse
from datetime import datetime

class AblationStudy:
    def __init__(self, base_dir: str = "/home/stephen-reilly/dev/virne", phase2_only: bool = False):
        self.base_dir = Path(base_dir)
        self.config_file = self.base_dir / "virne" / "config.py"
        self.main_file = self.base_dir / "virne" / "main.py"
        self.p_net_settings = self.base_dir / "virne" / "settings" / "p_net_setting.yaml"
        self.v_sim_settings = self.base_dir / "virne" / "settings" / "v_sim_setting.yaml"
        self.results_csv = self.base_dir / "save" / "global_summary.csv"
        
        # Mode selection
        self.phase2_only = phase2_only
        
        # Experimental parameters
        self.k_shortest_values = [1, 3, 5, 7, 10, 13, 15]
        self.num_train_epochs = 100
        self.num_test_epochs = 10
        self.conda_env = "nfv"
        self.solver_name = "a3c_gcn_pre_train_transformer"
        
        # Pre-trained models and datasets (for phase 2 only mode)
        self.trained_models_config = {
            "small": {
                "dataset_dir": "/home/stephen-reilly/dev/virne/dataset/results-2",
                "model_path": "/home/stephen-reilly/dev/virne/dataset/results-2/output/model/model.pkl"
            },
            "medium": {
                "dataset_dir": "/home/stephen-reilly/dev/virne/dataset/results-3", 
                "model_path": "/home/stephen-reilly/dev/virne/dataset/results-3/output/model/model.pkl"
            },
            "large": {
                "dataset_dir": "/home/stephen-reilly/dev/virne/dataset/results-6",
                "model_path": "/home/stephen-reilly/dev/virne/dataset/results-6/output/model/model.pkl"
            }
        }
        
        # Network configurations for both training and testing
        # In phase2_only mode: More generous resources to achieve ~90% baseline acceptance
        # In full mode: Standard resource settings for training
        if phase2_only:
            # Generous settings for high baseline acceptance rates
            self.network_configs = {
                "small": {
                    "p_net": {
                        "num_nodes": 14,
                        "link_attrs_high": 200,  # Generous bandwidth
                        "link_attrs_low": 200,
                        "node_attrs_high": 500,  # Generous CPU/resources  
                        "node_attrs_low": 500
                    },
                    "v_sim": {
                        "v_net_size_low": 3,
                        "v_net_size_high": 3,
                        "node_attrs_low": 15,    # Moderate virtual demands
                        "node_attrs_high": 15
                    }
                },
                "medium": {
                    "p_net": {
                        "num_nodes": 47,
                        "link_attrs_high": 150,  # Generous bandwidth
                        "link_attrs_low": 150,
                        "node_attrs_high": 300,  # Generous CPU/resources
                        "node_attrs_low": 300
                    },
                    "v_sim": {
                        "v_net_size_low": 4,
                        "v_net_size_high": 4,
                        "node_attrs_low": 20,    # Moderate virtual demands
                        "node_attrs_high": 20
                    }
                },
                "large": {
                    "p_net": {
                        "num_nodes": 100,
                        "link_attrs_high": 80,   # Challenging bandwidth (same as training)
                        "link_attrs_low": 80,
                        "node_attrs_high": 100,  # Challenging CPU (same as training)
                        "node_attrs_low": 100
                    },
                    "v_sim": {
                        "v_net_size_low": 7,
                        "v_net_size_high": 7,
                        "node_attrs_low": 30,    # Challenging virtual demands (same as training)
                        "node_attrs_high": 30
                    }
                }
            }
        else:
            # Standard settings for training mode
            self.network_configs = {
                "small": {
                    "p_net": {
                        "num_nodes": 14,
                        "link_attrs_high": 150,
                        "link_attrs_low": 150,
                        "node_attrs_high": 500,
                        "node_attrs_low": 500
                    },
                    "v_sim": {
                        "v_net_size_low": 3,
                        "v_net_size_high": 3,
                        "node_attrs_low": 15,
                        "node_attrs_high": 15
                    }
                },
                "medium": {
                    "p_net": {
                        "num_nodes": 47,
                        "link_attrs_high": 100,
                        "link_attrs_low": 100,
                        "node_attrs_high": 250,
                        "node_attrs_low": 250
                    },
                    "v_sim": {
                        "v_net_size_low": 4,
                        "v_net_size_high": 4,
                        "node_attrs_low": 20,
                        "node_attrs_high": 20
                    }
                },
                "large": {
                    "p_net": {
                        "num_nodes": 100,
                        "link_attrs_high": 100,
                        "link_attrs_low": 100,
                        "node_attrs_high": 125,
                        "node_attrs_low": 125
                    },
                    "v_sim": {
                        "v_net_size_low": 7,
                        "v_net_size_high": 7,
                        "node_attrs_low": 25,
                        "node_attrs_high": 25
                    }
                }
            }
            
        # Results storage with date-based organization
        timestamp = datetime.now().strftime("%m.%d.%Y_%H%M%S")
        self.run_timestamp = timestamp
        self.results_base_dir = self.base_dir / "ablation_results"
        self.results_dir = self.results_base_dir / f"run_{timestamp}"
        self.results_dir.mkdir(parents=True, exist_ok=True)
        self.results_summary = []
        
        print(f"Results will be saved to: {self.results_dir}")
        
        # Track trained models for dynamic discovery in full mode
        self.trained_models = {}  # network_size -> {"dataset_dir": path, "model_path": path}
        
    def backup_original_configs(self):
        """Backup original configuration files"""
        print("Backing up original configuration files...")
        shutil.copy2(self.config_file, f"{self.config_file}.backup")
        shutil.copy2(self.main_file, f"{self.main_file}.backup")
        shutil.copy2(self.p_net_settings, f"{self.p_net_settings}.backup")
        shutil.copy2(self.v_sim_settings, f"{self.v_sim_settings}.backup")
        
    def restore_original_configs(self):
        """Restore original configuration files"""
        print("Restoring original configuration files...")
        shutil.copy2(f"{self.config_file}.backup", self.config_file)
        shutil.copy2(f"{self.main_file}.backup", self.main_file)
        shutil.copy2(f"{self.p_net_settings}.backup", self.p_net_settings)
        shutil.copy2(f"{self.v_sim_settings}.backup", self.v_sim_settings)
        
    def modify_config_py(self, k_shortest: int = 10, num_epochs: int = 1, num_train_epochs: int = 100, 
                        use_fixed_dataset: bool = False, dir_save_dataset: str = "", 
                        pretrained_model_path: str = "", renew_v_net_simulator: bool = True):
        """Modify config.py with all necessary parameters"""
        with open(self.config_file, 'r') as f:
            content = f.read()
        
        import re
        
        # Set solver name to transformer
        content = re.sub(r"solver_name: str = '[^']*'", f"solver_name: str = '{self.solver_name}'", content)
        
        # Update k_shortest
        content = re.sub(r'k_shortest: int = \d+', f'k_shortest: int = {k_shortest}', content)
        
        # Update num_epochs
        content = re.sub(r'num_epochs: int = \d+', f'num_epochs: int = {num_epochs}', content)
        
        # Update num_train_epochs
        content = re.sub(r'num_train_epochs: int = \d+', f'num_train_epochs: int = {num_train_epochs}', content)
        
        # Update renew_v_net_simulator (critical for phase 2 mode)
        content = re.sub(r'renew_v_net_simulator: bool = \w+', f'renew_v_net_simulator: bool = {renew_v_net_simulator}', content)
        
        # Update dataset settings
        content = re.sub(r'use_fixed_dataset: bool = \w+', f'use_fixed_dataset: bool = {use_fixed_dataset}', content)
        if dir_save_dataset:
            content = re.sub(r'dir_save_dataset: str = "[^"]*"', f'dir_save_dataset: str = "{dir_save_dataset}"', content)
        
        # Update pretrained model path
        content = re.sub(r"pretrained_model_path: str = '[^']*'", f"pretrained_model_path: str = '{pretrained_model_path}'", content)
        content = re.sub(r'pretrained_model_path: str = "[^"]*"', f'pretrained_model_path: str = "{pretrained_model_path}"', content)
        
        with open(self.config_file, 'w') as f:
            f.write(content)
            
    def modify_main_py(self, reuse_existing_p: bool, reuse_existing_v: bool):
        """Modify main.py to control dataset generation"""
        with open(self.main_file, 'r') as f:
            content = f.read()
        
        # Update the Generator.generate_dataset call
        import re
        pattern = r'Generator\.generate_dataset\(\s*config,\s*p_net=True,\s*v_nets=True,\s*save=True,\s*reuse_existing_p=\w+,\s*reuse_existing_v=\w+\s*\)'
        replacement = f'''Generator.generate_dataset(
        config,
        p_net=True,
        v_nets=True,
        save=True,
        reuse_existing_p={reuse_existing_p},
        reuse_existing_v={reuse_existing_v}
    )'''
        
        content = re.sub(pattern, replacement, content, flags=re.MULTILINE | re.DOTALL)
        
        with open(self.main_file, 'w') as f:
            f.write(content)
            
    def modify_p_net_settings(self, network_size: str, dataset_dir: str = ""):
        """Modify p_net_setting.yaml for different network sizes"""
        with open(self.p_net_settings, 'r') as f:
            config = yaml.safe_load(f)
        
        net_config = self.network_configs[network_size]["p_net"]
        
        # Update num_nodes
        config["num_nodes"] = net_config["num_nodes"]
        
        # Set save_dir if provided (for phase 2 mode)
        if dataset_dir:
            config["save_dir"] = dataset_dir
        
        # Update link attributes
        for attr in config["link_attrs_setting"]:
            if attr["type"] == "resource":
                attr["high"] = net_config["link_attrs_high"]
                attr["low"] = net_config["link_attrs_low"]
                
        # Update node attributes  
        for attr in config["node_attrs_setting"]:
            if attr["type"] == "resource":
                attr["high"] = net_config["node_attrs_high"]
                attr["low"] = net_config["node_attrs_low"]
        
        with open(self.p_net_settings, 'w') as f:
            yaml.dump(config, f, default_flow_style=False)
            
    def modify_v_sim_settings(self, network_size: str, dataset_dir: str = ""):
        """Modify v_sim_setting.yaml for different network sizes"""
        with open(self.v_sim_settings, 'r') as f:
            config = yaml.safe_load(f)
        
        net_config = self.network_configs[network_size]["v_sim"]
        
        # Set save_dir if provided (for phase 2 mode)
        if dataset_dir:
            config["save_dir"] = dataset_dir
        
        # Update v_net_size
        config["v_net_size"]["low"] = net_config["v_net_size_low"]
        config["v_net_size"]["high"] = net_config["v_net_size_high"]
        
        # Update node attributes
        for attr in config["node_attrs_setting"]:
            if attr["type"] == "resource":
                attr["low"] = net_config["node_attrs_low"]
                attr["high"] = net_config["node_attrs_high"]
        
        with open(self.v_sim_settings, 'w') as f:
            yaml.dump(config, f, default_flow_style=False)
            
    def clear_previous_results(self):
        """Clear previous results to ensure clean experiment"""
        if self.results_csv.exists():
            self.results_csv.unlink()
            
        # Also clear the save directory
        save_dir = self.base_dir / "save"
        if save_dir.exists():
            for item in save_dir.iterdir():
                if item.is_file() and item.name != '.gitkeep':
                    item.unlink()
                elif item.is_dir():
                    shutil.rmtree(item)
                    
    def find_latest_dataset_dir(self) -> str:
        """Find the latest dataset directory created by get_next_results_dir()"""
        dataset_pattern = self.base_dir / "dataset" / "results-*"
        dataset_dirs = glob.glob(str(dataset_pattern))
        
        if not dataset_dirs:
            return ""
        
        # Sort by creation time and get the most recent
        dataset_dirs.sort(key=os.path.getctime, reverse=True)
        return dataset_dirs[0]
    
    def find_model_file(self, dataset_dir: str) -> str:
        """Find the trained model file in the dataset directory"""
        model_pattern = os.path.join(dataset_dir, self.solver_name, "output", "model", "model.pkl")
        
        if os.path.exists(model_pattern):
            return model_pattern
        
        # Try alternative patterns
        alt_patterns = [
            os.path.join(dataset_dir, "output", self.solver_name, "model", "model.pkl"),
            os.path.join(dataset_dir, "output", "model", "model.pkl"),
        ]
        
        for pattern in alt_patterns:
            if os.path.exists(pattern):
                return pattern
        
        # Search recursively for any model.pkl
        for root, dirs, files in os.walk(dataset_dir):
            for file in files:
                if file == "model.pkl":
                    return os.path.join(root, file)
        
        return ""
    
    def read_results_from_csv(self) -> Dict:
        """Read results from global_summary.csv - get average for phase2_only mode"""
        if not self.results_csv.exists():
            print(f"Results file not found: {self.results_csv}")
            return {"acceptance_rate": 0.0, "success": False, "raw_result": {}}
        
        try:
            df = pd.read_csv(self.results_csv)
            if len(df) == 0:
                return {"acceptance_rate": 0.0, "success": False, "raw_result": {}}
            
            if self.phase2_only:
                # In phase2_only mode, get average of last 10 runs
                last_10_rows = df.tail(self.num_test_epochs)
                
                if len(last_10_rows) < self.num_test_epochs:
                    print(f"Warning: Expected {self.num_test_epochs} rows, got {len(last_10_rows)}")
                
                # Calculate average acceptance rate across the test runs
                avg_acceptance_rate = float(last_10_rows['acceptance_rate'].mean())
                
                # Get the last row for other metadata
                last_result = df.iloc[-1]
                
                print(f"Averaged acceptance_rate: {avg_acceptance_rate:.4f} from last {len(last_10_rows)} runs (total CSV rows: {len(df)})")
                
                return {
                    "acceptance_rate": avg_acceptance_rate,
                    "success": True,
                    "raw_result": last_result.to_dict(),
                    "test_runs": len(last_10_rows),
                    "individual_rates": last_10_rows['acceptance_rate'].tolist()
                }
            else:
                # In full mode, get the most recent result (last row)
                last_result = df.iloc[-1]
                acceptance_rate = float(last_result.get('acceptance_rate', 0.0))
                
                return {
                    "acceptance_rate": acceptance_rate,
                    "success": True,
                    "raw_result": last_result.to_dict()
                }
            
        except Exception as e:
            print(f"Error reading results CSV: {e}")
            return {"acceptance_rate": 0.0, "success": False, "raw_result": {}}
    
    def train_model_for_network_size(self, network_size: str) -> Dict:
        """Train model and generate dataset for a specific network size"""
        print(f"\n{'='*60}")
        print(f"TRAINING: {network_size.upper()} network")
        print(f"{'='*60}")
        
        # Configure settings for this network size
        self.modify_p_net_settings(network_size)
        self.modify_v_sim_settings(network_size)
        self.modify_config_py(
            k_shortest=10,  # Doesn't matter for training, just use default
            num_epochs=0,   # Don't do testing during training phase
            num_train_epochs=self.num_train_epochs,  # Do training
            use_fixed_dataset=False,  # Generate new dataset
            pretrained_model_path="",  # No pretrained model for training
            renew_v_net_simulator=True  # Generate new v_nets for training
        )
        self.modify_main_py(reuse_existing_p=False, reuse_existing_v=False)
        
        # Clear previous results
        self.clear_previous_results()
        
        # Change to the project directory
        os.chdir(self.base_dir)
        
        # Run training
        start_time = time.time()
        cmd = f"conda run -n {self.conda_env} python -m virne.main"
        
        try:
            print(f"Starting training for {network_size} network...")
            result = subprocess.run(
                cmd,
                shell=True,
                capture_output=True,
                text=True
                # No timeout - let training complete
            )
            
            end_time = time.time()
            duration = end_time - start_time
            
            if result.returncode != 0:
                print(f"Training failed for {network_size}:")
                print(result.stderr)
                return {"success": False, "dataset_dir": "", "model_path": ""}
            
            # Find the dataset directory that was created
            dataset_dir = self.find_latest_dataset_dir()
            if not dataset_dir:
                print(f"Could not find dataset directory for {network_size}")
                return {"success": False, "dataset_dir": "", "model_path": ""}
            
            # Find the trained model
            model_path = self.find_model_file(dataset_dir)
            if not model_path:
                print(f"Could not find trained model for {network_size}")
                return {"success": False, "dataset_dir": dataset_dir, "model_path": ""}
            
            print(f"Training completed for {network_size}:")
            print(f"  Dataset: {dataset_dir}")
            print(f"  Model: {model_path}")
            print(f"  Duration: {duration:.2f}s")
            
            # Save training logs
            training_dir = self.results_dir / f"training_{network_size}"
            training_dir.mkdir(exist_ok=True)
            
            with open(training_dir / "stdout.log", 'w') as f:
                f.write(result.stdout)
            with open(training_dir / "stderr.log", 'w') as f:
                f.write(result.stderr)
            
            return {
                "success": True,
                "dataset_dir": dataset_dir,
                "model_path": model_path,
                "duration": duration
            }
            
        # Timeout handling removed - no longer needed
        except Exception as e:
            print(f"Error during training for {network_size}: {e}")
            return {"success": False, "dataset_dir": "", "model_path": ""}
    
    def run_experiment(self, network_size: str, k_shortest: int, dataset_dir: str, model_path: str) -> Dict:
        """Run a single k_shortest experiment using trained model and fixed dataset"""
        print(f"\nRunning experiment: {network_size} network, k_shortest={k_shortest}")
        if not self.phase2_only:
            print(f"Dataset: {dataset_dir}")
            print(f"Model: {model_path}")
        
        # Set up experiment directory
        exp_name = f"{network_size}_k{k_shortest}"
        exp_dir = self.results_dir / exp_name
        exp_dir.mkdir(exist_ok=True)
        
        # Configure settings for this network size (with dataset dir for phase2_only)
        if self.phase2_only:
            self.modify_p_net_settings(network_size, dataset_dir)
            self.modify_v_sim_settings(network_size, dataset_dir)
        else:
            self.modify_p_net_settings(network_size)
            self.modify_v_sim_settings(network_size)
        
        # Configure for this experiment
        self.modify_config_py(
            k_shortest=k_shortest,
            num_epochs=self.num_test_epochs,  # Do test runs
            num_train_epochs=0,  # Don't retrain - use pretrained model
            use_fixed_dataset=True,
            dir_save_dataset=dataset_dir,
            pretrained_model_path=model_path,
            renew_v_net_simulator=False  # Reuse existing v_nets
        )
        self.modify_main_py(reuse_existing_p=True, reuse_existing_v=True)
        
        # Don't clear previous results in phase2_only mode to avoid 0.0 issue
        if not self.phase2_only:
            self.clear_previous_results()
        
        # Change to the project directory
        os.chdir(self.base_dir)
        
        # Run the experiment with no timeout for phase2_only mode
        start_time = time.time()
        cmd = f"conda run -n {self.conda_env} python -m virne.main"
        
        try:
            print(f"Running command: {cmd}")
            # No timeout - let experiments complete naturally
            result = subprocess.run(
                cmd,
                shell=True,
                capture_output=True,
                text=True
            )
            
            end_time = time.time()
            duration = end_time - start_time
            
            # Save output logs
            with open(exp_dir / "stdout.log", 'w') as f:
                f.write(result.stdout)
            with open(exp_dir / "stderr.log", 'w') as f:
                f.write(result.stderr)
                
            print(f"Process completed with return code: {result.returncode}")
            if result.returncode != 0:
                print("STDERR:", result.stderr[:500])
                
            # Read results from CSV
            csv_results = self.read_results_from_csv()
            
            # Copy the results CSV to experiment directory
            if self.results_csv.exists():
                shutil.copy2(self.results_csv, exp_dir / "global_summary.csv")
            
            experiment_result = {
                "network_size": network_size,
                "k_shortest": k_shortest,
                "acceptance_rate": csv_results["acceptance_rate"],
                "duration": duration,
                "return_code": result.returncode,
                "success": result.returncode == 0 and csv_results["success"],
                "dataset_dir": dataset_dir,
                "model_path": model_path,
                "csv_data": csv_results.get("raw_result", {})
            }
            
            print(f"Result: Acceptance Rate = {csv_results['acceptance_rate']:.4f}, Duration = {duration:.2f}s")
            
        # Timeout handling removed - no longer needed
        except Exception as e:
            print(f"Error running experiment {exp_name}: {e}")
            experiment_result = {
                "network_size": network_size,
                "k_shortest": k_shortest,
                "acceptance_rate": 0.0,
                "duration": 0,
                "return_code": -1,
                "success": False,
                "dataset_dir": dataset_dir,
                "model_path": model_path
            }
        
        # Save individual experiment result
        with open(exp_dir / "result.json", 'w') as f:
            json.dump(experiment_result, f, indent=2)
            
        return experiment_result
    
    def run_phase2_experiments(self):
        """Run phase 2 only - k_shortest ablation experiments using existing trained models"""
        print("Starting K-Shortest Path Ablation Study - Phase 2 Only")
        print(f"K-shortest values: {self.k_shortest_values}")
        print(f"Network sizes: {list(self.trained_models_config.keys())}")
        print(f"Test epochs per experiment: {self.num_test_epochs}")
        
        # Verify models exist
        for network_size, info in self.trained_models_config.items():
            if not os.path.exists(info["model_path"]):
                print(f"ERROR: Model not found for {network_size}: {info['model_path']}")
                return
            if not os.path.exists(info["dataset_dir"]):
                print(f"ERROR: Dataset not found for {network_size}: {info['dataset_dir']}")
                return
            print(f"✓ {network_size}: {info['model_path']}")
        
        # Use the pre-configured trained models
        self.trained_models = self.trained_models_config.copy()
        
        # Run ablation experiments
        total_experiments = len(self.trained_models) * len(self.k_shortest_values)
        current_exp = 0
        
        for network_size in self.trained_models.keys():
            print(f"\n{'='*60}")
            print(f"Running experiments for {network_size.upper()} network")
            print(f"{'='*60}")
            
            dataset_dir = self.trained_models[network_size]["dataset_dir"]
            model_path = self.trained_models[network_size]["model_path"]
            
            for k_shortest in self.k_shortest_values:
                current_exp += 1
                print(f"\n--- Experiment {current_exp}/{total_experiments} ---")
                
                # Run experiment
                result = self.run_experiment(network_size, k_shortest, dataset_dir, model_path)
                self.results_summary.append(result)
                
                # Save intermediate results
                self.save_results_summary()
        
        print(f"\n{'='*60}")
        print("Phase 2 experiments completed!")
        print(f"Results saved to: {self.results_dir}")
        print(f"{'='*60}")
    
    def run_full_study(self):
        """Run the complete ablation study"""
        print("Starting K-Shortest Path Ablation Study - Full Mode")
        print(f"Conda environment: {self.conda_env}")
        print(f"K-shortest values: {self.k_shortest_values}")
        print(f"Network sizes: {list(self.network_configs.keys())}")
        print(f"Training epochs: {self.num_train_epochs}")
        print(f"Test epochs per experiment: {self.num_test_epochs}")
        
        # Phase 1: Train models for each network size
        print(f"\n{'='*80}")
        print("PHASE 1: Training models for each network size")
        print(f"{'='*80}")
        
        for network_size in self.network_configs.keys():
            # Check for existing trained models first
            if network_size in self.trained_models_config:
                info = self.trained_models_config[network_size]
                if os.path.exists(info["model_path"]) and os.path.exists(info["dataset_dir"]):
                    print(f"Using existing trained model for {network_size}")
                    self.trained_models[network_size] = info
                    continue
            
            # Train new model if no existing one found
            training_result = self.train_model_for_network_size(network_size)
            if not training_result["success"]:
                print(f"Failed to train model for {network_size}. Aborting.")
                return
            
            self.trained_models[network_size] = {
                "dataset_dir": training_result["dataset_dir"],
                "model_path": training_result["model_path"]
            }
        
        # Phase 2: Run ablation experiments
        print(f"\n{'='*80}")
        print("PHASE 2: Running k_shortest ablation experiments")
        print(f"{'='*80}")
        
        total_experiments = len(self.network_configs) * len(self.k_shortest_values)
        current_exp = 0
        
        for network_size in self.network_configs.keys():
            print(f"\n{'='*50}")
            print(f"Running experiments for {network_size.upper()} network")
            print(f"Dataset: {self.trained_models[network_size]['dataset_dir']}")
            print(f"Model: {self.trained_models[network_size]['model_path']}")
            print(f"{'='*50}")
            
            dataset_dir = self.trained_models[network_size]["dataset_dir"]
            model_path = self.trained_models[network_size]["model_path"]
            
            for k_shortest in self.k_shortest_values:
                current_exp += 1
                print(f"\nExperiment {current_exp}/{total_experiments}")
                
                # Run experiment with trained model and fixed dataset
                result = self.run_experiment(network_size, k_shortest, dataset_dir, model_path)
                self.results_summary.append(result)
                
                # Save intermediate results
                self.save_results_summary()
                
        print(f"\n{'='*80}")
        print("Full ablation study completed!")
        print(f"Results saved to: {self.results_dir}")
        print(f"{'='*80}")
        
    def save_results_summary(self):
        """Save results summary to CSV and JSON with detailed documentation"""
        # Save as CSV for easy analysis
        df = pd.DataFrame(self.results_summary)
        df.to_csv(self.results_dir / "ablation_results.csv", index=False)
        
        # Save as JSON for detailed data
        with open(self.results_dir / "ablation_results.json", 'w') as f:
            json.dump(self.results_summary, f, indent=2)
            
        # Save trained models info
        with open(self.results_dir / "trained_models.json", 'w') as f:
            json.dump(self.trained_models, f, indent=2)
        
        # Create README explaining the results structure
        readme_content = f"""# Ablation Study Results - Run {self.run_timestamp}

## File Structure:
- **ablation_results.csv**: Main results table with averaged acceptance rates
- **ablation_results.json**: Detailed results in JSON format  
- **trained_models.json**: Paths to trained models used
- **analysis_report.txt**: Summary analysis report
- **plot_results.py**: Script to generate plots
- **{'{network_size}'}_k{'{k_value}'}/**: Individual experiment folders

## Individual Experiment Folders Contain:
- **result.json**: AVERAGED result from {self.num_test_epochs} test runs
- **global_summary.csv**: RAW CSV with ALL {self.num_test_epochs} individual test runs
- **stdout.log**: Command output
- **stderr.log**: Error output (if any)

## Important Notes:
- Each acceptance_rate in ablation_results.csv is the AVERAGE of {self.num_test_epochs} test runs
- global_summary.csv in each experiment folder contains the individual runs
- Same physical network and virtual network requests used for each k_shortest value
- Only k_shortest parameter varies between experiments

## Dataset Sources:
{json.dumps(self.trained_models, indent=2) if self.trained_models else "See trained_models.json"}
"""
        
        with open(self.results_dir / "README.md", 'w') as f:
            f.write(readme_content)
            
        print(f"Saved results: {len(self.results_summary)} experiments")
        
    def generate_analysis_report(self):
        """Generate analysis report"""
        if not self.results_summary:
            print("No results to analyze")
            return
            
        df = pd.DataFrame(self.results_summary)
        
        report = []
        report.append("K-Shortest Path Ablation Study Results")
        report.append("=" * 60)
        report.append("")
        
        if not self.phase2_only:
            # Training summary for full mode
            report.append("Training Summary:")
            for network_size, info in self.trained_models.items():
                report.append(f"  {network_size.upper()}: {info['model_path']}")
            report.append("")
        
        # Summary statistics
        report.append("Summary:")
        report.append(f"Total experiments: {len(df)}")
        report.append(f"Successful experiments: {df['success'].sum()}")
        report.append("")
        
        # Results by network size
        for network in df['network_size'].unique():
            network_df = df[df['network_size'] == network]
            report.append(f"{network.upper()} Network:")
            for _, row in network_df.iterrows():
                status = "✓" if row['success'] else "✗"
                report.append(f"  k={row['k_shortest']:2d}: {row['acceptance_rate']:.4f} {status}")
            report.append("")
            
        report_text = '\n'.join(report)
        print(report_text)
        
        with open(self.results_dir / "analysis_report.txt", 'w') as f:
            f.write(report_text)

    def generate_plotting_script(self):
        """Generate a Python script for plotting the results"""
        plotting_script = '''#!/usr/bin/env python3
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

# Read the results
df = pd.read_csv('ablation_results.csv')

# Set up the plotting style
plt.style.use('seaborn-v0_8')
fig, ax = plt.subplots(1, 1, figsize=(12, 8))

# Plot acceptance rate vs k_shortest for each network size
for network in df['network_size'].unique():
    network_data = df[df['network_size'] == network]
    network_data = network_data.sort_values('k_shortest')
    ax.plot(network_data['k_shortest'], network_data['acceptance_rate'], 
            marker='o', linewidth=2, markersize=8, label=f'{network.title()} Network')

ax.set_xlabel('K-Shortest Parameter', fontsize=14)
ax.set_ylabel('Acceptance Rate', fontsize=14)
ax.set_title('K-Shortest Path Ablation Study Results', fontsize=16)
ax.legend(fontsize=12)
ax.grid(True, alpha=0.3)

# Set x-axis to show all k values
ax.set_xticks(df['k_shortest'].unique())

plt.tight_layout()
plt.savefig('k_shortest_ablation_results.png', dpi=300, bbox_inches='tight')
plt.show()

# Print summary table
print("\\nSummary Table:")
pivot_table = df.pivot_table(values='acceptance_rate', index='k_shortest', columns='network_size', aggfunc='mean')
print(pivot_table)

# Save summary table
pivot_table.to_csv('summary_table.csv')
'''
        
        with open(self.results_dir / "plot_results.py", 'w') as f:
            f.write(plotting_script)
        
        print(f"Plotting script saved to: {self.results_dir / 'plot_results.py'}")

def main():
    """Main function to run the ablation study"""
    parser = argparse.ArgumentParser(description='K-Shortest Path Ablation Study')
    parser.add_argument('--phase2-only', action='store_true', 
                       help='Run phase 2 only using existing trained models')
    parser.add_argument('--base-dir', default='/home/stephen-reilly/dev/virne',
                       help='Base directory for the project')
    parser.add_argument('--network-size', choices=['small', 'medium', 'large'], 
                       help='Run experiments for only this network size')
    
    args = parser.parse_args()
    
    study = AblationStudy(base_dir=args.base_dir, phase2_only=args.phase2_only)
    
    # Filter network sizes if specified
    if args.network_size:
        if args.phase2_only:
            # Filter the pre-configured models
            study.trained_models_config = {args.network_size: study.trained_models_config[args.network_size]}
        else:
            # Filter the network configs for full mode
            study.network_configs = {args.network_size: study.network_configs[args.network_size]}
        print(f"Running experiments for {args.network_size} network only")
    
    try:
        # Backup original configs
        study.backup_original_configs()
        
        if args.phase2_only:
            study.run_phase2_experiments()
        else:
            study.run_full_study()
            
        study.generate_analysis_report()
        study.generate_plotting_script()
        
        print("\nNext steps:")
        print("1. Check the results in:", study.results_dir)
        print("2. Use ablation_results.csv for analysis")
        print("3. Run plot_results.py to generate plots")
        print("4. Check trained_models.json for model paths")
        print("5. Check individual experiment logs in subdirectories")
        print("6. See README.md for detailed explanation of results structure")
        
        # Show all previous runs for reference
        print(f"\nAll ablation runs in {study.results_base_dir}:")
        if study.results_base_dir.exists():
            runs = sorted([d.name for d in study.results_base_dir.iterdir() if d.is_dir() and d.name.startswith("run_")])
            for i, run in enumerate(runs, 1):
                marker = " ← CURRENT" if run == f"run_{study.run_timestamp}" else ""
                print(f"  {i}. {run}{marker}")
        else:
            print("  (No previous runs found)")
        
    except KeyboardInterrupt:
        print("\nInterrupted by user")
        study.restore_original_configs()
    except Exception as e:
        print(f"Error: {e}")
        study.restore_original_configs()
        raise
    finally:
        # Always restore original configs
        study.restore_original_configs()

if __name__ == "__main__":
    main()