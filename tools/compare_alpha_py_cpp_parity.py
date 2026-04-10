#!/usr/bin/env python3
"""Compare Python and C++ AlphaZero SFC solve paths on the same requests."""

from __future__ import annotations

import argparse
import copy
import contextlib
import json
import logging
import os
import sys
import time
from dataclasses import asdict, dataclass
from typing import Any, Dict, List, Optional

REPO_ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
if REPO_ROOT not in sys.path:
    sys.path.insert(0, REPO_ROOT)

from omegaconf import OmegaConf

from virne.core import Controller, Counter, Recorder, Solution
from virne.core.environment import SolutionStepEnvironment
from virne.core.logger import Logger
from virne.network import VirtualNetworkRequestSimulator
from virne.system.base_system import BaseSystem
from virne.solver.learning.reinforcement_learning.alpha_vne.actor_optimized import (
    OptimizedAlphaZeroActor,
)
from virne.solver.learning.reinforcement_learning.alpha_vne.cpp_adapter import (
    create_cpp_adapter,
)
from virne.solver.learning.reinforcement_learning.alpha_vne.node import Node, State


@dataclass
class StepTrace:
    step_idx: int
    v_node_id: int
    chosen_action: Optional[int]
    candidate_actions: List[int]
    child_visit_counts: Dict[int, int]
    child_priors: Dict[int, float]
    root_value: Optional[float]
    effective_sims: Optional[int]
    place_result: Optional[bool]
    place_info: Optional[dict]


@dataclass
class SolveTrace:
    mode: str
    actions: List[int]
    accepted: bool
    place_result: bool
    route_result: Optional[bool]
    rejected: bool
    steps: List[StepTrace]


def _parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--config", required=True, help="Path to saved run config.yaml")
    parser.add_argument("--model", required=True, help="Path to checkpoint .pt")
    parser.add_argument("--num-requests", type=int, default=100, help="Max arrival requests to compare")
    parser.add_argument("--seed", type=int, default=None, help="Environment seed override")
    parser.add_argument("--start-request", type=int, default=0, help="Skip this many arrival requests first")
    parser.add_argument("--stop-on-divergence", action="store_true", default=True, help="Stop at first divergence")
    parser.add_argument("--keep-going", dest="stop_on_divergence", action="store_false")
    parser.add_argument("--output", default="", help="Optional JSON report path")
    parser.add_argument("--log-level", default="CRITICAL", help="Logger level for harness internals")
    parser.add_argument("--internal-logs", action="store_true", help="Enable internal solver/logger output")
    parser.add_argument("--print-full-divergence", action="store_true", help="Print full divergence JSON to console")
    return parser


@contextlib.contextmanager
def _quiet_io(enabled: bool):
    if not enabled:
        yield
        return
    with open(os.devnull, "w", encoding="utf-8") as devnull:
        with contextlib.redirect_stdout(devnull), contextlib.redirect_stderr(devnull):
            yield


def _clone_config(base_cfg, *, run_suffix: str, use_cpp_mcts: bool, pure_cpp: bool, internal_logs: bool):
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
    cfg.experiment.run_id = f"{cfg.experiment.run_id}__parity__{run_suffix}"
    cfg.logger.backends = ["console"] if internal_logs else []
    cfg.logger.level = str(getattr(cfg.logger, "level", "WARNING")).upper()
    cfg.logger.log_file_name = ""
    return cfg


def _build_runtime(config, log_level: str, internal_logs: bool):
    cfg = OmegaConf.create(OmegaConf.to_container(config, resolve=True))
    cfg.logger.backends = ["console"] if internal_logs else []
    cfg.logger.level = log_level.upper()
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


def _build_actor(
    config,
    controller,
    recorder,
    counter,
    logger,
    model_path: str,
    *,
    force_adapter: bool = False,
) -> OptimizedAlphaZeroActor:
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
    if force_adapter and actor.cpp_adapter is None:
        actor.cpp_adapter = create_cpp_adapter(actor, actor.computation_budget)
    return actor


