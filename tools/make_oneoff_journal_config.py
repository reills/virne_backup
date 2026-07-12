#!/usr/bin/env python3
"""Create a one-off journal experiment config for a single-seed rerun."""

from __future__ import annotations

import argparse
from pathlib import Path

from omegaconf import OmegaConf


def _replace_override(items: object, key: str, value: object) -> list[str]:
    entries = [str(item) for item in (items or [])]
    entries = [item for item in entries if item.split("=", 1)[0].strip() != key]
    entries.append(f"{key}={value}")
    return entries


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(
        description="Build a one-off journal-suite config with one seed and max training steps."
    )
    parser.add_argument("--config", required=True, help="Source journal suite config YAML.")
    parser.add_argument("--out", required=True, help="Output one-off config YAML.")
    parser.add_argument("--train-profile", required=True, help="Train profile key to modify.")
    parser.add_argument("--eval-profile", required=True, help="Eval profile key to modify.")
    parser.add_argument("--seed", required=True, type=int, help="Single seed to run.")
    parser.add_argument(
        "--max-training-steps",
        required=True,
        type=int,
        help="Override training.max_training_steps for the train profile.",
    )
    parser.add_argument("--stamp", required=True, help="Unique suffix for run IDs and registry files.")
    parser.add_argument(
        "--train-k-values",
        default=None,
        help="Optional comma-separated train k values, e.g. 1 or 1,3,5.",
    )
    parser.add_argument(
        "--eval-k-values",
        default=None,
        help="Optional comma-separated evaluation k values, e.g. 1 or 1,3,5.",
    )
    return parser


def main() -> int:
    args = build_parser().parse_args()
    config_path = Path(args.config)
    out_path = Path(args.out)

    cfg = OmegaConf.load(str(config_path))
    profiles = cfg.journal_suite.profiles
    if args.train_profile not in profiles:
        raise SystemExit(f"missing train profile: {args.train_profile}")
    if args.eval_profile not in profiles:
        raise SystemExit(f"missing eval profile: {args.eval_profile}")

    train_k_values = None
    if args.train_k_values:
        train_k_values = [
            int(value.strip())
            for value in args.train_k_values.split(",")
            if value.strip()
        ]
        if not train_k_values:
            raise SystemExit("--train-k-values did not contain any k values")
    eval_k_values = None
    if args.eval_k_values:
        eval_k_values = [
            int(value.strip())
            for value in args.eval_k_values.split(",")
            if value.strip()
        ]
        if not eval_k_values:
            raise SystemExit("--eval-k-values did not contain any k values")

    profiles[args.train_profile].seeds = [args.seed]
    profiles[args.eval_profile].seeds = [args.seed]
    if eval_k_values is not None:
        profiles[args.eval_profile].k_eval_values = eval_k_values

    if train_k_values is not None:
        method_keys = [str(value) for value in profiles[args.train_profile].methods]
        for method_key in method_keys:
            method_cfg = cfg.journal_suite.methods[method_key]
            if bool(method_cfg.get("trainable", False)):
                method_cfg.train_k_values = train_k_values

    train_overrides = profiles[args.train_profile].get("overrides", {})
    train_overrides["train"] = _replace_override(
        train_overrides.get("train", []),
        "training.max_training_steps",
        args.max_training_steps,
    )
    profiles[args.train_profile]["overrides"] = train_overrides

    train_k_token = "base"
    if train_k_values is not None:
        train_k_token = "-".join(str(value) for value in train_k_values)
    eval_k_token = "base"
    if eval_k_values is not None:
        eval_k_token = "-".join(str(value) for value in eval_k_values)
    suffix = (
        f"oneoff_seed{args.seed}_ktrain{train_k_token}_"
        f"keval{eval_k_token}_steps{args.max_training_steps}_{args.stamp}"
    )
    cfg.journal_suite.name = f"{cfg.journal_suite.name}__{suffix}"

    registry_path = out_path.parent / f"model_registry__{suffix}.csv"
    shards_dir = out_path.parent / f"model_registry_shards__{suffix}"
    cfg.journal_suite.paths.model_registry_path = str(registry_path.resolve())
    cfg.journal_suite.paths.model_registry_shards_dir = str(shards_dir.resolve())

    out_path.parent.mkdir(parents=True, exist_ok=True)
    OmegaConf.save(cfg, str(out_path))
    print(f"wrote {out_path}")
    print(f"registry {registry_path}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
