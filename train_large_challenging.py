#!/usr/bin/env python3
"""
Train Large Network with More Challenging Resource Constraints

This script trains a new model for the large network with tighter resource constraints
to create more realistic acceptance rates (60-80% range) for better k_shortest comparison.
"""

import os
import sys
import yaml
import shutil
import subprocess
import time
from pathlib import Path

def backup_configs(base_dir):
    """Backup original configuration files"""
    config_file = base_dir / "virne" / "config.py"
    main_file = base_dir / "virne" / "main.py"
    p_net_settings = base_dir / "virne" / "settings" / "p_net_setting.yaml"
    v_sim_settings = base_dir / "virne" / "settings" / "v_sim_setting.yaml"
    
    print("Backing up original configuration files...")
    shutil.copy2(config_file, f"{config_file}.backup")
    shutil.copy2(main_file, f"{main_file}.backup")
    shutil.copy2(p_net_settings, f"{p_net_settings}.backup")
    shutil.copy2(v_sim_settings, f"{v_sim_settings}.backup")
    
    return config_file, main_file, p_net_settings, v_sim_settings

def restore_configs(base_dir):
    """Restore original configuration files"""
    config_file = base_dir / "virne" / "config.py"
    main_file = base_dir / "virne" / "main.py"
    p_net_settings = base_dir / "virne" / "settings" / "p_net_setting.yaml"
    v_sim_settings = base_dir / "virne" / "settings" / "v_sim_setting.yaml"
    
    print("Restoring original configuration files...")
    shutil.copy2(f"{config_file}.backup", config_file)
    shutil.copy2(f"{main_file}.backup", main_file)
    shutil.copy2(f"{p_net_settings}.backup", p_net_settings)
    shutil.copy2(f"{v_sim_settings}.backup", v_sim_settings)

def modify_config_for_training(config_file):
    """Configure config.py for training"""
    with open(config_file, 'r') as f:
        content = f.read()
    
    import re
    
    # Set for training mode
    content = re.sub(r"solver_name: str = '[^']*'", f"solver_name: str = 'a3c_gcn_pre_train_transformer'", content)
    content = re.sub(r'num_epochs: int = \d+', f'num_epochs: int = 0', content)  # No testing during training
    content = re.sub(r'num_train_epochs: int = \d+', f'num_train_epochs: int = 100', content)  # 100 training epochs
    content = re.sub(r'use_fixed_dataset: bool = \w+', f'use_fixed_dataset: bool = False', content)  # Generate new dataset
    content = re.sub(r"pretrained_model_path: str = '[^']*'", f"pretrained_model_path: str = ''", content)  # No pretrained model
    content = re.sub(r'renew_v_net_simulator: bool = \w+', f'renew_v_net_simulator: bool = True', content)  # Generate new v_nets
    
    with open(config_file, 'w') as f:
        f.write(content)

def modify_main_for_training(main_file):
    """Configure main.py to generate new datasets"""
    with open(main_file, 'r') as f:
        content = f.read()
    
    import re
    
    # Set to generate new datasets (not reuse existing)
    pattern = r'Generator\.generate_dataset\(\s*config,\s*p_net=True,\s*v_nets=True,\s*save=True,\s*reuse_existing_p=\w+,\s*reuse_existing_v=\w+\s*\)'
    replacement = '''Generator.generate_dataset(
        config,
        p_net=True,
        v_nets=True,
        save=True,
        reuse_existing_p=False,
        reuse_existing_v=False
    )'''
    
    content = re.sub(pattern, replacement, content, flags=re.MULTILINE | re.DOTALL)
    
    with open(main_file, 'w') as f:
        f.write(content)

def modify_p_net_settings(p_net_settings):
    """Configure p_net_setting.yaml for challenging large network"""
    with open(p_net_settings, 'r') as f:
        config = yaml.safe_load(f)
    
    # Large network with tighter resource constraints
    config["num_nodes"] = 100
    
    # Reduce bandwidth to make routing more challenging
    for attr in config["link_attrs_setting"]:
        if attr["type"] == "resource":
            attr["high"] = 80   # Reduced from 150 to 80
            attr["low"] = 80
            
    # Reduce CPU to make node placement more challenging
    for attr in config["node_attrs_setting"]:
        if attr["type"] == "resource":
            attr["high"] = 100  # Reduced from 200 to 100
            attr["low"] = 100
    
    with open(p_net_settings, 'w') as f:
        yaml.dump(config, f, default_flow_style=False)
        
    print("Large network P-Net settings:")
    print(f"  Nodes: {config['num_nodes']}")
    print(f"  Link bandwidth: {80} (reduced from 150)")  
    print(f"  Node CPU: {100} (reduced from 200)")