def _trace_python_like(actor: OptimizedAlphaZeroActor, v_net, p_net, *, mode: str) -> tuple[Solution, SolveTrace]:
    solution = Solution.from_v_net(v_net)
    actor.obs_builder.set_episode_data(p_net, v_net)
    if actor.cpp_adapter is not None:
        actor.cpp_adapter.begin_request(p_net, v_net)

    current_node = Node(
        None,
        State(
            p_net,
            v_net,
            actor.controller,
            actor.recorder,
            actor.counter,
            link_params={
                "shortest_method": actor.shortest_method,
                "k": actor.k_shortest,
            },
        ),
    )

    trace_steps: List[StepTrace] = []
    allow_rejection = getattr(actor.policy.actor.decoder, "allow_rejection", False)

    for move_index in range(v_net.num_nodes):
        next_pos = current_node.state.v_node_id + 1
        curr_v_id = current_node.state.v_order[next_pos]
        candidate_actions = [int(x) for x in actor._candidate_actions(current_node.state, curr_v_id)]
        actor.search(current_node, curr_v_id, add_root_noise=False)
        temperature = actor.get_action_selection_temperature(False, move_index=move_index)
        best_child = actor._select_best_child(current_node, temperature=temperature)

        child_visit_counts: Dict[int, int] = {}
        child_priors: Dict[int, float] = {}
        for child in current_node.children:
            action = int(child.state.p_node_id)
            child_visit_counts[action] = int(child.visit_times)
            child_priors[action] = float(getattr(child, "prior", 0.0))

        chosen_action = None if best_child is None else int(best_child.state.p_node_id)
        reject_idx = actor._state_num_nodes(current_node.state)
        place_result = None
        place_info = None

        if best_child is None:
            trace_steps.append(
                StepTrace(
                    step_idx=move_index,
                    v_node_id=int(curr_v_id),
                    chosen_action=None,
                    candidate_actions=candidate_actions,
                    child_visit_counts=child_visit_counts,
                    child_priors=child_priors,
                    root_value=getattr(current_node, "_diag_root_value", None),
                    effective_sims=getattr(current_node, "_diag_effective_sims", None),
                    place_result=None,
                    place_info=None,
                )
            )
            solution["place_result"] = False
            solution["route_result"] = False
            solution["result"] = False
            break

        if allow_rejection and chosen_action == reject_idx:
            trace_steps.append(
                StepTrace(
                    step_idx=move_index,
                    v_node_id=int(curr_v_id),
                    chosen_action=chosen_action,
                    candidate_actions=candidate_actions,
                    child_visit_counts=child_visit_counts,
                    child_priors=child_priors,
                    root_value=getattr(current_node, "_diag_root_value", None),
                    effective_sims=getattr(current_node, "_diag_effective_sims", None),
                    place_result=False,
                    place_info={"reason": "reject_action"},
                )
            )
            solution["rejected"] = True
            solution["place_result"] = False
            solution["route_result"] = False
            solution["result"] = False
            break

        if chosen_action < 0 or chosen_action >= reject_idx:
            trace_steps.append(
                StepTrace(
                    step_idx=move_index,
                    v_node_id=int(curr_v_id),
                    chosen_action=chosen_action,
                    candidate_actions=candidate_actions,
                    child_visit_counts=child_visit_counts,
                    child_priors=child_priors,
                    root_value=getattr(current_node, "_diag_root_value", None),
                    effective_sims=getattr(current_node, "_diag_effective_sims", None),
                    place_result=False,
                    place_info={"reason": "invalid_action"},
                )
            )
            solution["place_result"] = False
            solution["route_result"] = False
            solution["result"] = False
            break

        place_result, place_info = actor.controller.node_mapper.place(
            v_net, p_net, curr_v_id, chosen_action, solution=solution
        )
        trace_steps.append(
            StepTrace(
                step_idx=move_index,
                v_node_id=int(curr_v_id),
                chosen_action=chosen_action,
                candidate_actions=candidate_actions,
                child_visit_counts=child_visit_counts,
                child_priors=child_priors,
                root_value=getattr(current_node, "_diag_root_value", None),
                effective_sims=getattr(current_node, "_diag_effective_sims", None),
                place_result=bool(place_result),
                place_info=place_info,
            )
        )
        if not place_result:
            solution["place_result"] = False
            solution["route_result"] = False
            solution["result"] = False
            break

        best_child.parent = None
        current_node = best_child
    else:
        solution["place_result"] = True
        link_ok = actor.controller.link_mapper.link_mapping(
            v_net,
            p_net,
            solution=solution,
            shortest_method=actor.shortest_method,
            k=actor.k_shortest,
            inplace=True,
        )
        solution["route_result"] = bool(link_ok)
        solution["result"] = bool(solution.get("place_result", False) and solution.get("route_result", False))

    solve_trace = SolveTrace(
        mode=mode,
        actions=[step.chosen_action for step in trace_steps if step.chosen_action is not None],
        accepted=bool(solution.get("result", False)),
        place_result=bool(solution.get("place_result", False)),
        route_result=solution.get("route_result", None),
        rejected=bool(solution.get("rejected", False)),
        steps=trace_steps,
    )
    return solution, solve_trace


