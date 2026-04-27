#!/usr/bin/env python3
"""Summarize AlphaZero replay policy sharpness and learner policy accuracy."""

from __future__ import annotations

import argparse
import json
import math
import re
from pathlib import Path
from statistics import mean


POLICY_ACC_RE = re.compile(
    r"Learner Step\s+(?P<step>\d+):\s+policy_acc=(?P<acc>[0-9.]+)\s+loss_p=(?P<loss_p>[0-9.]+)"
)


def _mean(values: list[float]) -> float:
    return float("nan") if not values else mean(values)


def _entropy(probs: list[float]) -> float:
    return -sum(p * math.log(p) for p in probs if p > 0.0)


def _iter_replay_files(run_dir: Path) -> list[Path]:
    replay_dir = run_dir / "replay_buffer"
    if not replay_dir.exists():
        return []
    files = sorted(replay_dir.glob("*.json"), key=lambda p: p.stat().st_mtime)
    return files


def _load_policy_acc(run_dir: Path) -> list[tuple[int, float, float]]:
    rows: list[tuple[int, float, float]] = []
    for log_path in (run_dir / "stderr.log", run_dir / "stdout.log", run_dir / "logs" / "running.log"):
        if not log_path.exists():
            continue
        try:
            text = log_path.read_text(errors="ignore")
        except OSError:
            continue
        for match in POLICY_ACC_RE.finditer(text):
            rows.append(
                (
                    int(match.group("step")),
                    float(match.group("acc")),
                    float(match.group("loss_p")),
                )
            )
    rows.sort(key=lambda row: row[0])
    dedup: dict[int, tuple[int, float, float]] = {}
    for row in rows:
        dedup[row[0]] = row
    return [dedup[key] for key in sorted(dedup)]


def _trajectory(data: dict) -> list[dict]:
    trajectory = data.get("trajectory")
    if isinstance(trajectory, list):
        return [step for step in trajectory if isinstance(step, dict)]
    return []


def _summarize_replay(files: list[Path], sample: int) -> dict[str, float | int]:
    if sample > 0:
        files = files[-sample:]

    max_probs: list[float] = []
    nonzeros: list[int] = []
    entropies: list[float] = []
    action_is_argmax = 0
    steps_seen = 0

    for path in files:
        try:
            data = json.loads(path.read_text())
        except (OSError, json.JSONDecodeError):
            continue
        for step in _trajectory(data):
            pi = step.get("pi")
            if not isinstance(pi, list) or not pi:
                continue
            probs = [float(p) for p in pi]
            if not probs:
                continue
            max_prob = max(probs)
            argmax = probs.index(max_prob)
            a_taken = step.get("a_taken")
            max_probs.append(max_prob)
            nonzeros.append(sum(1 for p in probs if p > 0.0))
            entropies.append(_entropy(probs))
            if isinstance(a_taken, int) and a_taken == argmax:
                action_is_argmax += 1
            steps_seen += 1

    return {
        "files_sampled": len(files),
        "steps": steps_seen,
        "mean_max_pi": _mean(max_probs),
        "mean_nonzero_pi": _mean([float(v) for v in nonzeros]),
        "mean_entropy": _mean(entropies),
        "a_taken_argmax_rate": (action_is_argmax / steps_seen) if steps_seen else float("nan"),
    }


def _summarize_policy_acc(rows: list[tuple[int, float, float]], window: int) -> dict[str, float | int]:
    selected = rows[-window:] if window > 0 else rows
    return {
        "learner_steps": rows[-1][0] if rows else 0,
        "policy_acc_mean_last_window": _mean([row[1] for row in selected]),
        "loss_p_mean_last_window": _mean([row[2] for row in selected]),
        "policy_acc_last": selected[-1][1] if selected else float("nan"),
        "loss_p_last": selected[-1][2] if selected else float("nan"),
    }


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("run_dirs", nargs="+", type=Path)
    parser.add_argument("--sample-files", type=int, default=300)
    parser.add_argument("--policy-window", type=int, default=100)
    args = parser.parse_args()

    for run_dir in args.run_dirs:
        replay_summary = _summarize_replay(_iter_replay_files(run_dir), args.sample_files)
        acc_summary = _summarize_policy_acc(_load_policy_acc(run_dir), args.policy_window)
        print(f"run={run_dir}")
        print(
            "  replay: "
            f"files={replay_summary['files_sampled']} "
            f"steps={replay_summary['steps']} "
            f"mean_max_pi={replay_summary['mean_max_pi']:.4f} "
            f"mean_nonzero_pi={replay_summary['mean_nonzero_pi']:.2f} "
            f"mean_entropy={replay_summary['mean_entropy']:.4f} "
            f"a_taken_argmax={replay_summary['a_taken_argmax_rate']:.3f}"
        )
        print(
            "  learner: "
            f"last_step={acc_summary['learner_steps']} "
            f"mean_policy_acc={acc_summary['policy_acc_mean_last_window']:.3f} "
            f"last_policy_acc={acc_summary['policy_acc_last']:.3f} "
            f"mean_loss_p={acc_summary['loss_p_mean_last_window']:.4f} "
            f"last_loss_p={acc_summary['loss_p_last']:.4f}"
        )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
