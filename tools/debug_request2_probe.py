#!/usr/bin/env python3
from __future__ import annotations

import argparse
import copy
import os
import sys
from collections import defaultdict

from omegaconf import OmegaConf
import torch

REPO_ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
if REPO_ROOT not in sys.path:
    sys.path.insert(0, REPO_ROOT)

from tools.compare_alpha_py_cpp_parity import (
    _build_actor,
    _build_runtime,
    _clone_config,
    _first_divergence,
    _trace_python_like,
)
from virne.solver.learning.reinforcement_learning.alpha_vne.node import Node, PhysicalNetworkView, State
from virne.utils.config import add_simulation_into_config
from virne.utils import path_to_links


def _parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(description="Probe Python/C++ state parity around a request-2 action prefix.")
    parser.add_argument("--config", default="results/.hydra/config.yaml")
    parser.add_argument(
        "--prefix",
        default="93,60,28,80,95,1",
        help="Comma-separated action prefix to replay within request 2.",
    )
    parser.add_argument(
        "--trace-actions",
        default="50,67",
        help="Comma-separated child actions to diff path enumeration for at the final prefix state.",
    )
    parser.add_argument(
        "--print-request-traces",
        action="store_true",
        help="Print full Python vs adapter request traces before focused prefix probing.",
    )
    return parser


def _demands_for_edge(state: State, v_src: int, v_dst: int) -> dict[str, float]:
    edge_attrs = state._virtual_edge_attrs(v_src, v_dst)
    demands: dict[str, float] = {}
    for attr in state.controller.link_resource_attrs:
        demand = float(edge_attrs.get(attr.name, 0.0))
        if demand > 0.0:
            demands[attr.name] = demand
    return demands


def _canonical_link_key(state: State, u: int, v: int) -> tuple[int, int]:
    try:
        if bool(state._original_p_net.is_directed()):
            return (u, v)
    except Exception:
        pass
    return (u, v) if u <= v else (v, u)


def _python_path_trace(state: State, action: int) -> list[dict]:
    new_v = state.v_order[state.v_node_id + 1]
    link_alloc = {k: v.copy() for k, v in state._resource_allocations["link"].items()}
    node_alloc = {k: v.copy() for k, v in state._resource_allocations["node"].items()}
    shortest_method = state.link_params.get("shortest_method", "bfs_shortest")
    k_limit = int(state.link_params.get("k", 1))
    if shortest_method in ("bfs_shortest", "first_shortest", "available_shortest"):
        k_limit = 1
    records: list[dict] = []

    for neighbor in state.v_net.adj[new_v]:
        if state.v_pos[neighbor] > state.v_node_id:
            continue
        p_u = action
        p_v = state.selected_p_net_nodes[state.v_pos[neighbor]]
        demands = _demands_for_edge(state, new_v, neighbor)
        p_view = PhysicalNetworkView(state._original_p_net, {"node": node_alloc, "link": link_alloc})
        paths = state.controller.topology_analyzer.find_shortest_paths(
            state.v_net,
            p_view,
            (new_v, neighbor),
            (p_u, p_v),
            method=shortest_method,
            k=max(1, k_limit),
        )
        selected = None
        for path in paths:
            feasible = True
            for p_link in path_to_links(path):
                link_view = p_view.links[p_link]
                for attr_name, demand in demands.items():
                    if link_view.get(attr_name, 0.0) + 1e-8 < demand:
                        feasible = False
                        break
                if not feasible:
                    break
            if feasible:
                selected = list(path)
                break
        fallback_paths = []
        if selected is None and shortest_method != "available_shortest":
            fallback_paths = state.controller.topology_analyzer.find_shortest_paths(
                state.v_net,
                p_view,
                (new_v, neighbor),
                (p_u, p_v),
                method="available_shortest",
                k=1,
            )
            for path in fallback_paths:
                feasible = True
                for p_link in path_to_links(path):
                    link_view = p_view.links[p_link]
                    for attr_name, demand in demands.items():
                        if link_view.get(attr_name, 0.0) + 1e-8 < demand:
                            feasible = False
                            break
                    if not feasible:
                        break
                if feasible:
                    selected = list(path)
                    break
        if selected is not None:
            for u, v in path_to_links(selected):
                key = (u, v)
                if key not in link_alloc:
                    link_alloc[key] = {}
                for attr_name, demand in demands.items():
                    link_alloc[key][attr_name] = link_alloc[key].get(attr_name, 0.0) + demand
        records.append(
            {
                "neighbor": int(neighbor),
                "p_pair": [int(p_u), int(p_v)],
                "demands": demands,
                "paths": [list(path) for path in paths],
                "fallback_paths": [list(path) for path in fallback_paths],
                "selected_path": selected,
            }
        )
    return records


