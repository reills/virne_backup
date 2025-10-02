#!/usr/bin/env python3
"""
Test SFC Study - Controlled Experiment

Runs controlled experiments to measure how chain length (L) and k-shortest paths (k) 
affect acceptance ratio under different load levels (low/medium/high/random).

Key Controls:
- Same physical network across all tests
- Paired comparison: same VNR set tested across different k-values
- Detailed failure attribution (routing vs CPU)
- Tests k=1 through k=15 comprehensively

Parallel Execution Modes:
- dataset: Run multiple dataset combinations in parallel (each process handles one (load, L, seed) across all k-values)
- k-value: Run individual k-value tests in parallel (maximum parallelization, each process handles one k-value test)

Usage:
    python test_sfc_study.py --registry path/to/sfc_datasets_registry.json
    python test_sfc_study.py --auto-find --k-values 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
    python test_sfc_study.py --quick-test  # Test subset for verification
    
    # Parallel execution examples:
    python test_sfc_study.py --auto-find --parallel 4  # 4 processes, dataset-level parallelization
    python test_sfc_study.py --auto-find --parallel 8 --parallel-mode k-value  # 8 processes, k-value level parallelization
    python test_sfc_study.py --auto-find --parallel 0 --parallel-mode k-value  # Auto-detect cores, k-value parallelization
"""

import os
import sys
import yaml
import json
import shutil
import subprocess
import time
import argparse
import pandas as pd
from pathlib import Path
from typing import Dict, List, Tuple
from datetime import datetime
from multiprocessing import Pool, cpu_count
import multiprocessing as mp

