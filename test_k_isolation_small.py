#!/usr/bin/env python3
"""
Small-scale k-isolation experiment on a fixed 14-node Waxman topology using
k-specific transformer models. Endpoints (v0 and vL) are pinned to each ordered
pair of physical nodes; the model places the middle VNF.

Inputs are hard-wired per user request:
- P-net: /home/stephen-reilly/dev/virne/dataset/small_master/p_net.gml (14 nodes)
- Models: /home/stephen-reilly/dev/virne/dataset/small_master/output/model/model_k{K}.pkl

Outputs:
- results/k_isolation_small_14nodes_L3.csv (per run rows)
- results/summary_k_isolation_small_14nodes_L3.csv (aggregated acceptance per k)

This script is additive and does not modify existing repository files.
"""

import os
import csv
import time
import argparse
from pathlib import Path
from typing import Dict, Tuple
from copy import deepcopy

import torch
import networkx as nx

from virne.base import Controller, Recorder, Counter
from virne.data.physical_network import PhysicalNetwork
from virne.data.virtual_network import VirtualNetwork

from virne.solver.learning.a3c_gcn_pre_train_transformer.solver_pinned import (
    A3CTransformerPinned,
)
from virne.solver.learning.a3c_gcn_pre_train_transformer.instance_env2 import (
    PinnedInstanceEnv,
)


DEFAULT_PNET_PATH = \
    "/home/stephen-reilly/dev/virne/dataset/small_master/p_net.gml"
DEFAULT_MODELS_DIR = \
    "/home/stephen-reilly/dev/virne/dataset/small_master/output/model"


def build_low_regime_chain_vnet(L: int = 3, vid: int = 0,
                                cpu: int = 20, gpu: int = 20, rom: int = 20,
                                bw: int = 10) -> VirtualNetwork:
    """Create a single chain VNR with specified demands (defaults: low regime)."""
    node_attrs_setting = [
        {"distribution": "uniform", "dtype": "int", "generative": True,
         "high": int(cpu), "low": int(cpu), "name": "cpu", "owner": "node", "type": "resource"},
        {"distribution": "uniform", "dtype": "int", "generative": True,
         "high": int(gpu), "low": int(gpu), "name": "gpu", "owner": "node", "type": "resource"},
        {"distribution": "uniform", "dtype": "int", "generative": True,
         "high": int(rom), "low": int(rom), "name": "rom", "owner": "node", "type": "resource"},
    ]
    link_attrs_setting = [
        {"distribution": "uniform", "dtype": "int", "generative": True,
         "high": int(bw), "low": int(bw), "name": "bw", "owner": "link", "type": "resource"}
    ]

    vnet = VirtualNetwork(
        node_attrs_setting=node_attrs_setting,
        link_attrs_setting=link_attrs_setting,
        id=int(vid), arrival_time=0.0, lifetime=1000.0,
    )
    # Path topology yields a chain of length L
    vnet.generate_topology(num_nodes=L, type='path')
    vnet.generate_attrs_data(node=True, link=True)
    return vnet


def compute_feature_dims(pnet: PhysicalNetwork, vnet: VirtualNetwork) -> Tuple[int, int]:
    """Probe PinnedInstanceEnv once to infer p_net_x and v_net_x feature dims."""
    # Minimal controller/recorder/counter for env construction
    ctrl = Controller(node_attrs_setting=vnet.graph['node_attrs_setting'],
                      link_attrs_setting=vnet.graph['link_attrs_setting'],
                      reusable=True)
    cnt = Counter(node_attrs_setting=vnet.graph['node_attrs_setting'],
                  link_attrs_setting=vnet.graph['link_attrs_setting'])
    rec = Recorder(cnt, run_id='results/_probe', if_temp_save_records=False, verbose=0)
    env = PinnedInstanceEnv(
        pnet, vnet, ctrl, rec, cnt,
        allow_revocable=True, allow_rejection=False,
        pinned_v_to_p=None, phase=-1,
        shortest_method='k_shortest', k_shortest=1
    )
    obs = env.get_observation()
    p_dim = int(obs['p_net_x'].shape[1])
    v_dim = int(obs['v_net_x'].shape[1])
    return p_dim, v_dim


