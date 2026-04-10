from __future__ import annotations

from types import SimpleNamespace
import warnings

import pytest
import torch

warnings.filterwarnings(
    "ignore",
    message="CUDA initialization:.*",
    category=UserWarning,
)

from virne.solver.learning.reinforcement_learning.alpha_vne.actor_optimized import OptimizedAlphaZeroActor


cpp_core = pytest.importorskip(
    "virne.solver.learning.reinforcement_learning.alpha_vne.alpha_zero_cpp_core",
    reason="C++ extension is required for boundary regression checks.",
)


def _build_network(num_nodes: int, edges: list[tuple[int, int]], edge_bw: list[float], directed: bool):
    net = cpp_core.Network()
    net.set_num_nodes(num_nodes)
    net.set_edges(edges, is_directed=directed)
    net.set_node_attrs([{"cpu": 10.0} for _ in range(num_nodes)])
    net.set_edge_attrs([{"bw": float(bw)} for bw in edge_bw])
    return net


def _build_two_node_vnr(demand: float = 1.0):
    v_net = cpp_core.Network()
    v_net.set_num_nodes(2)
    v_net.set_edges([(0, 1)], is_directed=False)
    v_net.set_node_attrs([{"cpu": 1.0}, {"cpu": 1.0}])
    v_net.set_edge_attrs([{"bw": float(demand)}])
    return v_net


def _make_vnr_state(physical, virtual_net, shortest_method: str, allow_rejection: bool = False, k: int = 8):
    cfg = cpp_core.VNRConfig()
    cfg.node_resource_names = ["cpu"]
    cfg.link_resource_names = ["bw"]
    cfg.allow_rejection = bool(allow_rejection)
    cfg.shortest_method = shortest_method
    cfg.k_shortest = int(k)
    return cpp_core.VNRState(physical, virtual_net, cfg)


# Regression guard: path search must not mark a feasible directed link route as infeasible.
def test_available_k_shortest_keeps_feasible_directed_route():
    p_net = _build_network(
        num_nodes=6,
        edges=[(0, 1), (1, 2), (2, 5), (0, 3), (3, 5)],
        edge_bw=[1.0, 1.0, 1.0, 0.0, 1.0],
        directed=True,
    )
    v_net = _build_two_node_vnr(demand=1.0)

    state = _make_vnr_state(p_net, v_net, shortest_method="available_k_shortest", allow_rejection=False, k=8)
    state_after_first = state.create_child(5)   # place first virtual node
    state_after_second = state_after_first.create_child(0)  # route 0 -> 5

    assert state_after_second.last_physical_node != -1


# Regression guard: incremental C++ feasibility checks must mirror Python's
# fallback from first_shortest to available_shortest instead of pruning a
# feasible longer route.
def test_first_shortest_falls_back_to_available_shortest_in_child_expansion():
    p_net = _build_network(
        num_nodes=5,
        edges=[(0, 1), (1, 2), (0, 3), (3, 4), (4, 2)],
        edge_bw=[0.0, 1.0, 1.0, 1.0, 1.0],
        directed=True,
    )
    v_net = _build_two_node_vnr(demand=1.0)

    state = _make_vnr_state(p_net, v_net, shortest_method="first_shortest", allow_rejection=False, k=8)
    state_after_first = state.create_child(2)   # place first virtual node
    state_after_second = state_after_first.create_child(0)  # must use 0 -> 3 -> 2 fallback route

    assert state_after_second.last_physical_node != -1


# Regression guard: expansion must never emit out-of-bounds visits when only invalid action -1 exists.
def test_mcts_expansion_handles_only_invalid_candidate_within_action_bounds():
    p_net = cpp_core.Network()
    p_net.set_num_nodes(2)
    p_net.set_edges([], is_directed=False)
    p_net.set_node_attrs([{"cpu": 1.0}, {"cpu": 1.0}])
    p_net.set_edge_attrs([])

    v_net = cpp_core.Network()
    v_net.set_num_nodes(1)
    v_net.set_edges([], is_directed=False)
    v_net.set_node_attrs([{"cpu": 10.0}])  # intentionally infeasible demand
    v_net.set_edge_attrs([])

    cfg = cpp_core.VNRConfig()
    cfg.node_resource_names = ["cpu"]
    cfg.link_resource_names = []
    cfg.allow_rejection = False
    cfg.shortest_method = "bfs_shortest"
    cfg.k_shortest = 1
    root_state = cpp_core.VNRState(p_net, v_net, cfg)

    search_cfg = cpp_core.SearchConfig()
    search_cfg.simulations = 4
    search_cfg.c_puct = 1.0
    search_cfg.use_neural_network = False
    engine = cpp_core.MCTSEngine(search_cfg)
    engine.set_callbacks(lambda _s: [], lambda _s: ([], 0.0), lambda _s: -1000.0, lambda _s: False)

    view = cpp_core.StateView(1)
    view.domain_state = root_state
    result = engine.run_search(view)

    assert result.visit_counts.numel() == 2  # num physical nodes (reject disabled)
    assert float(result.visit_counts.sum().item()) == 0.0
    assert float(result.policy.sum().item()) == 0.0


