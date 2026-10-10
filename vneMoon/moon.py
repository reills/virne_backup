#!/usr/bin/env python3
"""Token-efficient autonomous research loop for Virne/AlphaVNE.

Codex is invoked only for a bounded edit turn.  It must terminate before this
controller starts any build, training, or evaluation subprocess.
"""
from __future__ import annotations

import argparse
import csv
import fcntl
import hashlib
import json
import math
import os
import re
import selectors
import signal
import shutil
import subprocess
import sys
import tempfile
import time
import uuid
from contextlib import contextmanager
from datetime import datetime, timedelta, timezone
from pathlib import Path
from typing import Any, Iterable, Mapping, Sequence

import yaml


CONTROL_DIR = Path(__file__).resolve().parent
REPO_ROOT = CONTROL_DIR.parent
RUNTIME_DIR = CONTROL_DIR / "runtime"
CONFIG_PATH = CONTROL_DIR / "config.json"
SCHEMA_PATH = CONTROL_DIR / "candidate.schema.json"
PROGRAM_PATH = CONTROL_DIR / "research_program.md"
STATE_PATH = RUNTIME_DIR / "state.json"
QUEUE_PATH = RUNTIME_DIR / "queue.json"
EXPERIMENTS_PATH = RUNTIME_DIR / "experiments.jsonl"
EVENTS_PATH = RUNTIME_DIR / "lifecycle.jsonl"


class MoonError(RuntimeError):
    pass


class CodexQuotaRetriesExhausted(MoonError):
    """A real Codex subscription limit persisted after bounded retries."""


def utc_now() -> datetime:
    return datetime.now(timezone.utc)


def iso_now() -> str:
    return utc_now().isoformat()


def parse_iso(value: str) -> datetime:
    return datetime.fromisoformat(value)


def atomic_json(path: Path, value: Any) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    temp = path.with_name(path.name + ".tmp")
    temp.write_text(json.dumps(value, indent=2, sort_keys=True) + "\n", encoding="utf-8")
    os.replace(temp, path)


def load_json(path: Path, default: Any = None) -> Any:
    if not path.exists():
        return default
    return json.loads(path.read_text(encoding="utf-8"))


def append_jsonl(path: Path, value: Mapping[str, Any]) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    with path.open("a", encoding="utf-8") as stream:
        stream.write(json.dumps(dict(value), sort_keys=True) + "\n")
        stream.flush()
        os.fsync(stream.fileno())


