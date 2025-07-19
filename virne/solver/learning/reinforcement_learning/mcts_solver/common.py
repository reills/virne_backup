from __future__ import annotations

import networkx as nx
import torch

from .net import ActorCritic
from .node import State
from ...utils import load_pyg_data_from_network


def serialize_state(state: State) -> dict:
    """Serialize a :class:`State` to a JSON-compatible dict."""
    return {
        "v_net": nx.node_link_data(state.v_net),
        "p_net": nx.node_link_data(state.p_net),
        "selected": state.selected_p_net_nodes,
        "v_node_id": state.v_node_id,
    }


def deserialize_state(state_dict: dict, controller, recorder, counter) -> State:
    """Reconstruct a :class:`State` from its serialized representation."""
    from virne.network import PhysicalNetwork, VirtualNetwork

    p_graph = nx.node_link_graph(state_dict["p_net"])
    v_graph = nx.node_link_graph(state_dict["v_net"])
    p_net = PhysicalNetwork(p_graph)
    v_net = VirtualNetwork(v_graph)

    state = State(p_net, v_net, controller, recorder, counter)
    state.selected_p_net_nodes = list(state_dict.get("selected", []))
    state.v_node_id = state_dict.get("v_node_id", -1)
    if state.selected_p_net_nodes:
        state.p_node_id = state.selected_p_net_nodes[-1]
    return state


def state_to_obs(
    state: State,
    policy: ActorCritic,
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

    # Use provided v_node_id or default to next virtual node
    target_v_node_id = v_node_id if v_node_id is not None else state.v_node_id + 1
    
    candidate_nodes = controller.find_candidate_nodes(
        v_net=state.v_net,
        p_net=state.p_net,
        v_node_id=target_v_node_id,
        filter=state.selected_p_net_nodes,
    )
    action_mask = torch.zeros(
        1,
        policy.actor.decoder.num_actions,
        dtype=torch.bool,
        device=device,
    )
    for idx in candidate_nodes:
        if 0 <= idx < action_mask.size(1):
            action_mask[0, idx] = True

    obs = {
        "p_net": p_data,
        "history_features": hist,
        "encoder_outputs": encoder_outputs,
        "curr_v_node_id": torch.tensor([target_v_node_id], device=device),
        "vnfs_remaining": torch.tensor([
            state.v_net.num_nodes - target_v_node_id
        ], device=device),
        "action_mask": action_mask,
        "v_net_x": v_data.x.unsqueeze(0),
    }
    return obs
