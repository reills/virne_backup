# ==============================================================================
# solver.py (Refactored for Autoregressive Transformer to Match Pretrainer)
# ==============================================================================
import os
import torch
import gc
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
from .net import ActorCritic 
from virne.solver.learning.rl_base import RLSolver, PPOSolver, InstanceAgent, A2CSolver, RolloutBuffer
from ..utils import get_pyg_data


def obs_as_tensor(obs, device, pad_token=None):
    """Preprocess the entire observation into tensor form."""
    if isinstance(obs, dict):
        data = get_pyg_data(obs['p_net_x'], obs['p_net_edge_index'], obs['edge_attr'])
        obs_p_net = Batch.from_data_list([data]).to(device)
        history_actions = torch.LongTensor(obs['history_actions']).unsqueeze(0).to(device)
        obs_encoder_outputs = torch.as_tensor(obs['encoder_outputs'], dtype=torch.float32, device=device)
        obs_action_mask = torch.as_tensor(obs['action_mask'], dtype=torch.float32, device=device)
       
        result =  {
            'p_net': obs_p_net,
            'history_actions': history_actions,
            'edge_attr'        : obs['edge_attr'],
            'encoder_outputs': obs_encoder_outputs,
            'action_mask': obs_action_mask,
            'mask': None
        }
        
        if 'rtg' in obs:
            rtg = torch.tensor(obs['rtg'], dtype=torch.float32, device=device)
            result['rtg'] = rtg  # shape: (1, T)
            
        return result 
            
    elif isinstance(obs, list):
        p_net_data_list = [get_pyg_data(o['p_net_x'], o['p_net_edge_index'], o['edge_attr']) for o in obs]
        history_actions_list = [torch.LongTensor(o['history_actions']) for o in obs]
        encoder_outputs_list = [o['encoder_outputs'] for o in obs]  
        action_mask_list = [o['action_mask'] for o in obs]
        obs_p_net = Batch.from_data_list(p_net_data_list).to(device)
        hist_padded = pad_sequence(history_actions_list, batch_first=True, padding_value=pad_token).to(device)

        batch_size = len(encoder_outputs_list)
        max_seq_len = max(eo.shape[1] for eo in encoder_outputs_list)
        emb_dim = encoder_outputs_list[0].shape[2]
        enc_padded = torch.zeros((batch_size, max_seq_len, emb_dim), dtype=torch.float32, device=device)
        
        for i, eo in enumerate(encoder_outputs_list):
            slen = eo.shape[1]
            enc_padded[i, :slen, :] = torch.as_tensor(eo, device=device)
            
        action_mask_np = np.array(action_mask_list)
        act_mask_t = torch.as_tensor(action_mask_np, dtype=torch.float32, device=device)
        
        result =  {
            'p_net': obs_p_net,
            'history_actions': hist_padded,
            'encoder_outputs': enc_padded,
            'action_mask': act_mask_t,
            'mask': None
        }
        
         
        if 'rtg' in obs[0]:
            rtg_list = [torch.tensor(o['rtg'], dtype=torch.float32) for o in obs]
            padded_rtg = pad_sequence(rtg_list, batch_first=True).to(device)
            result['rtg'] = padded_rtg  # shape: (B, T, 1) or (B, T)
        
        return result 
    else:
        raise ValueError('obs type error: expected dict or list')



#for pickling and multithreading
def transformer_policy_builder(slf, kwargs):
    return make_policy(
        slf,
        p_dimension_features=kwargs.get("p_dimension_features"),
        v_dimension_features=kwargs.get("v_dimension_features"),
        is_revocable=kwargs.get("allow_revocable"),
        is_rejection=kwargs.get("allow_rejection")
    )
    
# Pickle-safe policy builder
def policy_builder(slf):
    return transformer_policy_builder(slf, slf.policy_builder_args)  
    
@registry.register(
    solver_name='a3c_gcn_pre_train_transformer', 
    env_cls=SolutionStepEnvironment,
    solver_type='r_learning')
