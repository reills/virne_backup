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
from torch.nn.utils.rnn import pad_sequence

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
        self.global_history = []
        
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

        InstanceAgent.__init__(self, InstanceEnv )
        
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
        logits = self.policy(obs_tensors['p_net_x'], obs_tensors['p_net_edge_index'], obs_tensors['v_net_x'])
        values = self.policy.evaluate(obs_tensors['p_net_x'], obs_tensors['p_net_edge_index'], obs_tensors['v_net_x'])


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
        values = self.policy.evaluate(obs['p_net_x'], obs['p_net_edge_index'], obs['v_net_x'])


        dist = Categorical(logits=logits)
        action_logprobs = dist.log_prob(actions)
        dist_entropy = dist.entropy()


        if return_others:
            return values, action_logprobs, dist_entropy, {}
        else:
            return values, action_logprobs, dist_entropy


    def solve(self, instance):
        v_net, p_net = instance['v_net'], instance['p_net']
        sub_env = self.InstanceEnv(
            p_net, v_net, self.controller, self.recorder, self.counter,
            global_history=self.global_history,  # <- add this!
            start_token=100,
            **self.basic_config
        )

        obs = sub_env.get_observation()

        p_net_x = torch.tensor(obs['p_net_x'], dtype=torch.float32, device=self.device)
        p_edge_index = torch.tensor(obs['p_net_edge_index'], dtype=torch.long, device=self.device)
        # Convert to tensor and pad to batch shape (1, L, F)
        vnet_list = [torch.tensor(obs['v_net_x'], dtype=torch.float32, device=self.device)]
        v_net_x, attn_mask = pad_vnet_batch(vnet_list)

        edge_attr = torch.tensor(obs['edge_attr'], dtype=torch.float32, device=self.device)
        history_actions = torch.tensor(obs['history_actions'], dtype=torch.long, device=self.device)


        self.policy.eval()
        with torch.no_grad():
            logits = self.policy(p_net_x, p_edge_index, edge_attr, v_net_x, history_actions, attn_mask)

            # ==== INSERT MASKING HERE ====
            action_mask = torch.tensor(obs['action_mask'], dtype=torch.bool, device=self.device)  # (L, N)
            if action_mask.shape != logits.shape:
                raise ValueError(f"Mask shape {action_mask.shape} does not match logits {logits.shape}")

            logits = logits.masked_fill(~action_mask, float('-inf'))  # Mask out invalid actions

            # ==== SELECT VALID ACTIONS ====
            actions = torch.argmax(logits, dim=-1).tolist()  # List of L placements

        node_slots = {i: a for i, a in enumerate(actions)}
        solution = Solution(v_net)
        self.controller.deploy_with_node_slots(v_net, p_net, node_slots, solution)
        
        # After finishing the VNet, update the global history with the chosen node placements
        for _, pnode in solution['node_slots'].items():
            self.global_history.append(pnode)
            
        return solution


    def learn_with_instance(self, instance):
        sub_buffer = RolloutBuffer()
        v_net, p_net = instance['v_net'], instance['p_net']
        sub_env = self.InstanceEnv(
            p_net, v_net, self.controller, self.recorder, self.counter,
            global_history=self.global_history,  # <- add this!
            **self.basic_config
        )

        obs = sub_env.get_observation()

        p_net_x = torch.tensor(obs['p_net_x'], dtype=torch.float32, device=self.device)
        p_edge_index = torch.tensor(obs['p_net_edge_index'], dtype=torch.long, device=self.device)
        # Convert to tensor and pad to batch shape (1, L, F)
        vnet_list = [torch.tensor(obs['v_net_x'], dtype=torch.float32, device=self.device)]
        v_net_x, attn_mask = pad_vnet_batch(vnet_list)

        edge_attr = torch.tensor(obs['edge_attr'], dtype=torch.float32, device=self.device)
        history_actions = torch.tensor(obs['history_actions'], dtype=torch.long, device=self.device)  

        self.policy.train()
        logits = self.policy(p_net_x, p_edge_index, edge_attr, v_net_x, history_actions, attn_mask)

        value = self.policy.evaluate(p_net_x, p_edge_index, edge_attr, v_net_x, history_actions, attn_mask)

        dist = Categorical(logits=logits)
        actions = dist.sample()
        logprobs = dist.log_prob(actions)
        
        actions = actions.squeeze(0)  # from shape [1, 8] → [8]
        node_slots = dict(enumerate(actions))
        solution = Solution(v_net)
        
        self.controller.deploy_with_node_slots(v_net, p_net, node_slots, solution)

        # Reward is 1.0 if accepted, 0.0 or -1.0 if failed (tune as you like)
        reward = float(solution['result'])
        
        # After finishing the VNet, update the global history with the chosen node placements
        for _, pnode in solution['node_slots'].items():
            self.global_history.append(pnode)

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
 
 
def encoder_obs_to_tensor(obs, device):
    """Process the v_net features for the Transformer Encoder."""
    if isinstance(obs, dict):
        # If obs['v_net_x'] is already a tensor, move it; otherwise, create one on the desired device.
        if torch.is_tensor(obs['v_net_x']):
            obs_v_net_x = obs['v_net_x'].float().to(device)
        else:
            obs_v_net_x = torch.tensor(obs['v_net_x'], dtype=torch.float32, device=device)
        return {'v_net_x': obs_v_net_x}
    elif isinstance(obs, list):
        obs_batch = [
            torch.tensor(o['v_net_x'], dtype=torch.float32, device=device)
            if not torch.is_tensor(o['v_net_x']) else o['v_net_x'].float().to(device)
            for o in obs
        ]
        padded = pad_sequence(obs_batch, batch_first=True)
        return {'v_net_x': padded}
    else:
        raise Exception(f"Unrecognized type of observation {type(obs)}")

def pad_vnet_batch(vnet_list):
    lengths = [v.shape[0] for v in vnet_list]  # [L1, L2, ...]
    padded = pad_sequence(vnet_list, batch_first=True)  # (B, L_max, F)
    attention_mask = torch.zeros(padded.shape[:2], dtype=torch.bool, device=padded.device)  # Move to same device
    for i, l in enumerate(lengths):
        attention_mask[i, :l] = 1
    return padded, attention_mask


def obs_as_tensor(obs, device):
    data = get_pyg_data(obs['p_net_x'], obs['p_net_edge_index'], obs['edge_attr'])
    obs_p_net = Batch.from_data_list([data]).to(device)
    history_actions = torch.tensor(obs['history_actions'], dtype=torch.long, device=device)
    # No need to unsqueeze!
    obs_encoder_outputs = torch.as_tensor(obs['encoder_outputs'], dtype=torch.float32, device=device)
    obs_action_mask = torch.as_tensor(obs['action_mask'], dtype=torch.float32, device=device)
    return {
        'p_net': obs_p_net,
        'history_actions': history_actions,
        'edge_attr'        : obs['edge_attr'],
        'encoder_outputs': obs_encoder_outputs,
        'action_mask': obs_action_mask,
        'mask': None
    }
    