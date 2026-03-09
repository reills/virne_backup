from __future__ import annotations

from types import SimpleNamespace
import warnings

warnings.filterwarnings(
    "ignore",
    message="CUDA initialization:.*",
    category=UserWarning,
)

import torch

from virne.solver.learning.reinforcement_learning.alpha_vne.cpp_adapter import CppFullSolver
from virne.solver.learning.reinforcement_learning.alpha_vne.net import ActorCritic


def test_cpp_full_solver_export_fallback_uses_script_safe_model_fields(tmp_path, monkeypatch):
    model_config = {
        "p_net_num_nodes": 100,
        "p_net_feature_dim": 5,
        "v_net_feature_dim": 3,
        "p_net_edge_dim": 1,
        "embedding_dim": 128,
        "n_heads": 8,
        "n_layers": 4,
        "gnn_layers": 3,
        "dropout": 0.1,
        "allow_rejection": False,
        "max_seq_len": 15,
    }

    actor = SimpleNamespace(
        policy=ActorCritic(**model_config).eval(),
        policy_network=SimpleNamespace(model_config=model_config),
    )
    solver = SimpleNamespace(actor=actor)
    ts_path = tmp_path / "policy_latest.ts"

    def fake_script(_wrapper):
        raise RuntimeError("force trace fallback")

    class _FakeScripted:
        def save(self, path: str) -> None:
            with open(path, "wb") as handle:
                handle.write(b"ok")

    def fake_trace(_wrapper, example, check_trace=False):
        assert check_trace is False
        assert tuple(example["encoder_outputs"].shape) == (1, model_config["max_seq_len"], model_config["embedding_dim"])
        assert tuple(example["action_mask"].shape) == (1, model_config["p_net_num_nodes"])
        return _FakeScripted()

    monkeypatch.setattr(torch.jit, "script", fake_script, raising=True)
    monkeypatch.setattr(torch.jit, "trace", fake_trace, raising=True)

    CppFullSolver._export_torchscript(solver, str(ts_path))
    assert ts_path.exists()
    assert ts_path.read_bytes() == b"ok"
