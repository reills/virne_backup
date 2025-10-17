#!/usr/bin/env python3
"""
Generate a fixed physical network and VNR dataset for AlphaZero k-ablations.

Usage (after `conda activate virne`):
    python tools/generator/create_training_dataset.py \
        --output-root dataset/training \
        --num-vnrs 200 \
        --cpu-low 15 --cpu-high 40 \
        --bandwidth-low 10 --bandwidth-high 22 \
        --arrival-rate-lam 20.0 \
        --k-values 1-15
"""
from __future__ import annotations

import argparse
import datetime as dt
import json
import shutil
import sys
from pathlib import Path
from typing import Iterable, List

from omegaconf import OmegaConf

REPO_ROOT = Path(__file__).resolve().parents[2]  # Go up 2 levels: file -> generator -> tools -> virne
if str(REPO_ROOT) not in sys.path:
    sys.path.insert(0, str(REPO_ROOT))

from virne.config import Config
from virne.network import PhysicalNetwork, VirtualNetworkRequestSimulator
from virne.utils.dataset import set_seed
from virne.utils.setting import read_setting


def parse_k_values(spec: str) -> List[int]:
    values: List[int] = []
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


def ensure_empty_dir(path: Path, overwrite: bool) -> None:
    if path.exists():
        if not overwrite:
            raise FileExistsError(f"Directory already exists: {path}. Use --overwrite to replace it.")
        if path.is_dir():
            shutil.rmtree(path)
        else:
            path.unlink()
    path.mkdir(parents=True, exist_ok=True)


def update_range(setting_list: List[dict], attr_name: str, low: int | float, high: int | float) -> None:
    for attr in setting_list:
        if attr.get("name") == attr_name and attr.get("type") == "resource":
            attr["low"] = low
            attr["high"] = high
            return
    raise KeyError(f"Attribute '{attr_name}' not found in setting list {setting_list}")


def generate_dataset(base_dir: Path, cfg: Config, seed: int) -> None:
    snapshot = OmegaConf.create(
        {
            "seed": seed,
            "p_net_setting": cfg.p_net_setting,
            "v_sim_setting": cfg.v_sim_setting,
        }
    )
    OmegaConf.save(snapshot, str(base_dir / "config_snapshot.yaml"))
    set_seed(seed)
    physical = PhysicalNetwork.from_setting(cfg.p_net_setting, seed=seed)
    physical.save_dataset(str(base_dir))

    simulator = VirtualNetworkRequestSimulator.from_setting(cfg.v_sim_setting, seed=seed)
    simulator.renew(v_nets=True, events=True, seed=seed)
    simulator.save_dataset(str(base_dir))


def export_metadata(base_dir: Path, args: argparse.Namespace, k_values: Iterable[int]) -> None:
    metadata = {
        "generated_at": dt.datetime.utcnow().isoformat() + "Z",
        "seed": args.seed,
        "num_vnrs": args.num_vnrs,
        "vnr_resources": {
            "cpu_low": args.cpu_low,
            "cpu_high": args.cpu_high,
            "bandwidth_low": args.bandwidth_low,
            "bandwidth_high": args.bandwidth_high,
            "arrival_rate_lam": args.arrival_rate_lam,
            "is_random": True,
        },
        "vnr_size_low": args.vnr_size_low,
        "vnr_size_high": args.vnr_size_high,
        "lifetime_scale": args.lifetime_scale,
        "physical_num_nodes": args.p_net_nodes,
        "k_values": list(k_values),
    }
    with (base_dir / "generation_meta.json").open("w") as f:
        json.dump(metadata, f, indent=2)


def copy_for_k(base_dir: Path, output_root: Path, k_values: Iterable[int], overwrite: bool) -> None:
    for k in k_values:
        target = output_root / f"k{k:02d}"
        if target.exists():
            if not overwrite:
                raise FileExistsError(f"Per-k directory already exists: {target}. Use --overwrite.")
            shutil.rmtree(target)
        shutil.copytree(base_dir, target)


