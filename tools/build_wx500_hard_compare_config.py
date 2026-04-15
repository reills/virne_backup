#!/usr/bin/env python3
from __future__ import annotations

import argparse
from pathlib import Path

from omegaconf import OmegaConf


HARD_SCENARIO_KEY = "wx500_hard_compare"
DEFAULT_NUM_VNETS = 1000
DEFAULT_VNET_SIZE_LOW = 3
DEFAULT_VNET_SIZE_HIGH = 13
DEFAULT_NODE_DEMAND_HIGH = 26
DEFAULT_LINK_DEMAND_HIGH = 65


def _parse_seed_list(raw: str) -> list[int]:
    text = raw.strip()
    if not text:
        return []
    return [int(part.strip()) for part in text.split(",") if part.strip()]


def _profile_common_overrides(method_key: str) -> list[str]:
    if method_key != "alpha_zero_sfc":
        return ["training.resume_training=false"]
    return [
        "training.pure_cpp=true",
        "training.use_cpp_mcts=true",
        "training.use_cuda=true",
        "training.use_batched_gpu=false",
        "training.distributed_training=true",
        "training.enable_async_learner=true",
        "training.num_workers=4",
        "training.resume_training=false",
        "training.alpha_zero_backbone=transformer",
        "training.signal_stop_event_on_learner_complete=true",
        "training.computation_budget=96",
        "nn.embedding_dim=96",
        "nn.hidden_dim=96",
        "nn.num_gnn_layers=2",
        "nn.n_heads=6",
        "nn.transformer_layers=2",
    ]


def _train_overrides(method_key: str) -> list[str]:
    if method_key != "alpha_zero_sfc":
        return []
    return [
        "training.num_train_epochs=16",
        "experiment.num_simulations=0",
        "training.c_puct=1.4",
        "training.max_training_steps=3000",
        "training.min_buffer_size=128",
        "training.num_train_steps_per_epoch=128",
        "training.max_empty_batches=5400",
        "training.save_interval=2000",
    ]


def _eval_overrides(method_key: str) -> list[str]:
    if method_key in {"alpha_zero_sfc", "mcts"}:
        return ["training.computation_budget=96"]
    return []


def build_config(
    base_config_path: Path,
    config_path: Path,
    method_key: str,
    train_profile: str,
    eval_profile: str,
    train_seeds: list[int],
    eval_seeds: list[int],
    num_v_nets: int,
    v_net_size_low: int,
    v_net_size_high: int,
    node_demand_high: int,
    link_demand_high: int,
) -> None:
    cfg = OmegaConf.load(str(base_config_path))
    cfg.journal_suite.default_profile = eval_profile
    cfg.journal_suite.offline_slice = OmegaConf.create({"enabled": False})
    cfg.journal_suite.paired_matching_policy = OmegaConf.create(
        {
            "enabled": False,
            "method_keys": [method_key],
            "match_fields": ["topology", "scenario", "seed", "k_value"],
        }
    )
    cfg.journal_suite.k_semantics_parity = OmegaConf.create({"enabled": False})
    cfg.journal_suite.scenarios[HARD_SCENARIO_KEY] = OmegaConf.create(
        {
            "train_split": "train",
            "eval_split": "test",
            "v_sim_setting_overrides": {
                "num_v_nets": num_v_nets,
                "v_net_size": {
                    "low": v_net_size_low,
                    "high": v_net_size_high,
                },
            },
            "dataset_generation_v_sim_setting_overrides": {
                "node_attrs_setting": [
                    {
                        "name": "cpu",
                        "distribution": "uniform",
                        "dtype": "int",
                        "generative": True,
                        "low": 0,
                        "high": node_demand_high,
                        "owner": "node",
                        "type": "resource",
                    }
                ],
                "link_attrs_setting": [
                    {
                        "name": "bw",
                        "distribution": "uniform",
                        "dtype": "int",
                        "generative": True,
                        "low": 0,
                        "high": link_demand_high,
                        "owner": "link",
                        "type": "resource",
                    }
                ],
            },
        }
    )

    common_overrides = _profile_common_overrides(method_key)
    train_overrides = _train_overrides(method_key)
    eval_overrides = _eval_overrides(method_key)

    if train_seeds:
        cfg.journal_suite.profiles[train_profile] = OmegaConf.create(
            {
                "seeds": train_seeds,
                "topologies": ["wx500"],
                "scenarios": ["nominal"],
                "methods": [method_key],
                "k_eval_values": [10],
                "generalization_cells": [],
                "overrides": {
                    "common": common_overrides,
                    "train": train_overrides,
                    "eval": eval_overrides,
                },
            }
        )

    cfg.journal_suite.profiles[eval_profile] = OmegaConf.create(
        {
            "seeds": eval_seeds,
            "topologies": ["wx500"],
            "scenarios": [],
            "methods": [method_key],
            "k_eval_values": [10],
            "generalization_cells": [
                {
                    "train_scenario": "nominal",
                    "eval_scenario": HARD_SCENARIO_KEY,
                    "topology": "wx500",
                    "seed": seed,
                }
                for seed in eval_seeds
            ],
            "overrides": {
                "common": common_overrides,
                "eval": eval_overrides,
            },
        }
    )

    config_path.parent.mkdir(parents=True, exist_ok=True)
    OmegaConf.save(cfg, str(config_path))


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--config-path", required=True)
    parser.add_argument("--method-key", required=True)
    parser.add_argument("--train-profile", required=True)
    parser.add_argument("--eval-profile", required=True)
    parser.add_argument("--train-seeds", default="")
    parser.add_argument("--eval-seeds", default="0,1,2")
    parser.add_argument("--num-v-nets", type=int, default=DEFAULT_NUM_VNETS)
    parser.add_argument("--v-net-size-low", type=int, default=DEFAULT_VNET_SIZE_LOW)
    parser.add_argument("--v-net-size-high", type=int, default=DEFAULT_VNET_SIZE_HIGH)
    parser.add_argument("--node-demand-high", type=int, default=DEFAULT_NODE_DEMAND_HIGH)
    parser.add_argument("--link-demand-high", type=int, default=DEFAULT_LINK_DEMAND_HIGH)
    parser.add_argument(
        "--base-config",
        default="settings/experiments/journal_suite.yaml",
    )
    args = parser.parse_args()

    build_config(
        base_config_path=Path(args.base_config),
        config_path=Path(args.config_path),
        method_key=args.method_key,
        train_profile=args.train_profile,
        eval_profile=args.eval_profile,
        train_seeds=_parse_seed_list(args.train_seeds),
        eval_seeds=_parse_seed_list(args.eval_seeds),
        num_v_nets=args.num_v_nets,
        v_net_size_low=args.v_net_size_low,
        v_net_size_high=args.v_net_size_high,
        node_demand_high=args.node_demand_high,
        link_demand_high=args.link_demand_high,
    )
    print(f"wrote {args.config_path}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
