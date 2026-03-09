from __future__ import annotations

from types import SimpleNamespace

import pytest
import warnings

warnings.filterwarnings(
    "ignore",
    message="CUDA initialization:.*",
    category=UserWarning,
)

from virne.solver.learning.reinforcement_learning.alpha_vne.actor_optimized import OptimizedAlphaZeroActor


def test_solve_raises_when_pure_cpp_enabled_and_cpp_full_solver_fails():
    actor = SimpleNamespace(
        pure_cpp=True,
        cpp_full_solver=object(),
        _solve_with_cpp_full=lambda *_args, **_kwargs: (_ for _ in ()).throw(RuntimeError("cpp boom")),
    )

    with pytest.raises(RuntimeError, match="refusing Python fallback"):
        OptimizedAlphaZeroActor.solve(actor, {"v_net": object(), "p_net": object()}, training=True)


def test_worker_solve_raises_when_pure_cpp_enabled_and_cpp_full_solver_fails():
    actor = SimpleNamespace(
        pure_cpp=True,
        cpp_full_solver=object(),
        _solve_with_cpp_full=lambda *_args, **_kwargs: (_ for _ in ()).throw(RuntimeError("cpp boom")),
    )

    with pytest.raises(RuntimeError, match="refusing Python fallback"):
        OptimizedAlphaZeroActor.solve_vnr_with_mcts(
            actor,
            v_net=object(),
            p_net=object(),
            solution={},
            controller=object(),
            training=True,
        )