class SFCStudyTester:
    def __init__(self, base_dir: str = "/home/stephen-reilly/dev/virne", create_results_dir: bool = True,
                 shortest_method: str = 'available_k_shortest',
                 fixed_model_path: str | None = None,
                 allow_rejection: bool = True,
                 phase: int = -1):
        self.base_dir = Path(base_dir)
        self.config_file = self.base_dir / "virne" / "config.py"
        self.p_net_settings = self.base_dir / "virne" / "settings" / "p_net_setting.yaml"
        self.v_sim_settings = self.base_dir / "virne" / "settings" / "v_sim_setting.yaml"
        
        self.conda_env = "nfv"
        self.solver_name = "a3c_gcn_pre_train_transformer"
        # Shortest path method used in controller
        self.shortest_method = shortest_method
        # Fixed model override (use same model across k if provided)
        self.fixed_model_path = fixed_model_path
        # Control special actions to reduce policy confounds
        self.allow_rejection = allow_rejection
        # Curriculum/feasibility pruning phase
        self.phase = phase
        
        # Default k-values to test (comprehensive k=1 to k=15)
        self.default_k_values = list(range(1, 16))  # k=1,2,3,...,15
        
        # Results storage
        if create_results_dir:
            timestamp = datetime.now().strftime("%m.%d.%Y_%H%M%S")
            self.results_dir = self.base_dir / "sfc_study_results" / f"experiment_{timestamp}"
            self.results_dir.mkdir(parents=True, exist_ok=True)
            self.results_file = self.results_dir / f"sfc_study_results_{timestamp}.csv"
            print(f"SFC Study Results: {self.results_file}")
        else:
            # For parallel workers - will be set later
            self.results_dir = None
            self.results_file = None
        
        self.test_results = []
        
    def find_latest_sfc_registry(self) -> str:
        """Find the latest SFC datasets registry file"""
        pattern = self.base_dir / "sfc_datasets" / "generation_*" / "sfc_datasets_registry.json"
        import glob
        registry_files = glob.glob(str(pattern))
        if not registry_files:
            return ""
        registry_files.sort(key=os.path.getctime, reverse=True)
        return registry_files[0]
    
    def load_sfc_registry(self, registry_path: str) -> Dict:
        """Load the SFC datasets registry"""
        if not os.path.exists(registry_path):
            raise FileNotFoundError(f"SFC registry file not found: {registry_path}")
            
        with open(registry_path, 'r') as f:
            registry = json.load(f)
            
        print(f"Loaded SFC registry with {len(registry)} datasets")
        
        # Organize datasets by (load_level, L, seed)
        organized = {}
        for key, data in registry.items():
            load_level = data["load_level"]
            
            if load_level == "random":
                # For random load level, use L=0 as placeholder since L is randomized per VNR
                L = 0
            else:
                L = data["L"]
                
            seed = data["seed"]
            
            if load_level not in organized:
                organized[load_level] = {}
            if L not in organized[load_level]:
                organized[load_level][L] = {}
            organized[load_level][L][seed] = data
            
        print(f"Organization: {list(organized.keys())} load levels")
        for load_level, L_dict in organized.items():
            print(f"  {load_level}: L={list(L_dict.keys())}, seeds per L={len(list(L_dict.values())[0]) if L_dict else 0}")
        
        return registry, organized
    
    def find_trained_model_path(self, k_value: int) -> str:
        """Find the trained model path for given k-value"""
        # If fixed model path is specified, always use it (ignore k)
        if self.fixed_model_path:
            if not os.path.exists(self.fixed_model_path):
                raise FileNotFoundError(f"Fixed model file not found: {self.fixed_model_path}")
            return self.fixed_model_path
        # Look for trained models in k_specific_training directories
        pattern = self.base_dir / "k_specific_training" / "run_*" / "trained_models_registry.json"
        import glob
        registry_files = glob.glob(str(pattern))
        
        if not registry_files:
            raise FileNotFoundError("No k-specific trained models registry found")
        
        # Use the latest registry
        registry_files.sort(key=os.path.getctime, reverse=True)
        latest_registry = registry_files[0]
        
        with open(latest_registry, 'r') as f:
            models_registry = json.load(f)
        
        # Look for large network model with this k-value
        model_key = f"large_k{k_value}"
        if model_key not in models_registry:
            raise ValueError(f"No trained model found for k={k_value} on large network")
        
        model_path = models_registry[model_key]["model_path"]
        if not os.path.exists(model_path):
            raise FileNotFoundError(f"Model file not found: {model_path}")
        
        return model_path
    
    def create_temp_pnet_setting(self, dataset_dir: str) -> str:
        """Create a temp p_net_setting.yaml pointing to a dataset directory (no global edits)."""
        import tempfile
        with open(self.p_net_settings, 'r') as f:
            pnet = yaml.safe_load(f)
        pnet['save_dir'] = str(dataset_dir)
        fd, temp_path = tempfile.mkstemp(prefix='p_net_', suffix='.yaml')
        os.close(fd)
        with open(temp_path, 'w') as f:
            yaml.safe_dump(pnet, f, default_flow_style=False)
        return temp_path

    def build_run_config(self, k_value: int, dataset_dir: str, model_path: str, run_dir: str, temp_pnet_path: str) -> str:
        """Create a temp YAML config for virne.main that uses the dataset and isolated run_dir."""
        import tempfile
        v_sim_path = str(Path(dataset_dir) / 'v_sim_setting.yaml')
        cfg = {
            'p_net_setting_path': temp_pnet_path,
            'v_sim_setting_path': v_sim_path,
            'renew_v_net_simulator': False,
            'use_fixed_dataset': True,
            'dir_save_dataset': run_dir,
            'save_dir': run_dir,
            'summary_dir': run_dir,
            'summary_file_name': 'global_summary.csv',
            'solver_name': self.solver_name,
            'shortest_method': self.shortest_method,
            'k_shortest': int(k_value),
            'allow_rejection': bool(self.allow_rejection),
            'curriculum_phase': int(self.phase),
            'num_epochs': 1,
            'num_train_epochs': 0,
            'pretrained_model_path': model_path,
            'verbose': 1,
        }
        fd, temp_cfg = tempfile.mkstemp(prefix='run_', suffix='.yaml')
        os.close(fd)
        with open(temp_cfg, 'w') as f:
            yaml.safe_dump(cfg, f, default_flow_style=False)
        return temp_cfg

    def parse_results_from_run_dir(self, run_dir: str) -> Dict:
        """Parse acceptance ratio from run_dir, falling back to global_summary.csv if needed."""
        run_path = Path(run_dir)
        # Prefer detailed records CSV if present
        record_csvs = list(run_path.glob(f"{self.solver_name}-*.csv"))
        if record_csvs:
            latest_csv = max(record_csvs, key=os.path.getctime)
            try:
                df = pd.read_csv(latest_csv)
                if len(df) == 0:
                    return {"success": False, "error": "Empty CSV file"}
                final_row = df.iloc[-1]
                v_net_count = int(final_row.get('v_net_count', 0))
                success_count = int(final_row.get('success_count', 0))
                acceptance_ratio = (success_count / v_net_count) if v_net_count > 0 else 0.0
                failure_info = {}
                if 'total_failed' in final_row:
                    failure_info['total_failed'] = int(final_row['total_failed'])
                    for col in final_row.index:
                        if 'fail' in str(col).lower() and col != 'total_failed':
                            try:
                                failure_info[col] = int(final_row[col])
                            except Exception:
                                pass
                return {
                    'success': True,
                    'v_net_count': v_net_count,
                    'success_count': success_count,
                    'acceptance_ratio': acceptance_ratio,
                    'failure_info': failure_info,
                    'csv_file': str(latest_csv),
                }
            except Exception as e:
                return {"success": False, "error": f"Error parsing CSV: {e}"}

        # Fallback: parse global_summary.csv
        summary_path = run_path / 'global_summary.csv'
        if not summary_path.exists():
            return {"success": False, "error": "No CSV results file found (records or global_summary)"}
        try:
            sdf = pd.read_csv(summary_path)
            if len(sdf) == 0:
                return {"success": False, "error": "Empty global_summary.csv"}
            last = sdf.iloc[-1]
            acceptance_ratio = float(last.get('acceptance_rate', 0.0))
            success_count = int(last.get('success_count', 0))
            # v_net_count may not be recorded in summary; estimate if possible
            v_net_count = 0
            if acceptance_ratio > 0:
                est = success_count / acceptance_ratio
                try:
                    v_net_count = int(round(est))
                except Exception:
                    v_net_count = 0
            return {
                'success': True,
                'v_net_count': v_net_count,
                'success_count': success_count,
                'acceptance_ratio': acceptance_ratio,
                'failure_info': {},
                'csv_file': str(summary_path),
            }
        except Exception as e:
            return {"success": False, "error": f"Error parsing global_summary.csv: {e}"}
    
    def modify_config_py(self, k_value: int, dataset_dir: str, model_path: str, process_config_file: str = None):
        """Modify config.py for testing specific k-value"""
        # Always create a backup of original config.py if it doesn't exist
        backup_config = str(self.config_file) + '.backup'
        if not os.path.exists(backup_config):
            shutil.copy2(self.config_file, backup_config)
        
        # Use process-specific config file if provided, otherwise create temp file
        if process_config_file:
            config_file_to_use = process_config_file
        else:
            # For sequential mode, use a temporary config file
            import tempfile
            fd, config_file_to_use = tempfile.mkstemp(suffix='_config.py', dir=os.path.dirname(self.config_file))
            os.close(fd)
        
        # Read original content
        with open(backup_config, 'r') as f:
            content = f.read()
        
        import re
        
        # Testing mode configuration
        content = re.sub(r"solver_name: str = '[^']*'", f"solver_name: str = '{self.solver_name}'", content)
        content = re.sub(r'k_shortest: int = \d+', f'k_shortest: int = {k_value}', content)
        content = re.sub(r'num_epochs: int = \d+', f'num_epochs: int = 1', content)  # Single test epoch
        content = re.sub(r'num_train_epochs: int = \d+', f'num_train_epochs: int = 0', content)
        content = re.sub(r'renew_v_net_simulator: bool = \w+', f'renew_v_net_simulator: bool = False', content)  # CRITICAL: reuse VNRs
        content = re.sub(r'use_fixed_dataset: bool = \w+', f'use_fixed_dataset: bool = True', content)
        content = re.sub(r'dir_save_dataset: str = "[^"]*"', f'dir_save_dataset: str = "{dataset_dir}"', content)
        content = re.sub(r'save_dir: str = "[^"]*"', f'save_dir: str = "{dataset_dir}"', content)
        content = re.sub(r"pretrained_model_path: str = '[^']*'", f"pretrained_model_path: str = '{model_path}'", content)
        
        # Point to process-specific v_sim_setting.yaml if using parallel processing
        v_sim_path = str(self.v_sim_settings).replace('\\', '/')
        content = re.sub(
            r"v_sim_setting_path: str = os\.path\.join\(os\.path\.dirname\(os\.path\.abspath\(__file__\)\), 'settings/v_sim_setting\.yaml'\)",
            f"v_sim_setting_path: str = '{v_sim_path}'",
            content
        )
        
        with open(config_file_to_use, 'w') as f:
            f.write(content)
        
        # Copy temporary config to main config.py for virne to use
        if not process_config_file:
            shutil.copy2(config_file_to_use, self.config_file)
            # Clean up temp file
            try:
                os.remove(config_file_to_use)
            except:
                pass
        
        return config_file_to_use
    
    def modify_p_net_settings(self, dataset_dir: str):
        """Modify p_net_setting.yaml to point to dataset directory"""
        with open(self.p_net_settings, 'r') as f:
            config = yaml.safe_load(f)
        
        config["save_dir"] = str(dataset_dir)
        
        with open(self.p_net_settings, 'w') as f:
            yaml.dump(config, f, default_flow_style=False)
    
    def modify_v_sim_settings(self, dataset_dir: str, process_specific_config: str = None):
        """Copy dataset-specific v_sim_setting.yaml to shared location (or process-specific location)"""
        import shutil
        dataset_path = Path(dataset_dir)
        dataset_config = dataset_path / "v_sim_setting.yaml"
        
        # Use process-specific config path if provided (for parallel processing)
        target_config = Path(process_specific_config) if process_specific_config else self.v_sim_settings
        
        if dataset_config.exists():
            # Use the dataset-specific config (has correct resources)
            shutil.copy2(dataset_config, target_config)
            print(f"    Using dataset-specific config: {dataset_config} -> {target_config}")
        else:
            # Fallback: modify shared config to point to dataset directory
            with open(self.v_sim_settings, 'r') as f:
                config = yaml.safe_load(f)
            config["save_dir"] = str(dataset_dir)
            with open(target_config, 'w') as f:
                yaml.dump(config, f, default_flow_style=False)
            print(f"    Using shared config, pointing to: {dataset_dir}")
    
    def parse_results_from_csv(self, dataset_dir: str) -> Dict:
        """Parse results from the latest CSV file in dataset directory"""
        dataset_path = Path(dataset_dir)
        
        # Find the latest CSV file with solver name
        csv_pattern = f"{self.solver_name}-*.csv"
        csv_files = list(dataset_path.glob(csv_pattern))
        
        if not csv_files:
            return {"success": False, "error": "No CSV results file found"}
        
        # Get the most recent CSV file
        latest_csv = max(csv_files, key=os.path.getctime)
        
        try:
            df = pd.read_csv(latest_csv)
            if len(df) == 0:
                return {"success": False, "error": "Empty CSV file"}
            
            # Get the final row for cumulative results
            final_row = df.iloc[-1]
            
            v_net_count = int(final_row['v_net_count'])
            success_count = int(final_row['success_count'])
            
            # Calculate acceptance ratio
            if v_net_count > 0:
                acceptance_ratio = success_count / v_net_count
            else:
                acceptance_ratio = 0.0
            
            # Parse failure causes if available
            failure_info = {}
            if 'total_failed' in final_row:
                total_failed = int(final_row['total_failed'])
                failure_info['total_failed'] = total_failed
                
                # Look for specific failure types
                for col in final_row.index:
                    if 'fail' in col.lower() and col != 'total_failed':
                        failure_info[col] = int(final_row[col])
            
            return {
                "success": True,
                "v_net_count": v_net_count,
                "success_count": success_count,
                "acceptance_ratio": acceptance_ratio,
                "failure_info": failure_info,
                "csv_file": str(latest_csv)
            }
            
        except Exception as e:
            return {"success": False, "error": f"Error parsing CSV: {e}"}
    
    def test_single_combination(self, load_level: str, L: int, seed: int, k_value: int, 
                               dataset_info: Dict, model_path: str) -> Dict:
        """Test a single (load_level, L, seed, k) combination"""
        dataset_dir = dataset_info["dataset_dir"]
        
        print(f"    Testing k={k_value}... ", end="", flush=True)
        
        try:
            # Create isolated run dir and temp configs
            pid = os.getpid()
            if load_level == "random":
                run_dir = str(Path(dataset_dir) / 'experiments' / 'random' / f'seed_{seed}' / f'k_{k_value}' / f'pid_{pid}')
            else:
                run_dir = str(Path(dataset_dir) / 'experiments' / f'L{L}' / f'seed_{seed}' / f'k_{k_value}' / f'pid_{pid}')
            # Ensure run directory exists
            Path(run_dir).mkdir(parents=True, exist_ok=True)
            # Create temp configs
            temp_pnet = self.create_temp_pnet_setting(dataset_dir)
            temp_cfg = self.build_run_config(k_value, dataset_dir, model_path, run_dir, temp_pnet)

            # Run the test using external config and skipping regeneration
            os.chdir(self.base_dir)
            cmd = f"conda run -n {self.conda_env} python -m virne.main --config {temp_cfg} --skip-generate"
            
            start_time = time.time()
            result = subprocess.run(cmd, shell=True, capture_output=True, text=True)
            duration = time.time() - start_time
            
            if result.returncode != 0:
                print(f"FAILED")
                return {
                    "success": False,
                    "error": f"Subprocess failed: {result.stderr[:100]}",
                    "duration": duration
                }
            
            # Parse results from the run directory
            parsed_results = self.parse_results_from_run_dir(run_dir)
            if not parsed_results["success"]:
                print(f"FAILED")
                return {
                    "success": False,
                    "error": parsed_results["error"],
                    "duration": duration
                }
            
            acceptance_ratio = parsed_results["acceptance_ratio"]
            print(f"AR={acceptance_ratio:.4f}")
            
            return {
                "success": True,
                "load_level": load_level,
                "L": L,
                "seed": seed,
                "k_value": k_value,
                "acceptance_ratio": acceptance_ratio,
                "v_net_count": parsed_results["v_net_count"],
                "success_count": parsed_results["success_count"],
                "failure_info": parsed_results["failure_info"],
                "duration": duration,
                "dataset_dir": dataset_dir,
                "model_path": model_path,
                "csv_file": parsed_results["csv_file"],
                "run_dir": run_dir
            }
            
        except Exception as e:
            print(f"ERROR")
            return {
                "success": False,
                "error": str(e),
                "duration": time.time() - start_time if 'start_time' in locals() else 0
            }
        finally:
            # Cleanup temporary files
            try:
                if 'temp_cfg' in locals() and os.path.exists(temp_cfg):
                    os.remove(temp_cfg)
            except Exception:
                pass
            try:
                if 'temp_pnet' in locals() and os.path.exists(temp_pnet):
                    os.remove(temp_pnet)
            except Exception:
                pass
    
    def test_dataset_combination(self, load_level: str, L: int, seed: int, 
                                dataset_info: Dict, k_values: List[int]) -> List[Dict]:
        """Test all k-values for a single (load_level, L, seed) dataset - PAIRED COMPARISON"""
        print(f"\n{'='*60}")
        if load_level == "random":
            print(f"TESTING: PNC_{load_level}/seed{seed}")
        else:
            print(f"TESTING: PNC_{load_level}/L{L}/seed{seed}")
        print(f"Dataset: {dataset_info['dataset_dir']}")
        print(f"Resources: {dataset_info['resources']}")
        print(f"VNRs: {dataset_info['num_vnrs']}")
        print(f"Testing k-values: {k_values}")
        print(f"{'='*60}")
        
        # Verify dataset exists
        dataset_dir = Path(dataset_info["dataset_dir"])
        if not dataset_dir.exists():
            print(f"ERROR: Dataset directory not found: {dataset_dir}")
            return []
        
        # Check for required files
        required_files = [
            dataset_dir / "p_net.gml",
            dataset_dir / "v_nets",
            dataset_dir / "events.yaml",
            dataset_dir / "v_sim_setting.yaml"
        ]
        
        missing_files = [f for f in required_files if not f.exists()]
        if missing_files:
            print(f"ERROR: Missing required files: {[str(f) for f in missing_files]}")
            return []
        
        # Test each k-value with the SAME VNR set
        combination_results = []
        
        for k_value in k_values:
            try:
                # Get trained model for this k-value
                model_path = self.find_trained_model_path(k_value)
                
                # Test this k-value
                result = self.test_single_combination(load_level, L, seed, k_value, dataset_info, model_path)
                combination_results.append(result)
                
                # Save intermediate results
                self.test_results.extend([result])
                self.save_results()
                
            except Exception as e:
                print(f"    Testing k={k_value}... ERROR: {e}")
                error_result = {
                    "success": False,
                    "load_level": load_level,
                    "L": L,
                    "seed": seed,
                    "k_value": k_value,
                    "error": str(e)
                }
                combination_results.append(error_result)
                self.test_results.append(error_result)
        
        # Print summary for this combination
        successful_tests = [r for r in combination_results if r.get("success", False)]
        if successful_tests:
            print(f"\nSUMMARY for PNC_{load_level}/L{L}/seed{seed}:")
            for result in successful_tests:
                k = result["k_value"]
                ar = result["acceptance_ratio"]
                print(f"  k={k}: {ar:.4f} acceptance ratio")
        else:
            print(f"\nAll tests failed for PNC_{load_level}/L{L}/seed{seed}")
        
        return combination_results
    
    def run_sfc_study(self, organized_datasets: Dict, k_values: List[int], 
                     test_loads: List[str] = None, test_lengths: List[int] = None):
        """Run the complete SFC study experiment"""
        print(f"SFC Study Experiment Configuration:")
        print(f"  K-values to test: {k_values}")
        print(f"  Test loads: {test_loads or 'all'}")
        print(f"  Test lengths: {test_lengths or 'all'}")
        print()
        
        # Verify all required models exist
        print("Verifying trained models...")
        for k_value in k_values:
            try:
                model_path = self.find_trained_model_path(k_value)
                print(f"  ✓ k={k_value}: {model_path}")
            except Exception as e:
                print(f"  ✗ k={k_value}: {e}")
                raise
        print()
        
        # Count total test combinations
        total_datasets = 0
        for load_level, L_dict in organized_datasets.items():
            if test_loads and load_level not in test_loads:
                continue
            for L, seed_dict in L_dict.items():
                if test_lengths and L not in test_lengths:
                    continue
                total_datasets += len(seed_dict)
        
        total_tests = total_datasets * len(k_values)
        print(f"Total dataset combinations: {total_datasets}")
        print(f"Total individual tests: {total_tests}")
        print()
        
        # Run experiments
        current_dataset = 0
        all_results = []
        
        for load_level in sorted(organized_datasets.keys()):
            if test_loads and load_level not in test_loads:
                continue
                
            for L in sorted(organized_datasets[load_level].keys()):
                if test_lengths and L not in test_lengths:
                    continue
                    
                for seed in sorted(organized_datasets[load_level][L].keys()):
                    current_dataset += 1
                    dataset_info = organized_datasets[load_level][L][seed]
                    
                    if load_level == "random":
                        print(f"\n[{current_dataset}/{total_datasets}] Processing PNC_{load_level}/seed{seed}")
                    else:
                        print(f"\n[{current_dataset}/{total_datasets}] Processing PNC_{load_level}/L{L}/seed{seed}")
                    
                    # Test all k-values for this dataset (PAIRED COMPARISON)
                    combination_results = self.test_dataset_combination(
                        load_level, L, seed, dataset_info, k_values
                    )
                    
                    all_results.extend(combination_results)
        
        print(f"\n{'='*70}")
        print("SFC STUDY EXPERIMENT COMPLETED")
        print(f"{'='*70}")
        
        successful_tests = sum(1 for r in all_results if r.get("success", False))
        print(f"Completed tests: {successful_tests}/{total_tests}")
        
        if successful_tests == total_tests:
            print("\n✓ All tests completed successfully!")
        else:
            failed_tests = total_tests - successful_tests
            print(f"\n⚠️ {failed_tests} tests failed")
        
        self.test_results = all_results
        self.save_results()
        self.print_summary()
        
        return all_results
    
    def save_results(self):
        """Save test results to CSV file"""
        if not self.test_results:
            return
        
        # Convert results to DataFrame
        df = pd.DataFrame(self.test_results)
        
        # Reorder columns for clarity
        base_columns = [
            'load_level', 'L', 'seed', 'k_value', 'acceptance_ratio',
            'v_net_count', 'success_count', 'success'
        ]
        
        # Add any additional columns
        all_columns = df.columns.tolist()
        additional_columns = [col for col in all_columns if col not in base_columns]
        ordered_columns = base_columns + additional_columns
        
        # Filter to existing columns only
        final_columns = [col for col in ordered_columns if col in df.columns]
        df = df[final_columns]
        
        # Save to CSV
        df.to_csv(self.results_file, index=False)
        print(f"Results saved to: {self.results_file}")
    
    def print_summary(self):
        """Print experiment summary"""
        print(f"\n{'='*60}")
        print("SFC STUDY EXPERIMENT SUMMARY")
        print(f"{'='*60}")
        
        successful_results = [r for r in self.test_results if r.get("success", False)]
        failed_results = [r for r in self.test_results if not r.get("success", False)]
        
        print(f"Total tests: {len(self.test_results)}")
        print(f"Successful: {len(successful_results)}")
        print(f"Failed: {len(failed_results)}")
        
        if successful_results:
            # Organize by load_level and L
            by_load_L = {}
            for result in successful_results:
                load_level = result["load_level"]
                L = result["L"]
                key = f"PNC_{load_level}_L{L}"
                if key not in by_load_L:
                    by_load_L[key] = []
                by_load_L[key].append(result)
            
            print(f"\nACCEPTANCE RATIO SUMMARY:")
            for key, results in sorted(by_load_L.items()):
                print(f"\n{key}:")
                
                # Group by k-value
                by_k = {}
                for r in results:
                    k = r["k_value"]
                    if k not in by_k:
                        by_k[k] = []
                    by_k[k].append(r["acceptance_ratio"])
                
                for k in sorted(by_k.keys()):
                    ratios = by_k[k]
                    avg_ratio = sum(ratios) / len(ratios)
                    print(f"  k={k}: {avg_ratio:.4f} (avg over {len(ratios)} seeds)")
        
        if failed_results:
            print(f"\nFAILED TESTS:")
            failure_counts = {}
            for result in failed_results:
                error = result.get("error", "Unknown error")[:50]
                if error not in failure_counts:
                    failure_counts[error] = 0
                failure_counts[error] += 1
            
            for error, count in failure_counts.items():
                print(f"  {count}x: {error}")
        
        print(f"\nResults saved to: {self.results_file}")

