#!/usr/bin/env python3
from __future__ import annotations

import copy
import logging
import os
import sys

from omegaconf import OmegaConf

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
from virne.utils.config import add_simulation_into_config


CONFIG_PATH = "results/journal_suite/results/alpha_zero_sfc/journal_suite__alpha_zero_sfc__wx100__nominal_cppfix__seed0__eval__keval10__wx100_seed0_histpy_eval_after_sharedlink/config.yaml"


def main() -> int:
    logging.disable(logging.CRITICAL)
    cfg = OmegaConf.load(CONFIG_PATH)
    add_simulation_into_config(cfg)
    model = cfg.training.alphazero_model_path

    runtime_cfg = _clone_config(cfg, run_suffix="print_req2_env", use_cpp_mcts=False, pure_cpp=False, internal_logs=False)
    add_simulation_into_config(runtime_cfg)
    _, logger, counter, controller, recorder, env = _build_runtime(runtime_cfg, "CRITICAL", False)
    env.reset(seed=cfg.experiment.seed)

    actual_p_nodes = int(env.p_net.num_nodes)
    py_cfg = _clone_config(cfg, run_suffix="print_req2_py", use_cpp_mcts=False, pure_cpp=False, internal_logs=False)
    ad_cfg = _clone_config(cfg, run_suffix="print_req2_ad", use_cpp_mcts=True, pure_cpp=False, internal_logs=False)
    add_simulation_into_config(py_cfg)
    add_simulation_into_config(ad_cfg)
    py_cfg.simulation.p_net_setting_num_nodes = actual_p_nodes
    ad_cfg.simulation.p_net_setting_num_nodes = actual_p_nodes
    py_cfg.rl.feature_constructor.p_num_nodes = actual_p_nodes
    ad_cfg.rl.feature_constructor.p_num_nodes = actual_p_nodes

    py_actor = _build_actor(py_cfg, controller, recorder, counter, logger, model)
    ad_actor = _build_actor(ad_cfg, controller, recorder, counter, logger, model, force_adapter=True)

    arrival_seen = 0
    while True:
        if int(env.curr_event["type"]) != 1:
            done = env.transit_obs()
            if done:
                raise RuntimeError("Environment ended before request 2.")
            continue

        obs = env.get_observation()
        print(f"arrival_seen={arrival_seen}", flush=True)
        if arrival_seen == 2:
            _, py_trace = _trace_python_like(py_actor, copy.deepcopy(obs["v_net"]), copy.deepcopy(obs["p_net"]), mode="python")
            _, ad_trace = _trace_python_like(ad_actor, copy.deepcopy(obs["v_net"]), copy.deepcopy(obs["p_net"]), mode="cpp_adapter")
            print(f"py_actions={py_trace.actions}", flush=True)
            print(f"ad_actions={ad_trace.actions}", flush=True)
            print(f"py_vnodes={[int(step.v_node_id) for step in py_trace.steps]}", flush=True)
            print(f"ad_vnodes={[int(step.v_node_id) for step in ad_trace.steps]}", flush=True)
            print(f"divergence={_first_divergence(py_trace, ad_trace)}", flush=True)
            return 0

        py_solution, _ = _trace_python_like(py_actor, copy.deepcopy(obs["v_net"]), copy.deepcopy(obs["p_net"]), mode="python")
        _, _, done, _ = env.step(py_solution)
        arrival_seen += 1
        if done:
            raise RuntimeError("Environment ended before request 2.")


if __name__ == "__main__":
    raise SystemExit(main())