def derive_sim_info_for_solver(pnet: PhysicalNetwork, vnet: VirtualNetwork) -> Dict[str, int]:
    """Compute the sim-info counts expected by set_sim_info_to_object() in solver."""
    info = {}
    # Physical
    info['p_net_setting_num_nodes'] = pnet.num_nodes
    info['p_net_setting_num_node_attrs'] = len(pnet.get_node_attrs())
    info['p_net_setting_num_link_attrs'] = len(pnet.get_link_attrs())
    info['p_net_setting_num_node_resource_attrs'] = len(pnet.get_node_attrs(['resource']))
    info['p_net_setting_num_link_resource_attrs'] = len(pnet.get_link_attrs(['resource']))
    info['p_net_setting_num_node_extrema_attrs'] = len(pnet.get_node_attrs(['extrema']))

    # Virtual
    info['v_sim_setting_num_node_attrs'] = len(vnet.get_node_attrs())
    info['v_sim_setting_num_link_attrs'] = len(vnet.get_link_attrs())
    info['v_sim_setting_num_node_resource_attrs'] = len(vnet.get_node_attrs(['resource']))
    info['v_sim_setting_num_link_resource_attrs'] = len(vnet.get_link_attrs(['resource']))
    return info


def build_solver_for_k(k: int,
                       pnet: PhysicalNetwork,
                       vnet: VirtualNetwork,
                       p_dim: int, v_dim: int,
                       save_dir: str) -> A3CTransformerPinned:
    """Instantiate the pinned solver with greedy inference and revoke enabled."""
    sim_info = derive_sim_info_for_solver(pnet, vnet)
    kwargs = dict(
        # core flags
        solver_name='a3c_gcn_pre_train_transformer',
        save_dir=save_dir,
        reusable=True,
        verbose=0,
        # action/config
        node_ranking_method='order',
        link_ranking_method='order',
        matching_mathod='greedy',
        shortest_method='k_shortest',
        k_shortest=k,
        allow_revocable=True,
        allow_rejection=False,
        curriculum_phase=-1,
        # nn dims
        p_dimension_features=p_dim,
        v_dimension_features=v_dim,
        max_seq_len=15,
        # RL/compute
        use_cuda=torch.cuda.is_available(),
        num_train_epochs=0,
        batch_size=8,
    )
    kwargs.update(sim_info)

    ctrl = Controller(node_attrs_setting=vnet.graph['node_attrs_setting'],
                      link_attrs_setting=vnet.graph['link_attrs_setting'],
                      reusable=True)
    cnt = Counter(node_attrs_setting=vnet.graph['node_attrs_setting'],
                  link_attrs_setting=vnet.graph['link_attrs_setting'])
    rec = Recorder(cnt, run_id=save_dir, if_temp_save_records=False, verbose=0)

    solver = A3CTransformerPinned(ctrl, rec, cnt, **kwargs)
    solver.eval(decode_strategy='greedy')
    return solver


def load_model_for_k(solver: A3CTransformerPinned, models_dir: str, k: int) -> bool:
    """Load k-specific pretrained model. Returns True if successful."""
    fname = f"model_k{k}.pkl"
    path = os.path.join(models_dir, fname)
    if not os.path.exists(path):
        print(f"[WARN] Missing model for k={k}: {path}")
        return False
    solver.load_model(path)
    return True


def run_one_pair(solver: A3CTransformerPinned,
                 pnet: PhysicalNetwork,
                 vnet_template: VirtualNetwork,
                 s: int, t: int,
                 k: int,
                 repeats: int = 1) -> list:
    """Execute endpoint-pinned solves for (s,t) with optional repeats on same pnet copy."""
    results = []
    # Fresh P-net for this (s,t) group and k
    pnet_run = deepcopy(pnet)

    for r in range(repeats):
        vnet_run = deepcopy(vnet_template)
        start_time = time.time()

        # Pin endpoints: v0 -> s, v(L-1) -> t
        pinned = {0: int(s), vnet_run.num_nodes - 1: int(t)}
        solver.basic_config['pinned_v_to_p'] = pinned
        solver.basic_config['k_shortest'] = k

        # Build instance and solve on the evolving pnet_run
        instance = {'p_net': pnet_run, 'v_net': vnet_run}
        solution = solver.solve(instance)

        dur_ms = int((time.time() - start_time) * 1000)
        results.append({
            'k': k,
            's': s,
            't': t,
            'repeat': r,
            'success': bool(solution['result']),
            'place_result': bool(solution['place_result']),
            'route_result': bool(solution['route_result']),
            'revoke_times': int(solution['revoke_times']),
            'num_interactions': int(getattr(solution, 'num_interactions', 0)),
            'runtime_ms': dur_ms,
        })

    return results


