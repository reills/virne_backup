#!/usr/bin/env python3
"""
Focused debugger for a single Python-vs-pure-C++ divergence state.

Target use case (seed 0, wx100): request 2, after prefix actions [93,60,28,80,95],
compare:
  - Python observation tensors + policy logits/probs
  - Pure C++ observation tensors + policy logits/probs (via alpha_zero_cpp_core debug APIs)
  - Pure C++ MCTS visit counts at the same prefix
"""

from __future__ import annotations

import argparse
import contextlib
import copy
import json
import os
import sys
from dataclasses import dataclass
from typing import Any, Dict, List, Tuple

import torch
from omegaconf import OmegaConf

REPO_ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
if REPO_ROOT not in sys.path:
    sys.path.insert(0, REPO_ROOT)

from virne.core.logger import Logger
from virne.core import Controller, Counter, Recorder
from virne.core.environment import SolutionStepEnvironment
from virne.system.base_system import BaseSystem
from virne.solver.learning.reinforcement_learning.alpha_vne.actor_optimized import OptimizedAlphaZeroActor
from virne.solver.learning.reinforcement_learning.alpha_vne.node import Node, State
from virne.solver.learning.reinforcement_learning.alpha_vne.feature_constructor import AlphaZeroFeatureAdapter
from tools.compare_alpha_py_cpp_parity import _trace_python_like

try:
    from virne.solver.learning.reinforcement_learning.alpha_vne import alpha_zero_cpp_core as cpp_core  # type: ignore
except Exception:  # pragma: no cover
    cpp_core = None


@contextlib.contextmanager
def _quiet_stdio(enabled: bool):
    if not enabled:
        yield
        return
    with open(os.devnull, "w", encoding="utf-8") as devnull:
        with contextlib.redirect_stdout(devnull), contextlib.redirect_stderr(devnull):
            yield


def _parse_int_list(csv: str) -> List[int]:
    csv = (csv or "").strip()
    if not csv:
        return []
    return [int(x.strip()) for x in csv.split(",") if x.strip()]


def _clone_config(base_cfg, *, use_cpp_mcts: bool, pure_cpp: bool, run_suffix: str):
    cfg = OmegaConf.create(OmegaConf.to_container(base_cfg, resolve=True))
    cfg.use_fixed_dataset = True
    cfg.experiment.if_load_p_net = True
    cfg.experiment.if_load_v_nets = True
    cfg.training.alphazero_model_path = ""
    cfg.training.resume_training = False
    cfg.training.disable_trajectory_writing = True
    cfg.training.inference_only = True
    cfg.training.enable_async_learner = False
    cfg.training.num_train_epochs = 0
    cfg.training.use_batched_gpu = False
    cfg.training.use_cpp_mcts = bool(use_cpp_mcts)
    cfg.training.pure_cpp = bool(pure_cpp)
    cfg.experiment.run_id = f"{cfg.experiment.run_id}__debug__{run_suffix}"
    cfg.logger.backends = []
    cfg.logger.level = "CRITICAL"
    cfg.logger.log_file_name = ""
    return cfg


def _build_runtime(config) -> Tuple[Any, Any, Any, Any, Any, SolutionStepEnvironment]:
    cfg = OmegaConf.create(OmegaConf.to_container(config, resolve=True))
    cfg.logger.backends = []
    cfg.logger.level = "CRITICAL"
    logger = Logger(cfg)
    node_attrs_setting = cfg.v_sim_setting["node_attrs_setting"]
    link_attrs_setting = cfg.v_sim_setting["link_attrs_setting"]
    graph_attrs_setting = cfg.v_sim_setting.get("graph_attrs_setting", {})
    counter = Counter(node_attrs_setting, link_attrs_setting, graph_attrs_setting, cfg)
    controller = Controller(node_attrs_setting, link_attrs_setting, graph_attrs_setting, cfg)
    recorder = Recorder(counter, cfg)
    p_net, v_net_simulator = BaseSystem.load_dataset(logger, cfg)
    env = SolutionStepEnvironment(p_net, v_net_simulator, controller, recorder, counter, logger, cfg)
    return cfg, logger, counter, controller, recorder, env


def _build_actor(config, controller, recorder, counter, logger, model_path: str) -> OptimizedAlphaZeroActor:
    config.training.alphazero_model_path = model_path
    config.training.resume_training = False
    actor = OptimizedAlphaZeroActor(
        controller,
        recorder,
        counter,
        logger,
        config,
        use_batched_gpu=False,
        disable_trajectory_writing=True,
        shortest_method=getattr(config.solver, "shortest_method", "k_shortest"),
        k_shortest=int(getattr(config.solver, "k_shortest", 10)),
    )
    return actor


