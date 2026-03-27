#!/usr/bin/env python3
from __future__ import annotations

import argparse
from pathlib import Path

from omegaconf import OmegaConf


HARD_SCENARIO_KEY = "wx500_hard_compare"


def _parse_seed_list(raw: str) -> list[int]:
    text = raw.strip()
    if not text:
        return []
    return [int(part.strip()) for part in text.split(",") if part.strip()]


def _profile_common_overrides(method_key: str) -> list[str]:
    if method_key != "alpha_zero_sfc":
        return ["training.resume_training=false"]
    return [
        "training.pure_cpp=false",
        "training.use_cpp_mcts=false",
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
        "training.num_train_epochs=12",
        "training.c_puct=1.4",
        "training.max_training_steps=1000",
        "training.min_buffer_size=128",
        "training.num_train_steps_per_epoch=128",
        "training.max_empty_batches=1800",
        "training.save_interval=256",
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
) -> None:
    cfg = OmegaConf.load(str(base_config_path))
    cfg.journal_suite.default_profile = eval_profile
    cfg.journal_suite.scenarios[HARD_SCENARIO_KEY] = OmegaConf.create(
        {
            "train_split": "train",
            "eval_split": "test",
            "v_sim_setting_overrides": {
                "num_v_nets": 1000,
                "v_net_size": {
                    "low": 3,
                    "high": 15,
                },
                "node_attrs_setting": [
                    {
                        "high": 30,
                    }
                ],
                "link_attrs_setting": [
                    {
                        "high": 75,
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
    )
    print(f"wrote {args.config_path}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
