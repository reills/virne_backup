import logging
import torch
from omegaconf import OmegaConf, open_dict

from virne.system.base_system import BaseSystem
from virne.core import Controller, Recorder, Counter, Logger
from virne.core.environment import SolutionStepEnvironment
from virne.solver.learning.reinforcement_learning.alpha_vne.actor_optimized import OptimizedAlphaZeroActor
from virne.solver.learning.reinforcement_learning.alpha_vne.node import State
from virne.solver.learning.reinforcement_learning.alpha_vne.feature_constructor import AlphaZeroFeatureAdapter
from virne.solver.learning.reinforcement_learning.alpha_vne.cpp_adapter import create_cpp_adapter
from virne.solver.learning.reinforcement_learning.alpha_vne import alpha_zero_cpp_core as cpp_core


logging.disable(logging.CRITICAL)

CONFIG_PATH = "results/journal_suite/results/alpha_zero_sfc/journal_suite__alpha_zero_sfc__geant__nominal__seed0__train__ktrain10__attempt7/config.yaml"
MODELS_DIR = "results/journal_suite/results/alpha_zero_sfc/journal_suite__alpha_zero_sfc__geant__nominal__seed0__train__ktrain10__attempt7/models"
CKPT = MODELS_DIR + "/policy_latest.pt"


def load_actor():
    base = OmegaConf.load(CONFIG_PATH)
    with open_dict(base):
        base.training.use_cuda = False
        base.training.use_batched_gpu = False
        base.training.disable_trajectory_writing = True
        base.training.enable_async_learner = False
        base.training.inference_only = True
        base.training.resume_training = False
        base.training.alphazero_model_path = CKPT
        base.training.dirichlet_epsilon = 0.0
        base.training.temperature_eval = 0.0
        base.training.num_train_epochs = 0
        base.training.use_cpp_mcts = True
        base.training.pure_cpp = True
        base.logger.level = "ERROR"

    logger = Logger(config=base)
    logger.info = lambda *args, **kwargs: None
    logger.warning = lambda *args, **kwargs: None
    p_net, v_sim = BaseSystem.load_dataset(logger, base)
    node_attrs_setting = base.v_sim_setting["node_attrs_setting"]
    link_attrs_setting = base.v_sim_setting["link_attrs_setting"]
    graph_attrs_setting = base.v_sim_setting.get("graph_attrs_setting", {})
    counter = Counter(node_attrs_setting, link_attrs_setting, graph_attrs_setting, base)
    controller = Controller(node_attrs_setting, link_attrs_setting, graph_attrs_setting, base)
    recorder = Recorder(counter, base, worker_id=814)
    env = SolutionStepEnvironment(p_net, v_sim, controller, recorder, counter, logger, base)
    instance = env.reset(base.experiment.seed)
    p_net = instance["p_net"]
    v_net = instance["v_net"]
    actor = OptimizedAlphaZeroActor(
        controller,
        recorder,
        counter,
        logger,
        base,
        replay_dir="/tmp/az_parity_replay",
        models_dir=MODELS_DIR,
        use_batched_gpu=False,
        disable_trajectory_writing=True,
        shortest_method=base.solver.shortest_method,
        k_shortest=base.solver.k_shortest,
    )
    actor.obs_builder.set_episode_data(p_net, v_net)
    return base, p_net, v_net, controller, recorder, counter, actor


def tensor_diff(lhs, rhs):
    lhs = lhs.detach().cpu()
    rhs = rhs.detach().cpu()
    if tuple(lhs.shape) != tuple(rhs.shape):
        return f"shape {tuple(lhs.shape)} vs {tuple(rhs.shape)}"
    if lhs.dtype == torch.bool or rhs.dtype == torch.bool:
        return int((lhs != rhs).sum().item())
    if lhs.numel() == 0:
        return 0.0
    return float((lhs.to(torch.float32) - rhs.to(torch.float32)).abs().max().item())


