from __future__ import annotations

from dataclasses import dataclass
from typing import Any


def _safe_float(value: Any, default: float | None = None) -> float | None:
    try:
        if value is None:
            return default
        return float(value)
    except Exception:
        return default


def infer_total_revenue_from_static_env(static_env: dict | None) -> float | None:
    if not isinstance(static_env, dict):
        return None
    req = static_env.get("sfc_request")
    if not isinstance(req, dict):
        return None
    total = 0.0
    has_any = False
    for node in req.get("nodes", []) or []:
        if not isinstance(node, dict):
            continue
        val = _safe_float(node.get("cpu_demand"), None)
        if val is None:
            continue
        total += val
        has_any = True
    for link in req.get("links", []) or []:
        if not isinstance(link, dict):
            continue
        val = _safe_float(link.get("bw_demand"), None)
        if val is None:
            continue
        total += val
        has_any = True
    return total if has_any else None


def infer_total_cost_from_reward(total_revenue: float | None, raw_reward: float | None) -> float | None:
    if total_revenue is None or raw_reward is None:
        return None
    # raw_reward(success) = 1000 + revenue - cost
    return float(1000.0 + total_revenue - raw_reward)


@dataclass
class AcceptanceFirstValueTarget:
    reject_value: float = -1.0
    accept_value_min: float = 0.2
    accept_value_max: float = 1.0
    clip_margin: float = 1e-8

    def __post_init__(self) -> None:
        self.accepted_cost_min: float | None = None
        self.accepted_cost_max: float | None = None
        self.accepted_count: int = 0

    def update_cost_stats(self, total_cost: float | None) -> None:
        cost = _safe_float(total_cost, None)
        if cost is None:
            return
        if self.accepted_cost_min is None or self.accepted_cost_max is None:
            self.accepted_cost_min = cost
            self.accepted_cost_max = cost
        else:
            if cost < self.accepted_cost_min:
                self.accepted_cost_min = cost
            if cost > self.accepted_cost_max:
                self.accepted_cost_max = cost
        self.accepted_count += 1

    def _normalized_cost_penalty(self, total_cost: float | None) -> float:
        cost = _safe_float(total_cost, None)
        if cost is None:
            return 0.5
        lo = self.accepted_cost_min
        hi = self.accepted_cost_max
        if lo is None or hi is None:
            return 0.5
        span = hi - lo
        if span <= self.clip_margin:
            return 0.5
        z = (cost - lo) / span
        if z < 0.0:
            return 0.0
        if z > 1.0:
            return 1.0
        return float(z)

    def compute_target(
        self,
        *,
        accepted: bool,
        total_cost: float | None = None,
        total_revenue: float | None = None,
        raw_reward: float | None = None,
        update_stats: bool = True,
    ) -> float:
        if not accepted:
            return float(self.reject_value)

        resolved_cost = _safe_float(total_cost, None)
        if resolved_cost is None:
            resolved_cost = infer_total_cost_from_reward(
                _safe_float(total_revenue, None),
                _safe_float(raw_reward, None),
            )
        if update_stats:
            self.update_cost_stats(resolved_cost)

        penalty = self._normalized_cost_penalty(resolved_cost)
        span = max(0.0, float(self.accept_value_max) - float(self.accept_value_min))
        target = float(self.accept_value_max) - span * penalty
        if target <= self.reject_value:
            target = float(self.reject_value) + 1e-6
        return float(target)

    def state_dict(self) -> dict:
        return {
            "reject_value": float(self.reject_value),
            "accept_value_min": float(self.accept_value_min),
            "accept_value_max": float(self.accept_value_max),
            "accepted_cost_min": self.accepted_cost_min,
            "accepted_cost_max": self.accepted_cost_max,
            "accepted_count": int(self.accepted_count),
        }

    def load_state_dict(self, state: dict | None) -> None:
        if not isinstance(state, dict):
            return
        self.reject_value = float(state.get("reject_value", self.reject_value))
        self.accept_value_min = float(state.get("accept_value_min", self.accept_value_min))
        self.accept_value_max = float(state.get("accept_value_max", self.accept_value_max))
        self.accepted_cost_min = _safe_float(state.get("accepted_cost_min"), self.accepted_cost_min)
        self.accepted_cost_max = _safe_float(state.get("accepted_cost_max"), self.accepted_cost_max)
        self.accepted_count = int(state.get("accepted_count", self.accepted_count))
