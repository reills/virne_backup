from __future__ import annotations

import sys
import signal
from pathlib import Path

import pytest

sys.path.insert(0, str(Path(__file__).resolve().parents[2]))

from vneMoon import moon
from vneMoon.moon import MoonController, assess_subscription_quota, is_codex_usage_limit_error


NOW = 2_000_000_000.0


def window(used: float, duration: int, reset_delta: int = 3600) -> dict[str, float]:
    return {
        "usedPercent": used,
        "windowDurationMins": duration,
        "resetsAt": NOW + reset_delta,
    }


def response(
    *,
    primary_used: float = 20,
    secondary_used: float = 30,
    model_used: float = 40,
) -> dict[str, object]:
    shared = {
        "limitId": "codex",
        "primary": window(primary_used, 300),
        "secondary": window(secondary_used, 10080, 7200),
        "rateLimitReachedType": None,
        "spendControlReached": False,
    }
    return {
        "id": 2,
        "result": {
            "rateLimits": shared,
            "rateLimitsByLimitId": {
                "codex": shared,
                "gpt-6.1-sol": {
                    "limitId": "gpt-6.1-sol",
                    "primary": window(model_used, 300),
                    "secondary": window(20, 10080, 7200),
                },
            },
        },
    }


def test_allows_when_shared_and_model_windows_have_more_than_reserve() -> None:
    decision = assess_subscription_quota(response(), reserve_percent=10, now_epoch=NOW)
    assert decision["allowed"] is True
    assert {item["window_duration_mins"] for item in decision["windows"]} == {
        300.0,
        10080.0,
    }


@pytest.mark.parametrize(
    ("kwargs", "scope", "reset_delta"),
    [
        ({"primary_used": 90}, "shared.primary", 3600),
        ({"secondary_used": 95}, "shared.secondary", 7200),
        ({"model_used": 91}, "limit:gpt-6.1-sol.primary", 3600),
    ],
)
def test_blocks_at_ten_percent_remaining_across_all_windows(
    kwargs: dict[str, float], scope: str, reset_delta: int
) -> None:
    decision = assess_subscription_quota(
        response(**kwargs), reserve_percent=10, now_epoch=NOW
    )
    assert decision["allowed"] is False
    assert scope in decision["reason"]
    assert decision["pause_until"] == NOW + reset_delta


@pytest.mark.parametrize(
    "mutation",
    [
        lambda payload: payload["result"].pop("rateLimits"),
        lambda payload: payload["result"]["rateLimits"].pop("secondary"),
        lambda payload: payload["result"]["rateLimits"]["primary"].pop("resetsAt"),
        lambda payload: payload["result"]["rateLimits"]["primary"].update(
            {"resetsAt": NOW - 1}
        ),
        lambda payload: payload["result"]["rateLimits"]["primary"].update(
            {"usedPercent": 101}
        ),
    ],
)
def test_missing_stale_and_inconsistent_quota_fail_closed(mutation) -> None:
    payload = response()
    mutation(payload)
    decision = assess_subscription_quota(payload, reserve_percent=10, now_epoch=NOW)
    assert decision["allowed"] is False


def test_usage_limit_error_detection_is_specific() -> None:
    assert is_codex_usage_limit_error("ERROR: You've hit your usage limit. Try again later.")
    assert is_codex_usage_limit_error('{"code":"rate_limit_exceeded"}')
    assert not is_codex_usage_limit_error("candidate test failed")
    assert not is_codex_usage_limit_error("server disconnected")


def test_waiter_sleeps_to_reset_then_rechecks_mocked_app_server(monkeypatch) -> None:
    controller = MoonController.__new__(MoonController)
    controller.config = {
        "codex_quota_reserve_percent": 10,
        "quota_unknown_retry_seconds": 300,
        "quota_reset_grace_seconds": 5,
    }
    replies = iter([response(primary_used=90), response(primary_used=20)])
    events: list[tuple[str, dict[str, object]]] = []
    sleeps: list[float] = []
    controller.read_subscription_rate_limits = lambda: next(replies)
    controller.event = lambda kind, **fields: events.append((kind, fields))
    monkeypatch.setattr(moon.time, "time", lambda: NOW)
    monkeypatch.setattr(moon.time, "sleep", sleeps.append)

    decision = controller.wait_for_codex_allowance()

    assert decision["allowed"] is True
    assert sleeps == [3605.0]
    assert [kind for kind, _ in events].count("codex_quota_checked") == 2
    assert any(kind == "codex_quota_paused" for kind, _ in events)


def test_marker_cleanup_terminates_then_kills_only_marked_descendants(monkeypatch) -> None:
    controller = MoonController.__new__(MoonController)
    controller.config = {"codex_descendant_shutdown_seconds": 0}
    sightings = iter([[111, 222], [222], []])
    signals: list[tuple[int, signal.Signals]] = []
    controller.marker_pids = lambda marker: next(sightings)
    controller.event = lambda kind, **fields: None
    monkeypatch.setattr(moon.os, "kill", lambda pid, sig: signals.append((pid, sig)))

    controller.cleanup_codex_marker("unique-marker")

    assert signals == [
        (111, signal.SIGTERM),
        (222, signal.SIGTERM),
        (222, signal.SIGKILL),
    ]


def test_fixed_dataset_overrides_do_not_use_invalid_hydra_topology_key(tmp_path) -> None:
    controller = MoonController.__new__(MoonController)
    controller.config = {
        "mcts_computation_budget": 16,
        "request_timeout_seconds": 0.75,
    }
    overrides = controller.virne_overrides(
        plan={"solver_name": "alpha_zero_sfc"},
        case={"topology": "wx100", "seed": 0},
        trace=tmp_path,
        run_id="mock",
        save_root=tmp_path / "results",
        checkpoint=None,
        training=False,
        watchdog_seconds=60,
    )

    assert not any(item.startswith("p_net_setting.topology.file_path=") for item in overrides)
    assert f"simulation.p_net_dataset_dir={tmp_path}" in overrides


def test_checkpoint_overrides_restore_saved_model_architecture(tmp_path) -> None:
    model_dir = tmp_path / "models"
    model_dir.mkdir()
    checkpoint = model_dir / "policy_latest.pt"
    checkpoint.touch()
    (tmp_path / "config.yaml").write_text(
        "training:\n  alpha_zero_backbone: transformer\n"
        "nn:\n  embedding_dim: 96\n  n_heads: 6\n"
        "  transformer_layers: 2\n  num_gnn_layers: 2\n",
        encoding="utf-8",
    )
    controller = MoonController.__new__(MoonController)
    controller.config = {
        "mcts_computation_budget": 16,
        "request_timeout_seconds": 0.75,
    }

    overrides = controller.virne_overrides(
        plan={"solver_name": "alpha_zero_sfc"},
        case={"topology": "wx100", "seed": 0},
        trace=tmp_path,
        run_id="mock",
        save_root=tmp_path / "results",
        checkpoint=checkpoint,
        training=False,
        watchdog_seconds=60,
    )

    assert "training.alpha_zero_backbone=transformer" in overrides
    assert "nn.embedding_dim=96" in overrides
    assert "nn.n_heads=6" in overrides
    assert "nn.transformer_layers=2" in overrides
    assert "nn.num_gnn_layers=2" in overrides


def test_checkpoint_without_architecture_is_rejected(tmp_path) -> None:
    checkpoint = tmp_path / "models" / "policy_latest.pt"
    checkpoint.parent.mkdir()
    checkpoint.touch()

    with pytest.raises(moon.MoonError, match="checkpoint model config is missing"):
        MoonController.checkpoint_model_overrides(checkpoint)
