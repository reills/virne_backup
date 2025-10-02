#!/usr/bin/env python3
"""
Train K-Specific Models

This script trains separate models for different k_shortest values (k=1, k=2, k=10).
Each model is trained with its specific k value so that the model learns optimal
behavior for that particular k constraint.

Usage:
    python train_k_specific_models.py --k-values 1 2 10 --network-sizes small medium large
    python train_k_specific_models.py --k-values 1 --network-sizes large  # Train only k=1 for large network
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
import fcntl
from pathlib import Path
from typing import Dict, List, Tuple
from datetime import datetime

class KSpecificTrainer:
    def __init__(self, base_dir: str = "/home/stephen-reilly/dev/virne"):
        self.base_dir = Path(base_dir)
        self.config_file = self.base_dir / "virne" / "config.py"
        self.main_file = self.base_dir / "virne" / "main.py"
        self.p_net_settings = self.base_dir / "virne" / "settings" / "p_net_setting.yaml"
        self.v_sim_settings = self.base_dir / "virne" / "settings" / "v_sim_setting.yaml"
        
        self.num_train_epochs = 100
        self.conda_env = "nfv"
        self.solver_name = "a3c_gcn_pre_train_transformer"
        
        # Network configurations for training
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
                    "link_attrs_high": 80,  # Challenging settings
                    "link_attrs_low": 80,
                    "node_attrs_high": 100,
                    "node_attrs_low": 100
                },
                "v_sim": {
                    "v_net_size_low": 7,
                    "v_net_size_high": 7,
                    "node_attrs_low": 30,
                    "node_attrs_high": 30
                }
            }
        }
        
        # Results storage
        timestamp = datetime.now().strftime("%m.%d.%Y_%H%M%S")
        self.run_timestamp = timestamp
        self.results_dir = self.base_dir / "k_specific_training" / f"run_{timestamp}"
        self.results_dir.mkdir(parents=True, exist_ok=True)
        
        self.trained_models = {}  # {network_size}_{k} -> {"dataset_dir": path, "model_path": path}
        self.master_physical_networks = {}  # {network_size} -> dataset_dir with p_net.gml
        
        # File locking for concurrent training
        self.lock_file_path = self.base_dir / "virne" / ".training_lock"
        
        print(f"K-specific training results will be saved to: {self.results_dir}")
        
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
        
    def modify_config_py(self, k_shortest: int, network_size: str, is_first_k: bool, num_train_epochs: int = 100):
        """Modify config.py for k-specific training"""
        with open(self.config_file, 'r') as f:
            content = f.read()
        
        import re
        
        # Set solver name to transformer
        content = re.sub(r"solver_name: str = '[^']*'", f"solver_name: str = '{self.solver_name}'", content)
        
        # Update k_shortest - THIS IS THE KEY CHANGE
        content = re.sub(r'k_shortest: int = \d+', f'k_shortest: int = {k_shortest}', content)
        
        # Configure for training mode
        content = re.sub(r'num_epochs: int = \d+', f'num_epochs: int = 0', content)  # No testing during training
        content = re.sub(r'num_train_epochs: int = \d+', f'num_train_epochs: int = {num_train_epochs}', content)
        content = re.sub(r'renew_v_net_simulator: bool = \w+', f'renew_v_net_simulator: bool = True', content)
        content = re.sub(r"pretrained_model_path: str = '[^']*'", f"pretrained_model_path: str = ''", content)
        
        # Set predictable dataset directory (shared) and k-specific output directory
        master_dataset_dir = f"{self.base_dir}/dataset/{network_size}_master"
        k_specific_output_dir = f"{master_dataset_dir}/output_k{k_shortest}"
        
        # CRITICAL FIX: Always use fixed dataset with master directory
        # The get_run_id() function only uses dir_save_dataset when use_fixed_dataset=True
        content = re.sub(r'use_fixed_dataset: bool = \w+', f'use_fixed_dataset: bool = True', content)
        content = re.sub(r'dir_save_dataset: str = "[^"]*"', f'dir_save_dataset: str = "{master_dataset_dir}"', content)
        
        if is_first_k:
            print(f"  🏗️  Will create new dataset: {master_dataset_dir}")
        else:
            print(f"  🔄 Will reuse existing dataset: {master_dataset_dir}")
        
        # CRITICAL: Set k-specific save_dir to prevent model overwriting
        # Models get saved to: {save_dir}/output/model/model.pkl
        content = re.sub(r'save_dir: str = "[^"]*"', f'save_dir: str = "{k_specific_output_dir}"', content)
        print(f"  📁 Model will be saved to: {k_specific_output_dir}/output/model/model.pkl")
        
        with open(self.config_file, 'w') as f:
            f.write(content)
            
    def modify_main_py(self, reuse_physical: bool = True):
        """Modify main.py to reuse physical networks within same size category"""
        with open(self.main_file, 'r') as f:
            content = f.read()
        
        import re
        pattern = r'Generator\.generate_dataset\(\s*config,\s*p_net=True,\s*v_nets=True,\s*save=True,\s*reuse_existing_p=\w+,\s*reuse_existing_v=\w+\s*\)'
        replacement = f'''Generator.generate_dataset(
        config,
        p_net=True,
        v_nets=True,
        save=True,
        reuse_existing_p={str(reuse_physical)},
        reuse_existing_v=False
    )'''
        
        content = re.sub(pattern, replacement, content, flags=re.MULTILINE | re.DOTALL)
        
        with open(self.main_file, 'w') as f:
            f.write(content)
            
    def modify_p_net_settings(self, network_size: str):
        """Modify p_net_setting.yaml for different network sizes"""
        with open(self.p_net_settings, 'r') as f:
            config = yaml.safe_load(f)
        
        net_config = self.network_configs[network_size]["p_net"]
        
        config["num_nodes"] = net_config["num_nodes"]
        
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
            
    def modify_v_sim_settings(self, network_size: str):
        """Modify v_sim_setting.yaml for different network sizes"""
        with open(self.v_sim_settings, 'r') as f:
            config = yaml.safe_load(f)
        
        net_config = self.network_configs[network_size]["v_sim"]
        
        config["v_net_size"]["low"] = net_config["v_net_size_low"]
        config["v_net_size"]["high"] = net_config["v_net_size_high"]
        
        for attr in config["node_attrs_setting"]:
            if attr["type"] == "resource":
                attr["low"] = net_config["node_attrs_low"]
                attr["high"] = net_config["node_attrs_high"]
        
        with open(self.v_sim_settings, 'w') as f:
            yaml.dump(config, f, default_flow_style=False)
            
    def clear_previous_results(self):
        """Clear previous results for clean training"""
        results_csv = self.base_dir / "save" / "global_summary.csv"
        if results_csv.exists():
            results_csv.unlink()
            
        save_dir = self.base_dir / "save"
        if save_dir.exists():
            for item in save_dir.iterdir():
                if item.is_file() and item.name != '.gitkeep':
                    item.unlink()
                elif item.is_dir():
                    shutil.rmtree(item)
                    
    def find_latest_dataset_dir(self) -> str:
        """Find the latest dataset directory created"""
        dataset_pattern = self.base_dir / "dataset" / "results-*"
        dataset_dirs = glob.glob(str(dataset_pattern))
        
        if not dataset_dirs:
            return ""
        
        dataset_dirs.sort(key=os.path.getctime, reverse=True)
        return dataset_dirs[0]
    
    def find_model_file(self, dataset_dir: str, k_shortest: int = None) -> str:
        """Find the trained model file in the dataset directory"""
        if k_shortest is not None:
            # Look for k-specific model first - check the actual location where models are saved
            k_specific_patterns = [
                os.path.join(dataset_dir, "output", "model", f"model_k{k_shortest}.pkl"),  # New k-specific naming
                os.path.join(dataset_dir, f"output_k{k_shortest}", "output", "model", "model.pkl"),  # Original intended structure
                os.path.join(dataset_dir, f"output_k{k_shortest}", "model", "model.pkl"),
                os.path.join(dataset_dir, f"output_k{k_shortest}", self.solver_name, "model", "model.pkl"),
            ]
            
            for pattern in k_specific_patterns:
                if os.path.exists(pattern):
                    return pattern
        
        # Fallback to original patterns for backward compatibility
        model_patterns = [
            os.path.join(dataset_dir, self.solver_name, "output", "model", "model.pkl"),
            os.path.join(dataset_dir, "output", self.solver_name, "model", "model.pkl"),
            os.path.join(dataset_dir, "output", "model", "model.pkl"),
        ]
        
        for pattern in model_patterns:
            if os.path.exists(pattern):
                return pattern
        
        # Search recursively for k-specific models first, then any model.pkl
        for root, dirs, files in os.walk(dataset_dir):
            for file in files:
                if k_shortest is not None and file == f"model_k{k_shortest}.pkl":
                    return os.path.join(root, file)
                elif file == "model.pkl":
                    return os.path.join(root, file)
        
        return ""
    
    def acquire_config_lock(self):
        """Acquire exclusive lock for config file modifications"""
        self.lock_file = open(self.lock_file_path, 'w')
        try:
            fcntl.flock(self.lock_file.fileno(), fcntl.LOCK_EX | fcntl.LOCK_NB)
            print(f"  🔒 Acquired config lock")
            return True
        except IOError:
            # Lock is held by another process, wait for it
            print(f"  ⏳ Waiting for config lock...")
            fcntl.flock(self.lock_file.fileno(), fcntl.LOCK_EX)  # Blocking wait
            print(f"  🔒 Acquired config lock after waiting")
            return True
    
    def release_config_lock(self):
        """Release the config file lock"""
        if hasattr(self, 'lock_file') and self.lock_file:
            try:
                fcntl.flock(self.lock_file.fileno(), fcntl.LOCK_UN)
                self.lock_file.close()
                print(f"  🔓 Released config lock")
            except:
                pass  # Lock may have already been released
    
    def verify_physical_network_consistency(self, network_size: str, current_dataset_dir: str):
        """Verify that physical networks are identical within same size category"""
        if network_size not in self.master_physical_networks:
            return
            
        master_dataset = self.master_physical_networks[network_size]
        master_p_net = os.path.join(master_dataset, "p_net.gml")
        current_p_net = os.path.join(current_dataset_dir, "p_net.gml")
        
        if os.path.exists(master_p_net) and os.path.exists(current_p_net):
            master_hash = subprocess.run(["md5sum", master_p_net], capture_output=True, text=True).stdout.split()[0]
            current_hash = subprocess.run(["md5sum", current_p_net], capture_output=True, text=True).stdout.split()[0]
            
            if master_hash == current_hash:
                print(f"  ✓ Physical network consistency verified for {network_size}")
            else:
                print(f"  ⚠️  WARNING: Physical networks differ! This invalidates k-value comparison!")
                print(f"    Master: {master_hash}")
                print(f"    Current: {current_hash}")
        else:
            print(f"  ⚠️  Warning: Could not verify physical network consistency")
    
    def train_k_specific_model(self, network_size: str, k_shortest: int, is_first_k_for_size: bool) -> Dict:
        """Train a model for specific network size and k_shortest value"""
        print(f"\n{'='*70}")
        print(f"TRAINING: {network_size.upper()} network with k_shortest={k_shortest}")
        if is_first_k_for_size:
            print(f"  🏗️  Creating NEW physical network for {network_size} category")
        else:
            print(f"  🔄 REUSING physical network from {network_size} category")
        print(f"{'='*70}")
        
        # CRITICAL SECTION: Acquire lock before config modifications
        self.acquire_config_lock()
        
        try:
            # Configure settings for this network size and k value
            self.modify_p_net_settings(network_size) 
            self.modify_v_sim_settings(network_size)
            self.modify_config_py(k_shortest, network_size, is_first_k_for_size, self.num_train_epochs)
            
            # For first k in each network size: create new physical network
            # For subsequent k values: reuse the existing physical network
            reuse_physical = not is_first_k_for_size
            self.modify_main_py(reuse_physical)
            
            # Clear previous results
            self.clear_previous_results()
            
            # Change to the project directory
            os.chdir(self.base_dir)
            
            # Run training
            start_time = time.time()
            cmd = f"conda run -n {self.conda_env} python -m virne.main"
            
            print(f"Starting k={k_shortest} training for {network_size} network...")
            print(f"Command: {cmd}")
            print(f"Training epochs: {self.num_train_epochs}")
            print(f"Expected duration: 10-30 minutes (depending on network size)")
            
            result = subprocess.run(
                cmd,
                shell=True,
                capture_output=True,
                text=True
            )
            
            end_time = time.time()
            duration = end_time - start_time
            
            if result.returncode != 0:
                print(f"Training failed for {network_size} k={k_shortest}:")
                print(result.stderr[:1000])
                return {"success": False, "dataset_dir": "", "model_path": ""}
            
            # Find the dataset directory that was created
            dataset_dir = self.find_latest_dataset_dir()
            if not dataset_dir:
                print(f"Could not find dataset directory for {network_size} k={k_shortest}")
                return {"success": False, "dataset_dir": "", "model_path": ""}
            
            # Store master physical network for this size (first k only)
            if is_first_k_for_size:
                self.master_physical_networks[network_size] = dataset_dir
                print(f"  📁 Saved {network_size} master physical network: {dataset_dir}")
            else:
                # Verify we're using the same dataset directory
                expected_dir = f"{self.base_dir}/dataset/{network_size}_master"
                if dataset_dir != expected_dir:
                    print(f"  ⚠️  Warning: Expected {expected_dir}, got {dataset_dir}")
            
            # Find the trained model (k-specific)
            # First try the expected master directory where models should be saved
            master_dataset_dir = f"{self.base_dir}/dataset/{network_size}_master"
            model_path = self.find_model_file(master_dataset_dir, k_shortest)
            
            # If not found in master, try the temporary dataset directory (fallback)
            if not model_path:
                model_path = self.find_model_file(dataset_dir, k_shortest)
                
            if not model_path:
                print(f"Could not find trained model for {network_size} k={k_shortest}")
                print(f"  Searched in: {master_dataset_dir}")
                print(f"  Also searched in: {dataset_dir}")
                return {"success": False, "dataset_dir": dataset_dir, "model_path": ""}
            
            print(f"✓ Training completed for {network_size} k={k_shortest}:")
            print(f"  Dataset: {dataset_dir}")
            print(f"  Model: {model_path}")
            print(f"  Duration: {duration:.2f}s ({duration/60:.1f} minutes)")
            
            # Verify physical network consistency (for non-first k values) 
            if not is_first_k_for_size:
                expected_master = f"{self.base_dir}/dataset/{network_size}_master"
                if network_size in self.master_physical_networks:
                    self.verify_physical_network_consistency(network_size, dataset_dir)
            
            # Save training logs
            training_dir = self.results_dir / f"training_{network_size}_k{k_shortest}"
            training_dir.mkdir(exist_ok=True)
            
            with open(training_dir / "stdout.log", 'w') as f:
                f.write(result.stdout)
            with open(training_dir / "stderr.log", 'w') as f:
                f.write(result.stderr)
                
            # Save configuration used
            config_info = {
                "network_size": network_size,
                "k_shortest": k_shortest,
                "num_train_epochs": self.num_train_epochs,
                "network_config": self.network_configs[network_size],
                "timestamp": datetime.now().isoformat(),
                "duration_seconds": duration
            }
            
            with open(training_dir / "training_config.json", 'w') as f:
                json.dump(config_info, f, indent=2)
            
            return {
                "success": True,
                "dataset_dir": dataset_dir,
                "model_path": model_path,
                "duration": duration,
                "network_size": network_size,
                "k_shortest": k_shortest
            }
            
        except Exception as e:
            print(f"Error during training for {network_size} k={k_shortest}: {e}")
            return {"success": False, "dataset_dir": "", "model_path": ""}
        finally:
            # Always release the lock, even if training fails
            self.release_config_lock()
    
    def train_multiple_k_models(self, network_sizes: List[str], k_values: List[int], reuse_physical_network: bool = False):
        """Train models for multiple network sizes and k values"""
        print("Starting K-Specific Model Training")
        print(f"Network sizes: {network_sizes}")
        print(f"K values: {k_values}")
        print(f"Training epochs per model: {self.num_train_epochs}")
        print(f"Total models to train: {len(network_sizes) * len(k_values)}")
        
        results = []
        total_models = len(network_sizes) * len(k_values)
        current_model = 0
        
        for network_size in network_sizes:
            # Track which k is first for each network size to manage physical network reuse
            k_values_for_size = sorted(k_values)  # Ensure consistent ordering
            
            for i, k_shortest in enumerate(k_values_for_size):
                current_model += 1
                # If reuse_physical_network flag is set, never create new physical networks
                is_first_k_for_size = (i == 0) and not reuse_physical_network
                
                print(f"\n[{current_model}/{total_models}] Training {network_size} network with k={k_shortest}")
                
                # Train this specific k model
                result = self.train_k_specific_model(network_size, k_shortest, is_first_k_for_size)
                
                if result["success"]:
                    model_key = f"{network_size}_k{k_shortest}"
                    # Use predictable master dataset directory
                    master_dataset_dir = f"{self.base_dir}/dataset/{network_size}_master"
                    self.trained_models[model_key] = {
                        "dataset_dir": master_dataset_dir,
                        "model_path": result["model_path"],
                        "network_size": network_size,
                        "k_shortest": k_shortest,
                        "training_duration": result["duration"]
                    }
                    
                results.append(result)
                
                # Save intermediate results
                self.save_training_summary()
                
        print(f"\n{'='*70}")
        print("K-SPECIFIC TRAINING COMPLETED!")
        print(f"{'='*70}")
        
        successful = sum(1 for r in results if r["success"])
        print(f"Successfully trained: {successful}/{total_models} models")
        print(f"Results saved to: {self.results_dir}")
        
        if successful == total_models:
            print("\n✓ All models trained successfully!")
            print("You can now use test_k_specific_models.py to test these models")
        else:
            print(f"\n⚠ {total_models - successful} models failed to train")
            print("Check the logs in the training subdirectories for details")
            
        return results
    
    def save_training_summary(self):
        """Save summary of trained models"""
        # Save trained models registry
        with open(self.results_dir / "trained_models_registry.json", 'w') as f:
            json.dump(self.trained_models, f, indent=2)
        
        # Create summary table
        summary_data = []
        for model_key, info in self.trained_models.items():
            summary_data.append({
                "model_key": model_key,
                "network_size": info["network_size"],
                "k_shortest": info["k_shortest"],
                "dataset_dir": info["dataset_dir"],
                "model_path": info["model_path"],
                "training_duration_minutes": info["training_duration"] / 60
            })
        
        # Save as JSON and create README
        with open(self.results_dir / "training_summary.json", 'w') as f:
            json.dump(summary_data, f, indent=2)
            
        # Create README
        readme_content = f"""# K-Specific Model Training Results - Run {self.run_timestamp}