def _cpp_path_trace(state: State, cpp_state, action: int) -> list[dict]:
    new_v = state.v_order[state.v_node_id + 1]
    local_used: dict[tuple[int, int], dict[str, float]] = defaultdict(dict)
    shortest_method = state.link_params.get("shortest_method", "bfs_shortest")
    records: list[dict] = []

    for neighbor in state.v_net.adj[new_v]:
        if state.v_pos[neighbor] > state.v_node_id:
            continue
        p_u = action
        p_v = state.selected_p_net_nodes[state.v_pos[neighbor]]
        demands = _demands_for_edge(state, new_v, neighbor)

        def feasible(path: list[int]) -> bool:
            for u, v in path_to_links(path):
                key = _canonical_link_key(state, u, v)
                for attr_name, demand in demands.items():
                    available = float(cpp_state.get_available_link_resource(u, v, attr_name))
                    available -= local_used.get(key, {}).get(attr_name, 0.0)
                    if available + 1e-8 < demand:
                        return False
            return True

        paths = [list(path) for path in cpp_state.debug_find_paths(p_u, p_v, demands)]
        selected = None
        for path in paths:
            if len(path) < 2:
                continue
            if feasible(path):
                selected = list(path)
                break

        fallback_paths = []

        if selected is not None:
            for u, v in path_to_links(selected):
                key = _canonical_link_key(state, u, v)
                bucket = local_used[key]
                for attr_name, demand in demands.items():
                    bucket[attr_name] = bucket.get(attr_name, 0.0) + demand

        records.append(
            {
                "neighbor": int(neighbor),
                "p_pair": [int(p_u), int(p_v)],
                "demands": demands,
                "paths": paths,
                "fallback_paths": fallback_paths,
                "selected_path": selected,
            }
        )
    return records


def _sum_allocations(allocations: dict) -> dict[str, float]:
    totals: dict[str, float] = defaultdict(float)
    for attrs in allocations.values():
        for attr_name, value in attrs.items():
            totals[str(attr_name)] += float(value)
    return dict(sorted(totals.items()))


def _diff_allocations(lhs: dict, rhs: dict) -> list[dict]:
    diffs: list[dict] = []
    all_keys = sorted(set(lhs) | set(rhs), key=lambda item: tuple(map(int, item)) if isinstance(item, tuple) else int(item))
    for key in all_keys:
        lhs_attrs = lhs.get(key, {})
        rhs_attrs = rhs.get(key, {})
        attr_names = sorted(set(lhs_attrs) | set(rhs_attrs))
        delta = {}
        for attr_name in attr_names:
            lhs_val = float(lhs_attrs.get(attr_name, 0.0))
            rhs_val = float(rhs_attrs.get(attr_name, 0.0))
            if abs(lhs_val - rhs_val) > 1e-6:
                delta[attr_name] = {"py": lhs_val, "cpp_rebuilt": rhs_val}
        if delta:
            diffs.append({"key": key, "delta": delta})
    return diffs


def _count_reverse_duplicates(allocations: dict[tuple[int, int], dict]) -> tuple[int, list[tuple[tuple[int, int], tuple[int, int]]]]:
    seen: set[tuple[int, int]] = set()
    dup_pairs: list[tuple[tuple[int, int], tuple[int, int]]] = []
    for u, v in allocations:
        canonical = (u, v) if u <= v else (v, u)
        if canonical in seen:
            dup_pairs.append(((u, v), (v, u)))
            continue
        seen.add(canonical)
    return len(dup_pairs), dup_pairs[:10]


