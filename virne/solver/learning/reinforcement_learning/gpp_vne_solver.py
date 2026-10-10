"""Independent Virne reproduction of the GPPVNE benchmark.

The source paper is Ali and Ullah, "Joint-node-link Mapping for Virtual
Network Embedding in 5G/6G Environments Using GAT-Augmented PPO"
(Mobile Networks and Applications, 2025), DOI 10.1007/s11036-025-02481-6.

This is not the authors' code.  The paper specifies a two-layer, 64-hidden-unit
GAT, PPO, action masking, and incremental node/link embedding, but it does not
specify a reproducible policy head over physical paths.  This implementation
therefore lets PPO select feasible physical nodes and uses Virne's configured
feasible shortest-path mapper for links exposed at each reported three-step
routing checkpoint.  The choice is intentionally explicit so results can be
described as an independent reproduction rather than as results from the
authors' implementation.
"""

from __future__ import annotations

from typing import Any, Tuple

import torch
from omegaconf import DictConfig, open_dict

from virne.core import Controller, Counter, Logger, Recorder, Solution
from virne.network import PhysicalNetwork, VirtualNetwork
from virne.solver import SolverRegistry
from virne.solver.learning.rl_core.instance_agent import InstanceAgent
from virne.solver.learning.rl_core.instance_rl_environment import JointPRStepInstanceRLEnv
from virne.solver.learning.rl_core.policy_builder import OptimizerBuilder, PolicyBuilder
from virne.solver.learning.rl_core.reward_calculator import (
    BaseRewardCalculator,
    RewardCalculatorRegistry,
)
from virne.solver.learning.rl_core.rl_solver import PPOSolver
from virne.solver.learning.rl_core.tensor_convertor import TensorConvertor
from virne.solver.learning.rl_policy import BiGatActorCritic


PAPER_DOI = "10.1007/s11036-025-02481-6"
REPRODUCTION_NOTES = {
    "implementation": "independent Virne reproduction; not authors' code",
    "node_action": "masked categorical choice over physical nodes",
    "virtual_node_order": "configured Virne node ranking (NRM in benchmark profile)",
    "link_action": "configured feasible shortest-path mapper at periodic routing checkpoints",
    "link_embedding_interval": "configurable; paper profile uses the reported three steps",
    "ppo_buffer": "on-policy rollout buffer; no cross-policy replay",
    "cost_tradeoff": "configurable because the paper does not report lambda",
}


@RewardCalculatorRegistry.register("gpp_vne_revenue_cost")
class GppVneRevenueCostRewardCalculator(BaseRewardCalculator):
    """Dense form of the paper's revenue-minus-cost objective.

    Each step pays the newly incurred embedding cost.  A successfully embedded
    request receives its revenue at the terminal step, so the undiscounted sum
    over a successful request is ``revenue - cost_weight * cost``.  The paper
    leaves its trade-off factor and infeasibility penalty unspecified; both are
    exposed under ``rl.gpp_vne``.
    """

    def __init__(self, config: DictConfig):
        super().__init__(config)
        reward_config = config.rl.gpp_vne
        self.cost_weight = float(reward_config.cost_weight)
        self.failure_penalty = float(reward_config.failure_penalty)
        self.reward_scale = float(reward_config.reward_scale)
        if self.cost_weight < 0:
            raise ValueError("rl.gpp_vne.cost_weight must be non-negative")
        if self.failure_penalty < 0:
            raise ValueError("rl.gpp_vne.failure_penalty must be non-negative")
        if self.reward_scale <= 0:
            raise ValueError("rl.gpp_vne.reward_scale must be positive")
        self._previous_cost = 0.0

    def compute(
        self,
        p_net: PhysicalNetwork,
        v_net: VirtualNetwork,
        solution: Solution,
    ) -> float:
        current_cost = max(0.0, float(solution.get("v_net_cost", 0.0)))
        incremental_cost = max(0.0, current_cost - self._previous_cost)
        if current_cost >= self._previous_cost:
            self._previous_cost = current_cost

        reward = -self.cost_weight * incremental_cost
        if bool(solution.get("result", False)):
            reward += float(solution.get("v_net_revenue", 0.0))
        elif not bool(solution.get("place_result", True)) or not bool(
            solution.get("route_result", True)
        ) or bool(solution.get("early_rejection", False)):
            reward -= self.failure_penalty

        scaled_reward = reward / self.reward_scale
        solution["v_net_reward"] = float(solution.get("v_net_reward", 0.0)) + scaled_reward
        self.v_net_reward += scaled_reward
        return scaled_reward


