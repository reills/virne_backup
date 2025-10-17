#!/usr/bin/env python3
"""
Generate fixed datasets for k-ablation study using Hydra config.

Usage:
    python generate_k_ablation_datasets.py --k-values 1-15 --num-vnrs 200
"""
import argparse
import shutil
import sys
from pathlib import Path

import hydra
from omegaconf import DictConfig, OmegaConf, open_dict

from virne.network import PhysicalNetwork, VirtualNetworkRequestSimulator
from virne.utils.dataset import set_seed


def parse_k_values(spec: str) -> list[int]:
    """Parse k values from string like '1-15' or '1,5,10'."""
    values = []
    for part in spec.split(","):
        part = part.strip()
        if not part:
            continue
        if "-" in part:
            start, end = part.split("-", 1)
            values.extend(range(int(start), int(end) + 1))
        else:
            values.append(int(part))
    return sorted(dict.fromkeys(values))


def generate_base_dataset(output_root: Path, cfg: DictConfig, seed: int, num_vnrs: int):
    """Generate base physical network and VNRs."""
    print(f"\n{'='*60}")
    print(f"Generating base dataset:")
    print(f"  - Output: {output_root}")
    print(f"  - Seed: {seed}")
    print(f"  - VNRs: {num_vnrs}")
    print(f"  - P-net nodes: {cfg.simulation.p_net_setting_num_nodes}")
    print(f"{'='*60}\n")

    # Create base directory
    base_dir = output_root / "base"
    base_dir.mkdir(parents=True, exist_ok=True)

    # Set seed for reproducibility
    set_seed(seed)

    # Generate physical network
    print("Generating physical network...")
    p_net = PhysicalNetwork.from_setting(cfg.p_net_setting, seed=seed)
    p_net.save_dataset(str(base_dir))
    print(f"  ✓ Physical network saved: {p_net.num_nodes} nodes")

    # Generate VNRs
    print(f"\nGenerating {num_vnrs} VNRs...")
    with open_dict(cfg):
        cfg.v_sim_setting.num_v_nets = num_vnrs

    simulator = VirtualNetworkRequestSimulator.from_setting(cfg.v_sim_setting, seed=seed)
    simulator.renew(v_nets=True, events=True, seed=seed)
    simulator.save_dataset(str(base_dir))
    print(f"  ✓ VNRs saved: {len(simulator.v_nets)} requests")

    # Save config snapshot
    snapshot = {
        "seed": seed,
        "num_vnrs": num_vnrs,
        "p_net_nodes": cfg.simulation.p_net_setting_num_nodes,
        "generated_with": "generate_k_ablation_datasets.py"
    }
    OmegaConf.save(OmegaConf.create(snapshot), str(base_dir / "dataset_info.yaml"))

    return base_dir


def clone_for_k_values(base_dir: Path, output_root: Path, k_values: list[int], overwrite: bool):
    """Clone base dataset to separate directories for each k value."""
    print(f"\n{'='*60}")
    print(f"Cloning dataset for k values: {k_values}")
    print(f"{'='*60}\n")

    for k in k_values:
        target = output_root / f"k{k:02d}"

        if target.exists():
            if not overwrite:
                print(f"  ⚠ Skipping k={k} (already exists, use --overwrite to replace)")
                continue
            print(f"  Removing existing k={k}...")
            shutil.rmtree(target)

        print(f"  Copying to k={k:02d}/...")
        shutil.copytree(base_dir, target)
        print(f"  ✓ Created {target}")

    print(f"\n✅ All k-value datasets ready!")


def main():
    parser = argparse.ArgumentParser(description="Generate datasets for k-shortest ablation study")
    parser.add_argument("--output-root", type=Path, default=Path("dataset/k_ablation"),
                       help="Root directory for generated datasets")
    parser.add_argument("--k-values", type=str, default="1-15",
                       help="K values to generate (e.g., '1-15' or '1,5,10,20')")
    parser.add_argument("--num-vnrs", type=int, default=200,
                       help="Number of VNRs to generate")
    parser.add_argument("--seed", type=int, default=42,
                       help="Random seed for reproducibility")
    parser.add_argument("--overwrite", action="store_true",
                       help="Overwrite existing directories")
    parser.add_argument("--skip-clone", action="store_true",
                       help="Only generate base dataset, skip per-k cloning")

    args = parser.parse_args()

    # Parse k values
    k_values = parse_k_values(args.k_values)
    print(f"\n🔬 K-Ablation Dataset Generator")
    print(f"   K values: {k_values}")
    print(f"   VNRs: {args.num_vnrs}")
    print(f"   Seed: {args.seed}")

    # Load Hydra config
    with hydra.initialize(config_path="settings", version_base=None):
        cfg = hydra.compose(config_name="main")

    # Add simulation info
    from virne.utils.config import add_simulation_into_config
    add_simulation_into_config(cfg)

    # Generate base dataset
    base_dir = generate_base_dataset(
        args.output_root,
        cfg,
        args.seed,
        args.num_vnrs
    )

    # Clone for each k value
    if not args.skip_clone:
        clone_for_k_values(base_dir, args.output_root, k_values, args.overwrite)

    print(f"\n{'='*60}")
    print(f"✅ Dataset generation complete!")
    print(f"   Base: {base_dir}")
    if not args.skip_clone:
        print(f"   K-dirs: {args.output_root}/k{{01..{k_values[-1]:02d}}}")
    print(f"{'='*60}\n")


if __name__ == "__main__":
    main()
