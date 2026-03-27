from __future__ import annotations

from typing import Any, Dict

from virne.solver.learning.rl_core.policy_builder import (
    get_p_net_edge_dim,
    get_p_net_x_dim,
    get_v_net_edge_dim,
    get_v_net_x_dim,
)

from .model_factory import resolve_model_name


def build_model_config(config: Any) -> Dict[str, Any]:
    """Build the AlphaZero model config using the shared RL feature-width helpers."""
    return {
        "model_name": resolve_model_name(config),
        "p_net_num_nodes": config.simulation.p_net_setting_num_nodes,
        "p_net_feature_dim": get_p_net_x_dim(config),
        "v_net_feature_dim": get_v_net_x_dim(config),
        "p_net_edge_dim": get_p_net_edge_dim(config),
        "v_net_edge_dim": get_v_net_edge_dim(config),
        "embedding_dim": getattr(config.nn, "embedding_dim", 96),
        "n_heads": getattr(config.nn, "n_heads", 6),
        "n_layers": getattr(config.nn, "transformer_layers", 2),
        "gnn_layers": getattr(config.nn, "num_gnn_layers", 3),
        "dropout": getattr(config.nn, "dropout_prob", 0.1),
        "allow_rejection": getattr(getattr(config, "solver", {}), "allow_rejection", False),
        "allow_revocable": getattr(getattr(config, "solver", {}), "allow_revocable", False),
        "max_seq_len": getattr(config.nn, "max_seq_len", 15),
    }
