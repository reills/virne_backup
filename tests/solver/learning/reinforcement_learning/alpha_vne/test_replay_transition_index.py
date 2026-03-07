from __future__ import annotations

import json
from pathlib import Path

from virne.solver.learning.reinforcement_learning.alpha_vne.learner import TransitionBuffer


def _write_episode(path: Path, name: str, trajectory: list[dict]) -> None:
    payload = {
        "final_reward": 1.0,
        "final_reward_raw": 1.0,
        "accepted": True,
        "total_cost": 2.0,
        "total_revenue": 3.0,
        "trajectory": trajectory,
        "static_environment": {"sfc_request": {"nodes": [], "links": []}},
    }
    with (path / name).open("w") as f:
        json.dump(payload, f)


def test_transition_buffer_indexes_all_valid_positions(tmp_path: Path) -> None:
    _write_episode(
        tmp_path,
        "episode_1.json",
        [
            {"observation": {"step_id": 0}, "pi": [1.0, 0.0], "mask": [1.0, 1.0]},
            {"observation": {"step_id": 1}, "mask": [1.0, 1.0]},  # invalid: no pi
            {"observation": {"step_id": 2}, "pi": [0.0, 1.0], "mask": [1.0, 1.0]},
        ],
    )

    replay = TransitionBuffer(max_size=32, episode_cache_size=4)
    added = replay.ingest_directory(str(tmp_path), limit=100)

    assert added == 2
    assert len(replay) == 2

    sample = replay.sample(2)
    assert len(sample) == 2
    sampled_steps = {int(t["observation"]["step_id"]) for t in sample}
    assert sampled_steps == {0, 2}


def test_transition_buffer_uses_episode_cache_during_sampling(tmp_path: Path) -> None:
    _write_episode(
        tmp_path,
        "episode_2.json",
        [
            {"observation": {"step_id": 0}, "pi": [1.0, 0.0], "mask": [1.0, 1.0]},
            {"observation": {"step_id": 1}, "pi": [0.0, 1.0], "mask": [1.0, 1.0]},
        ],
    )

    replay = TransitionBuffer(max_size=32, episode_cache_size=1)
    replay.ingest_directory(str(tmp_path), limit=100)

    def _fail_read(_: str):
        raise AssertionError("episode file should not be reparsed when cached")

    replay._read_episode = _fail_read  # type: ignore[method-assign]
    (tmp_path / "episode_2.json").unlink()

    sample = replay.sample(1)
    assert len(sample) == 1
    assert "observation" in sample[0]