def _trace_cpp_full(actor: OptimizedAlphaZeroActor, v_net, p_net) -> tuple[Solution, SolveTrace]:
    if actor.cpp_full_solver is None:
        raise RuntimeError("Full C++ solver is unavailable for this actor.")
    cpp_result = actor.cpp_full_solver.solve(p_net, v_net, training=False, pure_cpp=False)
    actions = [int(a) for a in cpp_result.get("actions", [])]
    policies = list(cpp_result.get("policies", []))
    values = list(cpp_result.get("values", []))
    order_state = State(
        p_net,
        v_net,
        actor.controller,
        actor.recorder,
        actor.counter,
        link_params={
            "shortest_method": actor.shortest_method,
            "k": actor.k_shortest,
        },
    )
    v_order = list(order_state.v_order)

    solution = Solution.from_v_net(v_net)
    for step_idx, action in enumerate(actions):
        if step_idx >= len(v_order):
            break
        solution["node_slots"][int(v_order[step_idx])] = action

    solution["place_result"] = bool(cpp_result.get("place_result", True))
    solution["route_result"] = cpp_result.get("route_result", None)
    solution["rejected"] = bool(cpp_result.get("rejected", False))
    solution["result"] = bool(solution.get("place_result", False) and solution.get("route_result", False)) and not solution["rejected"]

    steps: List[StepTrace] = []
    for step_idx, action in enumerate(actions):
        policy = policies[step_idx] if step_idx < len(policies) else []
        policy_map = {
            idx: float(prob)
            for idx, prob in enumerate(policy)
            if float(prob) > 0.0
        }
        v_node_id = int(v_order[step_idx]) if step_idx < len(v_order) else step_idx
        steps.append(
            StepTrace(
                step_idx=step_idx,
                v_node_id=v_node_id,
                chosen_action=int(action),
                candidate_actions=[],
                child_visit_counts={},
                child_priors=policy_map,
                root_value=float(values[step_idx]) if step_idx < len(values) else None,
                effective_sims=None,
                place_result=None,
                place_info=None,
            )
        )

    return solution, SolveTrace(
        mode="cpp_full",
        actions=actions,
        accepted=bool(solution.get("result", False)),
        place_result=bool(solution.get("place_result", False)),
        route_result=solution.get("route_result", None),
        rejected=bool(solution.get("rejected", False)),
        steps=steps,
    )


def _first_divergence(lhs: SolveTrace, rhs: SolveTrace) -> Optional[dict]:
    max_steps = min(len(lhs.steps), len(rhs.steps))
    for step_idx in range(max_steps):
        left = lhs.steps[step_idx]
        right = rhs.steps[step_idx]
        if left.chosen_action != right.chosen_action:
            return {
                "step_idx": step_idx,
                "lhs_action": left.chosen_action,
                "rhs_action": right.chosen_action,
                "lhs_v_node_id": left.v_node_id,
                "rhs_v_node_id": right.v_node_id,
                "lhs_candidates": left.candidate_actions,
                "rhs_candidates": right.candidate_actions,
                "lhs_visits": left.child_visit_counts,
                "rhs_visits": right.child_visit_counts,
                "lhs_priors": left.child_priors,
                "rhs_priors": right.child_priors,
            }
        if left.candidate_actions and right.candidate_actions and left.candidate_actions != right.candidate_actions:
            return {
                "step_idx": step_idx,
                "reason": "different_candidate_actions",
                "lhs_action": left.chosen_action,
                "rhs_action": right.chosen_action,
                "lhs_v_node_id": left.v_node_id,
                "rhs_v_node_id": right.v_node_id,
                "lhs_candidates": left.candidate_actions,
                "rhs_candidates": right.candidate_actions,
                "lhs_visits": left.child_visit_counts,
                "rhs_visits": right.child_visit_counts,
            }
    if len(lhs.steps) != len(rhs.steps):
        return {
            "step_idx": max_steps,
            "lhs_action": None,
            "rhs_action": None,
            "reason": "different_step_count",
            "lhs_steps": len(lhs.steps),
            "rhs_steps": len(rhs.steps),
        }
    if lhs.accepted != rhs.accepted or lhs.place_result != rhs.place_result or lhs.route_result != rhs.route_result:
        return {
            "step_idx": max_steps,
            "reason": "different_final_result",
            "lhs_accept": lhs.accepted,
            "rhs_accept": rhs.accepted,
            "lhs_place": lhs.place_result,
            "rhs_place": rhs.place_result,
            "lhs_route": lhs.route_result,
            "rhs_route": rhs.route_result,
        }
    return None


