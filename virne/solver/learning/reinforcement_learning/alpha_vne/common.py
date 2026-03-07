from __future__ import annotations

import torch

from .node import State
from ...utils import load_pyg_data_from_network


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
        p_data = load_pyg_data_from_network(state.p_net).to(device)
        v_data = load_pyg_data_from_network(state.v_net).to(device)
        encoder_outputs = policy.encode({"v_net_x": v_data.x.unsqueeze(0)})

    history_len = len(state.selected_p_net_nodes) + 1
    hist = torch.zeros(
        1,
        history_len,
        p_data.num_node_features,
        dtype=p_data.x.dtype,
        device=device,
    )
    hist[0, 0] = policy.actor.decoder.start_embedding
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

    # Step index for positional embedding in decoder: use placement step, not virtual node id
    curr_step_idx = len(state.selected_p_net_nodes)
    # Remaining vnfs by step count (independent of virtual id values)
    vnfs_remaining = max(state.v_net.num_nodes - (curr_step_idx + 1), 0)

    obs = {
        "p_net": p_data,
        "history_features": hist,
        "encoder_outputs": encoder_outputs,
        "curr_v_node_id": torch.tensor([curr_step_idx], dtype=torch.long, device=device),
        "vnfs_remaining": torch.tensor([vnfs_remaining], dtype=torch.long, device=device),
        "action_mask": action_mask,
        "v_net_x": v_data.x.unsqueeze(0),
    }
    return obs