def build_config(args: argparse.Namespace) -> Config:
    # Create config without calling __post_init__ by setting read_settings to False temporarily
    cfg = Config.__new__(Config)
    # Initialize all fields with defaults
    for field_name, field_def in Config.__dataclass_fields__.items():
        if field_def.default is not field_def.default_factory:
            setattr(cfg, field_name, field_def.default)
        elif field_def.default_factory is not field_def.default_factory:
            setattr(cfg, field_name, field_def.default_factory())

    cfg.verbose = 0
    cfg.use_fixed_dataset = True
    cfg.dir_save_dataset = str(args.output_root)
    cfg.save_dir = str(args.output_root)
    cfg.summary_dir = str(args.output_root)

    # Read settings manually to set num_nodes before validation
    cfg.p_net_setting = read_setting(cfg.p_net_setting_path)
    cfg.v_sim_setting = read_setting(cfg.v_sim_setting_path)

    # Add num_nodes at top level if it doesn't exist
    if 'num_nodes' not in cfg.p_net_setting and 'topology' in cfg.p_net_setting:
        cfg.p_net_setting['num_nodes'] = cfg.p_net_setting['topology'].get('num_nodes', 100)

    # Add save_dir at top level if it doesn't exist (expected by get_run_id and create_dirs)
    if 'save_dir' not in cfg.p_net_setting:
        cfg.p_net_setting['save_dir'] = cfg.p_net_setting.get('output', {}).get('save_dir', str(args.output_root))
    if 'save_dir' not in cfg.v_sim_setting:
        cfg.v_sim_setting['save_dir'] = cfg.v_sim_setting.get('output', {}).get('save_dir', str(args.output_root))

    # Physical network controls
    cfg.p_net_setting["output"]["save_dir"] = str(args.output_root)
    cfg.p_net_setting["save_dir"] = str(args.output_root)
    cfg.p_net_setting["topology"]["num_nodes"] = args.p_net_nodes
    cfg.p_net_setting["num_nodes"] = args.p_net_nodes

    # VNR settings
    v_setting = cfg.v_sim_setting
    v_setting["num_v_nets"] = args.num_vnrs
    v_setting["output"]["save_dir"] = str(args.output_root)
    v_setting["save_dir"] = str(args.output_root)
    v_setting["v_net_size"]["low"] = args.vnr_size_low
    v_setting["v_net_size"]["high"] = args.vnr_size_high
    v_setting["lifetime"]["scale"] = args.lifetime_scale
    v_setting["arrival_rate"]["lam"] = args.arrival_rate_lam
    update_range(v_setting["node_attrs_setting"], "cpu", args.cpu_low, args.cpu_high)
    update_range(v_setting["link_attrs_setting"], "bw", args.bandwidth_low, args.bandwidth_high)

    # Now complete the initialization
    cfg.create_dirs()
    cfg.get_run_id()

    # Set the computed attributes that read_settings would set
    cfg.p_net_setting_num_nodes = cfg.p_net_setting['num_nodes']
    cfg.p_net_setting_num_node_attrs = len(cfg.p_net_setting['node_attrs_setting'])
    cfg.p_net_setting_num_link_attrs = len(cfg.p_net_setting['link_attrs_setting'])
    cfg.p_net_setting_num_node_resource_attrs = len([1 for attr in cfg.p_net_setting['node_attrs_setting'] if attr['type'] == 'resource'])
    cfg.p_net_setting_num_link_resource_attrs = len([1 for attr in cfg.p_net_setting['link_attrs_setting'] if attr['type'] == 'resource'])
    cfg.p_net_setting_num_node_extrema_attrs = len([1 for attr in cfg.p_net_setting['node_attrs_setting'] if attr['type'] == 'extrema'])
    cfg.p_net_setting_num_link_extrema_attrs = len([1 for attr in cfg.p_net_setting['link_attrs_setting'] if attr['type'] == 'extrema'])

    cfg.v_sim_setting_num_node_attrs = len(cfg.v_sim_setting['node_attrs_setting'])
    cfg.v_sim_setting_num_link_attrs = len(cfg.v_sim_setting['link_attrs_setting'])
    cfg.v_sim_setting_num_node_resource_attrs = len([1 for attr in cfg.v_sim_setting['node_attrs_setting'] if attr['type'] == 'resource'])
    cfg.v_sim_setting_num_link_resource_attrs = len([1 for attr in cfg.v_sim_setting['link_attrs_setting'] if attr['type'] == 'resource'])

    return cfg


def parse_args(argv: List[str]) -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Generate a fixed VNR/physical dataset and clone it per k."
    )
    parser.add_argument("--output-root", type=Path, default=Path("dataset/training"), help="Root directory to store datasets.")
    parser.add_argument("--num-vnrs", type=int, default=200, help="Number of virtual network requests to generate.")
    parser.add_argument("--vnr-size-low", type=int, default=3, help="Minimum VNF chain length.")
    parser.add_argument("--vnr-size-high", type=int, default=12, help="Maximum VNF chain length.")
    parser.add_argument("--cpu-low", type=int, default=15, help="Minimum CPU demand per virtual node.")
    parser.add_argument("--cpu-high", type=int, default=40, help="Maximum CPU demand per virtual node.")
    parser.add_argument("--bandwidth-low", type=int, default=10, help="Minimum bandwidth demand per virtual link.")
    parser.add_argument("--bandwidth-high", type=int, default=22, help="Maximum bandwidth demand per virtual link.")
    parser.add_argument("--arrival-rate-lam", type=float, default=20.0, help="Lambda for Poisson arrival distribution.")
    parser.add_argument("--lifetime-scale", type=float, default=500.0, help="Scale for exponential lifetime distribution.")
    parser.add_argument("--p-net-nodes", type=int, default=100, help="Physical network node count.")
    parser.add_argument("--seed", type=int, default=42, help="Random seed for reproducibility.")
    parser.add_argument("--k-values", default="1-15", help="Comma/range list of k values to prepare directories for.")
    parser.add_argument("--overwrite", action="store_true", help="Allow replacing existing directories.")
    parser.add_argument("--skip-per-k", action="store_true", help="Skip cloning base dataset into per-k directories.")
    return parser.parse_args(argv)


def main(argv: List[str]) -> int:
    args = parse_args(argv)
    k_values = parse_k_values(args.k_values)

    base_dir = args.output_root / "base"
    ensure_empty_dir(base_dir, args.overwrite)

    cfg = build_config(args)
    generate_dataset(base_dir, cfg, args.seed)
    export_metadata(base_dir, args, k_values)

    if not args.skip_per_k:
        copy_for_k(base_dir, args.output_root, k_values, args.overwrite)

    print(f"Dataset generated at {base_dir}")
    if not args.skip_per_k:
        print(f"Cloned per-k datasets: {[str((args.output_root / f'k{k:02d}')) for k in k_values]}")
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