def test_single_dataset_parallel(args_tuple):
    """Wrapper function for parallel testing of a single dataset combination"""
    (load_level, L, seed, dataset_info, k_values, base_dir, results_file_base, shortest_method, fixed_model_path, allow_rejection, phase) = args_tuple
    
    # Create a separate tester instance for this process (no results dir)
    tester = SFCStudyTester(base_dir=base_dir, create_results_dir=False, shortest_method=shortest_method,
                            fixed_model_path=fixed_model_path, allow_rejection=allow_rejection, phase=phase)
    
    # Create process-specific files to avoid race conditions
    pid = os.getpid()
    process_results_file = Path(results_file_base).parent / f"temp_results_{pid}.csv"
    
    tester.results_file = process_results_file
    tester.test_results = []
    
    print(f"[PID {pid}] Testing PNC_{load_level}/L{L}/seed{seed}")
    
    try:
        # Test this dataset combination
        combination_results = tester.test_dataset_combination(load_level, L, seed, dataset_info, k_values)
        
        # Save results
        tester.test_results = combination_results
        tester.save_results()
        
        return combination_results, str(process_results_file)
    
    finally:
        pass

def test_single_k_parallel(args_tuple):
    """Wrapper function for parallel testing of individual k-values"""
    (load_level, L, seed, k_value, dataset_info, model_path, base_dir, results_file_base, shortest_method, fixed_model_path, allow_rejection, phase) = args_tuple
    pid = os.getpid()
    print(f"[PID {pid}] Testing PNC_{load_level}/L{L}/seed{seed}/k{k_value}")

    # Create a tester instance pointing to main base_dir (no results dir)
    tester = SFCStudyTester(base_dir=base_dir, create_results_dir=False, shortest_method=shortest_method,
                            fixed_model_path=fixed_model_path, allow_rejection=allow_rejection, phase=phase)

    # Use main results directory for combined outputs
    main_results_dir = Path(results_file_base).parent
    process_results_file = main_results_dir / f"temp_results_{load_level}_L{L}_seed_{seed}_k{k_value}_{pid}.csv"
    tester.results_dir = main_results_dir
    tester.results_file = process_results_file
    tester.test_results = []

    # Execute this single k-value test
    result = tester.test_single_combination(load_level, L, seed, k_value, dataset_info, model_path)

    # Save results
    tester.test_results = [result]
    tester.save_results()

    return result, str(process_results_file)

