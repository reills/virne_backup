#!/usr/bin/env python3
"""
Generate SFC Study Datasets

Creates datasets for Service Function Chain length study using the existing VNR generation system.
Tests L={2,3,4,5,6,7,8,9,10} chain lengths under PNC regime with multiple load levels.

PNC (Per-Node Constant): per-VNF CPU fixed, total CPU scales with L
Load levels: low, medium, high (affecting arrival rate and resource constraints)

Directory structure:
/dataset/large/
  PNC_low/size_{L}/seed_{S}/
  PNC_medium/size_{L}/seed_{S}/
  PNC_high/size_{L}/seed_{S}/

Usage:
    python generate_sfc_datasets.py --lengths 2 3 4 5 6 7 8 9 10 --loads low medium high
    python generate_sfc_datasets.py --quick-test  # Generate L={2,5,10} only
"""

import os
import sys
import yaml
import json
import shutil
import time
import argparse
from pathlib import Path
from typing import Dict, List, Tuple
from datetime import datetime

# Direct import of virne components
from virne import Config, Generator

def _dataset_worker(args: Tuple[int, str, int, str, int, int]) -> Dict:
    """Worker function for parallel dataset generation"""
    L, load_level, seed, base_dir, vnrs_per_seed, num_seeds = args
    g = SFCDatasetGenerator(base_dir=base_dir)
    g.num_vnrs_per_seed = vnrs_per_seed
    g.num_seeds = num_seeds
    # Do not call ensure_master_physical_network here; parent already ensured it
    return g.generate_dataset_combination(L, load_level, seed)

