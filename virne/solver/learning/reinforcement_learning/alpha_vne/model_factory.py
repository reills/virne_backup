from __future__ import annotations

import importlib
from typing import Any, Tuple, Type

import torch.nn as nn


def normalize_model_name(name: str | None) -> str:
    key = str(name or "gcn").strip().lower()
    if key in {"legacy", "transformer", "net"}:
        return "transformer"
    if key in {"gcn", "gcn_small", "ppo_gcn", "dual_gcn_like"}:
        return "gcn"
    raise ValueError(f"Unsupported alpha_zero_backbone={name}")


def resolve_model_name(config_or_model_config: Any) -> str:
    if isinstance(config_or_model_config, dict):
        return normalize_model_name(config_or_model_config.get("model_name", "gcn"))

    training_cfg = getattr(config_or_model_config, "training", None)
    if isinstance(training_cfg, dict):
        return normalize_model_name(training_cfg.get("alpha_zero_backbone", "gcn"))
    if training_cfg is not None and hasattr(training_cfg, "alpha_zero_backbone"):
        return normalize_model_name(getattr(training_cfg, "alpha_zero_backbone"))
    return "gcn"


def _module_name_for_model(model_name: str) -> str:
    if model_name == "transformer":
        return ".net"
    if model_name == "gcn":
        return ".gcn_net"
    raise ValueError(f"Unsupported alpha_zero model_name={model_name}")


def get_model_classes(config_or_model_config: Any) -> Tuple[Type[nn.Module], Type[nn.Module]]:
    model_name = resolve_model_name(config_or_model_config)
    module = importlib.import_module(_module_name_for_model(model_name), package=__package__)
    return module.ActorCritic, module.ActorCriticScriptWrapper


def build_actor_critic(model_config: dict) -> nn.Module:
    actor_critic_cls, _ = get_model_classes(model_config)
    return actor_critic_cls(**model_config)


def prefers_trace_torchscript(config_or_model_config: Any) -> bool:
    return resolve_model_name(config_or_model_config) == "gcn"
