import os
import torch
import numpy as np
import torch.nn as nn
import torch.nn.functional as F
from torch.distributions import Categorical
from torch_geometric.data import Batch
from torch.nn.utils.rnn import pad_sequence
from virne.base import Solution, SolutionStepEnvironment
from virne.solver import registry
from .instance_env import InstanceEnv
from .net import ActorCritic
from virne.solver.learning.rl_base import InstanceAgent, A2CSolver, RolloutBuffer
from ..utils import get_pyg_data

@registry.register(
    solver_name='a2c_gcn_transformer_encoder',
    env_cls=SolutionStepEnvironment,
    solver_type='r_learning')
class A3CGcnTransformerEncoder(InstanceAgent, A2CSolver):
    def __init__(self, controller, recorder, counter, **kwargs):
        print(f"allow_revocable: {kwargs.get('allow_revocable')}")

        policy_builder = (
            lambda slf,
                p_dim=kwargs.get("p_dimension_features"),
                v_dim=kwargs.get("v_dimension_features"),
                rev=kwargs.get("allow_revocable"),
                rej=kwargs.get("allow_rejection"): make_policy(
                slf,
                p_dimension_features=p_dim,
                v_dimension_features=v_dim,
                is_revocable=rev,
                is_rejection=rej
            )
        )

        A2CSolver.__init__(self, controller, recorder, counter, policy_builder, obs_as_tensor, **kwargs)
        InstanceAgent.__init__(self, InstanceEnv)
        self.preprocess_encoder_obs = encoder_obs_to_tensor
        self.entropy_coef = kwargs.get("entropy_coef", 0.01)
        self.normalize_advantage = kwargs.get("normalize_advantage", True)

    def update(self):
        obs_tensors = self.preprocess_obs(self.buffer.observations, self.device)
        actions = torch.LongTensor(self.buffer.actions).to(self.device)
        returns = torch.FloatTensor(self.buffer.returns).to(self.device)

        logits = self.policy.act(obs_tensors)
        values = self.policy.evaluate(obs_tensors).squeeze(-1)

        dist = Categorical(logits=logits)
        action_logprobs = dist.log_prob(actions)
        dist_entropy = dist.entropy()

        advantages = returns - values.detach()
        if self.normalize_advantage and advantages.numel() > 0:
            advantages = (advantages - advantages.mean()) / (advantages.std() + 1e-8)

        actor_loss = -(action_logprobs * advantages).mean()
        critic_loss = F.mse_loss(returns, values)
        total_loss = actor_loss + critic_loss - self.entropy_coef * dist_entropy.mean()

        self.optimizer.zero_grad()
        total_loss.backward()
        if self.clip_grad:
            torch.nn.utils.clip_grad_norm_(self.policy.parameters(), self.max_grad_norm)
        self.optimizer.step()

        if self.verbose >= 1:
            print(f"[Update] Total: {total_loss.item():.4f}, Actor: {actor_loss.item():.4f}, Critic: {critic_loss.item():.4f}, Entropy: {dist_entropy.mean().item():.4f}")

        self.buffer.clear()
        self.update_time += 1

    def evaluate_actions(self, obs, actions, return_others=False):
        logits = self.policy.act(obs)
        values = self.policy.evaluate(obs).squeeze(-1)
        dist = Categorical(logits=logits)
        action_logprobs = dist.log_prob(actions)
        dist_entropy = dist.entropy()

        if return_others:
            return values, action_logprobs, dist_entropy, {}
        else:
            return values, action_logprobs, dist_entropy

    def make_instance_obs(self, history_actions, encoder_obs, encoder_outputs, sub_env):
        return {
            'p_net_x': encoder_obs['p_net_x'],
            'p_net_edge_index': encoder_obs['p_net_edge_index'],
            'edge_attr': None,
            'history_actions': np.array(history_actions, dtype=np.int64),
            'encoder_outputs': encoder_outputs,
            'action_mask': np.expand_dims(sub_env.generate_action_mask(), axis=0)
        }

    def solve(self, instance):
        v_net, p_net = instance['v_net'], instance['p_net']
        sub_env = self.InstanceEnv(p_net, v_net, self.controller, self.recorder, self.counter,
                                   preprocess_obs_fn=self.preprocess_obs, **self.basic_config)

        encoder_obs = sub_env.get_observation()
        encoder_outputs = self.policy.encode(self.preprocess_encoder_obs(encoder_obs, device=self.device))

        history_actions = []
        instance_done = False
        while not instance_done:
            instance_obs = self.make_instance_obs(history_actions, encoder_obs, encoder_outputs, sub_env)
            tensor_instance_obs = self.preprocess_obs(instance_obs, device=self.device)

            sub_env.prev_obs = {
                **instance_obs,
                'encoder_outputs': encoder_outputs.detach().cpu().numpy()
            }
            sub_env.prev_tensor_obs = tensor_instance_obs

            action, _ = self.select_action(tensor_instance_obs, sample=True)
            next_obs, reward, instance_done, info = sub_env.step(action)
            history_actions.append(action)
            encoder_obs = next_obs

        return sub_env.solution

    def learn_with_instance(self, instance):
        sub_buffer = RolloutBuffer()
        v_net, p_net = instance['v_net'], instance['p_net']
        sub_env = self.InstanceEnv(p_net, v_net, self.controller, self.recorder, self.counter,
                                   preprocess_obs_fn=self.preprocess_obs, **self.basic_config)

        encoder_obs = sub_env.get_observation()
        encoder_outputs = self.policy.encode(self.preprocess_encoder_obs(encoder_obs, device=self.device))
        history_actions = []
        instance_done = False

        while not instance_done:
            instance_obs = self.make_instance_obs(history_actions, encoder_obs, encoder_outputs, sub_env)
            tensor_instance_obs = self.preprocess_obs(instance_obs, device=self.device)

            sub_env.prev_obs = {
                **instance_obs,
                'encoder_outputs': encoder_outputs.detach().cpu().numpy()
            }
            sub_env.prev_tensor_obs = tensor_instance_obs

            action, logprob = self.select_action(tensor_instance_obs, sample=True)
            value = self.estimate_value(tensor_instance_obs)
            next_obs, reward, instance_done, info = sub_env.step(action)

            sub_buffer.add(instance_obs, action, reward, instance_done, logprob, value=value)
            history_actions.append(action)
            encoder_obs = next_obs

        last_value = 0.
        if hasattr(self.policy, 'evaluate'):
            final_obs = self.make_instance_obs(history_actions, encoder_obs, encoder_outputs, sub_env)
            final_tensor_obs = self.preprocess_obs(final_obs, device=self.device)
            last_value = self.estimate_value(final_tensor_obs)

        return sub_env.solution, sub_buffer, last_value