class SFCDatasetGenerator:
    def __init__(self, base_dir: str = "/home/stephen-reilly/dev/virne"):
        self.base_dir = Path(base_dir)
        # No longer need to modify config.py or main.py
        self.p_net_settings_template = self.base_dir / "virne" / "settings" / "p_net_setting.yaml"
        self.v_sim_settings_template = self.base_dir / "virne" / "settings" / "v_sim_setting.yaml"
        
        self.num_vnrs_per_seed = 1000
        self.num_seeds = 2
        
        self.network_config = {
            "p_net": {
                "num_nodes": 100,
                "link_attrs_high": 80,
                "link_attrs_low": 80,
                "node_attrs_high": 100,
                "node_attrs_low": 100
            }
        }
        
        self.load_levels = {
            "low":    { "base_cpu_per_vnf": 20, "bandwidth": 10   },
            "medium": { "base_cpu_per_vnf": 25, "bandwidth": 14  },
            "high":   { "base_cpu_per_vnf": 30, "bandwidth": 18  },
            "random": { 
                "cpu_low": 15, "cpu_high": 40, 
                "bandwidth_low": 10, "bandwidth_high": 22,
                "length_low": 3, "length_high": 10
            }
        }
        
        self.fixed_lam = 20.0
        
        self.master_p_net_dir = self.base_dir / "dataset" / "large_master"
        
        timestamp = datetime.now().strftime("%m.%d.%Y_%H%M%S")
        self.results_dir = self.base_dir / "sfc_datasets" / f"generation_{timestamp}"
        self.results_dir.mkdir(parents=True, exist_ok=True)
        self.generated_datasets = {}
        
        print(f"SFC Dataset Generation Results: {self.results_dir}")

    def calculate_load_resources(self, load_level: str, L: int) -> Dict:
        """Calculate CPU/BW and use fixed arrival rate for all loads/L."""
        if load_level not in self.load_levels:
            raise ValueError(f"Unknown load level: {load_level}")

        lc = self.load_levels[load_level]
        
        if load_level == "random":
            # For random load level, return range values that will be used in YAML
            return {
                "cpu_low": lc["cpu_low"],
                "cpu_high": lc["cpu_high"],
                "bandwidth_low": lc["bandwidth_low"],
                "bandwidth_high": lc["bandwidth_high"],
                "arrival_rate_lam": self.fixed_lam,
                "is_random": True
            }
        else:
            cpu_per_vnf = int(lc["base_cpu_per_vnf"])
            bandwidth = int(lc["bandwidth"])
            return {
                "cpu_per_vnf": cpu_per_vnf,
                "total_cpu": cpu_per_vnf * L,
                "bandwidth": bandwidth,
                "arrival_rate_lam": self.fixed_lam,
                "is_random": False
            }
    
    def modify_v_sim_settings(self, L: int, load_level: str, dataset_dir: str, seed: int) -> Dict:
        """Create a dataset-local v_sim_setting.yaml for specific L and load level.
        Does NOT mutate the shared template file in virne/settings.
        Returns the resources dict used.
        """
        # Read the shared template as a base
        with open(self.v_sim_settings_template, 'r') as f:
            config = yaml.safe_load(f)

        resources = self.calculate_load_resources(load_level, L)

        # Chain length configuration
        if load_level == "random":
            # Random chain length between 2-10
            config["v_net_size"]["low"] = self.load_levels["random"]["length_low"]
            config["v_net_size"]["high"] = self.load_levels["random"]["length_high"]
        else:
            # Fixed chain length L
            config["v_net_size"]["low"] = L
            config["v_net_size"]["high"] = L

        # Ensure path topology for chains
        config["topology"]["type"] = "path"

        # Number of VNRs and save location
        config["num_v_nets"] = self.num_vnrs_per_seed
        config["save_dir"] = str(dataset_dir)

        # Resource settings based on load level
        if resources["is_random"]:
            # Random load level - set ranges for uniform distribution
            cpu_low = int(resources["cpu_low"])
            cpu_high = int(resources["cpu_high"])
            bandwidth_low = int(resources["bandwidth_low"])
            bandwidth_high = int(resources["bandwidth_high"])
            
            # Update node resources (CPU, GPU, ROM - all set to same range)
            for attr in config["node_attrs_setting"]:
                if attr["type"] == "resource":
                    attr["high"] = cpu_high
                    attr["low"] = cpu_low

            # Update link resources (bandwidth range)
            for attr in config["link_attrs_setting"]:
                if attr["type"] == "resource":
                    attr["high"] = bandwidth_high
                    attr["low"] = bandwidth_low
        else:
            # Fixed load level
            cpu_per_vnf = int(resources["cpu_per_vnf"])
            bandwidth = int(resources["bandwidth"])

            # Update node resources (CPU, GPU, ROM - all set to same value)
            for attr in config["node_attrs_setting"]:
                if attr["type"] == "resource":
                    attr["high"] = cpu_per_vnf
                    attr["low"] = cpu_per_vnf

            # Update link resources (bandwidth)
            for attr in config["link_attrs_setting"]:
                if attr["type"] == "resource":
                    attr["high"] = bandwidth
                    attr["low"] = bandwidth

        # --- Arrival process: Poisson process via exponential inter-arrival times ---
        ar = config.get("arrival_rate", {})
        ar["distribution"] = "poisson"
        ar["dtype"] = "float"
        ar["lam"] = float(resources["arrival_rate_lam"])
        ar["reciprocal"] = True
        if "scale" in ar:
            del ar["scale"]
        config["arrival_rate"] = ar
        # ---------------------------------------------------------------------------

        # Write dataset-local v_sim_setting.yaml
        ds_vsim_path = Path(dataset_dir) / "v_sim_setting.yaml"
        with open(ds_vsim_path, 'w') as f:
            yaml.dump(config, f, default_flow_style=False)

        return resources
    
    def ensure_master_physical_network(self) -> str:
        """Ensure master physical network exists, create if needed"""
        master_p_net_file = self.master_p_net_dir / "p_net.gml"
        
        if master_p_net_file.exists():
            print("Using existing master physical network")
            return str(self.master_p_net_dir)
        
        print("Creating master physical network...")
        self.master_p_net_dir.mkdir(parents=True, exist_ok=True)

        # Create a temporary config for p_net generation
        with open(self.p_net_settings_template, 'r') as f:
            p_net_setting = yaml.safe_load(f)

        p_net_setting["num_nodes"] = self.network_config["p_net"]["num_nodes"]
        p_net_setting["save_dir"] = str(self.master_p_net_dir)
        for attr in p_net_setting["link_attrs_setting"]:
            if attr["type"] == "resource":
                attr["high"] = self.network_config["p_net"]["link_attrs_high"]
                attr["low"] = self.network_config["p_net"]["link_attrs_low"]
        for attr in p_net_setting["node_attrs_setting"]:
            if attr["type"] == "resource":
                attr["high"] = self.network_config["p_net"]["node_attrs_high"]
                attr["low"] = self.network_config["p_net"]["node_attrs_low"]

        # Use a dummy config object
        class TempConfig:
            p_net_setting = p_net_setting
            seed = 0
            verbose = 1

        try:
            Generator.generate_p_net_dataset_from_config(TempConfig, save=True, reuse_existing=False)
        except Exception as e:
            print(f"Error creating master physical network: {e}")
            raise RuntimeError("Failed to create master physical network")

        if not master_p_net_file.exists():
            raise RuntimeError(f"Physical network file not found: {master_p_net_file}")
        
        print("Master physical network created")
        return str(self.master_p_net_dir)
    
    def generate_dataset_combination(self, L: int, load_level: str, seed: int) -> Dict:
        """Generate dataset for specific L, load level, and seed combination"""
        if load_level == "random":
            dataset_key = f"PNC_{load_level}_seed{seed}"
            load_dir = self.base_dir / "dataset" / "large" / f"PNC_{load_level}" / f"seed_{seed}"
        else:
            dataset_key = f"L{L}_PNC_{load_level}_seed{seed}"
            load_dir = self.base_dir / "dataset" / "large" / f"PNC_{load_level}" / f"size_{L}" / f"seed_{seed}"
        
        print(f"  Generating {dataset_key}...")
        
        try:
            load_dir.mkdir(parents=True, exist_ok=True)
            
            # Create and save the dataset-specific v_sim_setting.yaml
            actual_resources = self.modify_v_sim_settings(L, load_level, str(load_dir), seed)
            ds_vsim_path = load_dir / "v_sim_setting.yaml"

            # Copy master physical network to this dataset directory
            master_p_net = self.master_p_net_dir / "p_net.gml"
            target_p_net = load_dir / "p_net.gml"
            if not master_p_net.exists():
                raise RuntimeError("Master physical network not found!")
            shutil.copy2(master_p_net, target_p_net)

            # Load the just-created settings
            with open(ds_vsim_path, 'r') as f:
                v_sim_setting = yaml.safe_load(f)
            
            # Create a config object in memory for this generation task
            class TempConfig:
                pass
            
            temp_config = TempConfig()
            temp_config.v_sim_setting_path = str(ds_vsim_path)
            temp_config.seed = seed
            temp_config.verbose = 0
            temp_config.v_sim_setting = v_sim_setting

            start_time = time.time()
            
            # Generate VNRs directly
            Generator.generate_v_nets_dataset_from_config(temp_config, save=True, reuse_existing=False)

            duration = time.time() - start_time

            # Verify VNRs were generated
            v_nets_dir = load_dir / "v_nets"
            if not v_nets_dir.exists() or not any(v_nets_dir.iterdir()):
                raise RuntimeError("V_nets directory not created or is empty")

            vnr_files = list(v_nets_dir.glob("v_net-*.gml"))
            print(f"    ✓ Generated {len(vnr_files)} VNRs ({duration:.1f}s)")
            
            # Save resource configuration used
            config_info = {
                "load_level": load_level,
                "seed": seed,
                "resources": actual_resources,
                "num_vnrs_generated": len(vnr_files),
                "dataset_dir": str(load_dir),
                "generation_timestamp": datetime.now().isoformat()
            }
            
            # Add L for non-random load levels
            if load_level != "random":
                config_info["L"] = L
            
            config_file = load_dir / "generation_config.json"
            with open(config_file, 'w') as f:
                json.dump(config_info, f, indent=2)
            
            result = {
                "success": True,
                "combination_id": dataset_key,
                "dataset_dir": str(load_dir),
                "load_level": load_level,
                "seed": seed,
                "num_vnrs": len(vnr_files),
                "resources": actual_resources,
                "duration": duration
            }
            
            # Add L for non-random load levels
            if load_level != "random":
                result["L"] = L
                
            return result
            
        except Exception as e:
            print(f"    Exception: {e}")
            import traceback
            traceback.print_exc()
            return {"success": False, "error": str(e), "combination_id": dataset_key}
    
    def _build_tasks(self, lengths: List[int], load_levels: List[str]) -> List[Tuple[int, str, int]]:
        tasks: List[Tuple[int, str, int]] = []
        for load_level in load_levels:
            if load_level == "random":
                # For random load level, only create tasks based on seeds (L is randomized per VNR)
                for seed in range(1, self.num_seeds + 1):
                    tasks.append((0, load_level, seed))  # Use L=0 as placeholder
            else:
                # For fixed load levels, create tasks for each L and seed combination
                for L in lengths:
                    for seed in range(1, self.num_seeds + 1):
                        tasks.append((L, load_level, seed))
        return tasks

    def generate_all_datasets(self, lengths: List[int], load_levels: List[str], processes: int = 1):
        """Generate all L x load_level x seed dataset combinations.

        - When processes == 1: run sequentially (original behavior)
        - When processes > 1: run tasks in a multiprocessing pool
        - When processes == 0: auto-detect CPU count
        """
        from multiprocessing import Pool, cpu_count

        tasks = self._build_tasks(lengths, load_levels)
        total_combinations = len(tasks)
        print(f"Generating {total_combinations} datasets...")

        # Ensure the shared master physical network exists before fan-out
        self.ensure_master_physical_network()

        if processes == 0:
            processes = max(cpu_count() - 1, 1)

        if processes == 1:
            # Sequential generation
            results = []
            for i, (L, load_level, seed) in enumerate(tasks, start=1):
                print(f"[{i}/{total_combinations}] PNC_{load_level}/L{L}/seed{seed}")
                result = self.generate_dataset_combination(L, load_level, seed)
                results.append(result)
                self.save_generation_summary(results)
        else:
            # Parallel generation
            print(f"Running with {processes} processes in parallel")

            worker_args = [
                (L, load_level, seed, str(self.base_dir), self.num_vnrs_per_seed, self.num_seeds)
                for (L, load_level, seed) in tasks
            ]

            results: List[Dict] = []
            with Pool(processes=processes) as pool:
                for i, result in enumerate(pool.imap_unordered(_dataset_worker, worker_args), start=1):
                    results.append(result)
                    # Periodically update summary and lightweight progress
                    if i % max(1, (total_combinations // (processes * 2))) == 0 or i == total_combinations:
                        self.save_generation_summary(results)
                    ok = '✓' if result.get('success') else '✗'
                    cid = result.get('combination_id', '?')
                    print(f"[{i}/{total_combinations}] {ok} {cid}")

            # Final summary write
            self.save_generation_summary(results)

        # Compute final stats and echo
        successful = sum(1 for r in results if r["success"])  # type: ignore[name-defined]
        print(f"\nCompleted: {successful}/{total_combinations} datasets generated successfully")
        if successful < total_combinations:
            failed = [r for r in results if not r["success"]]  # type: ignore[name-defined]
            print(f"Failed: {len(failed)} datasets")

        return results  # type: ignore[name-defined]
    
    def save_generation_summary(self, results: List[Dict]):
        """Save generation summary and create dataset registry"""
        # Save detailed results
        results_file = self.results_dir / "generation_results.json"
        with open(results_file, 'w') as f:
            json.dump(results, f, indent=2)
        
        # Create dataset registry for testing
        successful_datasets = [r for r in results if r["success"]]
        registry = {}
        
        for result in successful_datasets:
            key = result["combination_id"]
            registry_entry = {
                "dataset_dir": result["dataset_dir"],
                "load_level": result["load_level"],
                "seed": result["seed"],
                "num_vnrs": result["num_vnrs"],
                "resources": result["resources"]
            }
            
            # Add L for non-random load levels
            if result["load_level"] != "random":
                registry_entry["L"] = result["L"]
                
            registry[key] = registry_entry
        
        registry_file = self.results_dir / "sfc_datasets_registry.json"
        with open(registry_file, 'w') as f:
            json.dump(registry, f, indent=2)
        
        # Create README
        successful_by_load = {}
        for result in successful_datasets:
            load_level = result["load_level"]
            if load_level not in successful_by_load:
                successful_by_load[load_level] = []
            successful_by_load[load_level].append(result)
        
        readme_content = f"""# SFC Study Datasets - Generated {datetime.now().strftime('%m/%d/%Y %H:%M')}

## Overview
Datasets for Service Function Chain (SFC) length study using controlled VNR generation.

## Generated Datasets
- **Total datasets**: {len(results)}
- **Successful**: {len(successful_datasets)}
- **Failed**: {len(results) - len(successful_datasets)}
- **Chain lengths**: {sorted(set(r['L'] for r in successful_datasets if 'L' in r)) if any('L' in r for r in successful_datasets) else 'Random (3-10)'}
- **Load levels**: {sorted(set(r['load_level'] for r in successful_datasets))}
- **Seeds per combination**: {self.num_seeds}
- **VNRs per seed**: {self.num_vnrs_per_seed}

## Directory Structure
```
/dataset/large/
  PNC_low/size_{{L}}/seed_{{S}}/     # Low load PNC
  PNC_medium/size_{{L}}/seed_{{S}}/  # Medium load PNC
  PNC_high/size_{{L}}/seed_{{S}}/    # High load PNC
```

## Load Level Definitions
"""
        
        for load_level, definition in self.load_levels.items():
            readme_content += f"- **{load_level}**\n"
        
        readme_content += "\n## Resource Calculations\n"
        
        # Show resource calculations for each L (only for non-random load levels)
        non_random_datasets = [r for r in successful_datasets if r.get('L') is not None]
        if non_random_datasets:
            lengths_in_data = sorted(set(r['L'] for r in non_random_datasets))
            for L in lengths_in_data:
                readme_content += f"\n### L={L} (Chain Length {L})\n"
                for load_level in ['low', 'medium', 'high']:
                    if load_level in self.load_levels:
                        resources = self.calculate_load_resources(load_level, L)
                        readme_content += (
                            f"- **{load_level}**: {resources['cpu_per_vnf']} CPU/VNF, "
                            f"Total: {resources['total_cpu']} CPU, BW: {resources['bandwidth']}, "
                            f"lam={resources['arrival_rate_lam']:.4f} (mean inter-arrival), "
                            f"rate={1.0/resources['arrival_rate_lam']:.6f}/unit\n "
                        )
        
        # Show random load level info if present
        random_datasets = [r for r in successful_datasets if r['load_level'] == 'random']
        if random_datasets:
            readme_content += f"\n### Random Load Level\n"
            resources = self.calculate_load_resources('random', 0)  # L doesn't matter for random
            readme_content += (
                f"- **random**: CPU per VNF: {resources['cpu_low']}-{resources['cpu_high']}, "
                f"BW: {resources['bandwidth_low']}-{resources['bandwidth_high']}, "
                f"Chain length: {self.load_levels['random']['length_low']}-{self.load_levels['random']['length_high']}, "
                f"lam={resources['arrival_rate_lam']:.4f}\n"
            )
        
        readme_content += f"""

## Dataset Files (per directory)
- `p_net.gml`: Physical network (100 nodes, shared across all)
- `v_nets/`: Directory with {self.num_vnrs_per_seed} VNR files (v_net-00000.gml to v_net-{self.num_vnrs_per_seed-1:05d}.gml)
- `events.yaml`: Event schedule for simulation
- `v_sim_setting.yaml`: VNR generation settings used
- `generation_config.json`: Resource configuration and metadata

## Registry Files
- `sfc_datasets_registry.json`: Registry for testing scripts
- `generation_results.json`: Detailed generation logs
- `README.md`: This file

## Next Steps
Use `test_sfc_study.py` with the registry file to run controlled experiments across k-values.

## Paired Testing Protocol
For each (load_level, L, seed) combination:
1. Generate VNRs with fixed seed
2. Test same VNR set across different k-values {{1,2,3,...,15}}
3. Compare acceptance ratios while controlling for routing vs CPU failures
"""
        
        with open(self.results_dir / "README.md", 'w') as f:
            f.write(readme_content)
        
        print(f"Generation summary saved: {registry_file}")

def main():
    """Main dataset generation function"""
    parser = argparse.ArgumentParser(description='Generate SFC Study Datasets')
    parser.add_argument('--lengths', type=int, nargs='+', default=[2, 3, 4, 5, 6, 7, 8, 9, 10],
                       help='Chain lengths to generate (default: 2 3 4 5 6 7 8 9 10)')
    parser.add_argument('--loads', choices=['low', 'medium', 'high', 'random'], nargs='+', default=['low', 'medium', 'high'],
                       help='Load levels to generate (default: low medium high)')
    parser.add_argument('--base-dir', default='/home/stephen-reilly/dev/virne',
                       help='Base directory for the project')
    parser.add_argument('--vnrs-per-seed', type=int, default=1000,
                       help='Number of VNRs per seed (default: 1000)')
    parser.add_argument('--seeds', type=int, default=5,
                       help='Number of seeds per combination (default: 5)')
    parser.add_argument('--quick-test', action='store_true',
                       help='Quick test: generate only L={2,5,10} with all load levels')
    parser.add_argument('--small-run', action='store_true',
                       help='Small run: L={2,5,10}, 1000 VNRs per seed, optimized for k=1-15 testing')
    parser.add_argument('--parallel', type=int, default=1,
                       help='Number of parallel processes (default: 1, 0=auto)')
    
    args = parser.parse_args()
    
    if args.quick_test:
        args.lengths = [2, 5, 10]
        print("Quick test mode: generating L={2,5,10} only")
    
    if args.small_run:
        args.lengths = [2, 5, 10]
        args.vnrs_per_seed = 1000
        args.seeds = 2
        print("Small run mode: L={2,5,10}, 1000 VNRs per seed, 2 seeds for k=1-15 testing")
    
    generator = SFCDatasetGenerator(base_dir=args.base_dir)
    generator.num_vnrs_per_seed = args.vnrs_per_seed
    generator.num_seeds = args.seeds
    
    print("SFC Dataset Generation:")
    print(f"  Lengths: {args.lengths}, Loads: {args.loads}")
    print(f"  VNRs/seed: {args.vnrs_per_seed}, Seeds: {args.seeds}")
    print(f"  Fixed lam: {generator.fixed_lam}")
    print(f"  Parallel: {args.parallel}")
    print()
    
    try:
        # Generate all datasets
        results = generator.generate_all_datasets(args.lengths, args.loads, processes=args.parallel)
        
        successful = sum(1 for r in results if r["success"])
        total = len(results)
        
        print(f"\nGeneration complete: {successful}/{total} datasets")
        if successful == total:
            print(f"Registry: {generator.results_dir / 'sfc_datasets_registry.json'}")
            
    except KeyboardInterrupt:
        print("\nGeneration interrupted by user")
    except Exception as e:
        print(f"Error during generation: {e}")
        raise

if __name__ == "__main__":
    main()