def modify_v_sim_settings(v_sim_settings):
    """Configure v_sim_setting.yaml for challenging virtual networks"""
    with open(v_sim_settings, 'r') as f:
        config = yaml.safe_load(f)
    
    # Keep virtual network demands at reasonable level
    config["v_net_size"]["low"] = 7
    config["v_net_size"]["high"] = 7
    
    # Slightly increase virtual demands to create more pressure
    for attr in config["node_attrs_setting"]:
        if attr["type"] == "resource":
            attr["low"] = 30    # Increased from 25 to 30
            attr["high"] = 30
    
    with open(v_sim_settings, 'w') as f:
        yaml.dump(config, f, default_flow_style=False)
        
    print("Large network V-Sim settings:")
    print(f"  V-Net size: {config['v_net_size']['low']}-{config['v_net_size']['high']} nodes")
    print(f"  Virtual node demands: {30} (increased from 25)")

def train_large_network(base_dir):
    """Train the large network with challenging settings"""
    print("="*60)
    print("TRAINING: LARGE network with challenging resource constraints")
    print("="*60)
    print("Goal: Achieve 60-80% acceptance rate for better k_shortest comparison")
    print()
    
    # Change to project directory
    os.chdir(base_dir)
    
    # Run training
    start_time = time.time()
    cmd = "conda run -n nfv python -m virne.main"
    
    print(f"Starting training with command: {cmd}")
    print("This will take some time (no timeout)...")
    print()
    
    result = subprocess.run(
        cmd,
        shell=True,
        capture_output=True,
        text=True
    )
    
    end_time = time.time()
    duration = end_time - start_time
    
    print(f"Training completed in {duration:.2f} seconds")
    print(f"Return code: {result.returncode}")
    
    if result.returncode == 0:
        print("✓ Training successful!")
        
        # Find the new dataset directory
        import glob
        dataset_pattern = str(base_dir / "dataset" / "results-*")
        dataset_dirs = glob.glob(dataset_pattern)
        if dataset_dirs:
            dataset_dirs.sort(key=os.path.getctime, reverse=True)
            latest_dataset = dataset_dirs[0]
            print(f"✓ New dataset created: {latest_dataset}")
            
            # Look for the model file
            for root, dirs, files in os.walk(latest_dataset):
                for file in files:
                    if file == "model.pkl":
                        model_path = os.path.join(root, file)
                        print(f"✓ New model saved: {model_path}")
                        break
        
        print()
        print("Next steps:")
        print("1. Update your ablation_study.py trained_models_config with the new paths")
        print("2. Run ablation experiments to test the new challenging network")
        print("3. The new resource constraints should give 60-80% acceptance rates")
        
    else:
        print("✗ Training failed!")
        print("STDERR:", result.stderr[:1000])
        return False
    
    return True

def main():
    """Main training function"""
    base_dir = Path("/home/stephen-reilly/dev/virne")
    
    try:
        # Backup configs
        config_file, main_file, p_net_settings, v_sim_settings = backup_configs(base_dir)
        
        # Configure for challenging large network training
        modify_config_for_training(config_file)
        modify_main_for_training(main_file)
        modify_p_net_settings(p_net_settings)
        modify_v_sim_settings(v_sim_settings)
        
        # Train the network
        success = train_large_network(base_dir)
        
        if success:
            print("\n" + "="*60)
            print("TRAINING COMPLETED SUCCESSFULLY!")
            print("="*60)
        else:
            print("\n" + "="*60)
            print("TRAINING FAILED!")
            print("="*60)
            
    except KeyboardInterrupt:
        print("\nTraining interrupted by user")
    except Exception as e:
        print(f"Error during training: {e}")
    finally:
        # Always restore original configs
        restore_configs(base_dir)

if __name__ == "__main__":
    main()