def run_parallel_experiment(tester, organized_datasets, k_values, test_loads, test_lengths, num_processes):
    """Run experiment with parallel processing at dataset level"""
    # Collect all dataset combinations to process
    tasks = []
    
    for load_level in sorted(organized_datasets.keys()):
        if test_loads and load_level not in test_loads:
            continue
            
        for L in sorted(organized_datasets[load_level].keys()):
            if test_lengths and L not in test_lengths:
                continue
                
            for seed in sorted(organized_datasets[load_level][L].keys()):
                dataset_info = organized_datasets[load_level][L][seed]
                tasks.append((load_level, L, seed, dataset_info, k_values, str(tester.base_dir), str(tester.results_file), tester.shortest_method, tester.fixed_model_path, tester.allow_rejection, tester.phase))
    
    print(f"Running {len(tasks)} dataset combinations across {num_processes} processes (dataset-level parallelization)")
    
    # Run tasks in parallel
    with Pool(processes=num_processes) as pool:
        parallel_results = pool.map(test_single_dataset_parallel, tasks)
    
    # Collect and merge results
    all_results = []
    temp_files = []
    
    for results, temp_file in parallel_results:
        all_results.extend(results)
        temp_files.append(temp_file)
    
    # Update main tester with combined results
    tester.test_results = all_results
    tester.save_results()
    tester.print_summary()
    
    # Clean up temporary files
    for temp_file in temp_files:
        try:
            os.remove(temp_file)
        except:
            pass
    
    return all_results

