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


cpp_core = pytest.importorskip(
    "virne.solver.learning.reinforcement_learning.alpha_vne.alpha_zero_cpp_core",
    reason="C++ extension is required for full-solver contract checks.",
)


def test_cpp_full_solver_marks_incomplete_placement_as_failure():
    vnr_cfg = cpp_core.VNRConfig()
    vnr_cfg.node_resource_names = ["cpu"]
    vnr_cfg.link_resource_names = []
    vnr_cfg.allow_rejection = False
    vnr_cfg.shortest_method = "bfs_shortest"
    vnr_cfg.k_shortest = 1

    search_cfg = cpp_core.SearchConfig()
    search_cfg.simulations = 2
    search_cfg.use_neural_network = False
    search_cfg.rollout_depth_limit = 4
    search_cfg.eval_batch_size = 1

    p_node_attrs = [{"cpu": 1.0}]
    p_edges: list[tuple[int, int]] = []
    p_edge_attrs: list[dict] = []

    v_node_attrs = [{"cpu": 1.0}, {"cpu": 1.0}]
    v_edges: list[tuple[int, int]] = []
    v_edge_attrs: list[dict] = []

    result = cpp_core.solve(
        p_node_attrs,
        p_edges,
        p_edge_attrs,
        False,
        v_node_attrs,
        v_edges,
        v_edge_attrs,
        False,
        vnr_cfg,
        search_cfg,
        "",
        "",
        "cpu",
        None,
        1.0,
        False,
        False,
        False,
        "",
        0,
    )

    node_slots = list(result.get("node_slots", []))
    assert len(node_slots) == 2
    assert result.get("place_result") is False
    assert result.get("route_result") is False
    assert any(slot < 0 for slot in node_slots)


def test_cpp_full_solver_retries_after_torchscript_corruption(tmp_path, monkeypatch):
    from virne.solver.learning.reinforcement_learning.alpha_vne import cpp_adapter

    if cpp_adapter.cpp_core is None:
        pytest.skip("C++ extension is required for retry checks.")

    policy_pt = tmp_path / "policy_latest.pt"
    policy_ts = tmp_path / "policy_latest.ts"
    policy_ts.write_bytes(b"corrupt")

    calls = {"count": 0}

    def fake_solve(*_args, **_kwargs):
        calls["count"] += 1
        if calls["count"] == 1:
            raise RuntimeError(
                "PytorchStreamReader failed reading file code/__torch__/foo.py: "
                "invalid header or archive is corrupted"
            )
        return {"place_result": False}

    export_calls = {"count": 0}

    def fake_export(self, path: str) -> None:
        export_calls["count"] += 1
        with open(path, "wb") as handle:
            handle.write(b"ok")

    monkeypatch.setattr(cpp_adapter.cpp_core, "solve", fake_solve, raising=True)
    monkeypatch.setattr(cpp_adapter.CppFullSolver, "_export_torchscript", fake_export, raising=True)

    actor = SimpleNamespace(
        policy_path=str(policy_pt),
        policy=SimpleNamespace(state_dict=lambda: {}),
        device=torch.device("cpu"),
        controller=SimpleNamespace(node_resource_attrs=[], link_resource_attrs=[]),
        shortest_method="bfs_shortest",
        k_shortest=1,
        use_neural_network=False,
        use_nn_policy=False,
        use_nn_value=False,
        disable_trajectory_writing=True,
        replay_dir=str(tmp_path),
        temperature_train=1.0,
        temperature_eval=0.0,
        config=SimpleNamespace(training=SimpleNamespace(gpu_batch_size=1, value_normalization="tanh", value_scale=1.0)),
    )

    solver = cpp_adapter.CppFullSolver(actor, computation_budget=1)

    class DummyNet:
        def __init__(self):
            self.nodes = {0: {"cpu": 1.0}}
            self.links = {}

        def is_directed(self):
            return False

    p_net = DummyNet()
    v_net = DummyNet()

    result = solver.solve(p_net, v_net, training=False, pure_cpp=False, replay_dir=str(tmp_path), max_buffer_size=1)

    assert result.get("place_result") is False
    assert calls["count"] == 2
    assert export_calls["count"] == 1
    assert policy_ts.exists()