def make_policy(agent, p_dimension_features, v_dimension_features, is_revocable, is_rejection, **kwargs):
    action_dim = agent.p_net_setting_num_nodes
    policy = ActorCritic(
        p_net_num_nodes=action_dim,
        p_net_feature_dim=p_dimension_features,
        v_net_feature_dim=v_dimension_features,
        embedding_dim=128,
        n_heads=8,
        n_layers=6,
        dropout=0.2,
        allow_revocable=is_revocable,
        allow_rejection=is_rejection
    ).to(agent.device)

    optimizer = torch.optim.Adam([
        {'params': policy.encoder.parameters(), 'lr': agent.lr_actor},
        {'params': policy.actor.parameters(),   'lr': agent.lr_actor},
        {'params': policy.critic.parameters(),  'lr': agent.lr_critic}
    ], weight_decay=agent.weight_decay)
    return policy, optimizer


def encoder_obs_to_tensor(obs, device):
    if isinstance(obs, dict):
        obs_v_net_x = obs['v_net_x'] if torch.is_tensor(obs['v_net_x']) else torch.tensor(obs['v_net_x'], dtype=torch.float32)
        return {'v_net_x': obs_v_net_x.to(device)}
    elif isinstance(obs, list):
        obs_batch = [
            o['v_net_x'] if torch.is_tensor(o['v_net_x']) else torch.tensor(o['v_net_x'], dtype=torch.float32)
            for o in obs
        ]
        padded = pad_sequence(obs_batch, batch_first=True).to(device)
        return {'v_net_x': padded}
    else:
        raise TypeError("Unsupported obs type")


def obs_as_tensor(obs, device):
    if isinstance(obs, dict):
        data = get_pyg_data(obs['p_net_x'], obs['p_net_edge_index'], None)
        obs_p_net = Batch.from_data_list([data]).to(device)
        return {
            'p_net': obs_p_net,
            'history_actions': torch.LongTensor(obs['history_actions']).unsqueeze(0).to(device),
            'encoder_outputs': obs['encoder_outputs'].clone().detach().to(device).float(),
            'action_mask': torch.tensor(obs['action_mask'], dtype=torch.float32, device=device)
        }

    elif isinstance(obs, list):
        p_net_data_list = [get_pyg_data(o['p_net_x'], o['p_net_edge_index'], None) for o in obs]
        obs_p_net = Batch.from_data_list(p_net_data_list).to(device)

        history_actions_list = [torch.LongTensor(o['history_actions']) for o in obs]
        hist_padded = pad_sequence(history_actions_list, batch_first=True, padding_value=0).to(device)

        encoder_outputs_list = [torch.tensor(o['encoder_outputs'], dtype=torch.float32) if not torch.is_tensor(o['encoder_outputs']) else o['encoder_outputs'] for o in obs]
        max_len = max(e.shape[1] for e in encoder_outputs_list)
        batch_size = len(encoder_outputs_list)
        emb_dim = encoder_outputs_list[0].shape[2]
        padded_enc = torch.zeros((batch_size, max_len, emb_dim), dtype=torch.float32, device=device)
        for i, eo in enumerate(encoder_outputs_list):
            padded_enc[i, :eo.shape[1], :] = eo.clone().detach().to(device).float()

        action_masks = torch.tensor(np.array([o['action_mask'] for o in obs]), dtype=torch.float32, device=device)

        return {
            'p_net': obs_p_net,
            'history_actions': hist_padded,
            'encoder_outputs': padded_enc,
            'action_mask': action_masks
        }

    else:
        raise TypeError("Unsupported obs type for batching")