def _trace_to_dict(trace: SolveTrace) -> dict:
    return {
        "mode": trace.mode,
        "actions": trace.actions,
        "accepted": trace.accepted,
        "place_result": trace.place_result,
        "route_result": trace.route_result,
        "rejected": trace.rejected,
        "steps": [asdict(step) for step in trace.steps],
    }


def _top_items(mapping: Dict[int, Any], limit: int = 4, as_int: bool = False) -> List[str]:
    items = sorted(mapping.items(), key=lambda kv: kv[1], reverse=True)[:limit]
    if as_int:
        return [f"{int(k)}:{int(v)}" for k, v in items]
    return [f"{int(k)}:{float(v):.3f}" for k, v in items]


def _summarize_divergence(divergence: Optional[dict], trace: SolveTrace, other_trace: SolveTrace) -> str:
    if divergence is None:
        return "none"
    step_idx = int(divergence.get("step_idx", -1))
    if 0 <= step_idx < len(trace.steps) and 0 <= step_idx < len(other_trace.steps):
        lhs = trace.steps[step_idx]
        rhs = other_trace.steps[step_idx]
        parts = [
            f"step={step_idx}",
            f"vnode={lhs.v_node_id}",
            f"py={lhs.chosen_action}",
            f"cpp={rhs.chosen_action}",
        ]
        cand_n = len(lhs.candidate_actions) or len(rhs.candidate_actions)
        if cand_n:
            parts.append(f"cand_n={cand_n}")
        lhs_top = _top_items(lhs.child_visit_counts, as_int=True)
        rhs_top = _top_items(rhs.child_visit_counts, as_int=True)
        if lhs_top:
            parts.append(f"py_top={lhs_top}")
        if rhs_top:
            parts.append(f"cpp_top={rhs_top}")
        return " ".join(parts)
    return json.dumps(divergence, sort_keys=True)


