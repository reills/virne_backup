#!/usr/bin/env python3
"""Regenerate the legacy CCWC Waxman/SFC dataset from saved Hydra config."""

from __future__ import annotations

import argparse
import shutil
import sys
from pathlib import Path

from omegaconf import OmegaConf

REPO_ROOT = Path(__file__).resolve().parents[2]
if str(REPO_ROOT) not in sys.path:
    sys.path.insert(0, str(REPO_ROOT))

from virne.network import PhysicalNetwork, VirtualNetworkRequestSimulator
from virne.utils.dataset import set_seed


DEFAULT_CONFIG = (
    REPO_ROOT
    / "legacy/CCWC_alpha_zero_sfc_eval/alpha_zero_sfc/eval-k01-20251031T180243/config.yaml"
)


def prepare_output(path: Path, overwrite: bool) -> None:
    if path.exists():
        if not overwrite:
            raise FileExistsError(f"{path} exists. Pass --overwrite to replace it.")
        shutil.rmtree(path)
    path.mkdir(parents=True, exist_ok=True)


def main(argv: list[str]) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--config", type=Path, default=DEFAULT_CONFIG)
    parser.add_argument("--seed", type=int, default=None)
    parser.add_argument("--overwrite", action="store_true")
    args = parser.parse_args(argv)

    cfg = OmegaConf.load(args.config)
    seed = int(args.seed if args.seed is not None else cfg.experiment.seed)
    p_dir = REPO_ROOT / str(cfg.simulation.p_net_dataset_dir)
    v_dir = REPO_ROOT / str(cfg.simulation.v_nets_dataset_dir)

    prepare_output(p_dir, args.overwrite)
    prepare_output(v_dir, args.overwrite)

    set_seed(seed)
    p_net = PhysicalNetwork.from_setting(cfg.p_net_setting, seed=seed)
    p_net.save_dataset(str(p_dir))

    v_sim = VirtualNetworkRequestSimulator.from_setting(cfg.v_sim_setting, seed=seed)
    v_sim.renew(v_nets=True, events=True, seed=seed)
    v_sim.save_dataset(str(v_dir))

    print(f"seed={seed}")
    print(f"p_net_dataset_dir={p_dir}")
    print(f"v_nets_dataset_dir={v_dir}")
    print(f"num_v_nets={v_sim.num_v_nets}")
    print(f"num_events={len(v_sim.events)}")
    if v_sim.events:
        print(f"last_event_time={max(float(event['time']) for event in v_sim.events)}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main(sys.argv[1:]))