def run_k_parallel_experiment(tester, organized_datasets, k_values, test_loads, test_lengths, num_processes):
    """Run experiment with parallel processing at individual k-value level"""
    # Pre-load all model paths to avoid race conditions
    print("Pre-loading model paths for all k-values...")
    k_model_paths = {}
    for k_value in k_values:
        try:
            k_model_paths[k_value] = tester.find_trained_model_path(k_value)
            print(f"  ✓ k={k_value}: {k_model_paths[k_value]}")
        except Exception as e:
            print(f"  ✗ k={k_value}: {e}")
            raise
    
    # Collect all individual k-value tasks
    tasks = []
    
    for load_level in sorted(organized_datasets.keys()):
        if test_loads and load_level not in test_loads:
            continue
            
        for L in sorted(organized_datasets[load_level].keys()):
            if test_lengths and L not in test_lengths:
                continue
                
            for seed in sorted(organized_datasets[load_level][L].keys()):
                dataset_info = organized_datasets[load_level][L][seed]
                
                # Create a task for each k-value
                for k_value in k_values:
                    model_path = k_model_paths[k_value]
                    tasks.append((load_level, L, seed, k_value, dataset_info, model_path, str(tester.base_dir), str(tester.results_file), tester.shortest_method, tester.fixed_model_path, tester.allow_rejection, tester.phase))
    
    print(f"Running {len(tasks)} individual k-value tests across {num_processes} processes (k-level parallelization)")
    print(f"This is {len(tasks)//len(k_values)} datasets × {len(k_values)} k-values")
    
    # Run tasks in parallel
    with Pool(processes=num_processes) as pool:
        parallel_results = pool.map(test_single_k_parallel, tasks)
    
    # Collect and merge results
    all_results = []
    temp_files = []
    
    for result, temp_file in parallel_results:
        all_results.append(result)
        temp_files.append(temp_file)
    
    # Update main tester with combined results
    tester.test_results = all_results
    tester.save_results()
    tester.print_summary()
    
    # Clean up temporary files
    for temp_file in temp_files:
        try:
            os.remove(temp_file)
        except:
            pass
    
    return all_results