class GppVneInstanceEnv(JointPRStepInstanceRLEnv):
    """Joint placement/routing environment used by the reproduction.

    A PPO action places the next critical virtual node.  At the configured link
    embedding interval (three steps in the paper profile), all newly exposed
    links are checked, routed, and reserved.  Thus node and link feasibility
    feeds back into the same trajectory instead of being deferred until all
    nodes are placed.
    """

    def __init__(
        self,
        p_net: PhysicalNetwork,
        v_net: VirtualNetwork,
        controller: Controller,
        recorder: Recorder,
        counter: Counter,
        logger: Logger,
        config: DictConfig,
        **kwargs: Any,
    ) -> None:
        with open_dict(config):
            config.rl.feature_constructor.name = "p_net_v_net"
            config.rl.reward_calculator.name = "gpp_vne_revenue_cost"
        self.link_embedding_interval = int(config.rl.gpp_vne.link_embedding_interval)
        if self.link_embedding_interval <= 0:
            raise ValueError("rl.gpp_vne.link_embedding_interval must be positive")
        super().__init__(
            p_net,
            v_net,
            controller,
            recorder,
            counter,
            logger,
            config,
            **kwargs,
        )

    @staticmethod
    def _link_is_routed(solution: Solution, v_link: tuple) -> bool:
        reverse_link = (v_link[1], v_link[0])
        return v_link in solution["link_paths"] or reverse_link in solution["link_paths"]

    def _pending_exposed_links(self) -> list[tuple]:
        placed_nodes = self.solution["node_slots"]
        return [
            tuple(v_link)
            for v_link in self.v_net.links
            if v_link[0] in placed_nodes
            and v_link[1] in placed_nodes
            and not self._link_is_routed(self.solution, tuple(v_link))
        ]

    def _record_step_offsets(
        self,
        link_offsets: list[dict],
        path_offsets: list[dict],
    ) -> None:
        if link_offsets:
            link_step_offset = {
                attr_name: max(offset[attr_name] for offset in link_offsets)
                for attr_name in link_offsets[0]
            }
        else:
            link_step_offset = dict(
                self.controller.step_constraint_offset_placeholder["link_level"]
            )
        if path_offsets:
            path_step_offset = {
                attr_name: max(offset[attr_name] for offset in path_offsets)
                for attr_name in path_offsets[0]
            }
        else:
            path_step_offset = dict(
                self.controller.step_constraint_offset_placeholder["path_level"]
            )

        self.solution["v_net_single_step_constraint_offset"][
            "link_level"
        ] = link_step_offset
        self.solution["v_net_single_step_constraint_offset"][
            "path_level"
        ] = path_step_offset

        hard_offsets = [
            offset_value
            for level_offsets in self.solution[
                "v_net_single_step_constraint_offset"
            ].values()
            for attr_name, offset_value in level_offsets.items()
            if attr_name in self.controller.hard_constraint_attrs_names
        ]
        max_offset = max(hard_offsets, default=0.0)
        self.solution["v_net_single_step_hard_constraint_offset"] = max_offset
        self.solution["v_net_max_single_step_hard_constraint_violation"] = max(
            self.solution["v_net_max_single_step_hard_constraint_violation"],
            max_offset,
        )

    def _route_pending_exposed_links(self) -> bool:
        link_offsets: list[dict] = []
        path_offsets: list[dict] = []
        for v_link in self._pending_exposed_links():
            p_pair = (
                self.solution["node_slots"][v_link[0]],
                self.solution["node_slots"][v_link[1]],
            )
            route_result, _ = self.controller.link_mapper.route(
                self.v_net,
                self.p_net,
                v_link,
                p_pair,
                self.solution,
                shortest_method=self.shortest_method,
                k=self.k_shortest,
                if_allow_constraint_violation=self.if_allow_constraint_violation,
            )
            link_offsets.append(
                self.solution["v_net_constraint_offsets"]["link_level"][v_link]
            )
            path_offsets.append(
                self.solution["v_net_constraint_offsets"]["path_level"][v_link]
            )
            if not route_result:
                self._record_step_offsets(link_offsets, path_offsets)
                return False

        self._record_step_offsets(link_offsets, path_offsets)
        return True

    def step(self, action: int):
        """Place one node and route exposed links every configured interval."""

        self.solution["num_interactions"] += 1
        p_node_id = int(action)
        self.solution.selected_actions.append(p_node_id)
        if self.solution["num_interactions"] > 10 * self.v_net.num_nodes:
            return self.reject()
        if self.if_rejection(action):
            return self.reject()
        if self.if_revocable(action):
            return self.revoke()

        if not self.reusable and p_node_id in self.selected_p_net_nodes:
            self.solution["place_result"] = False
            solution_info = self.counter.count_solution(self.v_net, self.solution)
            return (
                self.get_observation(),
                self.compute_reward(self.solution),
                True,
                self.get_info(solution_info),
            )

        if p_node_id not in self.p_net.nodes:
            raise ValueError(f"Physical node action {p_node_id} is not in the network")

        v_node_id = self.curr_v_node_id
        place_result, _ = self.controller.node_mapper.place(
            self.v_net,
            self.p_net,
            v_node_id,
            p_node_id,
            self.solution,
            if_allow_constraint_violation=self.if_allow_constraint_violation,
        )
        node_offset = self.solution["v_net_constraint_offsets"]["node_level"][v_node_id]
        self.solution["v_net_single_step_constraint_offset"] = {
            "node_level": node_offset,
            "link_level": {},
            "path_level": {},
        }

        if not place_result:
            self.solution.update({"place_result": False, "result": False})
            self._record_step_offsets([], [])
            solution_info = self.counter.count_solution(self.v_net, self.solution)
            return (
                self.get_observation(),
                self.compute_reward(self.solution),
                True,
                self.get_info(solution_info),
            )

        all_nodes_placed = self.num_placed_v_net_nodes == self.v_net.num_nodes
        routing_checkpoint = (
            self.num_placed_v_net_nodes % self.link_embedding_interval == 0
            or all_nodes_placed
        )
        self.add_extra_info(
            {
                "gpp_vne_routing_checkpoint": routing_checkpoint,
                "gpp_vne_link_embedding_interval": self.link_embedding_interval,
            }
        )

        if routing_checkpoint and not self._route_pending_exposed_links():
            self.solution.update({"route_result": False, "result": False})
            solution_info = self.counter.count_solution(self.v_net, self.solution)
            return (
                self.get_observation(),
                self.compute_reward(self.solution),
                True,
                self.get_info(solution_info),
            )
        if not routing_checkpoint:
            self._record_step_offsets([], [])

        if all_nodes_placed:
            all_links_routed = len(self.solution["link_paths"]) == self.v_net.num_links
            self.solution.update(
                {
                    "route_result": all_links_routed,
                    "result": all_links_routed,
                }
            )
            solution_info = self.counter.count_solution(self.v_net, self.solution)
            return (
                self.get_observation(),
                self.compute_reward(self.solution),
                True,
                self.get_info(solution_info),
            )

        solution_info = self.counter.count_partial_solution(self.v_net, self.solution)
        return (
            self.get_observation(),
            self.compute_reward(self.solution),
            False,
            self.get_info(solution_info),
        )