def aggregate_summary(rows: list) -> list:
    """Compute acceptance and failure attribution per k."""
    by_k: Dict[int, Dict[str, int]] = {}
    for r in rows:
        k = r['k']
        d = by_k.setdefault(k, dict(total=0, success=0, place_fail=0, route_fail=0))
        d['total'] += 1
        if r['success']:
            d['success'] += 1
        else:
            if not r['place_result']:
                d['place_fail'] += 1
            elif not r['route_result']:
                d['route_fail'] += 1

    summary = []
    for k, d in sorted(by_k.items()):
        acc = d['success'] / max(1, d['total'])
        summary.append({
            'k': k,
            'total': d['total'],
            'success': d['success'],
            'acceptance': f"{acc:.4f}",
            'place_fail': d['place_fail'],
            'route_fail': d['route_fail'],
        })
    return summary


def main():
    parser = argparse.ArgumentParser(description='Small-scale k-isolation on 14-node Waxman with endpoint pinning')
    parser.add_argument('--pnet', type=str, default=DEFAULT_PNET_PATH, help='Path to p_net.gml')
    parser.add_argument('--models', type=str, default=DEFAULT_MODELS_DIR, help='Directory with model_k{K}.pkl files')
    parser.add_argument('--k-min', type=int, default=1)
    parser.add_argument('--k-max', type=int, default=15)
    parser.add_argument('--cpu', type=int, default=20, help='per-VNF CPU demand')
    parser.add_argument('--gpu', type=int, default=20, help='per-VNF GPU demand')
    parser.add_argument('--rom', type=int, default=20, help='per-VNF ROM demand')
    parser.add_argument('--bw', type=int, default=60, help='per-link BW demand (higher to stress routing)')
    parser.add_argument('--repeats', type=int, default=4, help='repeats per (s,t) without resetting P-net')
    parser.add_argument('--seed', type=int, default=42)
    parser.add_argument('--out', type=str, default='results/k_isolation_small_14nodes_L3.csv')
    args = parser.parse_args()

    # Ensure output directory exists
    out_path = Path(args.out)
    out_path.parent.mkdir(parents=True, exist_ok=True)
    summary_path = out_path.parent / out_path.name.replace('.csv', '_summary.csv')

    # Load physical network (14-node Waxman)
    if not os.path.exists(args.pnet):
        raise FileNotFoundError(f"Physical network file not found: {args.pnet}")
    pnet = PhysicalNetwork.load_dataset(args.pnet)
    assert pnet.num_nodes == 14, f"Expected 14-node P-net, got {pnet.num_nodes}"

    # Single VNR template (L=3, low regime)
    vnet = build_low_regime_chain_vnet(L=3, vid=0, cpu=args.cpu, gpu=args.gpu, rom=args.rom, bw=args.bw)

    # Infer feature dimensions
    p_dim, v_dim = compute_feature_dims(pnet, vnet)

    # Prepare all ordered endpoint pairs s!=t
    nodes = list(pnet.nodes)
    pairs = [(int(s), int(t)) for s in nodes for t in nodes if s != t]

    # CSV setup
    rows = []
    with open(out_path, 'w', newline='') as f:
        writer = csv.writer(f)
        writer.writerow(['k', 's', 't', 'repeat', 'success', 'place_result', 'route_result',
                         'revoke_times', 'num_interactions', 'runtime_ms'])

        # Sweep k
        for k in range(args.k_min, args.k_max + 1):
            print(f"\n=== k={k} ===")
            save_dir = str(out_path.parent / f"tmp_k{k}")
            solver = build_solver_for_k(k, pnet, vnet, p_dim, v_dim, save_dir)
            if not load_model_for_k(solver, args.models, k):
                print(f"[SKIP] k={k} (no model)")
                continue

            # Run all pairs
            for (s, t) in pairs:
                results = run_one_pair(solver, pnet, vnet, s, t, k, repeats=args.repeats)
                for res in results:
                    writer.writerow([
                        res['k'], res['s'], res['t'], res['repeat'],
                        int(res['success']), int(res['place_result']), int(res['route_result']),
                        res['revoke_times'], res['num_interactions'], res['runtime_ms']
                    ])
                    rows.append(res)

    # Write summary
    summary = aggregate_summary(rows)
    with open(summary_path, 'w', newline='') as f:
        writer = csv.writer(f)
        writer.writerow(['k', 'total', 'success', 'acceptance', 'place_fail', 'route_fail'])
        for s in summary:
            writer.writerow([s['k'], s['total'], s['success'], s['acceptance'], s['place_fail'], s['route_fail']])

    print(f"\nSaved detailed results to: {out_path}")
    print(f"Saved summary to:        {summary_path}")


if __name__ == '__main__':
    main()
