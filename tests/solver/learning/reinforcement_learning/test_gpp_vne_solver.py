from types import SimpleNamespace
import warnings

warnings.filterwarnings(
    "ignore",
    message="CUDA initialization: CUDA driver initialization failed.*",
    category=UserWarning,
)

import pytest
import torch
from omegaconf import OmegaConf
from torch_geometric.data import Batch, Data

from virne.solver import SolverRegistry
from virne.solver.learning.reinforcement_learning.gpp_vne_solver import (
    GppVneRevenueCostRewardCalculator,
    GppVneSolver,
    build_gpp_vne_policy,
)


def _reward_config(*, cost_weight=0.1, failure_penalty=1.0, reward_scale=1.0):
    return OmegaConf.create(
        {
            "rl": {
                "reward_calculator": {"intermediate_reward": 0.1},
                "gpp_vne": {
                    "link_embedding_interval": 3,
                    "cost_weight": cost_weight,
                    "failure_penalty": failure_penalty,
                    "reward_scale": reward_scale,
                },
            }
        }
    )


def _policy_config():
    return OmegaConf.create(
        {
            "simulation": {"p_net_setting_num_nodes": 4},
            "nn": {
                "embedding_dim": 64,
                "dropout_prob": 0.1,
                "batch_norm": False,
                "num_layers": 2,
            },
            "rl": {
                "weight_decay": 0.0,
                "learning_rate": {"actor": 1e-4, "critic": 1e-4},
                "feature_constructor": {
                    "num_extracted_p_node_attrs": 1,
                    "num_extracted_p_link_attrs": 1,
                    "num_extracted_v_node_attrs": 1,
                    "num_extracted_v_link_attrs": 1,
                    "if_use_node_status_flags": True,
                    "if_use_aggregated_link_attrs": True,
                    "if_use_degree_metric": True,
                    "if_use_more_topological_metrics": True,
                },
            },
        }
    )


def test_solver_is_registered_as_gpp_vne():
    assert SolverRegistry.get("gpp_vne") is GppVneSolver


def test_revenue_cost_reward_telescopes_on_success():
    calculator = GppVneRevenueCostRewardCalculator(_reward_config())
    solution = {
        "result": False,
        "place_result": True,
        "route_result": True,
        "early_rejection": False,
        "v_net_cost": 10.0,
        "v_net_revenue": 0.0,
        "v_net_reward": 0.0,
    }

    first_reward = calculator.compute(None, None, solution)
    solution.update(v_net_cost=15.0)
    second_reward = calculator.compute(None, None, solution)
    solution.update(result=True, v_net_cost=20.0, v_net_revenue=50.0)
    terminal_reward = calculator.compute(None, None, solution)

    assert first_reward == pytest.approx(-1.0)
    assert second_reward == pytest.approx(-0.5)
    assert terminal_reward == pytest.approx(49.5)
    assert sum((first_reward, second_reward, terminal_reward)) == pytest.approx(48.0)
    assert solution["v_net_reward"] == pytest.approx(48.0)


def test_revenue_cost_reward_penalizes_failed_mapping():
    calculator = GppVneRevenueCostRewardCalculator(_reward_config())
    solution = {
        "result": False,
        "place_result": False,
        "route_result": True,
        "early_rejection": False,
        "v_net_cost": 0.0,
        "v_net_revenue": 0.0,
        "v_net_reward": 0.0,
    }

    assert calculator.compute(None, None, solution) == pytest.approx(-1.0)


def test_gpp_policy_uses_two_gat_layers_and_runs_forward():
    config = _policy_config()
    agent = SimpleNamespace(config=config, device=torch.device("cpu"))
    policy, optimizer = build_gpp_vne_policy(agent)

    assert policy.actor.encoder.p_net_encoder.net_gnn.num_layers == 2
    assert policy.actor.encoder.v_net_encoder.net_gnn.num_layers == 2
    assert len(optimizer.param_groups) == 2

    p_net = Batch.from_data_list(
        [
            Data(
                x=torch.zeros((4, 12), dtype=torch.float32),
                edge_index=torch.tensor(
                    [[0, 1, 1, 2, 2, 3], [1, 0, 2, 1, 3, 2]],
                    dtype=torch.long,
                ),
                edge_attr=torch.ones((6, 1), dtype=torch.float32),
            )
        ]
    )
    v_net = Batch.from_data_list(
        [
            Data(
                x=torch.zeros((3, 13), dtype=torch.float32),
                edge_index=torch.tensor(
                    [[0, 1, 1, 2], [1, 0, 2, 1]],
                    dtype=torch.long,
                ),
                edge_attr=torch.ones((4, 1), dtype=torch.float32),
            )
        ]
    )
    observation = {
        "p_net": p_net,
        "v_net": v_net,
        "curr_v_node_id": torch.tensor([0], dtype=torch.long),
    }

    assert policy.act(observation).shape == (1, 4)
    assert policy.evaluate(observation).shape == (1, 1)