def build_gpp_vne_policy(agent: Any) -> Tuple[torch.nn.Module, torch.optim.Optimizer]:
    """Build the paper-matched dual-GAT actor/critic.

    The repository's generic dual-GAT builder relies on the policy default of
    three layers.  GPPVNE reports two, so this benchmark passes ``num_layers``
    explicitly.
    """

    policy = BiGatActorCritic(
        **PolicyBuilder.get_feature_dim_config(agent.config),
        **PolicyBuilder.get_general_nn_config(agent.config),
        num_layers=int(agent.config.nn.num_layers),
    ).to(agent.device)
    optimizer = OptimizerBuilder.build_optimizer(agent.config, policy)
    return policy, optimizer


@SolverRegistry.register(solver_name="gpp_vne", solver_type="r_learning")
class GppVneSolver(InstanceAgent, PPOSolver):
    """GAT-PPO joint node/link benchmark registered as ``gpp_vne``."""

    paper_doi = PAPER_DOI
    reproduction_notes = REPRODUCTION_NOTES

    def __init__(
        self,
        controller: Controller,
        recorder: Recorder,
        counter: Counter,
        logger: Logger,
        config: DictConfig,
        **kwargs: Any,
    ) -> None:
        InstanceAgent.__init__(self, GppVneInstanceEnv)

        # PPOSolver historically supplies literal defaults for these values.
        # Pass the configured paper parameters explicitly while still allowing
        # a direct caller to override them.
        solver_kwargs = {
            "num_workers": int(config.training.num_workers),
            "repeat_times": int(config.rl.repeat_times),
            "gae_lambda": float(config.rl.gae_lambda),
            "eps_clip": float(config.rl.eps_clip),
            "norm_advantage": bool(config.rl.norm_advantage),
            "clip_grad": bool(config.rl.clip_grad),
            "max_grad_norm": float(config.rl.max_grad_norm),
        }
        solver_kwargs.update(kwargs)
        PPOSolver.__init__(
            self,
            controller,
            recorder,
            counter,
            logger,
            config,
            build_gpp_vne_policy,
            TensorConvertor.obs_as_tensor_for_dual_gnn,
            **solver_kwargs,
        )


__all__ = [
    "GppVneInstanceEnv",
    "GppVneRevenueCostRewardCalculator",
    "GppVneSolver",
    "PAPER_DOI",
    "REPRODUCTION_NOTES",
    "build_gpp_vne_policy",
]
