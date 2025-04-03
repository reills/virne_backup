# ==============================================================================
# solver.py (Refactored for Autoregressive Transformer to Match Pretrainer)
# ==============================================================================
import os
import torch
import numpy as np
import torch.nn as nn
import torch.nn.functional as F
from torch.distributions import Categorical
from torch_geometric.data import Data, Batch
from torch.nn.utils.rnn import pad_sequence, pad_packed_sequence
import warnings
import copy

from virne.base import Solution, SolutionStepEnvironment
from virne.solver import registry
from .instance_env import InstanceEnv
from .net import BatchPlacementNet
from virne.solver.learning.rl_base import RLSolver, PPOSolver, InstanceAgent, A2CSolver, RolloutBuffer
from ..utils import get_pyg_data

@registry.register(
    solver_name='a3c_gcn_oneshot_transformer', 
    env_cls=SolutionStepEnvironment,
    solver_type='r_learning')
class A3CGcnOneshotTransformerSolver(InstanceAgent, A2CSolver):
    """
    A Reinforcement Learning-based solver that uses 
    Advantage Actor-Critic (A3C) as the training algorithm,
    with a Transformer-based architecture.
    """
    def __init__(self, controller, recorder, counter, **kwargs):
        print(f"allow_revocable: {kwargs.get('allow_revocable')}")
       
        # Initialize parent classes
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

        # Initialize parent classes
        A2CSolver.__init__(  self,  controller,   recorder, counter, policy_builder,   obs_as_tensor,  **kwargs )
        
        self.preprocess_encoder_obs = encoder_obs_to_tensor

        InstanceAgent.__init__(self, InstanceEnv)
        
        # New hyperparameters
        self.entropy_coef = kwargs.get("entropy_coef", 0.01)
        self.normalize_advantage = kwargs.get("normalize_advantage", True)
  
        self.preprocess_encoder_obs = encoder_obs_to_tensor
        
        # # Retrieve pretrained RL model path (if any)
        self.rl_pretrained_path = kwargs.get("pretrained_model_path", None)
        #if self.rl_pretrained_path is not None:
        #    print(f"Pretrained model path specified: {self.rl_pretrained_path}")
        #    self.load_model(self.rl_pretrained_path) # Call the inherited load_model method
        #else:
        #    print("No pretrained model path specified, starting from scratch.")
            
        # # Retrieve pretrained model path from kwargs
        self.behavioral_cloning_path = kwargs.get("pretrained_bc_path", None)   

        # # Load the behavioral cloning if it exisys and there is no RL pretraining 
        if (not self.rl_pretrained_path or not os.path.exists(self.rl_pretrained_path)) and os.path.exists(self.behavioral_cloning_path):
             with warnings.catch_warnings():
                 warnings.filterwarnings("ignore", category=FutureWarning, message=".*weights_only=False.*") 
                 checkpoint = torch.load(self.behavioral_cloning_path, map_location=self.device)

                 self.policy.load_state_dict(checkpoint['model_state_dict'])
                 #print(f"Loaded pretrained model from {checkpoint}")
                 pretrained_loaded = True
                 
    def update(self):
        """
        Updates both actor and critic using a single forward pass.
        Because the actor and critic share parts of the network,
        we compute a combined loss (actor loss + critic loss - entropy bonus)
        and perform one backward pass, avoiding multiple backward calls
        and the need for retain_graph=True.
        """
        # Collect batch data
        obs_tensors = self.preprocess_obs(self.buffer.observations, self.device)
        actions = torch.LongTensor(self.buffer.actions).to(self.device)
        returns = torch.FloatTensor(self.buffer.returns).to(self.device)

        # --- Forward Pass: Compute Actor and Critic Outputs ---
        # Run a single forward pass to obtain both the logits (for action selection)
        # and the value estimates (for the critic)
        logits, values = self.policy(
            p_net_x=obs_tensors['p_net_x'],
            p_edge_index=obs_tensors['p_net_edge_index'],
            v_net_x=obs_tensors['v_net_x']
        )
        # Create a categorical distribution from logits
        dist = torch.distributions.Categorical(logits=logits)
        action_logprobs = dist.log_prob(actions)
        dist_entropy = dist.entropy()

        # --- Loss Computation ---
        # Compute advantage (detach critic to avoid backpropagating through it twice)
        advantages = returns - values.detach()
        if self.normalize_advantage and advantages.numel() > 0:
            advantages = (advantages - advantages.mean()) / (advantages.std() + 1e-8)
        
        # Actor loss (policy gradient loss)
        actor_loss = -(action_logprobs * advantages).mean()
        # Critic loss (value estimation loss)
        critic_loss = F.mse_loss(returns, values)
        # Combined loss: you can also weight critic_loss with a factor if desired
        total_loss = actor_loss + critic_loss - self.entropy_coef * dist_entropy.mean()

        # --- Backpropagation ---
        self.optimizer.zero_grad()
        total_loss.backward()
        if self.clip_grad:
            torch.nn.utils.clip_grad_norm_(self.policy.parameters(), self.max_grad_norm)
        self.optimizer.step()

        # --- Logging ---
        info = {
            "loss_total": total_loss.item(),
            "actor_loss": actor_loss.item(),
            "critic_loss": critic_loss.item(),
            "entropy": dist_entropy.mean().item()
        }
        if self.verbose >= 1 and self.update_time % 100 == 0:
            print(f"[Update {self.update_time}] {info}")
 
        self.buffer.clear()
        self.update_time += 1


    def evaluate_actions(self, obs, actions, return_others=False):
        """
        Evaluate log-probabilities, value, and entropy for chosen actions.
        """
        logits = self.policy.act(obs)  # Shape: (B, p_net_num_nodes)
        values = self.policy.evaluate(obs).squeeze(-1)
        dist = Categorical(logits=logits)
        action_logprobs = dist.log_prob(actions)
        dist_entropy = dist.entropy()


        if return_others:
            return values, action_logprobs, dist_entropy, {}
        else:
            return values, action_logprobs, dist_entropy


    def solve(self, instance):
        v_net, p_net = instance['v_net'], instance['p_net']
        sub_env = self.InstanceEnv(p_net, v_net, self.controller, self.recorder, self.counter, **self.basic_config)

        obs = sub_env.get_observation()

        p_net_x = torch.tensor(obs['p_net_x'], dtype=torch.float32, device=self.device)
        p_edge_index = torch.tensor(obs['p_net_edge_index'], dtype=torch.long, device=self.device)
        v_net_x = torch.tensor(obs['v_net_x'], dtype=torch.float32, device=self.device).unsqueeze(0)  # add batch dim

        self.policy.eval()
        with torch.no_grad():
            logits, _ = self.policy(p_net_x, p_edge_index, v_net_x)  # logits: (8, N_p)
            actions = torch.argmax(logits, dim=-1).tolist()          # list of 8 placements

        node_slots = {i: a for i, a in enumerate(actions)}
        solution = Solution()
        self.controller.deploy_with_node_slots(v_net, p_net, node_slots, solution)
        return solution


    def learn_with_instance(self, instance):
        sub_buffer = RolloutBuffer()
        v_net, p_net = instance['v_net'], instance['p_net']
        sub_env = self.InstanceEnv(p_net, v_net, self.controller, self.recorder, self.counter, **self.basic_config)

        obs = sub_env.get_observation()

        p_net_x = torch.tensor(obs['p_net_x'], dtype=torch.float32, device=self.device)
        p_edge_index = torch.tensor(obs['p_net_edge_index'], dtype=torch.long, device=self.device)
        v_net_x = torch.tensor(obs['v_net_x'], dtype=torch.float32, device=self.device).unsqueeze(0)  # (1, 8, F)

        self.policy.train()
        logits, value = self.policy(p_net_x, p_edge_index, v_net_x)  # logits: (8, N_p)

        dist = Categorical(logits=logits)
        actions = dist.sample()
        logprobs = dist.log_prob(actions)

        node_slots = {i: a.item() for i, a in enumerate(actions)}
        solution = Solution()
        self.controller.deploy_with_node_slots(v_net, p_net, node_slots, solution)

        # Reward is 1.0 if accepted, 0.0 or -1.0 if failed (tune as you like)
        reward = float(solution['result'])

        # Buffer expects lists per step — just wrap everything as one step
        sub_buffer.add(obs, actions.tolist(), reward, done=True, logprob=logprobs.sum(), value=value)

        return solution, sub_buffer, value


def make_policy(agent, p_dimension_features, v_dimension_features, **kwargs):
    model = BatchPlacementNet(
        p_net_num_nodes=agent.p_net_setting_num_nodes,
        p_net_feature_dim=p_dimension_features,
        v_net_feature_dim=v_dimension_features,
        embedding_dim=128,
        n_heads=8,
        n_layers=6,
        dropout=0.2
    ).to(agent.device)

    optimizer = torch.optim.Adam(model.parameters(), lr=agent.lr_actor, weight_decay=agent.weight_decay)
    return model, optimizer
 