class A3CGcnPreTrainTransformerSolver(InstanceAgent, A2CSolver):
    """
    A Reinforcement Learning-based solver that uses 
    Advantage Actor-Critic (A3C) as the training algorithm,
    with a Transformer-based architecture.
    """
    def __init__(self, controller, recorder, counter, **kwargs):
        print(f"allow_revocable: {kwargs.get('allow_revocable')}")
       
        # Initialize parent classes
        self.policy_builder_args = kwargs 
        
        # Initialize parent classes
        make_policy = kwargs.pop("make_policy", policy_builder)
        obs_as_tensor_func = kwargs.pop("obs_as_tensor", obs_as_tensor )
        self.v_dimension_features = kwargs.get("v_dimension_features", None)
        self.p_dimension_features = kwargs.get("p_dimension_features", None)

        A2CSolver.__init__(  self,  controller,   recorder, counter, policy_builder,   obs_as_tensor_func,  **kwargs )
        
        self.preprocess_encoder_obs = encoder_obs_to_tensor

        InstanceAgent.__init__(self, InstanceEnv)
        
        # New hyperparameters
        self.entropy_coef = kwargs.get("entropy_coef", 0.05)
        self.normalize_advantage = kwargs.get("normalize_advantage", True)
 
        # Special start token (we use p_net.num_nodes as start token)
        self.start_token = self.policy.actor.decoder.start_token
        self.pad_token   = self.policy.actor.decoder.pad_token

        self.preprocess_encoder_obs = encoder_obs_to_tensor
        
        # # Retrieve pretrained RL model path (if any)
        self.rl_pretrained_path = kwargs.get("pretrained_model_path", None)
        #if self.rl_pretrained_path is not None:
        #    print(f"Pretrained model path specified: {self.rl_pretrained_path}")
        #    self.load_model(self.rl_pretrained_path) # Call the inherited load_model method
        #else:
        #    print("No pretrained model path specified, starting from scratch.")
            
        # # Retrieve pretrained model path from kwargs
        # self.behavioral_cloning_path = kwargs.get("pretrained_bc_path", None)   

        # # # Load the behavioral cloning if it exisys and there is no RL pretraining 
        # if (not self.rl_pretrained_path or not os.path.exists(self.rl_pretrained_path)) and os.path.exists(self.behavioral_cloning_path):
        #      with warnings.catch_warnings():
        #          warnings.filterwarnings("ignore", category=FutureWarning, message=".*weights_only=False.*") 
        #          checkpoint = torch.load(self.behavioral_cloning_path, map_location=self.device)

        #          self.policy.load_state_dict(checkpoint['model_state_dict'])
        #          #print(f"Loaded pretrained model from {checkpoint}")
        #          pretrained_loaded = True
                 
    # Inside A3CGcnPreTrainTransformerSolver class

    def update(self):
        """
        Update the policy using collected rollouts (A2C-style).
        Leverages inherited update_grad for distributed synchronization.
        """
        detached_total_loss = None
        info = {}

        try:
            with torch.amp.autocast("cuda"):
                # === 1. Collect batch data ===
                obs_tensors = self.preprocess_obs(self.buffer.observations, self.device, pad_token=self.pad_token)
                actions = torch.LongTensor(self.buffer.actions).to(self.device)
                returns = torch.FloatTensor(self.buffer.returns).to(self.device)

                # === 2. Forward pass ===
                logits = self.policy.act(obs_tensors)
                values = self.policy.evaluate(obs_tensors).squeeze(-1)

                dist = torch.distributions.Categorical(logits=logits)
                action_logprobs = dist.log_prob(actions)
                dist_entropy = dist.entropy()

                # === 3. Compute advantage ===
                advantages = returns - values.detach()
                if self.normalize_advantage and advantages.numel() > 0:
                    advantages_mean = advantages.mean()
                    advantages_std = advantages.std()
                    advantages = (advantages - advantages_mean) / (advantages_std + 1e-8)

                # === 4. Losses ===
                actor_loss = -(action_logprobs * advantages).mean()
                critic_loss = F.mse_loss(returns, values)
                entropy_loss = dist_entropy.mean()
                # *** Use self.entropy_coef consistent with your class ***
                total_loss = actor_loss + critic_loss - self.entropy_coef * entropy_loss

            detached_total_loss = total_loss.item()

            # === 5. Backpropagation & Synchronization via inherited method ===
            # *** Instead of direct backprop/step, call update_grad ***
            grad_clipped_tensor = self.update_grad(total_loss) # This handles backprop, sync, shared step
            grad_clipped_value = float(grad_clipped_tensor or 0.0)


        finally:
            # === 7. Memory cleanup (Still important!) ===
            try: del obs_tensors, actions, returns
            except NameError: pass
            try: del logits, values, dist, action_logprobs, dist_entropy
            except NameError: pass
            try: del advantages, actor_loss, critic_loss, entropy_loss, total_loss
            except NameError: pass

            gc.collect()
            torch.cuda.empty_cache()

            # === 8. Post-step housekeeping ===
            self.buffer.clear()
            if self.lr_scheduler is not None:
                self.lr_scheduler.step() # Should this step based on shared optimizer? Depends.
            self.update_time += 1 

            # === 9. Sync Local Policy with Shared Policy ===
            # *** Add this call, mirroring A2CSolver ***
            if self.distributed_training:
                self.sync_parameters()

        # Return something if needed, e.g., the detached loss
        # return detached_total_loss

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
        
        
    def make_instance_obs(self, history_actions, encoder_obs, encoder_outputs, sub_env, rtg=None):
        # Step 1: Remove invalid actions (e.g., 100 = pad, 101 = revoke)
        filtered = [a for a in history_actions if a not in [100, 101]]
        final_history_actions = [self.start_token] + filtered[:25]

        # Step 2: Fix RTG length to match final_history_actions
        if rtg is not None:
            if len(rtg) > len(final_history_actions):
                rtg = rtg[:len(final_history_actions)]
            elif len(rtg) < len(final_history_actions):
                rtg = list(rtg) + [0.0] * (len(final_history_actions) - len(rtg))
        else:
            rtg = [0.0] * len(final_history_actions)

        obs = {
            'p_net_x': encoder_obs['p_net_x'],
            'p_net_edge_index': encoder_obs['p_net_edge_index'],
            'edge_attr': encoder_obs['edge_attr'],
            'history_actions': np.array(final_history_actions, dtype=np.int64),
            'encoder_outputs': encoder_outputs,
            'action_mask': np.expand_dims(sub_env.generate_action_mask(), axis=0),
            'rtg': np.array(rtg, dtype=np.float32).reshape(1, -1)  # Shape: (1, T)
        }
        return obs



    def solve(self, instance):
        """Inference-only solve using a greedy or sampling approach."""
        v_net, p_net = instance['v_net'], instance['p_net']
        sub_env = self.InstanceEnv(p_net, v_net, self.controller, self.recorder, self.counter,
                                preprocess_obs_fn=self.preprocess_obs, **self.basic_config)

        # Encode once
        encoder_obs = sub_env.get_observation()
        encoder_outputs = self.policy.encode(self.preprocess_encoder_obs(encoder_obs, device=self.device))

        # Start partial action sequence with <start_token>
        history_actions = [self.start_token]
        instance_done = False
        
        while not instance_done:
            instance_obs = self.make_instance_obs(history_actions, encoder_obs, encoder_outputs, sub_env)
                        
            tensor_instance_obs = self.preprocess_obs(instance_obs, device=self.device)
            tensor_instance_obs_cpu = {
                k: v.cpu() if torch.is_tensor(v) else v
                for k, v in tensor_instance_obs.items()
            }
            sub_env.prev_tensor_obs = tensor_instance_obs_cpu
 
            sub_env.prev_obs = {
                **instance_obs,
                'encoder_outputs': encoder_outputs.detach().cpu().numpy()
            }  
            action, action_logprob = self.select_action(tensor_instance_obs, sample=True) 
            next_obs, reward, instance_done, info = sub_env.step(action) 
            history_actions.append(action)
            if instance_done:
                break
            
            encoder_obs = next_obs  # Re-encode if needed
            
        return sub_env.solution

    def learn_with_instance(self, instance):
        """Collect one trajectory and store it in the buffer."""
        sub_buffer = RolloutBuffer()
        v_net, p_net = instance['v_net'], instance['p_net']
        sub_env = self.InstanceEnv(p_net, v_net, self.controller, self.recorder, self.counter,
                                preprocess_obs_fn=self.preprocess_obs, **self.basic_config)

        encoder_obs = sub_env.get_observation()
        encoder_outputs = self.policy.encode(self.preprocess_encoder_obs(encoder_obs, device=self.device))
        history_actions = [self.start_token]
        instance_done = False
         
        while not instance_done:
            #dummy first pass
            rtg_slice = [0.0] * len(history_actions)
            instance_obs = self.make_instance_obs(history_actions, encoder_obs, encoder_outputs, sub_env, rtg=rtg_slice)

            sub_env.prev_obs = {
                **instance_obs,
                'encoder_outputs': encoder_outputs.detach().cpu().numpy()
            }
              
            # Accessing InstanceRLEnv attribute -- save for when revoke -- less recalculating..
            tensor_instance_obs = self.preprocess_obs(instance_obs, device=self.device)
            tensor_instance_obs_cpu = {
                k: v.cpu() if torch.is_tensor(v) else v
                for k, v in tensor_instance_obs.items()
            }
            sub_env.prev_tensor_obs = tensor_instance_obs_cpu 
            action, action_logprob = self.select_action(tensor_instance_obs, sample=True) 
            value = self.estimate_value(tensor_instance_obs) if hasattr(self.policy, 'evaluate') else None
            
            next_obs, reward, instance_done, info = sub_env.step(action)  
            sub_buffer.add(instance_obs, action, reward, instance_done, action_logprob, value=value)
            history_actions.append(action)
            
            if not instance_done:
                encoder_obs = next_obs

        # Now compute RTG
        rtg = np.cumsum(sub_buffer.rewards[::-1])[::-1]

        # Inject correct RTG values into buffer observations
        for i, obs in enumerate(sub_buffer.observations):
            rtg_slice = rtg[:len(obs['history_actions'])]  # ← add +1 if rtg is one shorter than history
            if len(rtg_slice) < len(obs['history_actions']):
                rtg_slice = np.pad(rtg_slice, (0, 1), constant_values=0.0)

            obs['rtg'] = np.array(rtg_slice, dtype=np.float32)
                
        last_value = 0.
        if hasattr(self.policy, 'evaluate'):
            final_obs = self.make_instance_obs(history_actions, encoder_obs, encoder_outputs, sub_env, rtg=[0.0]*len(history_actions))
            final_tensor_obs = self.preprocess_obs(final_obs, device=self.device)
            last_value = self.estimate_value(final_tensor_obs)
         

        return sub_env.solution, sub_buffer, last_value
        #print(f"Last Value: {last_value}")
        #print(f"Rewards: {sub_buffer.rewards}")
        #print(f"Values: {sub_buffer.values}")