# Regression guard: root Dirichlet noise must stay inside valid action bounds only.
def test_root_noise_keeps_prior_mass_on_valid_actions():
    cfg = cpp_core.SearchConfig()
    cfg.simulations = 1
    cfg.c_puct = 1.0
    cfg.dirichlet_alpha = 0.3
    cfg.dirichlet_epsilon = 0.25
    cfg.add_root_noise = True
    cfg.use_neural_network = True
    engine = cpp_core.MCTSEngine(cfg)

    root = cpp_core.StateView(1)
    root.step_index = 0
    root.action_mask = torch.tensor([False, True, False, False, True, False], dtype=torch.bool)

    child_a = cpp_core.StateView(2)
    child_a.step_index = 1
    child_b = cpp_core.StateView(3)
    child_b.step_index = 1

    def expand_cb(state):
        if int(state.step_index) != 0:
            return []
        return [(1, child_a), (4, child_b)]

    def eval_cb(_state):
        logits = torch.zeros(6, dtype=torch.float32)
        value = torch.tensor(0.0, dtype=torch.float32)
        return logits, value

    engine.set_callbacks(expand_cb, eval_cb, lambda _s: 0.0, lambda s: int(s.step_index) >= 1)
    result = engine.run_search(root)

    valid_sum = float(result.root_priors[1].item() + result.root_priors[4].item())
    invalid_sum = float(result.root_priors.sum().item() - valid_sum)
    assert valid_sum == pytest.approx(1.0, abs=1e-5)
    assert invalid_sum == pytest.approx(0.0, abs=1e-6)


# Regression guard: when C++ search already computed root value, Python must not trigger another NN boundary call.
def test_compute_value_prefers_cpp_root_value_without_extra_policy_call():
    class DummyPolicyNetwork:
        def __init__(self):
            self.calls = 0

        def evaluate(self, obs, use_nn_value=True):
            self.calls += 1
            return None, 999.0

    policy_network = DummyPolicyNetwork()
    actor = SimpleNamespace(
        use_neural_network=True,
        policy_network=policy_network,
        _state_to_obs=lambda state, v_node_id: {"dummy": 1},
    )
    node = SimpleNamespace(
        visit_times=0,
        value=0.0,
        state=SimpleNamespace(),
        _diag_root_value=0.25,
    )

    value = OptimizedAlphaZeroActor._compute_value(actor, node, v_node_id=0)

    assert value == pytest.approx(0.25)
    assert policy_network.calls == 0


# Regression guard: reverse-oriented copies of an undirected physical link must share one capacity bucket.
def test_reverse_oriented_physical_edges_share_capacity_when_configured():
    p_net = cpp_core.Network()
    p_net.set_num_nodes(2)
    p_net.set_edges([(0, 1), (1, 0)], is_directed=True)
    p_net.reverse_edge_pairs_share_capacity = True
    p_net.set_node_attrs([{"cpu": 10.0}, {"cpu": 10.0}])
    p_net.set_edge_attrs([{"bw": 1.0}, {"bw": 1.0}])

    v_net = _build_two_node_vnr(demand=1.0)
    state = _make_vnr_state(p_net, v_net, shortest_method="available_shortest", allow_rejection=False, k=1)
    state_after_first = state.create_child(1)
    state_after_second = state_after_first.create_child(0)

    assert state_after_second.last_physical_node != -1
    assert state_after_second.get_available_link_resource(0, "bw") == pytest.approx(0.0)
    assert state_after_second.get_available_link_resource(1, "bw") == pytest.approx(0.0)


def test_cpp_adapter_step_seed_is_deterministic_and_step_specific():
    from virne.solver.learning.reinforcement_learning.alpha_vne.cpp_adapter import CppMCTSAdapter

    adapter = object.__new__(CppMCTSAdapter)
    adapter.actor = SimpleNamespace(_cpp_request_seed=12345, _cpp_worker_seed=None, config=None)

    seed_step0_a = adapter._search_seed_for_step(0)
    seed_step0_b = adapter._search_seed_for_step(0)
    seed_step1 = adapter._search_seed_for_step(1)

    assert seed_step0_a == seed_step0_b
    assert seed_step0_a != seed_step1