def _masked_softmax_1d(logits: torch.Tensor, mask: torch.Tensor) -> torch.Tensor:
    logits = logits.to(torch.float32).flatten()
    mask = mask.to(torch.bool).flatten()
    masked = logits.clone()
    masked[~mask] = -1.0e9
    return torch.softmax(masked, dim=0)


def _topk(t: torch.Tensor, k: int = 10) -> List[Tuple[int, float]]:
    t = t.flatten()
    if t.numel() == 0:
        return []
    k = min(int(k), int(t.numel()))
    vals, idx = torch.topk(t, k=k)
    return [(int(i), float(v)) for i, v in zip(idx.cpu().tolist(), vals.cpu().tolist())]


def _summarize_tensor(t: torch.Tensor) -> dict:
    out = {
        "shape": list(t.shape),
        "dtype": str(t.dtype),
        "device": str(t.device),
    }
    if t.numel() == 0:
        return out
    if t.dtype.is_floating_point:
        tf = t.detach().to(torch.float32).cpu()
        out.update(
            {
                "min": float(tf.min().item()),
                "max": float(tf.max().item()),
                "mean": float(tf.mean().item()),
                "absmax": float(tf.abs().max().item()),
            }
        )
    else:
        out["unique_n"] = int(torch.unique(t.cpu()).numel()) if t.numel() <= 200000 else None
    return out


def _diff_tensors(a: torch.Tensor, b: torch.Tensor) -> dict:
    if a.shape != b.shape or a.dtype != b.dtype:
        return {"same": False, "reason": "shape_or_dtype", "a": _summarize_tensor(a), "b": _summarize_tensor(b)}
    if a.numel() == 0:
        return {"same": True, "a": _summarize_tensor(a)}
    if a.dtype.is_floating_point:
        af = a.detach().to(torch.float32).cpu()
        bf = b.detach().to(torch.float32).cpu()
        diff = (af - bf).abs()
        return {
            "same": bool(torch.allclose(af, bf, atol=0.0, rtol=0.0)),
            "max_abs": float(diff.max().item()),
            "mean_abs": float(diff.mean().item()),
        }
    eq = bool(torch.equal(a.cpu(), b.cpu()))
    return {"same": eq}


def _build_cpp_network(
    node_attrs: list[dict[str, float]],
    edges: list[tuple[int, int]],
    edge_attrs: list[dict[str, float]],
    directed: bool,
    reverse_share: bool,
):
    net = cpp_core.Network()
    net.set_num_nodes(int(len(node_attrs)))
    net.set_edges([(int(u), int(v)) for (u, v) in edges], bool(directed))
    net.reverse_edge_pairs_share_capacity = bool(reverse_share)
    net.set_node_attrs([{str(k): float(v) for k, v in attrs.items()} for attrs in node_attrs])
    if edge_attrs:
        net.set_edge_attrs([{str(k): float(v) for k, v in attrs.items()} for attrs in edge_attrs])
    return net


def _python_reward_for_actions(
    p_net,
    v_net,
    controller,
    recorder,
    counter,
    shortest_method: str,
    k_shortest: int,
    actions: list[int],
) -> float:
    state = State(
        p_net,
        v_net,
        controller,
        recorder,
        counter,
        link_params={"shortest_method": str(shortest_method), "k": int(k_shortest)},
    )
    for a in actions:
        state = state.next_state(int(a))
    return float(state.compute_final_reward())


def _cpp_reward_for_actions(
    p_cpp_net,
    v_cpp_net,
    vnr_cfg,
    actions: list[int],
) -> float:
    state = cpp_core.VNRState(p_cpp_net, v_cpp_net, vnr_cfg)
    for a in actions:
        state = state.create_child(int(a))
    return float(state.compute_final_reward())


