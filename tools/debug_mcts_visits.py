#!/usr/bin/env python3
"""Inspect raw C++ MCTS visit counts on a generated brain request.

Run with:
  conda run -n virne python tools/debug_mcts_visits.py
"""

from __future__ import annotations

import argparse
import os
import sys
from pathlib import Path

import torch

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))

from virne.network import PhysicalNetwork, VirtualNetworkRequestSimulator
from virne.solver.learning.reinforcement_learning.alpha_vne import alpha_zero_cpp_core as cpp


def build_cpp_network(net, *, preserve_link_orientation: bool) -> cpp.Network:
    cpp_net = cpp.Network()
    num_nodes = int(getattr(net, "num_nodes", len(net.nodes)))
    cpp_net.set_num_nodes(num_nodes)

    node_attrs: list[dict[str, float]] = [{} for _ in range(num_nodes)]
    for node_id, data in net.nodes(data=True):
        attrs = {}
        for key, value in data.items():
            if isinstance(value, (int, float, bool)):
                attrs[str(key)] = float(value)
        node_attrs[int(node_id)] = attrs
    cpp_net.set_node_attrs(node_attrs)

    edges: list[tuple[int, int]] = []
    edge_attrs: list[dict[str, float]] = []
    directed = False
    net_is_directed = bool(net.is_directed()) if hasattr(net, "is_directed") else False

    if preserve_link_orientation:
        directed = True
        for u, v, data in net.edges(data=True):
            oriented_edges = [(int(u), int(v))]
            if not net_is_directed and int(u) != int(v):
                oriented_edges.append((int(v), int(u)))
            attrs = {
                str(key): float(value)
                for key, value in data.items()
                if isinstance(value, (int, float, bool))
            }
            for src, dst in oriented_edges:
                edges.append((src, dst))
                edge_attrs.append(dict(attrs))
    else:
        for u, v, data in net.edges(data=True):
            edges.append((int(u), int(v)))
            edge_attrs.append(
                {
                    str(key): float(value)
                    for key, value in data.items()
                    if isinstance(value, (int, float, bool))
                }
            )

    cpp_net.set_edges(edges, is_directed=directed)
    cpp_net.set_edge_attrs(edge_attrs)
    cpp_net.reverse_edge_pairs_share_capacity = bool(
        preserve_link_orientation
        and not net_is_directed
        and os.environ.get("AZSFC_CPP_SHARE_REVERSE_EDGE_CAPACITY", "0") in {"1", "true", "True", "yes", "on"}
    )
    return cpp_net


def attr_names(attrs) -> list[str]:
    return [getattr(attr, "name", str(attr)) for attr in attrs]


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--dataset-dir",
        default="/home/stephen-reilly/dev/virne/datasets/generated/journal/nominal/brain/seed_0/train",
    )
    parser.add_argument("--v-net-index", type=int, default=0)
    parser.add_argument("--simulations", type=int, default=96)
    parser.add_argument("--c-puct", type=float, default=1.4)
    parser.add_argument("--seed", type=int, default=0)
    args = parser.parse_args()

    dataset_dir = Path(args.dataset_dir)
    p_net = PhysicalNetwork.load_dataset(str(dataset_dir))
    v_sim = VirtualNetworkRequestSimulator.load_dataset(str(dataset_dir))
    v_net = v_sim.v_nets[args.v_net_index]

    p_cpp = build_cpp_network(p_net, preserve_link_orientation=True)
    v_cpp = build_cpp_network(v_net, preserve_link_orientation=False)

    vnr_cfg = cpp.VNRConfig()
    vnr_cfg.node_resource_names = attr_names(p_net.get_node_attrs(types=["resource"]))
    vnr_cfg.link_resource_names = attr_names(p_net.get_link_attrs(types=["resource"]))
    vnr_cfg.node_constraint_names = list(vnr_cfg.node_resource_names)
    vnr_cfg.hard_constraint_names = list(vnr_cfg.node_resource_names)
    vnr_cfg.allow_rejection = False
    vnr_cfg.shortest_method = "k_shortest"
    vnr_cfg.k_shortest = 10

    state = cpp.VNRState(p_cpp, v_cpp, vnr_cfg)
    candidates = list(state.get_candidate_nodes())
    num_actions = int(p_cpp.num_nodes)

    root = cpp.StateView(1)
    root.step_index = 0
    root.curr_v_node_override = int(state.virtual_order[0]) if len(state.virtual_order) else 0
    root.domain_state = state
    mask = torch.zeros((1, num_actions), dtype=torch.bool)
    for action in candidates:
        if 0 <= int(action) < num_actions:
            mask[0, int(action)] = True
    root.action_mask = mask

    cfg = cpp.SearchConfig()
    cfg.simulations = int(args.simulations)
    cfg.c_puct = float(args.c_puct)
    cfg.dirichlet_alpha = 0.03
    cfg.dirichlet_epsilon = 0.1
    cfg.top_k_candidates = 24
    cfg.add_root_noise = True
    cfg.use_neural_network = True
    cfg.eval_batch_size = 1

    engine = cpp.MCTSEngine(cfg)
    engine.set_callbacks(
        lambda _state: [],
        lambda _state: (torch.zeros((1, num_actions), dtype=torch.float32), torch.tensor([0.0], dtype=torch.float32)),
        lambda _state: 0.0,
        lambda _state: False,
    )

    result = engine.run_search(root, args.seed)
    visits = result.visit_counts.cpu()
    priors = result.root_priors.cpu()
    policy = result.policy.cpu()

    candidate_visits = [(a, float(visits[a].item())) for a in candidates if 0 <= a < visits.numel()]
    nonzero = [(a, v) for a, v in candidate_visits if v > 0]
    top_visits = sorted(nonzero, key=lambda item: item[1], reverse=True)[:20]
    top_priors = sorted(
        [(a, float(priors[a].item())) for a in candidates if 0 <= a < priors.numel()],
        key=lambda item: item[1],
        reverse=True,
    )[:20]

    print(f"dataset={dataset_dir}")
    print(f"p_nodes={p_cpp.num_nodes} v_nodes={v_cpp.num_nodes} v_net_id={getattr(v_net, 'id', args.v_net_index)}")
    print(f"candidates={len(candidates)} num_actions={num_actions}")
    print(f"visit_sum={float(visits.sum().item())} nonzero_visits={len(nonzero)} max_visit={float(visits.max().item())}")
    print(f"policy_sum={float(policy.sum().item())} policy_nonzero={int((policy > 0).sum().item())} max_pi={float(policy.max().item())}")
    print(f"prior_sum={float(priors.sum().item())} prior_nonzero={int((priors > 0).sum().item())} max_prior={float(priors.max().item())}")
    print(f"top_visits={top_visits}")
    print(f"top_priors={top_priors}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
