from __future__ import annotations

from virne.solver.learning.reinforcement_learning.alpha_vne.value_target import (
    AcceptanceFirstValueTarget,
    infer_total_cost_from_reward,
    infer_total_revenue_from_static_env,
)


def test_acceptance_first_target_orders_reject_below_accept() -> None:
    shaper = AcceptanceFirstValueTarget(reject_value=-1.0, accept_value_min=0.2, accept_value_max=1.0)
    shaper.update_cost_stats(10.0)
    shaper.update_cost_stats(100.0)

    rejected = shaper.compute_target(accepted=False)
    low_cost_accept = shaper.compute_target(accepted=True, total_cost=10.0, update_stats=False)
    high_cost_accept = shaper.compute_target(accepted=True, total_cost=100.0, update_stats=False)

    assert rejected < high_cost_accept < low_cost_accept
    assert rejected < 0.0
    assert low_cost_accept > 0.0


def test_infer_total_cost_from_reward_uses_raw_formula() -> None:
    # reward = 1000 + revenue - cost
    revenue = 75.0
    cost = 21.5
    reward = 1000.0 + revenue - cost
    assert infer_total_cost_from_reward(revenue, reward) == cost


def test_infer_total_revenue_from_static_env() -> None:
    env = {
        "sfc_request": {
            "nodes": [{"cpu_demand": 2.0}, {"cpu_demand": 3.0}],
            "links": [{"bw_demand": 4.0}],
        }
    }
    assert infer_total_revenue_from_static_env(env) == 9.0
