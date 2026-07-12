#!/usr/bin/env python3
from __future__ import annotations

import argparse
from pathlib import Path

from omegaconf import OmegaConf


DEFAULT_TOPOLOGY_KEY = "wx100"
DEFAULT_HARD_SCENARIO_KEY = "wx100_hard_compare"
DEFAULT_NUM_VNETS = 1000
DEFAULT_VNET_SIZE_LOW = 3
DEFAULT_VNET_SIZE_HIGH = 12
DEFAULT_ARRIVAL_LAM = 0.06
DEFAULT_NODE_DEMAND_HIGH = 26
DEFAULT_LINK_DEMAND_HIGH = 65
DEFAULT_K_EVAL = 10


def _parse_seed_list(raw: str) -> list[int]:
    text = raw.strip()
    if not text:
        return []
    return [int(part.strip()) for part in text.replace(" ", ",").split(",") if part.strip()]


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
        "training.c_puct=1.4",
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
        "training.max_training_steps=3000",
        "training.min_buffer_size=128",
        "training.num_train_steps_per_epoch=128",
        "training.max_empty_batches=5400",
        "training.save_interval=2000",
    ]


def _eval_overrides(method_key: str, computation_budget: int) -> list[str]:
    if method_key in {"alpha_zero_sfc", "mcts"}:
        return [f"training.computation_budget={computation_budget}"]
    return []


def build_config(
    *,
    base_config_path: Path,
    config_path: Path,
    topology_key: str,
    hard_scenario_key: str,
    method_key: str,
    train_profile: str,
    eval_profile: str,
    train_seeds: list[int],
    eval_seeds: list[int],
    num_v_nets: int,
    v_net_size_low: int,
    v_net_size_high: int,
    arrival_lam: float,
    node_demand_high: int,
    link_demand_high: int,
    k_eval: int,
    computation_budget: int,
    parallelism: int,
    comparison_mode: str,
) -> None:
    if comparison_mode not in {"zero_shot", "indomain"}:
        raise ValueError(f"unsupported comparison_mode={comparison_mode!r}")

    cfg = OmegaConf.load(str(base_config_path))
    cfg.journal_suite.default_profile = eval_profile
    cfg.journal_suite.evaluation.parallelism = int(parallelism)
    cfg.journal_suite.offline_slice = OmegaConf.create({"enabled": False})
    cfg.journal_suite.paired_matching_policy = OmegaConf.create(
        {
            "enabled": False,
            "method_keys": [method_key],
            "match_fields": ["topology", "scenario", "seed", "k_value"],
        }
    )
    cfg.journal_suite.k_semantics_parity = OmegaConf.create({"enabled": False})
    cfg.journal_suite.scenarios[hard_scenario_key] = OmegaConf.create(
        {
            "train_split": "train",
            "eval_split": "test",
            "v_sim_setting_overrides": {
                "num_v_nets": num_v_nets,
                "arrival_rate": {
                    "lam": arrival_lam,
                },
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
    eval_overrides = _eval_overrides(method_key, computation_budget)
    train_scenario_key = hard_scenario_key if comparison_mode == "indomain" else "nominal"
    eval_scenarios = [hard_scenario_key] if comparison_mode == "indomain" else []
    generalization_cells = []
    if comparison_mode == "zero_shot":
        generalization_cells = [
            {
                "train_scenario": train_scenario_key,
                "eval_scenario": hard_scenario_key,
                "topology": topology_key,
                "seed": seed,
            }
            for seed in eval_seeds
        ]

    if train_seeds:
        cfg.journal_suite.profiles[train_profile] = OmegaConf.create(
            {
                "seeds": train_seeds,
                "topologies": [topology_key],
                "scenarios": [train_scenario_key],
                "methods": [method_key],
                "k_eval_values": [k_eval],
                "generalization_cells": [],
                "overrides": {
                    "common": common_overrides,
                    "train": _train_overrides(method_key),
                    "eval": eval_overrides,
                },
            }
        )

    cfg.journal_suite.profiles[eval_profile] = OmegaConf.create(
        {
            "seeds": eval_seeds,
            "topologies": [topology_key],
            "scenarios": eval_scenarios,
            "methods": [method_key],
            "k_eval_values": [k_eval],
            "generalization_cells": generalization_cells,
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
    parser.add_argument("--topology-key", default=DEFAULT_TOPOLOGY_KEY)
    parser.add_argument("--hard-scenario-key", default=DEFAULT_HARD_SCENARIO_KEY)
    parser.add_argument("--train-seeds", default="")
    parser.add_argument("--eval-seeds", default="0,1,2")
    parser.add_argument("--num-v-nets", type=int, default=DEFAULT_NUM_VNETS)
    parser.add_argument("--v-net-size-low", type=int, default=DEFAULT_VNET_SIZE_LOW)
    parser.add_argument("--v-net-size-high", type=int, default=DEFAULT_VNET_SIZE_HIGH)
    parser.add_argument("--arrival-lam", type=float, default=DEFAULT_ARRIVAL_LAM)
    parser.add_argument("--node-demand-high", type=int, default=DEFAULT_NODE_DEMAND_HIGH)
    parser.add_argument("--link-demand-high", type=int, default=DEFAULT_LINK_DEMAND_HIGH)
    parser.add_argument("--k-eval", type=int, default=DEFAULT_K_EVAL)
    parser.add_argument("--computation-budget", type=int, default=96)
    parser.add_argument("--parallelism", type=int, default=1)
    parser.add_argument(
        "--comparison-mode",
        choices=("zero_shot", "indomain"),
        default="zero_shot",
    )
    parser.add_argument(
        "--base-config",
        default="settings/experiments/journal_suite.yaml",
    )
    args = parser.parse_args()

    build_config(
        base_config_path=Path(args.base_config),
        config_path=Path(args.config_path),
        topology_key=args.topology_key,
        hard_scenario_key=args.hard_scenario_key,
        method_key=args.method_key,
        train_profile=args.train_profile,
        eval_profile=args.eval_profile,
        train_seeds=_parse_seed_list(args.train_seeds),
        eval_seeds=_parse_seed_list(args.eval_seeds),
        num_v_nets=args.num_v_nets,
        v_net_size_low=args.v_net_size_low,
        v_net_size_high=args.v_net_size_high,
        arrival_lam=args.arrival_lam,
        node_demand_high=args.node_demand_high,
        link_demand_high=args.link_demand_high,
        k_eval=args.k_eval,
        computation_budget=args.computation_budget,
        parallelism=args.parallelism,
        comparison_mode=args.comparison_mode,
    )
    print(f"wrote {args.config_path}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