def sha256_file(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as stream:
        for chunk in iter(lambda: stream.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def sha256_paths(paths: Iterable[Path], root: Path) -> str:
    digest = hashlib.sha256()
    for path in sorted(set(paths), key=lambda item: str(item)):
        relative = path.relative_to(root)
        digest.update(str(relative).encode("utf-8"))
        digest.update(b"\0")
        digest.update(sha256_file(path).encode("ascii"))
        digest.update(b"\0")
    return digest.hexdigest()


def safe_float(value: Any, default: float = 0.0) -> float:
    try:
        number = float(value)
        if number != number or number in (float("inf"), float("-inf")):
            return default
        return number
    except (TypeError, ValueError):
        return default


def tail_text(path: Path, limit: int = 4000) -> str:
    if not path.exists():
        return ""
    text = path.read_text(encoding="utf-8", errors="replace")
    return text[-limit:]


def classify_failure(message: str) -> str:
    lowered = message.lower()
    if is_codex_usage_limit_error(message):
        return "codex_usage_limit"
    if "out of memory" in lowered or "cuda oom" in lowered or "exited 137" in lowered:
        return "oom"
    if "timed out" in lowered or "timeout" in lowered:
        return "timeout"
    if "protected path" in lowered or "protected source" in lowered:
        return "integrity_violation"
    if "test" in lowered:
        return "test_failure"
    return "execution_failure"


def is_codex_usage_limit_error(message: str) -> bool:
    """Recognize subscription-limit failures emitted by `codex exec`."""
    lowered = message.lower()
    patterns = (
        "you've hit your usage limit",
        "you have hit your usage limit",
        "usage limit has been reached",
        "usage limit reached",
        "rate_limit_exceeded",
        "rate limit exceeded",
    )
    return any(pattern in lowered for pattern in patterns)


def assess_subscription_quota(
    response: Mapping[str, Any], *, reserve_percent: float, now_epoch: float
) -> dict[str, Any]:
    """Return a conservative decision for a fresh account/rateLimits/read result."""
    result = response.get("result")
    if not isinstance(result, Mapping):
        return {"allowed": False, "reason": "missing JSON-RPC result", "windows": []}
    shared = result.get("rateLimits")
    if not isinstance(shared, Mapping):
        return {"allowed": False, "reason": "missing shared rate limits", "windows": []}

    snapshots: list[tuple[str, Mapping[str, Any], bool]] = [("shared", shared, True)]
    by_limit_id = result.get("rateLimitsByLimitId")
    if by_limit_id is not None:
        if not isinstance(by_limit_id, Mapping):
            return {"allowed": False, "reason": "invalid model-specific limits", "windows": []}
        for limit_id, snapshot in sorted(by_limit_id.items(), key=lambda item: str(item[0])):
            if not isinstance(snapshot, Mapping):
                return {
                    "allowed": False,
                    "reason": f"invalid model-specific limit {limit_id}",
                    "windows": [],
                }
            snapshots.append((f"limit:{limit_id}", snapshot, False))

    windows: list[dict[str, Any]] = []
    problems: list[str] = []
    blocked_resets: list[float] = []
    for label, snapshot, require_both_windows in snapshots:
        if snapshot.get("spendControlReached") is True:
            problems.append(f"{label} spend control reached")
        if snapshot.get("rateLimitReachedType") not in (None, ""):
            problems.append(f"{label} reports {snapshot['rateLimitReachedType']}")
        present = 0
        for window_name in ("primary", "secondary"):
            window = snapshot.get(window_name)
            if window is None:
                if require_both_windows:
                    problems.append(f"{label}.{window_name} quota window missing")
                continue
            present += 1
            if not isinstance(window, Mapping):
                problems.append(f"{label}.{window_name} quota window invalid")
                continue
            used = safe_float(window.get("usedPercent"), float("nan"))
            duration = safe_float(window.get("windowDurationMins"), float("nan"))
            resets_at = safe_float(window.get("resetsAt"), float("nan"))
            remaining = 100.0 - used
            windows.append(
                {
                    "scope": label,
                    "window": window_name,
                    "used_percent": used,
                    "remaining_percent": remaining,
                    "window_duration_mins": duration,
                    "resets_at": resets_at,
                }
            )
            if not math.isfinite(used) or not (0.0 <= used <= 100.0):
                problems.append(f"{label}.{window_name} usedPercent invalid")
            if not math.isfinite(duration) or duration <= 0.0:
                problems.append(f"{label}.{window_name} windowDurationMins missing or invalid")
            if not math.isfinite(resets_at) or resets_at <= now_epoch:
                problems.append(f"{label}.{window_name} resetsAt missing or stale")
            if remaining <= reserve_percent:
                problems.append(
                    f"{label}.{window_name} has {remaining:.1f}% remaining "
                    f"(reserve {reserve_percent:.1f}%)"
                )
                if math.isfinite(resets_at) and resets_at > now_epoch:
                    blocked_resets.append(resets_at)
        if present == 0:
            problems.append(f"{label} has no quota windows")

    return {
        "allowed": not problems,
        "reason": "; ".join(problems),
        "windows": windows,
        "pause_until": min(blocked_resets) if blocked_resets else None,
    }


def sanitized_experiment_env() -> dict[str, str]:
    forbidden_fragments = ("OPENAI", "CODEX", "ANTHROPIC", "AZURE_OPENAI")
    env = {
        key: value
        for key, value in os.environ.items()
        if not any(fragment in key.upper() for fragment in forbidden_fragments)
    }
    env.update(
        {
            "VNEMOON_LLM_FORBIDDEN": "1",
            "CUDA_VISIBLE_DEVICES": "0",
            "PYTHONDONTWRITEBYTECODE": "1",
            "OMP_NUM_THREADS": "1",
            "MKL_NUM_THREADS": "1",
            "OPENBLAS_NUM_THREADS": "1",
            "NUMEXPR_NUM_THREADS": "1",
            "TOKENIZERS_PARALLELISM": "false",
        }
    )
    return env


@contextmanager
def campaign_lock() -> Any:
    RUNTIME_DIR.mkdir(parents=True, exist_ok=True)
    lock_path = RUNTIME_DIR / "moon.lock"
    with lock_path.open("a+", encoding="utf-8") as lock_file:
        try:
            fcntl.flock(lock_file.fileno(), fcntl.LOCK_EX | fcntl.LOCK_NB)
        except BlockingIOError as exc:
            raise MoonError("another vneMoon controller already holds the GPU/research lock") from exc
        yield


class MoonController:
    def __init__(self, config_path: Path = CONFIG_PATH) -> None:
        self.config_path = config_path.resolve()
        self.config = load_json(self.config_path)
        if not isinstance(self.config, dict):
            raise MoonError(f"invalid config: {self.config_path}")
        configured_worktree = Path(str(self.config["worktree_dir"]))
        self.worktree = (
            configured_worktree
            if configured_worktree.is_absolute()
            else (REPO_ROOT / configured_worktree).resolve()
        )
        self.branch = str(self.config["branch"])
        self.conda = shutil.which("conda") or ""
        self.codex = shutil.which("codex") or ""
        self.bwrap = shutil.which("bwrap") or ""

    def event(self, kind: str, **fields: Any) -> None:
        append_jsonl(EVENTS_PATH, {"at": iso_now(), "kind": kind, **fields})

    def run_process(
        self,
        command: Sequence[str],
        *,
        cwd: Path,
        timeout: float,
        stdout_path: Path,
        stderr_path: Path,
        env: Mapping[str, str] | None = None,
        stdin: str | None = None,
    ) -> subprocess.CompletedProcess[str]:
        stdout_path.parent.mkdir(parents=True, exist_ok=True)
        stderr_path.parent.mkdir(parents=True, exist_ok=True)
        with stdout_path.open("w", encoding="utf-8") as stdout, stderr_path.open(
            "w", encoding="utf-8"
        ) as stderr:
            return subprocess.run(
                list(command),
                cwd=cwd,
                env=dict(env) if env is not None else None,
                input=stdin,
                text=True,
                stdout=stdout,
                stderr=stderr,
                timeout=max(1.0, float(timeout)),
                check=False,
                start_new_session=True,
            )

    @staticmethod
    def _read_rpc_response(
        process: subprocess.Popen[str], request_id: int, timeout: float
    ) -> dict[str, Any]:
        if process.stdout is None:
            raise MoonError("Codex app-server stdout is unavailable")
        selector = selectors.DefaultSelector()
        selector.register(process.stdout, selectors.EVENT_READ)
        deadline = time.monotonic() + timeout
        try:
            while time.monotonic() < deadline:
                ready = selector.select(max(0.0, deadline - time.monotonic()))
                if not ready:
                    break
                line = process.stdout.readline()
                if not line:
                    break
                try:
                    message = json.loads(line)
                except json.JSONDecodeError:
                    continue
                if message.get("id") == request_id:
                    if "error" in message:
                        raise MoonError(f"Codex app-server RPC error: {message['error']}")
                    return message
        finally:
            selector.close()
        raise MoonError(f"Codex app-server request {request_id} timed out")

    def read_subscription_rate_limits(self) -> dict[str, Any]:
        """Fetch ChatGPT plan usage without performing an inference request."""
        if not self.codex:
            raise MoonError("codex executable is missing")
        timeout = float(self.config.get("quota_rpc_timeout_seconds", 20))
        env = dict(os.environ)
        env.pop("VNEMOON_CODEX_MARKER", None)
        process = subprocess.Popen(
            [self.codex, "app-server", "--listen", "stdio://"],
            cwd=REPO_ROOT,
            env=env,
            stdin=subprocess.PIPE,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            text=True,
            start_new_session=True,
        )
        try:
            if process.stdin is None:
                raise MoonError("Codex app-server stdin is unavailable")
            initialize = {
                "method": "initialize",
                "id": 1,
                "params": {
                    "clientInfo": {
                        "name": "vnemoon",
                        "title": "vneMoon autonomous research controller",
                        "version": "1.0.0",
                    }
                },
            }
            process.stdin.write(json.dumps(initialize) + "\n")
            process.stdin.flush()
            self._read_rpc_response(process, 1, timeout)
            process.stdin.write(json.dumps({"method": "initialized", "params": {}}) + "\n")
            process.stdin.write(json.dumps({"method": "account/rateLimits/read", "id": 2}) + "\n")
            process.stdin.flush()
            return self._read_rpc_response(process, 2, timeout)
        finally:
            if process.poll() is None:
                process.terminate()
                try:
                    process.wait(timeout=5)
                except subprocess.TimeoutExpired:
                    process.kill()
                    process.wait(timeout=5)

    def wait_for_codex_allowance(self) -> dict[str, Any]:
        """Block locally until every reported subscription quota is safe."""
        reserve = float(self.config.get("codex_quota_reserve_percent", 10.0))
        retry_seconds = float(self.config.get("quota_unknown_retry_seconds", 300.0))
        reset_grace = float(self.config.get("quota_reset_grace_seconds", 5.0))
        if not 0.0 <= reserve < 100.0:
            raise MoonError("codex_quota_reserve_percent must be in [0, 100)")
        while True:
            checked_at = time.time()
            try:
                response = self.read_subscription_rate_limits()
                decision = assess_subscription_quota(
                    response, reserve_percent=reserve, now_epoch=checked_at
                )
            except (MoonError, OSError, subprocess.SubprocessError, ValueError) as exc:
                decision = {
                    "allowed": False,
                    "reason": f"quota read unavailable: {exc}",
                    "windows": [],
                    "pause_until": None,
                }
            self.event(
                "codex_quota_checked",
                reserve_percent=reserve,
                allowed=bool(decision["allowed"]),
                reason=decision.get("reason", ""),
                windows=decision.get("windows", []),
            )
            if decision["allowed"]:
                return decision
            pause_until = decision.get("pause_until")
            if isinstance(pause_until, (int, float)) and pause_until > checked_at:
                pause_seconds = max(1.0, float(pause_until) - checked_at + reset_grace)
            else:
                pause_seconds = max(1.0, retry_seconds)
            pause_started = time.time()
            self.event(
                "codex_quota_paused",
                reason=decision.get("reason", "unknown quota state"),
                planned_pause_seconds=pause_seconds,
                planned_resume_at=datetime.fromtimestamp(
                    pause_started + pause_seconds, timezone.utc
                ).isoformat(),
            )
            time.sleep(pause_seconds)
            self.event(
                "codex_quota_pause_finished",
                paused_seconds=max(0.0, time.time() - pause_started),
            )

    def git(self, *args: str, cwd: Path | None = None, check: bool = True) -> str:
        result = subprocess.run(
            ["git", *args],
            cwd=cwd or REPO_ROOT,
            capture_output=True,
            text=True,
            check=False,
        )
        if check and result.returncode != 0:
            raise MoonError(
                f"git {' '.join(args)} failed ({result.returncode}): "
                f"{(result.stderr or result.stdout).strip()}"
            )
        return result.stdout.strip()

    def preflight(self) -> dict[str, Any]:
        problems: list[str] = []
        for label, value in (("conda", self.conda), ("codex", self.codex), ("bwrap", self.bwrap)):
            if not value:
                problems.append(f"{label} is not on PATH")
        if not (REPO_ROOT / ".git").exists():
            problems.append(f"not a Git worktree: {REPO_ROOT}")
        if not SCHEMA_PATH.is_file() or not PROGRAM_PATH.is_file():
            problems.append("candidate schema or research program is missing")
        try:
            model, reasoning_effort = self.codex_settings()
        except MoonError as exc:
            problems.append(str(exc))
            model, reasoning_effort = "INVALID", "INVALID"

        checkpoint_report: dict[str, str] = {}
        for topology, candidates in self.config["checkpoint_candidates"].items():
            resolved = self.resolve_checkpoint(topology, required=False)
            checkpoint_report[topology] = str(resolved) if resolved else "MISSING"
            if resolved is None:
                problems.append(f"no checkpoint found for {topology}: {candidates}")
            else:
                try:
                    self.checkpoint_model_overrides(resolved)
                except MoonError as exc:
                    problems.append(str(exc))

        trace_report: list[str] = []
        all_cases = [
            *self.config["dev_suites"]["smoke"],
            *self.config["dev_suites"]["screen"],
            *self.config["heldout_suite"],
        ]
        for case in all_cases:
            source = self.source_trace_dir(case)
            key = self.case_key(case)
            trace_report.append(f"{key}: {source}")
            required = [source / "p_net.gml", source / "events.yaml", source / "v_sim_setting.yaml"]
            if not all(path.is_file() for path in required):
                problems.append(f"trace is incomplete: {source}")
            available = len(list((source / "v_nets").glob("v_net-*.gml")))
            if available < int(case["requests"]):
                problems.append(f"trace {source} has {available} requests, needs {case['requests']}")

        gpu = subprocess.run(
            ["nvidia-smi", "--query-gpu=name,memory.total", "--format=csv,noheader"],
            capture_output=True,
            text=True,
            check=False,
        )
        if gpu.returncode != 0:
            problems.append("nvidia-smi did not detect the requested GPU")

        report = {
            "ok": not problems,
            "repo": str(REPO_ROOT),
            "branch": self.branch,
            "worktree": str(self.worktree),
            "gpu": gpu.stdout.strip(),
            "codex_model": model,
            "codex_reasoning_effort": reasoning_effort,
            "checkpoints": checkpoint_report,
            "traces": trace_report,
            "dirty_source_files": self.git("status", "--porcelain=v1").splitlines(),
            "problems": problems,
        }
        if problems:
            raise MoonError("preflight failed:\n- " + "\n- ".join(problems))
        return report

    def codex_settings(self) -> tuple[str, str]:
        model = str(self.config.get("codex_model", "gpt-6.1-sol")).strip()
        reasoning_effort = str(self.config.get("codex_reasoning_effort", "medium")).strip().lower()
        if not model:
            raise MoonError("codex_model must be non-empty so every research invocation is explicit")
        if not re.fullmatch(r"[A-Za-z0-9_.-]+", model):
            raise MoonError(f"invalid codex_model: {model!r}")
        if reasoning_effort not in {"low", "medium", "high", "xhigh", "max"}:
            raise MoonError(
                "codex_reasoning_effort must be one of: low, medium, high, xhigh, max"
            )
        return model, reasoning_effort

    def codex_command(self, answer_path: Path) -> list[str]:
        """Build the sole command shape used by every autonomous research turn."""
        if not self.codex:
            raise MoonError("codex executable is missing")
        model, reasoning_effort = self.codex_settings()
        command = [
            self.codex,
            "exec",
            "--model",
            model,
            "-c",
            f"model_reasoning_effort={reasoning_effort}",
            "--ephemeral",
            "--sandbox",
            "workspace-write",
            "--cd",
            str(self.worktree),
            "--output-schema",
            str(SCHEMA_PATH),
            "--output-last-message",
            str(answer_path),
            "--color",
            "never",
            "-",
        ]
        self.verify_codex_command(command)
        return command

    def verify_codex_command(self, command: Sequence[str]) -> None:
        """Fail closed if an iteration would inherit model settings globally."""
        model, reasoning_effort = self.codex_settings()
        try:
            model_index = command.index("--model")
            config_index = command.index("-c")
        except ValueError as exc:
            raise MoonError("research Codex command lacks explicit --model or -c") from exc
        if model_index + 1 >= len(command) or command[model_index + 1] != model:
            raise MoonError("research Codex command has the wrong explicit model")
        expected_effort = f"model_reasoning_effort={reasoning_effort}"
        if config_index + 1 >= len(command) or command[config_index + 1] != expected_effort:
            raise MoonError("research Codex command has the wrong explicit reasoning effort")

    def source_trace_dir(self, case: Mapping[str, Any]) -> Path:
        return (
            REPO_ROOT
            / "datasets"
            / "generated"
            / "journal"
            / "nominal"
            / str(case["topology"])
            / f"seed_{int(case['seed'])}"
            / str(case["split"])
        ).resolve()

    @staticmethod
    def case_key(case: Mapping[str, Any]) -> str:
        return (
            f"{case['topology']}_seed{int(case['seed'])}_{case['split']}_"
            f"n{int(case['requests'])}"
        )

    def resolve_checkpoint(self, topology: str, required: bool = True) -> Path | None:
        for text in self.config["checkpoint_candidates"].get(topology, []):
            path = Path(text)
            path = path if path.is_absolute() else (REPO_ROOT / path)
            if path.is_file() and path.stat().st_size > 0:
                return path.resolve()
        if required:
            raise MoonError(f"no usable checkpoint configured for topology {topology}")
        return None

    @staticmethod
    def checkpoint_model_overrides(checkpoint: Path) -> list[str]:
        """Use the architecture recorded alongside a checkpoint, not today's defaults."""
        config_path = checkpoint.parent.parent / "config.yaml"
        if not config_path.is_file():
            raise MoonError(f"checkpoint model config is missing: {config_path}")
        saved = yaml.safe_load(config_path.read_text(encoding="utf-8"))
        if not isinstance(saved, dict):
            raise MoonError(f"checkpoint model config is invalid: {config_path}")
        training = saved.get("training")
        nn = saved.get("nn")
        if not isinstance(training, dict) or not isinstance(nn, dict):
            raise MoonError(f"checkpoint architecture is missing: {config_path}")
        backbone = training.get("alpha_zero_backbone")
        if backbone not in {"gcn", "mlp", "transformer"}:
            raise MoonError(f"checkpoint backbone is invalid: {config_path}")
        overrides = [f"training.alpha_zero_backbone={backbone}"]
        for key in ("embedding_dim", "n_heads", "transformer_layers", "num_gnn_layers"):
            value = nn.get(key)
            if type(value) is not int or value <= 0:
                raise MoonError(f"checkpoint nn.{key} is missing or invalid: {config_path}")
            overrides.append(f"nn.{key}={value}")
        return overrides

    def ensure_worktree(self) -> str:
        if (self.worktree / ".git").exists():
            current_branch = self.git("branch", "--show-current", cwd=self.worktree)
            if current_branch != self.branch:
                raise MoonError(
                    f"research worktree uses branch {current_branch!r}, expected {self.branch!r}"
                )
            self.install_cpp_artifact()
            return self.git("rev-parse", "HEAD", cwd=self.worktree)

        if self.worktree.exists() and any(self.worktree.iterdir()):
            raise MoonError(f"refusing to reuse non-empty non-worktree path: {self.worktree}")
        self.worktree.parent.mkdir(parents=True, exist_ok=True)
        branch_exists = subprocess.run(
            ["git", "show-ref", "--verify", "--quiet", f"refs/heads/{self.branch}"],
            cwd=REPO_ROOT,
            check=False,
        ).returncode == 0
        if branch_exists:
            self.git("worktree", "add", str(self.worktree), self.branch)
        else:
            self.git("worktree", "add", "-b", self.branch, str(self.worktree), "HEAD")

        # Copy the user's current tracked changes without touching the dirty source checkout.
        diff = subprocess.run(
            ["git", "diff", "--binary", "HEAD", "--", ".", ":(exclude)vneMoon"],
            cwd=REPO_ROOT,
            capture_output=True,
            check=False,
        )
        if diff.returncode != 0:
            raise MoonError(diff.stderr.decode("utf-8", errors="replace"))
        if diff.stdout:
            applied = subprocess.run(
                ["git", "apply", "--whitespace=nowarn", "-"],
                cwd=self.worktree,
                input=diff.stdout,
                capture_output=True,
                check=False,
            )
            if applied.returncode != 0:
                raise MoonError(
                    "could not copy the current tracked diff into the research worktree: "
                    + applied.stderr.decode("utf-8", errors="replace")
                )

        untracked_raw = subprocess.run(
            ["git", "ls-files", "--others", "--exclude-standard", "-z"],
            cwd=REPO_ROOT,
            capture_output=True,
            check=True,
        ).stdout
        for raw_name in untracked_raw.split(b"\0"):
            if not raw_name:
                continue
            name = raw_name.decode("utf-8", errors="strict")
            if name == "vneMoon" or name.startswith("vneMoon/"):
                continue
            source = (REPO_ROOT / name).resolve()
            target = (self.worktree / name).resolve()
            if not source.is_file() or self.worktree not in target.parents:
                continue
            target.parent.mkdir(parents=True, exist_ok=True)
            shutil.copy2(source, target)

        if self.git("status", "--porcelain=v1", cwd=self.worktree):
            self.git("add", "-A", cwd=self.worktree)
            self.git(
                "-c",
                "user.name=vneMoon",
                "-c",
                "user.email=vnemoon@localhost",
                "commit",
                "-m",
                "vneMoon: snapshot current research baseline",
                cwd=self.worktree,
            )
        baseline = self.git("rev-parse", "HEAD", cwd=self.worktree)
        self.install_cpp_artifact()
        self.event("worktree_ready", worktree=str(self.worktree), baseline_commit=baseline)
        return baseline

    def install_cpp_artifact(self) -> None:
        source_so = (
            REPO_ROOT
            / "virne/solver/learning/reinforcement_learning/alpha_vne/cpp_core/build/alpha_zero_cpp_core.so"
        )
        if not source_so.is_file():
            return
        alpha_dir = (
            self.worktree / "virne/solver/learning/reinforcement_learning/alpha_vne"
        )
        cpp_dir = alpha_dir / "cpp_core"
        build_dir = cpp_dir / "build"
        build_dir.mkdir(parents=True, exist_ok=True)
        copied_so = build_dir / "alpha_zero_cpp_core.so"
        if not copied_so.exists() or copied_so.stat().st_size != source_so.stat().st_size:
            shutil.copy2(source_so, copied_so)
        cpp_link = cpp_dir / "alpha_zero_cpp_core.so"
        alpha_link = alpha_dir / "alpha_zero_cpp_core.so"
        for link, target in (
            (cpp_link, Path("build/alpha_zero_cpp_core.so")),
            (alpha_link, Path("cpp_core/alpha_zero_cpp_core.so")),
        ):
            if link.is_symlink() or link.exists():
                link.unlink()
            link.symlink_to(target)

    def initialize_state(self, hours: float) -> dict[str, Any]:
        existing = load_json(STATE_PATH)
        if isinstance(existing, dict):
            return existing
        baseline = self.ensure_worktree()
        start = utc_now()
        model, reasoning_effort = self.codex_settings()
        state = {
            "schema_version": 1,
            "campaign_id": start.strftime("%Y%m%dT%H%M%SZ"),
            "status": "running",
            "started_at": start.isoformat(),
            "deadline": (start + timedelta(hours=hours)).isoformat(),
            "codex_model": model,
            "codex_reasoning_effort": reasoning_effort,
            "baseline_commit": baseline,
            "best_commit": baseline,
            "best_candidate_id": "baseline",
            "best_trained_checkpoint": None,
            "best_screen_metrics": None,
            "baseline_metrics": {},
            "next_experiment_number": 1,
            "active_candidate_id": None,
            "heldout_started": False,
            "heldout_consumed": False,
            "stop_reason": "",
        }
        atomic_json(STATE_PATH, state)
        atomic_json(QUEUE_PATH, [])
        self.event("campaign_started", campaign_id=state["campaign_id"], deadline=state["deadline"])
        return state

    def save_state(self, state: Mapping[str, Any]) -> None:
        atomic_json(STATE_PATH, dict(state))

    def remaining_seconds(self, state: Mapping[str, Any]) -> float:
        return max(0.0, (parse_iso(str(state["deadline"])) - utc_now()).total_seconds())

    def materialize_trace(self, case: Mapping[str, Any], kind: str) -> tuple[Path, str]:
        source = self.source_trace_dir(case)
        count = int(case["requests"])
        selected_vnets = [source / "v_nets" / f"v_net-{index:05d}.gml" for index in range(count)]
        source_files = [
            source / "p_net.gml",
            source / "events.yaml",
            source / "v_sim_setting.yaml",
            *selected_vnets,
        ]
        source_hash = sha256_paths(source_files, source)
        target = RUNTIME_DIR / "traces" / kind / self.case_key(case)
        manifest_path = target / "vnemoon_manifest.json"
        manifest = load_json(manifest_path)
        if (
            isinstance(manifest, dict)
            and manifest.get("source_sha256") == source_hash
            and int(manifest.get("requests", -1)) == count
        ):
            return target, source_hash

        if target.exists():
            for path in target.rglob("*"):
                try:
                    path.chmod(0o755 if path.is_dir() else 0o644)
                except OSError:
                    pass
            shutil.rmtree(target)
        (target / "v_nets").mkdir(parents=True, exist_ok=True)
        shutil.copy2(source / "p_net.gml", target / "p_net.gml")
        for optional in ("config_snapshot.yaml", "generation_metadata.json"):
            if (source / optional).is_file():
                shutil.copy2(source / optional, target / optional)
        for vnet in selected_vnets:
            shutil.copy2(vnet, target / "v_nets" / vnet.name)

        v_setting = yaml.safe_load((source / "v_sim_setting.yaml").read_text(encoding="utf-8"))
        v_setting["num_v_nets"] = count
        output = v_setting.setdefault("output", {})
        output["save_dir"] = str(target)
        output["v_nets_save_dir"] = "v_nets"
        (target / "v_sim_setting.yaml").write_text(
            yaml.safe_dump(v_setting, sort_keys=False), encoding="utf-8"
        )

        events = yaml.safe_load((source / "events.yaml").read_text(encoding="utf-8")) or []
        filtered = [event for event in events if int(event["v_net_id"]) < count]
        filtered.sort(key=lambda event: (float(event["time"]), int(event.get("id", 0))))
        for event_id, event in enumerate(filtered):
            event["id"] = event_id
        (target / "events.yaml").write_text(
            yaml.safe_dump(filtered, sort_keys=False), encoding="utf-8"
        )
        atomic_json(
            manifest_path,
            {
                "created_at": iso_now(),
                "kind": kind,
                "source": str(source),
                "source_sha256": source_hash,
                "requests": count,
                "event_count": len(filtered),
                "contains_heldout": str(case["split"]) == "test",
            },
        )
        for path in target.rglob("*"):
            path.chmod(0o555 if path.is_dir() else 0o444)
        target.chmod(0o555)
        return target, source_hash

    def verify_source_trace(self, case: Mapping[str, Any], expected_hash: str) -> None:
        source = self.source_trace_dir(case)
        count = int(case["requests"])
        files = [
            source / "p_net.gml",
            source / "events.yaml",
            source / "v_sim_setting.yaml",
            *[source / "v_nets" / f"v_net-{index:05d}.gml" for index in range(count)],
        ]
        actual = sha256_paths(files, source)
        if actual != expected_hash:
            raise MoonError(f"protected source trace changed during experiment: {source}")

    def reset_to_commit(self, commit: str) -> None:
        self.git("reset", "--hard", commit, cwd=self.worktree)
        # This is a dedicated disposable worktree. Remove only non-ignored files
        # created by a failed candidate; compiled artifacts remain ignored/reusable.
        self.git("clean", "-fd", cwd=self.worktree)
        self.install_cpp_artifact()

    def marker_pids(self, marker: str) -> list[int]:
        encoded = f"VNEMOON_CODEX_MARKER={marker}".encode("utf-8")
        matches: list[int] = []
        for environ_path in Path("/proc").glob("[0-9]*/environ"):
            try:
                if encoded in environ_path.read_bytes():
                    matches.append(int(environ_path.parent.name))
            except (OSError, PermissionError, ValueError):
                continue
        return matches

    def cleanup_codex_marker(self, marker: str) -> None:
        """Terminate detached descendants created by this one Codex invocation."""
        grace = float(self.config.get("codex_descendant_shutdown_seconds", 5.0))
        pids = self.marker_pids(marker)
        if not pids:
            return
        self.event("codex_descendant_cleanup_started", marker=marker, pids=pids)
        for pid in pids:
            try:
                os.kill(pid, signal.SIGTERM)
            except (ProcessLookupError, PermissionError):
                pass
        deadline = time.monotonic() + max(0.0, grace)
        remaining = self.marker_pids(marker)
        while remaining and time.monotonic() < deadline:
            time.sleep(0.05)
            remaining = self.marker_pids(marker)
        for pid in remaining:
            try:
                os.kill(pid, signal.SIGKILL)
            except (ProcessLookupError, PermissionError):
                pass
        final = self.marker_pids(marker)
        self.event(
            "codex_descendant_cleanup_finished",
            marker=marker,
            terminated_pids=pids,
            remaining_pids=final,
        )

    def assert_codex_gone(self, marker: str) -> None:
        pids = self.marker_pids(marker)
        if pids:
            raise MoonError(f"Codex invocation marker still exists in processes {pids}; refusing experiment")

    def concise_history(self) -> list[dict[str, Any]]:
        if not EXPERIMENTS_PATH.exists():
            return []
        rows: list[dict[str, Any]] = []
        for line in EXPERIMENTS_PATH.read_text(encoding="utf-8").splitlines():
            if not line.strip():
                continue
            try:
                record = json.loads(line)
            except json.JSONDecodeError:
                continue
            rows.append(
                {
                    "id": record.get("candidate_id"),
                    "title": record.get("title"),
                    "mechanism": str(record.get("mechanism", ""))[:400],
                    "novelty_distinction": str(record.get("novelty_distinction", ""))[:300],
                    "status": record.get("status"),
                    "smoke": record.get("smoke_metrics"),
                    "screen": record.get("screen_metrics"),
                    "failure": str(record.get("failure", ""))[-500:],
                }
            )
        limit = int(self.config["max_history_items_for_codex"])
        return rows[-limit:]

    def build_prompt(self, state: Mapping[str, Any], candidate_id: str) -> str:
        allowed = "\n".join(f"- {root}" for root in self.config["allowed_edit_roots"])
        history = json.dumps(self.concise_history(), separators=(",", ":"))
        best_metrics = json.dumps(state.get("best_screen_metrics"), separators=(",", ":"))
        return (
            PROGRAM_PATH.read_text(encoding="utf-8")
            + "\n\n"
            + f"Candidate id: {candidate_id}\n"
            + f"Current strongest commit: {state['best_commit']}\n"
            + f"Current strongest screen metrics: {best_metrics}\n"
            + "Editable paths (all other changes will be rejected):\n"
            + allowed
            + "\n\nCompact prior experiment history:\n"
            + history
            + "\n\nImplement one candidate now. Inspect the existing AlphaVNE, baselines, and tests as needed. "
            + "Keep the patch small enough to diagnose from one overnight experiment."
        )

    def invoke_codex(self, state: Mapping[str, Any], candidate_id: str) -> tuple[dict[str, Any], str]:
        invocation_dir = RUNTIME_DIR / "codex" / candidate_id
        invocation_dir.mkdir(parents=True, exist_ok=True)
        answer_path = invocation_dir / "answer.json"
        prompt = self.build_prompt(state, candidate_id)
        (invocation_dir / "prompt.txt").write_text(prompt, encoding="utf-8")
        command = self.codex_command(answer_path)
        model, effort = self.codex_settings()
        atomic_json(
            invocation_dir / "command.json",
            {
                "candidate_id": candidate_id,
                "argv": command,
                "model": model,
                "model_reasoning_effort": effort,
            },
        )
        max_retries = int(self.config.get("codex_rate_limit_max_retries", 3))
        backoff_base = float(self.config.get("codex_rate_limit_backoff_seconds", 30.0))
        marker = ""
        for attempt in range(max_retries + 1):
            self.wait_for_codex_allowance()
            marker = f"vnemoon-{candidate_id}-{attempt}-{uuid.uuid4().hex}"
            env = dict(os.environ)
            env["VNEMOON_CODEX_MARKER"] = marker
            answer_path.unlink(missing_ok=True)
            stdout_path = invocation_dir / f"stdout_attempt_{attempt + 1}.jsonl"
            stderr_path = invocation_dir / f"stderr_attempt_{attempt + 1}.log"
            self.event(
                "codex_started",
                candidate_id=candidate_id,
                attempt=attempt + 1,
                marker=marker,
                model=model,
                model_reasoning_effort=effort,
                explicit_cli_settings=True,
            )
            try:
                result = self.run_process(
                    command,
                    cwd=self.worktree,
                    timeout=float(self.config["codex_timeout_seconds"]),
                    stdout_path=stdout_path,
                    stderr_path=stderr_path,
                    env=env,
                    stdin=prompt,
                )
            except subprocess.TimeoutExpired as exc:
                self.cleanup_codex_marker(marker)
                self.event("codex_timed_out", candidate_id=candidate_id, marker=marker)
                raise MoonError(f"Codex timed out after {exc.timeout}s") from exc
            self.event(
                "codex_exited",
                candidate_id=candidate_id,
                attempt=attempt + 1,
                marker=marker,
                returncode=result.returncode,
            )
            self.cleanup_codex_marker(marker)
            self.assert_codex_gone(marker)
            if result.returncode == 0:
                break
            stderr_tail = tail_text(stderr_path)
            if not is_codex_usage_limit_error(stderr_tail):
                raise MoonError(f"Codex exited {result.returncode}: {stderr_tail}")
            self.event(
                "codex_usage_limit_error",
                candidate_id=candidate_id,
                attempt=attempt + 1,
                max_retries=max_retries,
            )
            if attempt >= max_retries:
                raise CodexQuotaRetriesExhausted(
                    f"Codex usage limit persisted after {max_retries + 1} attempts"
                )
            backoff = min(900.0, max(1.0, backoff_base * (2**attempt)))
            self.event("codex_rate_limit_backoff", candidate_id=candidate_id, seconds=backoff)
            time.sleep(backoff)
        if not answer_path.is_file():
            raise MoonError("Codex produced no structured answer")
        answer = json.loads(answer_path.read_text(encoding="utf-8"))
        return answer, marker

    def changed_files(self, base_commit: str) -> list[str]:
        tracked = self.git("diff", "--name-only", base_commit, cwd=self.worktree).splitlines()
        untracked_raw = subprocess.run(
            ["git", "ls-files", "--others", "--exclude-standard", "-z"],
            cwd=self.worktree,
            capture_output=True,
            check=True,
        ).stdout
        untracked = [item.decode("utf-8") for item in untracked_raw.split(b"\0") if item]
        return sorted(set(tracked + untracked))

    def validate_candidate_changes(self, base_commit: str, plan: Mapping[str, Any]) -> list[str]:
        files = self.changed_files(base_commit)
        if plan.get("action") == "stop":
            if files:
                raise MoonError("Codex returned action=stop but modified files")
            return []
        if not files:
            raise MoonError("Codex proposed an experiment but made no code changes")
        allowed = tuple(str(value) for value in self.config["allowed_edit_roots"])
        forbidden: list[str] = []
        for name in files:
            if name == "settings/learning.yaml" or any(
                root.endswith("/") and name.startswith(root) for root in allowed
            ):
                path = self.worktree / name
                if path.is_symlink():
                    forbidden.append(name + " (symlink)")
                continue
            forbidden.append(name)
        if forbidden:
            raise MoonError("candidate changed protected paths: " + ", ".join(forbidden))

        declared = sorted(set(str(name) for name in plan.get("changed_files", [])))
        if declared and declared != files:
            # Keep going, but preserve the discrepancy in the plan for audit.
            plan["declared_changed_files"] = declared  # type: ignore[index]
        plan["changed_files"] = files  # type: ignore[index]
        return files

    def commit_candidate(self, candidate_id: str, title: str) -> str:
        self.git("add", "-A", cwd=self.worktree)
        subject = re.sub(r"\s+", " ", title).strip()[:72]
        self.git(
            "-c",
            "user.name=vneMoon",
            "-c",
            "user.email=vnemoon@localhost",
            "commit",
            "-m",
            f"vneMoon {candidate_id}: {subject}",
            cwd=self.worktree,
        )
        return self.git("rev-parse", "HEAD", cwd=self.worktree)

    def sandbox_command(self, writable_dir: Path, inner: Sequence[str]) -> list[str]:
        if not self.bwrap:
            raise MoonError("bubblewrap is required to enforce no-network experiment execution")
        writable_dir.mkdir(parents=True, exist_ok=True)
        return [
            self.bwrap,
            "--die-with-parent",
            "--unshare-net",
            "--dev-bind",
            "/",
            "/",
            "--proc",
            "/proc",
            "--ro-bind",
            str(self.worktree),
            str(self.worktree),
            "--ro-bind",
            str(REPO_ROOT / "datasets"),
            str(REPO_ROOT / "datasets"),
            "--ro-bind",
            str(REPO_ROOT / "results"),
            str(REPO_ROOT / "results"),
            "--ro-bind",
            str(CONTROL_DIR),
            str(CONTROL_DIR),
            "--bind",
            str(writable_dir),
            str(writable_dir),
            "--chdir",
            str(self.worktree),
            "--",
            *inner,
        ]

    def maybe_build_cpp(
        self, candidate_id: str, changed_files: Sequence[str], state: Mapping[str, Any], marker: str
    ) -> None:
        if not any("/alpha_vne/cpp_core/" in name for name in changed_files):
            return
        self.assert_codex_gone(marker)
        remaining = self.remaining_seconds(state)
        if remaining <= 60:
            raise MoonError("insufficient campaign time for the required C++ rebuild")
        build_dir = RUNTIME_DIR / "runs" / candidate_id / "build"
        build_dir.mkdir(parents=True, exist_ok=True)
        self.event("experiment_started", candidate_id=candidate_id, stage="cpp_build")
        command = ["bash", "skills/alpha-vne-cpp-build/scripts/rebuild_alpha_vne_cpp.sh"]
        try:
            result = self.run_process(
                command,
                cwd=self.worktree,
                timeout=min(900.0, remaining - 30.0),
                stdout_path=build_dir / "stdout.log",
                stderr_path=build_dir / "stderr.log",
                env=sanitized_experiment_env(),
            )
        except subprocess.TimeoutExpired as exc:
            raise MoonError("C++ rebuild timed out") from exc
        self.event("experiment_finished", candidate_id=candidate_id, stage="cpp_build", returncode=result.returncode)
        if result.returncode != 0:
            raise MoonError("C++ rebuild failed: " + tail_text(build_dir / "stderr.log"))

    def run_static_checks(
        self, candidate_id: str, state: Mapping[str, Any], marker: str
    ) -> None:
        self.assert_codex_gone(marker)
        check_dir = RUNTIME_DIR / "runs" / candidate_id / "checks"
        remaining = self.remaining_seconds(state)
        if remaining <= 30:
            raise MoonError("insufficient campaign time for static checks")
        inner = [
            self.conda,
            "run",
            "-n",
            "virne",
            "python",
            "-m",
            "pytest",
            "tests/solver/learning/reinforcement_learning/alpha_vne",
            "-q",
            "--disable-warnings",
            "--maxfail=1",
        ]
        command = self.sandbox_command(check_dir, inner)
        self.event("experiment_started", candidate_id=candidate_id, stage="tests")
        try:
            result = self.run_process(
                command,
                cwd=self.worktree,
                timeout=min(300.0, remaining - 10.0),
                stdout_path=check_dir / "stdout.log",
                stderr_path=check_dir / "stderr.log",
                env=sanitized_experiment_env(),
            )
        except subprocess.TimeoutExpired as exc:
            raise MoonError("candidate tests timed out") from exc
        self.event("experiment_finished", candidate_id=candidate_id, stage="tests", returncode=result.returncode)
        if result.returncode != 0:
            raise MoonError("candidate tests failed: " + tail_text(check_dir / "stdout.log"))

    def run_training(
        self,
        candidate_id: str,
        plan: Mapping[str, Any],
        state: Mapping[str, Any],
        marker: str,
    ) -> Path | None:
        if plan.get("training_mode") != "short":
            return None
        case = self.config["dev_suites"]["screen"][0]
        trace, source_hash = self.materialize_trace(case, "dev")
        run_dir = RUNTIME_DIR / "runs" / candidate_id / "training"
        run_id = f"vnemoon_{candidate_id}_train"
        save_root = run_dir / "results"
        checkpoint = self.resolve_checkpoint(str(case["topology"])) if plan.get("uses_checkpoint") else None
        overrides = self.virne_overrides(
            plan=plan,
            case=case,
            trace=trace,
            run_id=run_id,
            save_root=save_root,
            checkpoint=checkpoint,
            training=True,
            watchdog_seconds=min(540.0, self.remaining_seconds(state) - 20.0),
        )
        inner = [self.conda, "run", "-n", "virne", "python", "-u", "main.py", *overrides]
        command = self.sandbox_command(run_dir, inner)
        self.assert_codex_gone(marker)
        self.event("experiment_started", candidate_id=candidate_id, stage="short_training")
        try:
            result = self.run_process(
                command,
                cwd=self.worktree,
                timeout=min(600.0, self.remaining_seconds(state) - 10.0),
                stdout_path=run_dir / "stdout.log",
                stderr_path=run_dir / "stderr.log",
                env=sanitized_experiment_env(),
            )
        except subprocess.TimeoutExpired as exc:
            raise MoonError("short training timed out") from exc
        self.event("experiment_finished", candidate_id=candidate_id, stage="short_training", returncode=result.returncode)
        self.verify_source_trace(case, source_hash)
        if result.returncode != 0:
            raise MoonError("short training failed: " + tail_text(run_dir / "stderr.log"))
        model_dir = save_root / str(plan["solver_name"]) / run_id / "models"
        candidates = [
            model_dir / "policy_latest.pt",
            model_dir / "model.pkl",
            model_dir / "model.pt",
        ]
        for path in candidates:
            if path.is_file() and path.stat().st_size > 0:
                return path.resolve()
        raise MoonError(f"short training completed but emitted no supported checkpoint in {model_dir}")

    def virne_overrides(
        self,
        *,
        plan: Mapping[str, Any],
        case: Mapping[str, Any],
        trace: Path,
        run_id: str,
        save_root: Path,
        checkpoint: Path | None,
        training: bool,
        watchdog_seconds: float,
    ) -> list[str]:
        overrides = [
            f"solver.solver_name={plan['solver_name']}",
            "solver.k_shortest=10",
            f"experiment.seed={int(case['seed'])}",
            f"training.seed={int(case['seed'])}",
            f"experiment.run_id={run_id}",
            f"experiment.save_root_dir={save_root}",
            f"hydra.run.dir={save_root / str(plan['solver_name']) / run_id / 'hydra'}",
            "use_fixed_dataset=true",
            "experiment.if_load_p_net=true",
            "experiment.if_load_v_nets=true",
            f"simulation.p_net_dataset_dir={trace}",
            f"simulation.v_nets_dataset_dir={trace}",
            "training.use_cuda=true",
            "training.gpu_id=0",
            "training.distributed_training=false",
            "training.num_workers=1",
            f"training.computation_budget={int(self.config['mcts_computation_budget'])}",
            "training.use_batched_gpu=false",
            "training.disable_trajectory_writing=true",
            "training.use_cpp_mcts=true",
            "training.pure_cpp=false",
            "training.resume_training=false",
            "experiment.num_simulations=1",
            f"experiment.request_timeout_sec={float(self.config['request_timeout_seconds'])}",
            f"experiment.run_watchdog_timeout_sec={max(1.0, watchdog_seconds):.3f}",
            "experiment.record_arrival_solve_time=true",
            "experiment.gpu_synchronize_timing=true",
            "logger.backends=[file]",
            "logger.verbose=0",
        ]
        if training:
            overrides.extend(
                [
                    "training.inference_only=false",
                    "training.enable_async_learner=true",
                    "training.num_train_epochs=1",
                    "training.max_training_steps=64",
                    "training.min_buffer_size=8",
                    "training.num_train_steps_per_epoch=8",
                    "training.max_empty_batches=30",
                    "training.disable_trajectory_writing=false",
                    "training.guaranteed_save_step=16",
                ]
            )
        else:
            overrides.extend(
                [
                    "training.inference_only=true",
                    "training.enable_async_learner=false",
                    "training.num_train_epochs=0",
                ]
            )
        if checkpoint is not None:
            overrides.extend(self.checkpoint_model_overrides(checkpoint))
            overrides.extend(
                [
                    f"solver.pretrained_model_path={checkpoint}",
                    f"training.alphazero_model_path={checkpoint}",
                ]
            )
        else:
            overrides.extend(["solver.pretrained_model_path=", "training.alphazero_model_path="])
        return overrides

    def parse_case_metrics(
        self,
        save_root: Path,
        solver_name: str,
        run_id: str,
        expected_requests: int,
        elapsed_seconds: float,
        returncode: int,
    ) -> dict[str, Any]:
        summary = save_root / solver_name / run_id / "summary.csv"
        if not summary.is_file():
            matches = list(save_root.rglob("summary.csv"))
            if len(matches) == 1:
                summary = matches[0]
        if not summary.is_file():
            return {
                "valid": False,
                "failure": "summary.csv missing",
                "returncode": returncode,
                "elapsed_seconds": elapsed_seconds,
            }
        with summary.open("r", newline="", encoding="utf-8") as stream:
            rows = list(csv.DictReader(stream))
        if not rows:
            return {
                "valid": False,
                "failure": "summary.csv has no rows",
                "returncode": returncode,
                "elapsed_seconds": elapsed_seconds,
                "summary_path": str(summary),
            }
        row = rows[-1]
        requests = int(safe_float(row.get("num_arrival_requests"), -1))
        violations_present = row.get("total_violation") not in (None, "")
        violations = safe_float(row.get("total_violation"), float("inf"))
        run_timeout = str(row.get("run_timeout", "false")).lower() in {"1", "true", "yes"}
        acceptance = safe_float(row.get("acceptance_rate"), -1.0)
        success_count = int(safe_float(row.get("success_count"), -1.0))
        valid = (
            returncode == 0
            and requests == expected_requests
            and violations_present
            and violations <= 0.0
            and not run_timeout
            and 0.0 <= acceptance <= 1.0
            and 0 <= success_count <= requests
        )
        return {
            "valid": valid,
            "failure": "" if valid else "incomplete, timed out, nonzero exit, or infeasible",
            "returncode": returncode,
            "requests": requests,
            "expected_requests": expected_requests,
            "acceptance_rate": acceptance,
            "success_count": success_count,
            "long_term_r2c_ratio": safe_float(row.get("long_term_r2c_ratio")),
            "violations": violations,
            "request_timeout_count": int(safe_float(row.get("request_timeout_count"))),
            "request_timeout_rate": safe_float(row.get("request_timeout_rate")),
            "run_timeout": run_timeout,
            "elapsed_seconds": elapsed_seconds,
            "reported_clock_seconds": safe_float(row.get("clock_running_time")),
            "summary_path": str(summary),
        }

    def run_case(
        self,
        *,
        candidate_id: str,
        tier: str,
        plan: Mapping[str, Any],
        case: Mapping[str, Any],
        checkpoint: Path | None,
        state: Mapping[str, Any],
        marker: str,
        case_timeout: float,
    ) -> dict[str, Any]:
        kind = "heldout" if str(case["split"]) == "test" else "dev"
        trace, source_hash = self.materialize_trace(case, kind)
        case_key = self.case_key(case)
        case_dir = RUNTIME_DIR / "runs" / candidate_id / tier / case_key
        save_root = case_dir / "results"
        run_id = f"vnemoon_{candidate_id}_{tier}_{case_key}"
        overrides = self.virne_overrides(
            plan=plan,
            case=case,
            trace=trace,
            run_id=run_id,
            save_root=save_root,
            checkpoint=checkpoint,
            training=False,
            watchdog_seconds=max(1.0, case_timeout - 20.0),
        )
        inner = [self.conda, "run", "-n", "virne", "python", "-u", "main.py", *overrides]
        command = self.sandbox_command(case_dir, inner)
        (case_dir / "command.json").write_text(
            json.dumps(command, indent=2) + "\n", encoding="utf-8"
        )
        self.assert_codex_gone(marker)
        self.event(
            "experiment_started",
            candidate_id=candidate_id,
            tier=tier,
            case=case_key,
            llm_forbidden=True,
            network_disabled=True,
        )
        started = time.monotonic()
        timed_out = False
        try:
            result = self.run_process(
                command,
                cwd=self.worktree,
                timeout=case_timeout,
                stdout_path=case_dir / "stdout.log",
                stderr_path=case_dir / "stderr.log",
                env=sanitized_experiment_env(),
            )
            returncode = result.returncode
        except subprocess.TimeoutExpired:
            returncode = 124
            timed_out = True
        elapsed = time.monotonic() - started
        self.event(
            "experiment_finished",
            candidate_id=candidate_id,
            tier=tier,
            case=case_key,
            returncode=returncode,
            elapsed_seconds=elapsed,
        )
        self.verify_source_trace(case, source_hash)
        metrics = self.parse_case_metrics(
            save_root=save_root,
            solver_name=str(plan["solver_name"]),
            run_id=run_id,
            expected_requests=int(case["requests"]),
            elapsed_seconds=elapsed,
            returncode=returncode,
        )
        metrics.update(
            {
                "case": case_key,
                "topology": case["topology"],
                "seed": int(case["seed"]),
                "split": case["split"],
                "timed_out_by_controller": timed_out,
                "stderr_tail": tail_text(case_dir / "stderr.log", 1200) if returncode else "",
            }
        )
        atomic_json(case_dir / "metrics.json", metrics)
        return metrics

    def run_suite(
        self,
        *,
        candidate_id: str,
        tier: str,
        plan: Mapping[str, Any],
        state: Mapping[str, Any],
        marker: str,
        trained_checkpoint: Path | None = None,
    ) -> dict[str, Any]:
        if tier == "heldout":
            cases = list(self.config["heldout_suite"])
        else:
            cases = list(self.config["dev_suites"][tier])
        configured_timeout = float(self.config["per_experiment_timeout_seconds"][tier])
        results: list[dict[str, Any]] = []
        for index, case in enumerate(cases):
            remaining = self.remaining_seconds(state)
            remaining_cases = len(cases) - index
            if remaining <= 20:
                results.append({"valid": False, "failure": "campaign deadline reached", "case": self.case_key(case)})
                break
            case_timeout = min(configured_timeout / len(cases), max(1.0, (remaining - 10.0) / remaining_cases))
            checkpoint = trained_checkpoint
            if checkpoint is None and bool(plan.get("uses_checkpoint")):
                checkpoint = self.resolve_checkpoint(str(case["topology"]))
            results.append(
                self.run_case(
                    candidate_id=candidate_id,
                    tier=tier,
                    plan=plan,
                    case=case,
                    checkpoint=checkpoint,
                    state=state,
                    marker=marker,
                    case_timeout=case_timeout,
                )
            )
            if not results[-1].get("valid"):
                break

        valid = len(results) == len(cases) and all(bool(row.get("valid")) for row in results)
        total_requests = sum(int(row.get("requests", 0)) for row in results)
        total_success = sum(int(row.get("success_count", 0)) for row in results)
        aggregate = {
            "tier": tier,
            "valid": valid,
            "cases_completed": len(results),
            "cases_expected": len(cases),
            "requests": total_requests,
            "success_count": total_success,
            "acceptance_rate": (total_success / total_requests) if total_requests else 0.0,
            "elapsed_seconds": sum(float(row.get("elapsed_seconds", 0.0)) for row in results),
            "request_timeout_count": sum(int(row.get("request_timeout_count", 0)) for row in results),
            "violations": sum(float(row.get("violations", 0.0)) for row in results),
            "mean_r2c": (
                sum(float(row.get("long_term_r2c_ratio", 0.0)) for row in results) / len(results)
                if results
                else 0.0
            ),
            "cases": results,
        }
        suite_dir = RUNTIME_DIR / "runs" / candidate_id / tier
        atomic_json(suite_dir / "aggregate.json", aggregate)
        return aggregate

    def baseline_plan(self) -> dict[str, Any]:
        return {
            "action": "experiment",
            "title": "Frozen AlphaVNE baseline",
            "hypothesis": "Reference only",
            "mechanism": "Current AlphaVNE implementation",
            "novelty_distinction": "None; baseline",
            "literature_risk": "Not applicable",
            "implementation_summary": "Frozen starting commit",
            "changed_files": [],
            "solver_name": "alpha_zero_sfc",
            "uses_checkpoint": True,
            "training_mode": "none",
            "expected_signal": "Reference acceptance and runtime",
            "failure_modes": [],
        }

    def ensure_baseline_tier(
        self, state: dict[str, Any], tier: str, marker: str = "baseline-no-codex"
    ) -> dict[str, Any]:
        cached = state.setdefault("baseline_metrics", {}).get(tier)
        if isinstance(cached, dict) and cached.get("valid"):
            return cached
        current = self.git("rev-parse", "HEAD", cwd=self.worktree)
        self.reset_to_commit(str(state["baseline_commit"]))
        metrics = self.run_suite(
            candidate_id="baseline",
            tier=tier,
            plan=self.baseline_plan(),
            state=state,
            marker=marker,
        )
        state["baseline_metrics"][tier] = metrics
        if tier == "screen" and state.get("best_screen_metrics") is None:
            state["best_screen_metrics"] = metrics
        self.save_state(state)
        self.reset_to_commit(current if current else str(state["best_commit"]))
        return metrics

    def should_promote(self, candidate: Mapping[str, Any], baseline: Mapping[str, Any]) -> bool:
        if not candidate.get("valid"):
            return False
        if float(candidate.get("violations", 1.0)) > 0.0:
            return False
        acceptance_delta = float(candidate["acceptance_rate"]) - float(baseline["acceptance_rate"])
        runtime_ratio = float(candidate["elapsed_seconds"]) / max(0.001, float(baseline["elapsed_seconds"]))
        return (
            acceptance_delta >= float(self.config["promotion_acceptance_delta"])
            and runtime_ratio <= float(self.config["runtime_ratio_limit"])
        )

    def is_stronger(self, candidate: Mapping[str, Any], best: Mapping[str, Any]) -> bool:
        if not candidate.get("valid") or float(candidate.get("violations", 1.0)) > 0.0:
            return False
        delta = float(candidate["acceptance_rate"]) - float(best["acceptance_rate"])
        runtime_ratio = float(candidate["elapsed_seconds"]) / max(0.001, float(best["elapsed_seconds"]))
        if delta >= float(self.config["adoption_acceptance_delta"]):
            return runtime_ratio <= float(self.config["runtime_ratio_limit"])
        # Pareto improvement: statistically coarse overnight screen, but useful
        # when acceptance is exactly tied and runtime falls materially.
        return delta >= 0.0 and runtime_ratio <= 0.90

    def queue(self) -> list[dict[str, Any]]:
        value = load_json(QUEUE_PATH, [])
        return value if isinstance(value, list) else []

    def update_queue_item(self, item: Mapping[str, Any]) -> None:
        queue = self.queue()
        item_id = item["candidate_id"]
        replaced = False
        for index, existing in enumerate(queue):
            if existing.get("candidate_id") == item_id:
                queue[index] = dict(item)
                replaced = True
                break
        if not replaced:
            queue.append(dict(item))
        atomic_json(QUEUE_PATH, queue)

    def archive_patch(self, candidate_id: str, commit: str) -> None:
        patch_path = RUNTIME_DIR / "runs" / candidate_id / "candidate.patch"
        patch_path.parent.mkdir(parents=True, exist_ok=True)
        result = subprocess.run(
            ["git", "show", "--binary", "--format=fuller", commit],
            cwd=self.worktree,
            capture_output=True,
            check=False,
        )
        patch_path.write_bytes(result.stdout)

    def run_candidate(self, state: dict[str, Any]) -> bool:
        number = int(state["next_experiment_number"])
        candidate_id = f"exp_{number:04d}"
        state["next_experiment_number"] = number + 1
        state["active_candidate_id"] = candidate_id
        self.save_state(state)
        self.reset_to_commit(str(state["best_commit"]))
        base_commit = str(state["best_commit"])
        item: dict[str, Any] = {
            "candidate_id": candidate_id,
            "status": "codex_running",
            "base_commit": base_commit,
            "created_at": iso_now(),
        }
        self.update_queue_item(item)
        try:
            plan, marker = self.invoke_codex(state, candidate_id)
            if plan.get("action") == "stop":
                self.validate_candidate_changes(base_commit, plan)
                item.update({"status": "stopped", "plan": plan, "finished_at": iso_now()})
                self.update_queue_item(item)
                state["stop_reason"] = f"Codex requested stop: {plan.get('hypothesis', '')}"
                self.save_state(state)
                return False
            changed = self.validate_candidate_changes(base_commit, plan)
            commit = self.commit_candidate(candidate_id, str(plan["title"]))
            item.update(
                {
                    "status": "queued",
                    "plan": plan,
                    "candidate_commit": commit,
                    "changed_files": changed,
                }
            )
            self.update_queue_item(item)
            self.archive_patch(candidate_id, commit)
            self.maybe_build_cpp(candidate_id, changed, state, marker)
            self.run_static_checks(candidate_id, state, marker)
            trained_checkpoint = self.run_training(candidate_id, plan, state, marker)
            item["trained_checkpoint"] = str(trained_checkpoint) if trained_checkpoint else None
            self.update_queue_item(item)
            item["status"] = "running_smoke"
            self.update_queue_item(item)
            smoke = self.run_suite(
                candidate_id=candidate_id,
                tier="smoke",
                plan=plan,
                state=state,
                marker=marker,
                trained_checkpoint=trained_checkpoint,
            )
            baseline_smoke = self.ensure_baseline_tier(state, "smoke", marker)
            promoted = self.should_promote(smoke, baseline_smoke)
            screen: dict[str, Any] | None = None
            adopted = False
            if promoted and self.remaining_seconds(state) > 120:
                item["status"] = "running_screen"
                self.update_queue_item(item)
                baseline_screen = self.ensure_baseline_tier(state, "screen", marker)
                self.reset_to_commit(commit)
                screen = self.run_suite(
                    candidate_id=candidate_id,
                    tier="screen",
                    plan=plan,
                    state=state,
                    marker=marker,
                    trained_checkpoint=trained_checkpoint,
                )
                best_metrics = state.get("best_screen_metrics") or baseline_screen
                adopted = self.is_stronger(screen, best_metrics)

            record = {
                "candidate_id": candidate_id,
                "title": plan["title"],
                "hypothesis": plan["hypothesis"],
                "mechanism": plan["mechanism"],
                "novelty_distinction": plan["novelty_distinction"],
                "literature_risk": plan["literature_risk"],
                "implementation_summary": plan["implementation_summary"],
                "changed_files": changed,
                "base_commit": base_commit,
                "candidate_commit": commit,
                "smoke_metrics": smoke,
                "screen_metrics": screen,
                "promoted": promoted,
                "adopted": adopted,
                "status": "adopted" if adopted else "rejected",
                "finished_at": iso_now(),
            }
            append_jsonl(EXPERIMENTS_PATH, record)
            item.update({"status": record["status"], "finished_at": record["finished_at"]})
            self.update_queue_item(item)
            if adopted:
                state["best_commit"] = commit
                state["best_candidate_id"] = candidate_id
                state["best_trained_checkpoint"] = (
                    str(trained_checkpoint) if trained_checkpoint is not None else None
                )
                state["best_screen_metrics"] = screen
                self.reset_to_commit(commit)
            else:
                self.reset_to_commit(str(state["best_commit"]))
            state["active_candidate_id"] = None
            state["consecutive_pre_experiment_failures"] = 0
            self.save_state(state)
            return True
        except (MoonError, subprocess.TimeoutExpired, json.JSONDecodeError) as exc:
            failure = str(exc)
            record = {
                "candidate_id": candidate_id,
                "title": item.get("plan", {}).get("title", "failed candidate"),
                "mechanism": item.get("plan", {}).get("mechanism", ""),
                "novelty_distinction": item.get("plan", {}).get("novelty_distinction", ""),
                "status": "failed",
                "failure": failure,
                "failure_kind": classify_failure(failure),
                "base_commit": base_commit,
                "candidate_commit": item.get("candidate_commit"),
                "finished_at": iso_now(),
            }
            append_jsonl(EXPERIMENTS_PATH, record)
            item.update(
                {
                    "status": "failed",
                    "failure": failure,
                    "failure_kind": classify_failure(failure),
                    "finished_at": iso_now(),
                }
            )
            self.update_queue_item(item)
            self.reset_to_commit(str(state["best_commit"]))
            state["active_candidate_id"] = None
            pre_experiment = item.get("candidate_commit") is None
            if pre_experiment:
                failures = int(state.get("consecutive_pre_experiment_failures", 0)) + 1
                state["consecutive_pre_experiment_failures"] = failures
            else:
                failures = 0
                state["consecutive_pre_experiment_failures"] = 0
            if isinstance(exc, CodexQuotaRetriesExhausted):
                state["status"] = "paused_quota_error"
                state["stop_reason"] = failure
            elif pre_experiment and failures >= int(
                self.config.get("max_consecutive_pre_experiment_failures", 3)
            ):
                state["status"] = "paused_controller_failure"
                state["stop_reason"] = (
                    f"paused after {failures} consecutive failures before experiment execution: "
                    f"{failure}"
                )
            self.save_state(state)
            return state.get("status") not in {
                "paused_quota_error",
                "paused_controller_failure",
            }

    def recover(self, state: dict[str, Any]) -> None:
        active = state.get("active_candidate_id")
        if not active:
            self.reset_to_commit(str(state["best_commit"]))
            return
        queue = self.queue()
        item = next((entry for entry in queue if entry.get("candidate_id") == active), None)
        if item is not None:
            item["status"] = "interrupted"
            item["failure"] = "controller stopped before durable completion; candidate discarded on recovery"
            item["finished_at"] = iso_now()
            self.update_queue_item(item)
            append_jsonl(
                EXPERIMENTS_PATH,
                {
                    "candidate_id": active,
                    "title": item.get("plan", {}).get("title", "interrupted candidate"),
                    "mechanism": item.get("plan", {}).get("mechanism", ""),
                    "status": "interrupted",
                    "failure": item["failure"],
                    "finished_at": iso_now(),
                },
            )
        self.reset_to_commit(str(state["best_commit"]))
        state["active_candidate_id"] = None
        self.save_state(state)
        self.event("campaign_recovered", discarded_candidate=active)

    def finalize(self, state: dict[str, Any]) -> None:
        if state.get("heldout_consumed"):
            state["status"] = "complete"
            self.save_state(state)
            return
        if self.remaining_seconds(state) <= 30:
            state["status"] = "budget_exhausted"
            state["stop_reason"] = state.get("stop_reason") or "deadline reached before held-out phase"
            self.save_state(state)
            return

        # This flag is written before any held-out result. A crash cannot feed a
        # partial held-out result into a later Codex turn because the AI loop is over.
        state["heldout_started"] = True
        self.save_state(state)
        marker = "final-no-codex"
        self.event("heldout_phase_started", best_commit=state["best_commit"])
        self.reset_to_commit(str(state["baseline_commit"]))
        baseline = self.run_suite(
            candidate_id="baseline_final",
            tier="heldout",
            plan=self.baseline_plan(),
            state=state,
            marker=marker,
        )
        best: dict[str, Any]
        if state["best_commit"] == state["baseline_commit"]:
            best = baseline
        elif self.remaining_seconds(state) > 30:
            self.reset_to_commit(str(state["best_commit"]))
            best_record = next(
                (
                    json.loads(line)
                    for line in reversed(EXPERIMENTS_PATH.read_text(encoding="utf-8").splitlines())
                    if line.strip()
                    and json.loads(line).get("candidate_id") == state.get("best_candidate_id")
                ),
                None,
            )
            plan = {
                **self.baseline_plan(),
                "title": best_record.get("title", "best candidate") if best_record else "best candidate",
                "solver_name": "alpha_zero_sfc",
            }
            queue_item = next(
                (item for item in self.queue() if item.get("candidate_id") == state.get("best_candidate_id")),
                None,
            )
            if queue_item and isinstance(queue_item.get("plan"), dict):
                plan.update(queue_item["plan"])
            best = self.run_suite(
                candidate_id=f"{state['best_candidate_id']}_final",
                tier="heldout",
                plan=plan,
                state=state,
                marker=marker,
                trained_checkpoint=(
                    Path(str(state["best_trained_checkpoint"])).resolve()
                    if state.get("best_trained_checkpoint")
                    else None
                ),
            )
        else:
            best = {"valid": False, "failure": "deadline reached before best-candidate heldout run"}
        self.reset_to_commit(str(state["best_commit"]))
        state["heldout_consumed"] = True
        state["heldout_results"] = {"baseline": baseline, "best": best}
        state["status"] = "complete" if best.get("valid") else "complete_with_heldout_failure"
        state["completed_at"] = iso_now()
        self.save_state(state)
        self.event("heldout_phase_finished", status=state["status"])

    def run(self, hours: float) -> dict[str, Any]:
        self.preflight()
        self.ensure_worktree()
        state = self.initialize_state(hours)
        if state.get("status") in {"complete", "complete_with_heldout_failure", "budget_exhausted"}:
            return state
        self.recover(state)
        if state.get("status") in {"paused_quota_error", "paused_controller_failure"}:
            state["status"] = "running"
            state["stop_reason"] = ""
            self.save_state(state)
        reserve = float(self.config["final_reserve_minutes"]) * 60.0

        # Cheap reference first. Longer screen reference is lazy and runs only
        # when a candidate is promising enough to promote.
        baseline_smoke = self.ensure_baseline_tier(state, "smoke")
        if not baseline_smoke.get("valid"):
            state["status"] = "blocked_baseline_failure"
            state["stop_reason"] = (
                "baseline smoke evaluation is invalid; refusing to spend Codex quota"
            )
            self.save_state(state)
            self.event("campaign_blocked", reason=state["stop_reason"], metrics=baseline_smoke)
            return state
        if state.get("status") == "blocked_baseline_failure":
            state["status"] = "running"
            state["stop_reason"] = ""
            self.save_state(state)
        while self.remaining_seconds(state) > reserve:
            keep_going = self.run_candidate(state)
            if not keep_going:
                break
        if state.get("status") in {"paused_quota_error", "paused_controller_failure"}:
            return state
        state["status"] = "finalizing"
        if not state.get("stop_reason"):
            state["stop_reason"] = "reserved time reached for one-shot held-out validation"
        self.save_state(state)
        self.finalize(state)
        return state

    def self_test(self) -> dict[str, Any]:
        if not self.bwrap:
            raise MoonError("bubblewrap is required for the lifecycle self-test")
        stamp = utc_now().strftime("%Y%m%dT%H%M%S")
        output_dir = RUNTIME_DIR / "selftest" / stamp
        output_dir.mkdir(parents=True, exist_ok=True)
        marker = f"mock-{uuid.uuid4().hex}"
        codex_output = output_dir / "mock_codex.json"
        experiment_output = output_dir / "mock_experiment.json"
        events: list[dict[str, Any]] = []

        env = dict(os.environ)
        env["VNEMOON_CODEX_MARKER"] = marker
        events.append({"kind": "codex_started", "at_ns": time.time_ns()})
        codex = subprocess.run(
            [
                sys.executable,
                str(CONTROL_DIR / "mock_worker.py"),
                "codex",
                "--output",
                str(codex_output),
                "--marker",
                marker,
            ],
            cwd=REPO_ROOT,
            env=env,
            capture_output=True,
            text=True,
            timeout=5,
            check=False,
        )
        events.append({"kind": "codex_exited", "at_ns": time.time_ns(), "returncode": codex.returncode})
        self.assert_codex_gone(marker)

        inner = [
            sys.executable,
            str(CONTROL_DIR / "mock_worker.py"),
            "experiment",
            "--output",
            str(experiment_output),
            "--marker",
            marker,
        ]
        command = [
            self.bwrap,
            "--die-with-parent",
            "--unshare-net",
            "--dev-bind",
            "/",
            "/",
            "--proc",
            "/proc",
            "--ro-bind",
            str(CONTROL_DIR),
            str(CONTROL_DIR),
            "--bind",
            str(output_dir),
            str(output_dir),
            "--",
            *inner,
        ]
        events.append({"kind": "experiment_started", "at_ns": time.time_ns()})
        experiment = subprocess.run(
            command,
            cwd=REPO_ROOT,
            env=sanitized_experiment_env(),
            capture_output=True,
            text=True,
            timeout=5,
            check=False,
        )
        events.append(
            {"kind": "experiment_finished", "at_ns": time.time_ns(), "returncode": experiment.returncode}
        )
        result = load_json(experiment_output, {})
        model, reasoning_effort = self.codex_settings()
        research_commands = [
            self.codex_command(output_dir / f"iteration_{index}.json")
            for index in (1, 2)
        ]
        expected_effort = f"model_reasoning_effort={reasoning_effort}"
        checks = {
            "mock_codex_exit_zero": codex.returncode == 0,
            "mock_experiment_exit_zero": experiment.returncode == 0,
            "codex_exited_before_experiment_started": events[1]["at_ns"] < events[2]["at_ns"],
            "codex_process_absent_during_experiment": result.get("codex_alive") is False,
            "experiment_network_disabled": result.get("network_blocked") is True,
            "llm_credentials_and_calls_forbidden": result.get("llm_forbidden") is True,
            "every_research_iteration_has_explicit_model": all(
                "--model" in command
                and command[command.index("--model") + 1] == model
                for command in research_commands
            ),
            "every_research_iteration_has_explicit_reasoning_effort": all(
                "-c" in command
                and command[command.index("-c") + 1] == expected_effort
                for command in research_commands
            ),
        }
        report = {
            "ok": all(checks.values()),
            "checks": checks,
            "events": events,
            "output_dir": str(output_dir),
            "experiment_observation": result,
            "research_command_samples": research_commands,
            "expected_codex_model": model,
            "expected_reasoning_effort": reasoning_effort,
        }
        atomic_json(output_dir / "report.json", report)
        if not report["ok"]:
            raise MoonError("self-test failed: " + json.dumps(report, indent=2))
        return report

    def status(self) -> dict[str, Any]:
        state = load_json(STATE_PATH, {})
        return {
            "state": state,
            "queue": self.queue(),
            "worktree": str(self.worktree),
            "worktree_exists": (self.worktree / ".git").exists(),
            "experiments_file": str(EXPERIMENTS_PATH),
        }


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(description="Autonomous, token-efficient Virne research controller")
    parser.add_argument("--config", type=Path, default=CONFIG_PATH)
    subparsers = parser.add_subparsers(dest="command", required=True)
    subparsers.add_parser("preflight", help="validate tools, GPU, checkpoints, and source traces")
    subparsers.add_parser("init", help="create the isolated branch/worktree without running experiments")
    subparsers.add_parser("self-test", help="run short mock lifecycle and no-network tests")
    subparsers.add_parser("status", help="print persistent campaign state")
    run_parser = subparsers.add_parser("run", help="start or resume the autonomous campaign")
    run_parser.add_argument("--hours", type=float, default=None)
    run_parser.add_argument(
        "--model",
        default=None,
        help="Override config codex_model for this campaign (default: gpt-6.1-sol).",
    )
    run_parser.add_argument(
        "--reasoning-effort",
        choices=("low", "medium", "high", "xhigh", "max"),
        default=None,
        help="Override config codex_reasoning_effort for this campaign (default: medium).",
    )
    return parser


def main(argv: Sequence[str] | None = None) -> int:
    args = build_parser().parse_args(argv)
    controller = MoonController(args.config)
    try:
        if args.command == "preflight":
            result = controller.preflight()
        elif args.command == "init":
            controller.preflight()
            baseline = controller.ensure_worktree()
            result = {
                "ok": True,
                "branch": controller.branch,
                "worktree": str(controller.worktree),
                "baseline_commit": baseline,
                "experiments_started": False,
            }
        elif args.command == "self-test":
            result = controller.self_test()
        elif args.command == "status":
            result = controller.status()
        elif args.command == "run":
            if args.model is not None:
                controller.config["codex_model"] = args.model
            if args.reasoning_effort is not None:
                controller.config["codex_reasoning_effort"] = args.reasoning_effort
            hours = float(args.hours if args.hours is not None else controller.config["wall_clock_hours"])
            if hours <= 0:
                raise MoonError("--hours must be positive")
            with campaign_lock():
                result = controller.run(hours)
        else:  # pragma: no cover
            raise MoonError(f"unknown command: {args.command}")
    except MoonError as exc:
        print(f"vneMoon error: {exc}", file=sys.stderr)
        return 2
    print(json.dumps(result, indent=2, sort_keys=True))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())

