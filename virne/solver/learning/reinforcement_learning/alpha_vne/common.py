from __future__ import annotations

import torch

from .feature_constructor import AlphaZeroFeatureAdapter
from .node import State


def state_to_obs(
    state: State,
    policy,
    controller,
    device: torch.device,
    p_data=None,
    v_data=None,
    encoder_outputs=None,
    v_node_id=None,
):
    """Build an observation dictionary for the given state."""

    if p_data is None or v_data is None or encoder_outputs is None:
        adapter = AlphaZeroFeatureAdapter(
            config=state.controller.config,
            p_net=state._original_p_net,
            v_net=state.v_net,
        )
        p_data, v_data = adapter.build_graphs(state, v_node_id=v_node_id)
        p_data = p_data.to(device)
        v_data = v_data.to(device)
        policy_device = next(policy.parameters()).device
        with torch.inference_mode():
            encoder_outputs = policy.encode({"v_net_x": v_data.x.unsqueeze(0).to(policy_device)})
        encoder_outputs = encoder_outputs.detach().to(device)

    history_len = len(state.selected_p_net_nodes) + 1
    hist = torch.zeros(
        1,
        history_len,
        p_data.num_node_features,
        dtype=p_data.x.dtype,
        device=device,
    )
    start_embedding = policy.actor.decoder.start_embedding.detach().to(device=device, dtype=p_data.x.dtype)
    if start_embedding.numel() > 0:
        hist[0, 0, : min(hist.size(-1), start_embedding.numel())] = start_embedding[: hist.size(-1)]
    for i, idx in enumerate(state.selected_p_net_nodes):
        if 0 <= idx < p_data.num_nodes:
            hist[0, i + 1] = p_data.x[idx]

    # Determine the actual virtual node to place next using state's ordering if present
    if v_node_id is not None:
        target_v_node_id = v_node_id
    else:
        # Next step index in the ordering
        next_pos = state.v_node_id + 1
        if hasattr(state, 'v_order') and 0 <= next_pos < state.v_net.num_nodes:
            target_v_node_id = state.v_order[next_pos]
        else:
            target_v_node_id = next_pos
    
    if hasattr(state, "get_candidate_node_ids"):
        candidate_nodes = state.get_candidate_node_ids(v_target=target_v_node_id)
    else:
        candidate_nodes = controller.find_candidate_nodes(
            v_net=state.v_net,
            p_net=state.p_net,
            v_node_id=target_v_node_id,
            filter=state.selected_p_net_nodes,
            check_link_constraint=False,
        )
    num_actions = getattr(policy.actor.decoder, 'num_actions', None)
    if num_actions is None:
        num_actions = p_data.num_nodes
    action_mask = torch.zeros(1, num_actions, dtype=torch.bool, device=device)
    for idx in candidate_nodes:
        if 0 <= idx < action_mask.size(1):
            action_mask[0, idx] = True

    candidate_feature_dim = int(getattr(getattr(policy, "_policy_head", None), "candidate_feature_dim", 8))
    candidate_features = torch.zeros(
        1,
        num_actions,
        candidate_feature_dim,
        dtype=p_data.x.dtype,
        device=device,
    )

    # Step index for positional embedding in decoder: use placement step, not virtual node id
    curr_step_idx = len(state.selected_p_net_nodes)
    # Remaining vnfs by step count (independent of virtual id values)
    vnfs_remaining = max(state.v_net.num_nodes - (curr_step_idx + 1), 0)

    obs = {
        "p_net": p_data,
        "history_features": hist,
        "history_lengths": torch.tensor([history_len], dtype=torch.long, device=device),
        "encoder_outputs": encoder_outputs,
        "curr_v_node_id": torch.tensor([curr_step_idx], dtype=torch.long, device=device),
        "vnfs_remaining": torch.tensor([vnfs_remaining], dtype=torch.long, device=device),
        "action_mask": action_mask,
        "candidate_features": candidate_features,
        "v_net_x": v_data.x.unsqueeze(0),
    }
    return obs