## Overview
This directory contains models trained with specific k_shortest values.
Each model was trained from scratch with its corresponding k value.

## Trained Models
Total models: {len(self.trained_models)}

"""
        
        for model_key, info in self.trained_models.items():
            readme_content += f"""### {model_key}
- **Network Size**: {info['network_size']}
- **K-Shortest**: {info['k_shortest']}
- **Dataset**: `{info['dataset_dir']}`
- **Model**: `{info['model_path']}`
- **Training Duration**: {info['training_duration']/60:.1f} minutes

"""
        
        readme_content += f"""
## File Structure
- `trained_models_registry.json`: Complete registry of all trained models
- `training_summary.json`: Summary table of training results
- `training_{{network}}_k{{k}}/`: Individual training logs and configs for each model

## Next Steps
1. Use `test_k_specific_models.py` to test these models
2. Each model should be tested with its corresponding k value
3. Compare results against the previous approach (k=10 training, various k testing)

## Training Configuration
- Training epochs: {self.num_train_epochs}
- Solver: {self.solver_name}
- Conda environment: {self.conda_env}
"""
        
        with open(self.results_dir / "README.md", 'w') as f:
            f.write(readme_content)
            
        print(f"Training summary updated: {len(self.trained_models)} models registered")

def main():
    """Main training function"""
    parser = argparse.ArgumentParser(description='Train K-Specific Models')
    parser.add_argument('--k-values', type=int, nargs='+', default=[1, 2, 10],
                       help='K-shortest values to train models for (default: 1 2 10)')
    parser.add_argument('--network-sizes', choices=['small', 'medium', 'large'], 
                       nargs='+', default=['small', 'medium', 'large'],
                       help='Network sizes to train (default: all)')
    parser.add_argument('--base-dir', default='/home/stephen-reilly/dev/virne',
                       help='Base directory for the project')
    parser.add_argument('--epochs', type=int, default=100,
                       help='Number of training epochs per model (default: 100)')
    parser.add_argument('--reuse-physical-network', action='store_true',
                       help='Reuse existing physical network instead of creating new one (for retraining)')
    
    args = parser.parse_args()
    
    trainer = KSpecificTrainer(base_dir=args.base_dir)
    trainer.num_train_epochs = args.epochs
    
    print("K-Specific Model Training Configuration:")
    print(f"  K values: {args.k_values}")
    print(f"  Network sizes: {args.network_sizes}")
    print(f"  Training epochs per model: {args.epochs}")
    print(f"  Base directory: {args.base_dir}")
    print()
    
    try:
        # Backup original configs
        trainer.backup_original_configs()
        
        # Train all requested models
        results = trainer.train_multiple_k_models(args.network_sizes, args.k_values, args.reuse_physical_network)
        
        print("\nTraining Summary:")
        successful = sum(1 for r in results if r["success"])
        total = len(results)
        print(f"Successfully trained: {successful}/{total} models")
        
        if successful == total:
            print("\n🎉 All models trained successfully!")
            print(f"\nNext step: Use test_k_specific_models.py to test these models")
            print(f"Registry saved to: {trainer.results_dir / 'trained_models_registry.json'}")
        else:
            failed_models = [r for r in results if not r["success"]]
            print(f"\n⚠ {len(failed_models)} models failed:")
            for r in failed_models:
                if 'network_size' in r and 'k_shortest' in r:
                    print(f"  - {r['network_size']} k={r['k_shortest']}")
                    
    except KeyboardInterrupt:
        print("\nTraining interrupted by user")
    except Exception as e:
        print(f"Error during training: {e}")
        raise
    finally:
        # Always restore original configs
        trainer.restore_original_configs()

if __name__ == "__main__":
    main()