def main():
    """Main testing function"""
    parser = argparse.ArgumentParser(description='Test SFC Study - Controlled Experiment')
    parser.add_argument('--registry', type=str, help='Path to sfc_datasets_registry.json')
    parser.add_argument('--auto-find', action='store_true', help='Auto-find latest SFC registry')
    parser.add_argument('--k-values', type=int, nargs='+', default=list(range(1, 16)),
                       help='K-values to test (default: 1 2 3 ... 15)')
    parser.add_argument('--loads', choices=['low', 'medium', 'high', 'random'], nargs='+',
                       help='Specific load levels to test (default: all)')
    parser.add_argument('--lengths', type=int, nargs='+',
                       help='Specific chain lengths to test (default: all)')
    parser.add_argument('--base-dir', default='/home/stephen-reilly/dev/virne',
                       help='Base directory for the project')
    parser.add_argument('--quick-test', action='store_true',
                       help='Quick test: L={2,5,10}, k={1,5,10,15} only')
    parser.add_argument('--parallel', type=int, default=1,
                       help='Number of parallel processes (default: 1, use 0 for auto-detect)')
    parser.add_argument('--parallel-mode', choices=['dataset', 'k-value'], default='dataset',
                       help='Parallelization strategy: dataset (parallel datasets) or k-value (parallel k-values within datasets)')
    parser.add_argument('--shortest-method', choices=['k_shortest', 'available_k_shortest', 'first_shortest', 'all_shortest', 'available_shortest'],
                       default='available_k_shortest', help='Shortest path method for routing (default: available_k_shortest)')
    parser.add_argument('--fixed-model-path', type=str, default=None,
                       help='Use a single fixed pretrained model for all k-values (overrides per-k model lookup)')
    parser.add_argument('--no-rejection', action='store_true',
                       help='Disable rejection during testing to reduce policy confounds')
    parser.add_argument('--phase', type=int, default=-1,
                       help='Curriculum phase (-1=off, 0=enable feasibility pruning)')
    
    args = parser.parse_args()
    
    if not args.registry and not args.auto_find:
        print("Error: Must specify --registry or --auto-find")
        sys.exit(1)
    
    if args.quick_test:
        args.k_values = [1, 5, 10, 15]
        args.lengths = [2, 5, 10]
        print("Quick test mode: k={1,5,10,15}, L={2,5,10}")
    
    # Handle parallel processes
    if args.parallel == 0:
        args.parallel = min(cpu_count(), 8)  # Auto-detect, max 8 processes
        print(f"Auto-detected {args.parallel} parallel processes")
    
    tester = SFCStudyTester(
        base_dir=args.base_dir,
        shortest_method=args.shortest_method,
        fixed_model_path=args.fixed_model_path,
        allow_rejection=not args.no_rejection,
        phase=args.phase,
    )
    
    try:
        # Find or load registry
        if args.auto_find:
            registry_path = tester.find_latest_sfc_registry()
            if not registry_path:
                print("Error: No SFC registry found. Run generate_sfc_datasets.py first.")
                sys.exit(1)
        else:
            registry_path = args.registry
        
        print(f"Loading SFC datasets registry: {registry_path}")
        raw_registry, organized_datasets = tester.load_sfc_registry(registry_path)
        
        print(f"Configuration:")
        print(f"  K-values: {args.k_values}")
        print(f"  Loads: {args.loads or 'all'}")
        print(f"  Lengths: {args.lengths or 'all'}")
        print(f"  Parallel processes: {args.parallel}")
        print(f"  Parallel mode: {args.parallel_mode}")
        print(f"  Shortest method: {args.shortest_method}")
        print(f"  Fixed model: {args.fixed_model_path or 'none'}")
        print(f"  Allow rejection: {not args.no_rejection}")
        print(f"  Phase: {args.phase}")
        print()
        
        # Run the experiment (parallel or sequential)
        if args.parallel > 1:
            if args.parallel_mode == 'k-value':
                results = run_k_parallel_experiment(
                    tester, organized_datasets, args.k_values,
                    args.loads, args.lengths, args.parallel
                )
            else:  # dataset mode
                results = run_parallel_experiment(
                    tester, organized_datasets, args.k_values,
                    args.loads, args.lengths, args.parallel
                )
        else:
            results = tester.run_sfc_study(
                organized_datasets, 
                args.k_values,
                test_loads=args.loads,
                test_lengths=args.lengths
            )
        
    except KeyboardInterrupt:
        print("\nExperiment interrupted by user")
    except Exception as e:
        print(f"Error: {e}")
        raise

if __name__ == "__main__":
    main()
