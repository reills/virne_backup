from __future__ import annotations

import warnings

import torch

# Torch Geometric triggers a CUDA init warning during import in this env.
warnings.filterwarnings(
    "ignore",
    message="CUDA initialization:.*",
    category=UserWarning,
)

from virne.solver.learning.reinforcement_learning.alpha_vne.net import (
    ActorCritic,
    ActorCriticScriptWrapper,
)


def _build_inputs(model: ActorCritic):
    torch.manual_seed(7)
    num_nodes = model.actor.decoder.p_net_num_nodes
    p_feat = model.actor.decoder.history_feature_dim
    edge_feat = getattr(model.actor.decoder, "p_net_edge_dim", 1)

    p_net_x = torch.randn(num_nodes, p_feat)
    edge_index = torch.tensor([[0, 1, 2], [1, 2, 3]], dtype=torch.long)
    edge_attr = torch.randn(edge_index.size(1), edge_feat)
    p_batch = torch.zeros(num_nodes, dtype=torch.long)
    selected_p_nodes = torch.tensor([1, 3], dtype=torch.long)

    v_net_x = torch.randn(1, 4, model.encoder.token_embed.in_features)
    encoder_outputs = model.encoder(v_net_x)

    curr_v_node_id = torch.tensor([2], dtype=torch.long)
    vnfs_remaining = torch.tensor([1], dtype=torch.long)
    action_mask = torch.ones((1, model.actor.decoder.num_actions), dtype=torch.bool)

    inputs = {
        "p_net_x": p_net_x,
        "p_net_edge_index": edge_index,
        "p_net_edge_attr": edge_attr,
        "p_net_batch": p_batch,
        "selected_p_nodes": selected_p_nodes,
        "encoder_outputs": encoder_outputs,
        "curr_v_node_id": curr_v_node_id,
        "vnfs_remaining": vnfs_remaining,
        "action_mask": action_mask,
    }
    return inputs


def test_torchscript_wrapper_matches_python():
    model = ActorCritic(
        p_net_num_nodes=4,
        p_net_feature_dim=3,
        v_net_feature_dim=2,
        p_net_edge_dim=1,
        embedding_dim=16,
        n_heads=2,
        n_layers=1,
        gnn_layers=1,
        dropout=0.0,
        allow_rejection=False,
        max_seq_len=6,
    ).eval()

    wrapper = ActorCriticScriptWrapper(model).eval()
    inputs = _build_inputs(model)

    # Python outputs
    history_len = inputs["selected_p_nodes"].size(0) + 1
    history_features = torch.zeros((1, history_len, inputs["p_net_x"].size(1)))
    history_features[0, 0, :] = model.actor.decoder.start_embedding
    history_features[0, 1:history_len, :] = inputs["p_net_x"].index_select(0, inputs["selected_p_nodes"])

    logits_py = model.actor.decoder.forward_from_tensors(
        p_net_x=inputs["p_net_x"],
        p_net_edge_index=inputs["p_net_edge_index"],
        p_net_edge_attr=inputs["p_net_edge_attr"],
        p_net_batch=inputs["p_net_batch"],
        history_features=history_features,
        encoder_outputs=inputs["encoder_outputs"],
        curr_v_node_id=inputs["curr_v_node_id"],
        vnfs_remaining=inputs["vnfs_remaining"],
        action_mask=inputs["action_mask"],
    )
    value_py = model.critic.forward_from_tensors(
        p_net_x=inputs["p_net_x"],
        p_net_edge_index=inputs["p_net_edge_index"],
        p_net_edge_attr=inputs["p_net_edge_attr"],
        p_net_batch=inputs["p_net_batch"],
        history_features=history_features,
        encoder_outputs=inputs["encoder_outputs"],
        curr_v_node_id=inputs["curr_v_node_id"],
        vnfs_remaining=inputs["vnfs_remaining"],
    )

    try:
        scripted = torch.jit.script(wrapper)
    except Exception:
        scripted = torch.jit.trace(wrapper, inputs, check_trace=False)
    logits_ts, value_ts = scripted(inputs)

    assert torch.allclose(logits_py, logits_ts, atol=1e-4, rtol=1e-4)
    assert torch.allclose(value_py, value_ts, atol=1e-4, rtol=1e-4)