def make_policy(agent, p_dimension_features, v_dimension_features, is_revocable, is_rejection, **kwargs):
    """
    Create the ActorCritic policy with the same hyperparameters as used in pretraining.
    """
    max_seq_len = kwargs.get("max_seq_len", 15)  # Default to 15 if not specified
    action_dim = agent.p_net_setting_num_nodes  # ← this exists and is defined in RLSolver

    policy = ActorCritic(
        p_net_num_nodes=action_dim,
        p_net_feature_dim=p_dimension_features,
        v_net_feature_dim=v_dimension_features,
        embedding_dim=100,
        n_heads=5,
        n_layers=4,
        dropout=0.1,
        allow_revocable=is_revocable,
        allow_rejection=is_rejection,
        max_seq_len=max_seq_len
    ).to(agent.device) 
    
    return policy 



def encoder_obs_to_tensor(obs, device):
    """Process the v_net features for the Transformer Encoder."""
    if isinstance(obs, dict):
        # If obs['v_net_x'] is already a tensor, move it; otherwise, create one on the desired device.
        if torch.is_tensor(obs['v_net_x']):
            obs_v_net_x = obs['v_net_x'].float().to(device)
        else:
            obs_v_net_x = torch.tensor(obs['v_net_x'], dtype=torch.float32, device=device)
            
        # Make sure it's [1, T, F] instead of [T, F]
        if obs_v_net_x.dim() == 2:
            obs_v_net_x = obs_v_net_x.unsqueeze(0)  # Add batch dim
        elif obs_v_net_x.dim() != 3:
            raise ValueError(f"Expected 2D or 3D tensor, got {obs_v_net_x.dim()}D")

        return {'v_net_x': obs_v_net_x}
    elif isinstance(obs, list):
        obs_batch = [
            torch.tensor(o['v_net_x'], dtype=torch.float32, device=device)
            if not torch.is_tensor(o['v_net_x']) else o['v_net_x'].float().to(device)
            for o in obs
        ]
        obs_batch_2d = [x if x.dim() == 2 else x.unsqueeze(0) for x in obs_batch]
        padded = pad_sequence(obs_batch_2d, batch_first=True)
        return {'v_net_x': padded}
    else:
        raise Exception(f"Unrecognized type of observation {type(obs)}")