def summarize_diff(name, lhs, rhs):
    lhs = lhs.detach().cpu()
    rhs = rhs.detach().cpu()
    if tuple(lhs.shape) != tuple(rhs.shape):
        print(name, "shape", tuple(lhs.shape), tuple(rhs.shape))
        return
    if lhs.dtype == torch.bool or rhs.dtype == torch.bool:
        print(name, "bool_diff", int((lhs != rhs).sum().item()))
        return
    if lhs.numel() == 0:
        print(name, "empty")
        return
    delta = (lhs.to(torch.float32) - rhs.to(torch.float32)).abs()
    flat_idx = int(delta.view(-1).argmax().item())
    max_diff = float(delta.view(-1)[flat_idx].item())
    print(name, "max_diff", max_diff, "flat_idx", flat_idx)
    if lhs.dim() == 2:
        row = flat_idx // lhs.size(1)
        col = flat_idx % lhs.size(1)
        print(" row", row, "col", col, "py", float(lhs[row, col]), "cpp", float(rhs[row, col]))
    elif lhs.dim() == 3:
        plane = flat_idx // (lhs.size(1) * lhs.size(2))
        rem = flat_idx % (lhs.size(1) * lhs.size(2))
        row = rem // lhs.size(2)
        col = rem % lhs.size(2)
        print(" plane", plane, "row", row, "col", col, "py", float(lhs[plane, row, col]), "cpp", float(rhs[plane, row, col]))