@dataclass
class DebugResult:
    request_index: int
    prefix_actions: List[int]
    step_idx: int
    target_v_node_id: int
    python_obs_step_idx: int
    cpp_obs_step_idx: int
    python_top_logits: List[Tuple[int, float]]
    cpp_top_logits: List[Tuple[int, float]]
    python_top_probs: List[Tuple[int, float]]
    cpp_top_probs: List[Tuple[int, float]]
    cpp_top_visits: List[Tuple[int, int]]
    cpp_full_solve_action: int
    cpp_full_solve_top_visits: List[Tuple[int, int]]
    obs_diffs: Dict[str, dict]
    logit_diff: dict


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--config", required=True, help="Path to run config.yaml (saved Hydra config).")
    parser.add_argument("--model", required=True, help="Path to policy_latest.pt (PyTorch checkpoint).")
    parser.add_argument("--seed", type=int, default=0, help="Environment seed override.")
    parser.add_argument("--request-index", type=int, default=2, help="Arrival request index (0-based).")
    parser.add_argument("--prefix-actions", default="93,60,28,80,95", help="Comma-separated placement actions prefix.")
    parser.add_argument("--topk", type=int, default=10, help="Top-k items to print for logits/probs/visits.")
    parser.add_argument("--dump-json", default="", help="Optional path to write a compact JSON summary.")
    parser.add_argument("--internal-logs", action="store_true", help="Enable internal solver logs (noisy).")
    args = parser.parse_args()

    if cpp_core is None:
        raise RuntimeError("alpha_zero_cpp_core is unavailable; rebuild the C++ extension first.")

    base_cfg = OmegaConf.load(args.config)
    base_cfg.experiment.seed = int(args.seed)

    runtime_cfg = _clone_config(base_cfg, use_cpp_mcts=False, pure_cpp=False, run_suffix="env")
    with _quiet_stdio(not args.internal_logs):
        _, logger, counter, controller, recorder, env = _build_runtime(runtime_cfg)
        env.reset(seed=int(args.seed))

    py_cfg = _clone_config(base_cfg, use_cpp_mcts=False, pure_cpp=False, run_suffix="py")
    cpp_cfg = _clone_config(base_cfg, use_cpp_mcts=True, pure_cpp=True, run_suffix="cpp_pure")

    with _quiet_stdio(not args.internal_logs):
        py_actor = _build_actor(py_cfg, controller, recorder, counter, logger, args.model)
        cpp_actor = _build_actor(cpp_cfg, controller, recorder, counter, logger, args.model)

    if getattr(cpp_actor, "cpp_full_solver", None) is None:
        raise RuntimeError("cpp_full_solver is unavailable; ensure the extension exposes alpha_zero_cpp_core.solve.")

    prefix_actions = _parse_int_list(args.prefix_actions)

    # Step environment until we hit the target arrival request.
    arrival_seen = 0
    while True:
        if int(env.curr_event["type"]) != 1:
            done = env.transit_obs()
            if done:
                raise RuntimeError("Environment terminated before reaching target arrival request.")
            continue
        if arrival_seen < int(args.request_index):
            obs = env.get_observation()
            with _quiet_stdio(not args.internal_logs):
                solution, _ = _trace_python_like(
                    py_actor,
                    copy.deepcopy(obs["v_net"]),
                    copy.deepcopy(obs["p_net"]),
                    mode="python",
                )
                _, _, done, _ = env.step(solution)
            arrival_seen += 1
            if done:
                raise RuntimeError("Environment terminated while skipping earlier requests.")
            continue
        break

    obs = env.get_observation()
    v_net = obs["v_net"]
    p_net = obs["p_net"]

    # Build Python state after the prefix actions.
    py_actor.obs_builder.set_episode_data(p_net, v_net)
    state = State(
        p_net,
        v_net,
        controller,
        recorder,
        counter,
        link_params={"shortest_method": py_actor.shortest_method, "k": int(py_actor.k_shortest)},
    )
    for action in prefix_actions:
        state = state.next_state(int(action))

    next_pos = int(getattr(state, "v_node_id", -1)) + 1
    target_v_node_id = int(state.v_order[next_pos]) if 0 <= next_pos < len(state.v_order) else next_pos
    step_idx = int(len(getattr(state, "selected_p_net_nodes", [])))

    py_obs = py_actor.obs_builder.build(state, py_actor.policy, target_v_node_id)
    py_logits, py_value = py_actor.policy_network.evaluate(  # type: ignore[attr-defined]
        py_obs,
        use_nn_policy=True,
        use_nn_value=True,
    )
    if py_logits is None or py_logits.numel() == 0:
        raise RuntimeError("Python policy_network.evaluate returned empty logits.")
    py_logits = py_logits.squeeze().detach().cpu().to(torch.float32)
    py_mask = py_obs.get("action_mask", None)
    if py_mask is None:
        raise RuntimeError("Python observation missing action_mask.")
    py_mask = py_mask.squeeze().detach().cpu()
    py_probs = _masked_softmax_1d(py_logits, py_mask)

    # Build C++ (pure) inputs from the same raw p_net/v_net and prefix actions.
    feature_adapter = AlphaZeroFeatureAdapter(cpp_actor.config, p_net, v_net)
    feature_metadata = feature_adapter.build_cpp_feature_metadata()
    full_solver = cpp_actor.cpp_full_solver

    p_node_attrs, p_edges, p_edge_attrs, p_directed, p_rev_share = full_solver._build_network_payload(  # type: ignore[attr-defined]
        p_net,
        full_solver._node_resource_names,  # type: ignore[attr-defined]
        full_solver._link_resource_names,  # type: ignore[attr-defined]
        topological_metrics=feature_metadata.get("p_topological_metrics"),
        preserve_link_orientation=True,
    )
    v_node_attrs, v_edges, v_edge_attrs, v_directed, v_rev_share = full_solver._build_network_payload(  # type: ignore[attr-defined]
        v_net,
        full_solver._node_resource_names,  # type: ignore[attr-defined]
        full_solver._link_resource_names,  # type: ignore[attr-defined]
        topological_metrics=feature_metadata.get("v_topological_metrics"),
        preserve_link_orientation=False,
    )
    vnr_cfg = full_solver._build_vnr_config(feature_metadata)  # type: ignore[attr-defined]
    search_cfg = full_solver._build_search_config(training=False)  # type: ignore[attr-defined]

    policy_ts_path = cpp_actor.policy_path.replace(".pt", ".ts")
    if not os.path.exists(policy_ts_path):
        # Export TorchScript via the same helper used by the full solver wrapper.
        full_solver._export_torchscript(policy_ts_path)  # type: ignore[attr-defined]

    device = "cpu"
    cpp_obs = cpp_core.debug_build_observation_after_actions(
        p_node_attrs,
        p_edges,
        p_edge_attrs,
        bool(p_directed),
        bool(p_rev_share),
        v_node_attrs,
        v_edges,
        v_edge_attrs,
        bool(v_directed),
        bool(v_rev_share),
        vnr_cfg,
        [int(a) for a in prefix_actions],
        policy_ts_path,
        device,
    )
    cpp_eval = cpp_core.debug_evaluate_after_actions(
        p_node_attrs,
        p_edges,
        p_edge_attrs,
        bool(p_directed),
        bool(p_rev_share),
        v_node_attrs,
        v_edges,
        v_edge_attrs,
        bool(v_directed),
        bool(v_rev_share),
        vnr_cfg,
        [int(a) for a in prefix_actions],
        policy_ts_path,
        device,
    )
    cpp_search = cpp_core.debug_search_after_actions(
        p_node_attrs,
        p_edges,
        p_edge_attrs,
        bool(p_directed),
        bool(p_rev_share),
        v_node_attrs,
        v_edges,
        v_edge_attrs,
        bool(v_directed),
        bool(v_rev_share),
        vnr_cfg,
        search_cfg,
        [int(a) for a in prefix_actions],
        policy_ts_path,
        device,
    )

    python_obs_step_idx = int(py_obs["curr_v_node_id"].detach().cpu().flatten()[0].item())
    cpp_obs_step_idx = int(cpp_obs["curr_v_node_id"].detach().cpu().flatten()[0].item())
    cpp_logits = cpp_eval["policy_logits"].detach().cpu().to(torch.float32).flatten()
    cpp_mask = cpp_obs["action_mask"].detach().cpu().flatten().to(torch.bool)
    cpp_probs = _masked_softmax_1d(cpp_logits, cpp_mask)

    # Observation diffs (intersection only; keep output compact).
    obs_diffs: Dict[str, dict] = {}
    for key, py_val in py_obs.items():
        if not isinstance(py_val, torch.Tensor):
            continue
        if key not in cpp_obs or not isinstance(cpp_obs[key], torch.Tensor):
            continue
        obs_diffs[key] = _diff_tensors(py_val.detach().cpu(), cpp_obs[key].detach().cpu())

    # Logit diffs (masked positions excluded from max/mean report).
    common = min(int(py_logits.numel()), int(cpp_logits.numel()))
    logit_diff: dict = {"python_len": int(py_logits.numel()), "cpp_len": int(cpp_logits.numel())}
    if common > 0:
        py_l = py_logits[:common]
        cpp_l = cpp_logits[:common]
        mask = py_mask.to(torch.bool).flatten()[:common] & cpp_mask[:common]
        if int(mask.sum().item()) > 0:
            diff = (py_l[mask] - cpp_l[mask]).abs()
            logit_diff.update({"max_abs_masked": float(diff.max().item()), "mean_abs_masked": float(diff.mean().item())})

    # Visits top-k
    visits = list(getattr(cpp_search, "visit_counts", []))
    visit_top = sorted([(i, int(v)) for i, v in enumerate(visits) if int(v) > 0], key=lambda kv: kv[1], reverse=True)
    visit_top = visit_top[: int(args.topk)]

    py_parent_branch_top: List[Tuple[int, int]] = []
    cpp_parent_branch_top: List[Tuple[int, int]] = []
    if prefix_actions:
        parent_prefix = [int(a) for a in prefix_actions[:-1]]
        focus_action = int(prefix_actions[-1])

        parent_state = State(
            p_net,
            v_net,
            controller,
            recorder,
            counter,
            link_params={"shortest_method": py_actor.shortest_method, "k": int(py_actor.k_shortest)},
        )
        for action in parent_prefix:
            parent_state = parent_state.next_state(int(action))
        parent_next_pos = int(getattr(parent_state, "v_node_id", -1)) + 1
        parent_target_v_node_id = (
            int(parent_state.v_order[parent_next_pos]) if 0 <= parent_next_pos < len(parent_state.v_order) else parent_next_pos
        )
        py_parent_root = Node(None, parent_state)
        py_actor.search(py_parent_root, parent_target_v_node_id, add_root_noise=False)
        py_focus_child = next(
            (child for child in py_parent_root.children if int(getattr(child.state, "p_node_id", -1)) == focus_action),
            None,
        )
        if py_focus_child is not None:
            py_parent_branch_top = sorted(
                [
                    (int(getattr(child.state, "p_node_id", -1)), int(child.visit_times))
                    for child in py_focus_child.children
                    if int(child.visit_times) > 0
                ],
                key=lambda kv: (-kv[1], kv[0]),
            )[: int(args.topk)]

        cpp_parent_branch = cpp_core.debug_search_child_after_actions(
            p_node_attrs,
            p_edges,
            p_edge_attrs,
            bool(p_directed),
            bool(p_rev_share),
            v_node_attrs,
            v_edges,
            v_edge_attrs,
            bool(v_directed),
            bool(v_rev_share),
            vnr_cfg,
            search_cfg,
            parent_prefix,
            focus_action,
            policy_ts_path,
            device,
        )
        cpp_parent_branch_visits = list(getattr(cpp_parent_branch, "visit_counts", []))
        cpp_parent_branch_top = sorted(
            [(i, int(v)) for i, v in enumerate(cpp_parent_branch_visits) if int(v) > 0],
            key=lambda kv: (-kv[1], kv[0]),
        )[: int(args.topk)]

    # Full pure-C++ solver (tree reuse) for the same request to extract the
    # exact visit-count distribution at this step.
    with _quiet_stdio(not args.internal_logs):
        full_out = cpp_actor.cpp_full_solver.solve(p_net, v_net, training=False, pure_cpp=True)
    full_actions = [int(a) for a in full_out.get("actions", [])]
    full_visit_steps = list(full_out.get("visit_counts", []))
    cpp_full_solve_action = int(full_actions[step_idx]) if step_idx < len(full_actions) else -1
    full_visit_vec: List[float] = []
    if step_idx < len(full_visit_steps):
        full_visit_vec = [float(x) for x in full_visit_steps[step_idx]]
    full_visit_top = sorted(
        [(i, int(v)) for i, v in enumerate(full_visit_vec) if int(v) > 0],
        key=lambda kv: kv[1],
        reverse=True,
    )[: int(args.topk)]

    # Reward parity for full action sequences (python vs C++).
    with _quiet_stdio(not args.internal_logs):
        _, py_trace = _trace_python_like(py_actor, copy.deepcopy(v_net), copy.deepcopy(p_net), mode="python")
    py_actions = [int(a) for a in py_trace.actions]
    # Build C++ Network objects for reward comparison.
    p_cpp_net = _build_cpp_network(p_node_attrs, p_edges, p_edge_attrs, bool(p_directed), bool(p_rev_share))
    v_cpp_net = _build_cpp_network(v_node_attrs, v_edges, v_edge_attrs, bool(v_directed), bool(v_rev_share))
    py_reward_py = _python_reward_for_actions(
        copy.deepcopy(p_net),
        copy.deepcopy(v_net),
        controller,
        recorder,
        counter,
        py_actor.shortest_method,
        int(py_actor.k_shortest),
        py_actions,
    )
    py_reward_cpp = _python_reward_for_actions(
        copy.deepcopy(p_net),
        copy.deepcopy(v_net),
        controller,
        recorder,
        counter,
        py_actor.shortest_method,
        int(py_actor.k_shortest),
        full_actions,
    )
    cpp_reward_py = _cpp_reward_for_actions(p_cpp_net, v_cpp_net, vnr_cfg, py_actions)
    cpp_reward_cpp = _cpp_reward_for_actions(p_cpp_net, v_cpp_net, vnr_cfg, full_actions)

    result = DebugResult(
        request_index=int(args.request_index),
        prefix_actions=prefix_actions,
        step_idx=step_idx,
        target_v_node_id=target_v_node_id,
        python_obs_step_idx=python_obs_step_idx,
        cpp_obs_step_idx=cpp_obs_step_idx,
        python_top_logits=_topk(py_logits, k=int(args.topk)),
        cpp_top_logits=_topk(cpp_logits, k=int(args.topk)),
        python_top_probs=_topk(py_probs, k=int(args.topk)),
        cpp_top_probs=_topk(cpp_probs, k=int(args.topk)),
        cpp_top_visits=visit_top,
        cpp_full_solve_action=cpp_full_solve_action,
        cpp_full_solve_top_visits=full_visit_top,
        obs_diffs=obs_diffs,
        logit_diff=logit_diff,
    )

    # Console output (human-readable, compact).
    print(f"request={result.request_index} prefix={result.prefix_actions}")
    print(
        f"step_idx={result.step_idx} target_v_node_id={result.target_v_node_id} "
        f"py_obs.curr_v_node_id={result.python_obs_step_idx} cpp_obs.curr_v_node_id={result.cpp_obs_step_idx}"
    )
    print(f"python top logits={result.python_top_logits}")
    print(f"cpp    top logits={result.cpp_top_logits}")
    print(f"python top probs ={result.python_top_probs}")
    print(f"cpp    top probs ={result.cpp_top_probs}")
    print(f"cpp    top visits={result.cpp_top_visits}")
    if prefix_actions:
        print(f"python parent-branch visits after action {prefix_actions[-1]}={py_parent_branch_top}")
        print(f"cpp    parent-branch visits after action {prefix_actions[-1]}={cpp_parent_branch_top}")
    print(f"cpp    full.solve action@step={result.cpp_full_solve_action} top visits={result.cpp_full_solve_top_visits}")
    print(
        "final_reward "
        f"py(actions_py)={py_reward_py:.3f} py(actions_cpp)={py_reward_cpp:.3f} "
        f"cpp(actions_py)={cpp_reward_py:.3f} cpp(actions_cpp)={cpp_reward_cpp:.3f}"
    )
    print(f"logit_diff={result.logit_diff}")
    # Only print diffs that are not exactly equal.
    bad_keys = {k: v for k, v in result.obs_diffs.items() if not bool(v.get("same", False))}
    print(f"obs_diff_keys_total={len(result.obs_diffs)} mismatched={len(bad_keys)}")
    for key in sorted(bad_keys)[:30]:
        print(f"  {key}: {bad_keys[key]}")

    if args.dump_json:
        payload = {
            "request_index": result.request_index,
            "prefix_actions": result.prefix_actions,
            "step_idx": result.step_idx,
            "target_v_node_id": result.target_v_node_id,
            "python_obs_step_idx": result.python_obs_step_idx,
            "cpp_obs_step_idx": result.cpp_obs_step_idx,
            "python_top_logits": result.python_top_logits,
            "cpp_top_logits": result.cpp_top_logits,
            "python_top_probs": result.python_top_probs,
            "cpp_top_probs": result.cpp_top_probs,
            "cpp_top_visits": result.cpp_top_visits,
            "cpp_full_solve_action": result.cpp_full_solve_action,
            "cpp_full_solve_top_visits": result.cpp_full_solve_top_visits,
            "logit_diff": result.logit_diff,
            "obs_diffs": result.obs_diffs,
        }
        os.makedirs(os.path.dirname(os.path.abspath(args.dump_json)), exist_ok=True)
        with open(args.dump_json, "w", encoding="utf-8") as f:
            json.dump(payload, f, indent=2, sort_keys=True)
        print(f"wrote={os.path.abspath(args.dump_json)}")

    return 0


if __name__ == "__main__":
    raise SystemExit(main())