def main() -> int:
    args = _parser().parse_args()
    if not args.internal_logs:
        root_logger = logging.getLogger()
        root_logger.handlers.clear()
        logging.disable(logging.CRITICAL)
    base_cfg = OmegaConf.load(args.config)
    if args.seed is not None:
        base_cfg.experiment.seed = int(args.seed)

    runtime_cfg = _clone_config(
        base_cfg,
        run_suffix="env",
        use_cpp_mcts=False,
        pure_cpp=False,
        internal_logs=args.internal_logs,
    )
    runtime_cfg.logger.level = args.log_level.upper()
    runtime_cfg.logger.backends = ["console"] if args.internal_logs else []
    runtime_cfg.logger.log_file_name = ""

    with _quiet_io(not args.internal_logs):
        _, logger, counter, controller, recorder, env = _build_runtime(runtime_cfg, args.log_level, args.internal_logs)

    env_seed = args.seed if args.seed is not None else getattr(runtime_cfg.experiment, "seed", None)
    with _quiet_io(not args.internal_logs):
        env.reset(seed=env_seed)

    py_cfg = _clone_config(base_cfg, run_suffix="py", use_cpp_mcts=False, pure_cpp=False, internal_logs=args.internal_logs)
    adapter_cfg = _clone_config(base_cfg, run_suffix="cpp_adapter", use_cpp_mcts=True, pure_cpp=False, internal_logs=args.internal_logs)
    full_cfg = _clone_config(base_cfg, run_suffix="cpp_full", use_cpp_mcts=True, pure_cpp=False, internal_logs=args.internal_logs)

    with _quiet_io(not args.internal_logs):
        py_actor = _build_actor(py_cfg, controller, recorder, counter, logger, args.model)
        adapter_actor = _build_actor(
            adapter_cfg,
            controller,
            recorder,
            counter,
            logger,
            args.model,
            force_adapter=True,
        )
    if adapter_actor.cpp_full_solver is not None:
        adapter_actor.cpp_full_solver = None
    if adapter_actor.cpp_adapter is None:
        raise RuntimeError("C++ adapter mode is unavailable; cannot run parity harness.")
    with _quiet_io(not args.internal_logs):
        full_actor = _build_actor(full_cfg, controller, recorder, counter, logger, args.model)
    if full_actor.cpp_full_solver is None:
        raise RuntimeError("Full C++ solve mode is unavailable; cannot run parity harness.")

    report: Dict[str, Any] = {
        "config": os.path.abspath(args.config),
        "model": os.path.abspath(args.model),
        "num_requests": int(args.num_requests),
        "start_request": int(args.start_request),
        "seed": env_seed,
        "requests": [],
    }

    arrival_seen = 0
    arrival_compared = 0

    while arrival_compared < args.num_requests:
        if int(env.curr_event["type"]) != 1:
            done = env.transit_obs()
            if done:
                break
            continue

        if arrival_seen < args.start_request:
            obs = env.get_observation()
            with _quiet_io(not args.internal_logs):
                py_solution, _ = _trace_python_like(py_actor, obs["v_net"], obs["p_net"], mode="python")
                _, _, done, _ = env.step(py_solution)
            arrival_seen += 1
            if done:
                break
            continue

        obs = env.get_observation()
        v_net_id = int(getattr(obs["v_net"], "id", env.curr_event["v_net_id"]))
        event_id = int(env.curr_event["id"])

        with _quiet_io(not args.internal_logs):
            py_solution, py_trace = _trace_python_like(py_actor, copy.deepcopy(obs["v_net"]), copy.deepcopy(obs["p_net"]), mode="python")
            adapter_solution, adapter_trace = _trace_python_like(adapter_actor, copy.deepcopy(obs["v_net"]), copy.deepcopy(obs["p_net"]), mode="cpp_adapter")
            full_solution, full_trace = _trace_cpp_full(full_actor, copy.deepcopy(obs["v_net"]), copy.deepcopy(obs["p_net"]))

        py_vs_adapter = _first_divergence(py_trace, adapter_trace)
        py_vs_full = _first_divergence(py_trace, full_trace)

        request_report = {
            "arrival_index": arrival_seen,
            "event_id": event_id,
            "v_net_id": v_net_id,
            "python": _trace_to_dict(py_trace),
            "cpp_adapter": _trace_to_dict(adapter_trace),
            "cpp_full": _trace_to_dict(full_trace),
            "python_vs_cpp_adapter": py_vs_adapter,
            "python_vs_cpp_full": py_vs_full,
        }
        report["requests"].append(request_report)

        print(f"[request {arrival_seen}] py={int(py_trace.accepted)} adapter={int(adapter_trace.accepted)} full={int(full_trace.accepted)}")
        if py_vs_adapter is not None:
            print(f"  py-vs-adapter: {_summarize_divergence(py_vs_adapter, py_trace, adapter_trace)}")
            if args.print_full_divergence:
                print(f"    full: {json.dumps(py_vs_adapter, sort_keys=True)}")
        if py_vs_full is not None:
            print(f"  py-vs-full: {_summarize_divergence(py_vs_full, py_trace, full_trace)}")
            if args.print_full_divergence:
                print(f"    full: {json.dumps(py_vs_full, sort_keys=True)}")

        arrival_seen += 1
        arrival_compared += 1

        if args.stop_on_divergence and (py_vs_adapter is not None or py_vs_full is not None):
            break

        with _quiet_io(not args.internal_logs):
            _, _, done, _ = env.step(py_solution)
        if done:
            break

    if args.output:
        output_path = os.path.abspath(args.output)
        os.makedirs(os.path.dirname(output_path), exist_ok=True)
        with open(output_path, "w", encoding="utf-8") as f:
            json.dump(report, f, indent=2, sort_keys=True)
        print(f"report={output_path}")

    return 0


if __name__ == "__main__":
    raise SystemExit(main())