def main():
    base, p_net, v_net, controller, recorder, counter, actor = load_actor()
    solver = actor.cpp_full_solver
    feature_adapter = AlphaZeroFeatureAdapter(actor.config, p_net, v_net)
    feature_metadata = feature_adapter.build_cpp_feature_metadata()
    p_node_attrs, p_edges, p_edge_attrs, p_directed = solver._build_network_payload(
        p_net,
        solver._node_resource_names,
        solver._link_resource_names,
        topological_metrics=feature_metadata.get("p_topological_metrics"),
        preserve_link_orientation=True,
    )
    v_node_attrs, v_edges, v_edge_attrs, v_directed = solver._build_network_payload(
        v_net,
        solver._node_resource_names,
        solver._link_resource_names,
        topological_metrics=feature_metadata.get("v_topological_metrics"),
    )
    vnr_cfg = solver._build_vnr_config(feature_metadata)
    policy_ts = actor.policy_path.replace(".pt", ".ts")
    if solver._torchscript_needs_export(policy_ts):
        solver._export_torchscript(policy_ts)
    p_cpp = cpp_core.Network()
    p_cpp.set_num_nodes(len(p_node_attrs))
    p_cpp.set_edges(p_edges, p_directed)
    p_cpp.set_node_attrs(p_node_attrs)
    p_cpp.set_edge_attrs(p_edge_attrs)
    v_cpp = cpp_core.Network()
    v_cpp.set_num_nodes(len(v_node_attrs))
    v_cpp.set_edges(v_edges, v_directed)
    v_cpp.set_node_attrs(v_node_attrs)
    v_cpp.set_edge_attrs(v_edge_attrs)
    cpp_state = cpp_core.VNRState(p_cpp, v_cpp, vnr_cfg)
    py_root_state = State(
        p_net,
        v_net,
        controller,
        recorder,
        counter,
        link_params={"shortest_method": base.solver.shortest_method, "k": base.solver.k_shortest},
    )
    print("PY_V_ORDER", list(py_root_state.v_order))
    print("CPP_V_ORDER", list(cpp_state.virtual_order))
    adapter = create_cpp_adapter(actor, actor.computation_budget)
    adapter.begin_request(p_net, v_net)

    for prefix in ([], [4], [4, 9], [4, 34], [4, 34, 9]):
        state = State(
            p_net,
            v_net,
            controller,
            recorder,
            counter,
            link_params={"shortest_method": base.solver.shortest_method, "k": base.solver.k_shortest},
        )
        for action in prefix:
            state = state.next_state(action)
        curr_v = state.v_order[state.v_node_id + 1] if state.v_node_id + 1 < len(state.v_order) else None
        py_obs = actor.obs_builder.build(state, actor.policy, curr_v)
        adapter._ensure_cpp_networks(state)
        adapter_state = adapter._initialize_cpp_state(state)
        hybrid_state = adapter._python_state_from_cpp(state, adapter_state)
        hybrid_obs = adapter._build_obs_from_cpp_state(adapter_state, v_node_id=curr_v)
        if prefix:
            cpp_obs = cpp_core.debug_build_observation_after_actions(
                p_node_attrs,
                p_edges,
                p_edge_attrs,
                p_directed,
                v_node_attrs,
                v_edges,
                v_edge_attrs,
                v_directed,
                vnr_cfg,
                prefix,
                policy_ts,
                "cpu",
            )
            cpp_eval = cpp_core.debug_evaluate_after_actions(
                p_node_attrs,
                p_edges,
                p_edge_attrs,
                p_directed,
                v_node_attrs,
                v_edges,
                v_edge_attrs,
                v_directed,
                vnr_cfg,
                prefix,
                policy_ts,
                "cpu",
            )
        else:
            cpp_obs = cpp_core.debug_build_observation(
                p_node_attrs,
                p_edges,
                p_edge_attrs,
                p_directed,
                v_node_attrs,
                v_edges,
                v_edge_attrs,
                v_directed,
                vnr_cfg,
                policy_ts,
                "cpu",
            )
            cpp_eval = cpp_core.debug_evaluate_root(
                p_node_attrs,
                p_edges,
                p_edge_attrs,
                p_directed,
                v_node_attrs,
                v_edges,
                v_edge_attrs,
                v_directed,
                vnr_cfg,
                policy_ts,
                "cpu",
            )

        print("PREFIX", prefix, "curr_v", curr_v)
        mapping = {
            "p_net_x": py_obs["p_net"].x,
            "p_net_edge_index": py_obs["p_net"].edge_index,
            "p_net_edge_attr": py_obs["p_net"].edge_attr,
            "history_features": py_obs["history_features"],
            "encoder_outputs": py_obs["encoder_outputs"],
            "curr_v_node_id": py_obs["curr_v_node_id"],
            "vnfs_remaining": py_obs["vnfs_remaining"],
            "action_mask": py_obs["action_mask"],
            "candidate_features": py_obs["candidate_features"],
            "v_net_x": py_obs["v_net_x"],
        }
        for key, py_t in mapping.items():
            print(key, tensor_diff(py_t, cpp_obs[key]))
        print("HYBRID_COMPARE")
        hybrid_mapping = {
            "p_net_x": hybrid_obs["p_net"].x,
            "p_net_edge_index": hybrid_obs["p_net"].edge_index,
            "p_net_edge_attr": hybrid_obs["p_net"].edge_attr,
            "history_features": hybrid_obs["history_features"],
            "encoder_outputs": hybrid_obs["encoder_outputs"],
            "curr_v_node_id": hybrid_obs["curr_v_node_id"],
            "vnfs_remaining": hybrid_obs["vnfs_remaining"],
            "action_mask": hybrid_obs["action_mask"],
            "candidate_features": hybrid_obs["candidate_features"],
            "v_net_x": hybrid_obs["v_net_x"],
        }
        for key, hybrid_t in hybrid_mapping.items():
            print("hybrid", key, tensor_diff(mapping[key], hybrid_t))
        summarize_diff("v_net_x_detail", mapping["v_net_x"], cpp_obs["v_net_x"])
        summarize_diff("p_net_x_detail", mapping["p_net_x"], cpp_obs["p_net_x"])
        summarize_diff("p_edge_attr_detail", mapping["p_net_edge_attr"], cpp_obs["p_net_edge_attr"])
        py_logits, py_value = actor.policy_network.evaluate(py_obs, use_nn_policy=True, use_nn_value=True)
        cpp_logits = cpp_eval["policy_logits"]
        cpp_value = cpp_eval["value"]
        if py_logits.dim() > 1:
            py_logits = py_logits.squeeze(0)
        if cpp_logits.dim() > 1:
            cpp_logits = cpp_logits.squeeze(0)
        print("logits", tensor_diff(py_logits, cpp_logits))
        print("value", float(py_value), float(cpp_value.item()))
        if prefix == [4, 9]:
            print("PY_LINK_ALLOC", state._resource_allocations["link"])
            print("HYBRID_LINK_ALLOC", hybrid_state._resource_allocations["link"])


if __name__ == "__main__":
    main()