def _state_valid_actions(state: State) -> tuple[int | None, list[int], list[int]]:
    if state.p_node_id == -1 or state.v_node_id + 1 >= len(state.v_order):
        return None, [], []
    v_target = state.v_order[state.v_node_id + 1]
    candidates = list(state.get_candidate_node_ids(v_target=v_target))
    valid = []
    for action in candidates:
        child = state._create_child_state(int(action))
        if child.p_node_id != -1:
            valid.append(int(action))
    return int(v_target), [int(x) for x in candidates], valid


def main() -> int:
    args = _parser().parse_args()
    cfg = OmegaConf.load(args.config)
    add_simulation_into_config(cfg)
    model = cfg.training.alphazero_model_path

    runtime_cfg = _clone_config(cfg, run_suffix="dbg_env", use_cpp_mcts=False, pure_cpp=False, internal_logs=False)
    add_simulation_into_config(runtime_cfg)
    _, logger, counter, controller, recorder, env = _build_runtime(runtime_cfg, "CRITICAL", False)
    env.reset(seed=cfg.experiment.seed)
    actual_p_nodes = int(env.p_net.num_nodes)

    py_cfg = _clone_config(cfg, run_suffix="dbg_py", use_cpp_mcts=False, pure_cpp=False, internal_logs=False)
    adapter_cfg = _clone_config(cfg, run_suffix="dbg_cpp_adapter", use_cpp_mcts=True, pure_cpp=False, internal_logs=False)
    add_simulation_into_config(py_cfg)
    add_simulation_into_config(adapter_cfg)
    py_cfg.simulation.p_net_setting_num_nodes = actual_p_nodes
    adapter_cfg.simulation.p_net_setting_num_nodes = actual_p_nodes
    py_cfg.rl.feature_constructor.p_num_nodes = actual_p_nodes
    adapter_cfg.rl.feature_constructor.p_num_nodes = actual_p_nodes
    py_actor = _build_actor(py_cfg, controller, recorder, counter, logger, model)
    adapter_actor = _build_actor(adapter_cfg, controller, recorder, counter, logger, model, force_adapter=True)

    arrival_seen = 0
    while True:
        if int(env.curr_event["type"]) != 1:
            done = env.transit_obs()
            if done:
                raise RuntimeError("Environment ended before request 2.")
            continue
        obs = env.get_observation()
        if arrival_seen == 2:
            break
        solution, _ = _trace_python_like(
            py_actor,
            copy.deepcopy(obs["v_net"]),
            copy.deepcopy(obs["p_net"]),
            mode="python",
        )
        _, _, done, _ = env.step(solution)
        arrival_seen += 1
        if done:
            raise RuntimeError("Environment ended before request 2.")

    obs = env.get_observation()
    p_net = copy.deepcopy(obs["p_net"])
    v_net = copy.deepcopy(obs["v_net"])

    if args.print_request_traces:
        _, py_trace = _trace_python_like(py_actor, copy.deepcopy(v_net), copy.deepcopy(p_net), mode="python")
        _, adapter_trace = _trace_python_like(adapter_actor, copy.deepcopy(v_net), copy.deepcopy(p_net), mode="cpp_adapter")
        divergence = _first_divergence(py_trace, adapter_trace)
        print("=== request trace summary ===")
        print(f"py_actions={py_trace.actions}")
        print(f"adapter_actions={adapter_trace.actions}")
        print(f"py_step_vnodes={[int(step.v_node_id) for step in py_trace.steps]}")
        print(f"adapter_step_vnodes={[int(step.v_node_id) for step in adapter_trace.steps]}")
        print(f"py_vs_adapter_divergence={divergence}")

    py_actor.obs_builder.set_episode_data(p_net, v_net)
    adapter_actor.obs_builder.set_episode_data(p_net, v_net)
    root = State(
        p_net,
        v_net,
        controller,
        recorder,
        counter,
        link_params={
            "shortest_method": py_actor.shortest_method,
            "k": py_actor.k_shortest,
        },
    )
    adapter_actor.cpp_adapter.begin_request(p_net, v_net)
    adapter_actor.cpp_adapter._ensure_cpp_networks(root)
    cpp_state = adapter_actor.cpp_adapter._initialize_cpp_state(root)

    prefix = [int(part) for part in args.prefix.split(",") if part.strip()]
    trace_actions = [int(part) for part in args.trace_actions.split(",") if part.strip()]
    py_state = root
    cpp_curr = cpp_state

    print(f"request_index={arrival_seen}")
    print(f"full_prefix={prefix}")
    print(
        "root="
        f"(py_v_node_id={py_state.v_node_id}, cpp_v_node_id={cpp_curr.current_virtual_index}, "
        f"selected={py_state.selected_p_net_nodes})"
    )

    for prefix_len in range(len(prefix) + 1):
        prefix_slice = prefix[:prefix_len]
        print(f"\n=== prefix_len={prefix_len} prefix={prefix_slice} ===")
        print(
            "state="
            f"(py_v_node_id={py_state.v_node_id}, py_p_node_id={py_state.p_node_id}, "
            f"cpp_v_node_id={cpp_curr.current_virtual_index}, cpp_p_node_id={cpp_curr.last_physical_node}, "
            f"selected={py_state.selected_p_net_nodes})"
        )
        if py_state.p_node_id == -1 or cpp_curr.last_physical_node == -1:
            print("state_invalid=True")
        if py_state.v_node_id + 1 < len(py_state.v_order):
            v_target = py_state.v_order[py_state.v_node_id + 1]
            py_candidates = list(py_state.get_candidate_node_ids(v_target=v_target))
            cpp_candidates = list(cpp_curr.get_candidate_nodes())
            py_valid = []
            for action in py_candidates:
                child = py_state._create_child_state(int(action))
                if child.p_node_id != -1:
                    py_valid.append(int(action))
            cpp_valid = []
            for action in cpp_candidates:
                child = cpp_curr.create_child(int(action))
                if child.last_physical_node != -1:
                    cpp_valid.append(int(action))

            print(f"next_v_target={v_target}")
            print(f"py_candidates={py_candidates}")
            print(f"cpp_candidates={cpp_candidates}")
            print(f"py_valid={py_valid}")
            print(f"cpp_valid={cpp_valid}")
            print(f"py_only={sorted(set(py_valid) - set(cpp_valid))}")
            print(f"cpp_only={sorted(set(cpp_valid) - set(py_valid))}")
        else:
            print("terminal_prefix=True")

        if prefix_len == len(prefix):
            break
        action = prefix[prefix_len]
        py_state = py_state._create_child_state(action)
        cpp_curr = cpp_curr.create_child(int(action))

    if py_state.p_node_id != -1 and cpp_curr.last_physical_node != -1 and py_state.v_node_id + 1 < len(py_state.v_order):
        rebuilt_state = adapter_actor.cpp_adapter._python_state_from_cpp(root, cpp_curr)
        target_v_node = int(py_state.v_order[py_state.v_node_id + 1])
        print("\n=== reconstructed state comparison at final prefix ===")
        print(f"py_node_alloc_totals={_sum_allocations(py_state._resource_allocations['node'])}")
        print(f"rebuilt_node_alloc_totals={_sum_allocations(rebuilt_state._resource_allocations['node'])}")
        print(f"py_link_alloc_totals={_sum_allocations(py_state._resource_allocations['link'])}")
        print(f"rebuilt_link_alloc_totals={_sum_allocations(rebuilt_state._resource_allocations['link'])}")
        py_link_diffs = _diff_allocations(py_state._resource_allocations["link"], rebuilt_state._resource_allocations["link"])
        print(f"link_alloc_diff_count={len(py_link_diffs)}")
        print(f"link_alloc_diff_sample={py_link_diffs[:10]}")
        dup_count, dup_sample = _count_reverse_duplicates(rebuilt_state._resource_allocations["link"])
        print(f"rebuilt_reverse_dup_count={dup_count}")
        print(f"rebuilt_reverse_dup_sample={dup_sample}")

        print("\n=== policy comparison at final prefix ===")
        py_obs = py_actor._state_to_obs(py_state, target_v_node)
        cpp_obs = adapter_actor.cpp_adapter.build_obs_from_cpp_state(cpp_curr, v_node_id=target_v_node)
        py_logits, py_value = py_actor.policy_network.evaluate(py_obs)
        cpp_logits, cpp_value = adapter_actor.policy_network.evaluate(cpp_obs)
        py_mask = py_obs.get("action_mask").squeeze(0).to(torch.bool)
        cpp_mask = cpp_obs.get("action_mask").squeeze(0).to(torch.bool)
        py_probs = torch.softmax(py_logits.squeeze(0) if py_logits.dim() > 1 else py_logits, dim=-1)
        cpp_probs = torch.softmax(cpp_logits.squeeze(0) if cpp_logits.dim() > 1 else cpp_logits, dim=-1)
        py_top = torch.topk(py_probs, k=10)
        cpp_top = torch.topk(cpp_probs, k=10)
        print(f"py_mask_count={int(py_mask.sum().item())} cpp_mask_count={int(cpp_mask.sum().item())}")
        print(f"py_top_actions={list(zip(py_top.indices.tolist(), py_top.values.tolist()))}")
        print(f"cpp_top_actions={list(zip(cpp_top.indices.tolist(), cpp_top.values.tolist()))}")
        print(f"py_value={py_value} cpp_value={cpp_value}")
        print(f"p_net_x_max_abs_diff={(py_obs['p_net'].x - cpp_obs['p_net'].x).abs().max().item()}")
        print(f"p_net_edge_attr_max_abs_diff={(py_obs['p_net'].edge_attr - cpp_obs['p_net'].edge_attr).abs().max().item()}")
        print(f"history_max_abs_diff={(py_obs['history_features'] - cpp_obs['history_features']).abs().max().item()}")
        print("\n=== direct C++ engine result at final prefix ===")
        from virne.solver.learning.reinforcement_learning.alpha_vne import alpha_zero_cpp_core as cpp_core  # type: ignore
        state_view = cpp_core.StateView(1)
        state_view.step_index = len(py_state.selected_p_net_nodes)
        state_view.curr_v_node_override = target_v_node
        state_view.domain_state = cpp_curr
        cb_logits, cb_value = adapter_actor.cpp_adapter._evaluate_callback(state_view)
        cb_mask = state_view.action_mask.cpu()
        cb_probs = torch.softmax(cb_logits.squeeze(0) if cb_logits.dim() > 1 else cb_logits, dim=-1).cpu()
        cb_top = torch.topk(cb_probs, k=10)
        print(f"callback_mask_count={int(cb_mask.sum().item())}")
        print(f"callback_top_actions={list(zip(cb_top.indices.tolist(), cb_top.values.tolist()))}")
        print(f"callback_value={float(cb_value.item())}")
        state_view.policy_logits = cb_logits
        state_view.value = cb_value
        search_seed = adapter_actor.cpp_adapter._search_seed_for_step(state_view.step_index)
        engine_result = adapter_actor.cpp_adapter._engine.run_search(state_view, search_seed)
        engine_visits = engine_result.visit_counts.cpu()
        engine_priors = engine_result.root_priors.cpu()
        engine_top_visits = torch.topk(engine_visits, k=10)
        engine_top_priors = torch.topk(engine_priors, k=10)
        print(f"engine_total_visits={int(engine_visits.sum().item())}")
        print(f"engine_top_visits={list(zip(engine_top_visits.indices.tolist(), [int(v) for v in engine_top_visits.values.tolist()]))}")
        print(f"engine_top_priors={list(zip(engine_top_priors.indices.tolist(), engine_top_priors.values.tolist()))}")

        print("\n=== one-step search comparison at final prefix ===")
        py_root_node = Node(None, py_state)
        py_actor.search(py_root_node, target_v_node, add_root_noise=False)
        py_child_visits = {
            int(child.state.p_node_id): int(child.visit_times)
            for child in py_root_node.children
            if int(child.visit_times) > 0
        }
        py_visit_items = sorted(py_child_visits.items(), key=lambda item: (-item[1], item[0]))[:10]
        print(f"py_search_top_visits={py_visit_items}")

        adapter_root_node = Node(None, rebuilt_state)
        adapter_actor.search(adapter_root_node, target_v_node, add_root_noise=False)
        adapter_child_visits = {
            int(child.state.p_node_id): int(child.visit_times)
            for child in adapter_root_node.children
            if int(child.visit_times) > 0
        }
        adapter_visit_items = sorted(adapter_child_visits.items(), key=lambda item: (-item[1], item[0]))[:10]
        print(f"adapter_search_top_visits={adapter_visit_items}")

        print("\n=== path traces at final prefix ===")
        for action in trace_actions:
            print(f"\n--- action={action} ---")
            print(f"python_trace={_python_path_trace(py_state, action)}")
            print(f"cpp_trace={_cpp_path_trace(py_state, cpp_curr, action)}")
            py_child = py_state._create_child_state(int(action))
            cpp_child = cpp_curr.create_child(int(action))
            rebuilt_child = adapter_actor.cpp_adapter._python_state_from_cpp(root, cpp_child)
            print(
                "child_state="
                f"(py_valid={py_child.p_node_id != -1}, cpp_valid={cpp_child.last_physical_node != -1}, "
                f"py_v_node_id={getattr(py_child, 'v_node_id', None)}, cpp_v_node_id={getattr(cpp_child, 'current_virtual_index', None)})"
            )
            if py_child.p_node_id != -1 and cpp_child.last_physical_node != -1:
                if py_child.is_terminal() or cpp_child.is_terminal():
                    py_reward = py_child.compute_final_reward()
                    cpp_reward = cpp_child.compute_final_reward()
                    rebuilt_reward = rebuilt_child.compute_final_reward()
                    print(f"child_terminal_py={py_child.is_terminal()} child_terminal_cpp={cpp_child.is_terminal()}")
                    print(f"child_py_final_reward={py_reward} child_cpp_final_reward={cpp_reward} child_rebuilt_final_reward={rebuilt_reward}")
                else:
                    py_child_obs = py_actor._state_to_obs(py_child, None)
                    cpp_child_obs = adapter_actor.cpp_adapter.build_obs_from_cpp_state(cpp_child)
                    py_child_logits, py_child_value = py_actor.policy_network.evaluate(py_child_obs)
                    cpp_child_logits, cpp_child_value = adapter_actor.policy_network.evaluate(cpp_child_obs)
                    py_child_probs = torch.softmax(py_child_logits.squeeze(0) if py_child_logits.dim() > 1 else py_child_logits, dim=-1)
                    cpp_child_probs = torch.softmax(cpp_child_logits.squeeze(0) if cpp_child_logits.dim() > 1 else cpp_child_logits, dim=-1)
                    py_child_top = torch.topk(py_child_probs, k=10)
                    cpp_child_top = torch.topk(cpp_child_probs, k=10)
                    print(f"child_py_top_actions={list(zip(py_child_top.indices.tolist(), py_child_top.values.tolist()))}")
                    print(f"child_cpp_top_actions={list(zip(cpp_child_top.indices.tolist(), cpp_child_top.values.tolist()))}")
                    print(f"child_py_value={py_child_value} child_cpp_value={cpp_child_value}")
                    print(f"child_p_net_x_max_abs_diff={(py_child_obs['p_net'].x - cpp_child_obs['p_net'].x).abs().max().item()}")
                    print(f"child_p_net_edge_attr_max_abs_diff={(py_child_obs['p_net'].edge_attr - cpp_child_obs['p_net'].edge_attr).abs().max().item()}")
                    child_v_target_py, child_candidates_py, child_valid_py = _state_valid_actions(py_child)
                    child_v_target_cpp, child_candidates_cpp, child_valid_cpp = _state_valid_actions(rebuilt_child)
                    print(f"child_next_v_target_py={child_v_target_py} child_next_v_target_cpp={child_v_target_cpp}")
                    print(f"child_py_only={sorted(set(child_valid_py) - set(child_valid_cpp))}")
                    print(f"child_cpp_only={sorted(set(child_valid_cpp) - set(child_valid_py))}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
