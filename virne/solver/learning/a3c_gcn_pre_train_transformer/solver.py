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

from contextlib import nullcontext
from virne.base import Solution, SolutionStepEnvironment
from virne.solver import registry
from .instance_env import InstanceEnv
from .net import ActorCritic 

from torch.amp import autocast, GradScaler
from virne.solver.learning.rl_base.shared_adam import SharedAdam, sync_gradients
from virne.solver.learning.rl_base import RLSolver, PPOSolver, InstanceAgent, A2CSolver, RolloutBuffer

from ..utils import get_pyg_data

def apply_mask_to_logit(logit, mask=None):
        """
        Apply a mask to a given logits tensor.  Returns: masked_logit (tensor): the masked logits tensor
        """
        if mask is None:
            return logit
        # mask = torch.IntTensor(mask).to(logit.device).expand_as(logit)
        # masked_logit = logit + mask.log()
        if not isinstance(mask, torch.Tensor):
            mask = torch.BoolTensor(mask)
        
        NEG_TENSER = torch.tensor(-1e8).float()
        mask = mask.bool().to(logit.device).reshape(logit.size())
        mask_value_tensor = NEG_TENSER.type_as(logit).to(logit.device)
        masked_logit = torch.where(mask, logit, mask_value_tensor)
        return masked_logit
    
def obs_as_tensor(obs, device, pad_token=None):
    """Preprocess the entire observation into tensor form."""
    if isinstance(obs, dict):
        data = get_pyg_data(obs['p_net_x'], obs['p_net_edge_index'], obs['edge_attr'])
        obs_p_net = Batch.from_data_list([data]).to(device)
        history_feats = torch.tensor(obs['history_features'], dtype=torch.float32).unsqueeze(0).to(device)
        obs_encoder_outputs = torch.as_tensor(obs['encoder_outputs'], dtype=torch.float32, device=device)
        obs_action_mask = torch.as_tensor(obs['action_mask'], dtype=torch.float32, device=device)

        result = {
            'p_net': obs_p_net,
            'history_features': history_feats,
            'encoder_outputs': obs_encoder_outputs,
            'action_mask': obs_action_mask,
            'curr_v_node_id': torch.tensor([obs['curr_v_node_id']], dtype=torch.long, device=device),
            'vnfs_remaining': torch.tensor([obs['vnfs_remaining']], dtype=torch.long, device=device),
            'mask': None
        } 
        
        return result

    elif isinstance(obs, list):
        p_net_data_list = [get_pyg_data(o['p_net_x'], o['p_net_edge_index'], o['edge_attr']) for o in obs]
        history_feats_list = [torch.tensor(o['history_features'], dtype=torch.float32) for o in obs]
        encoder_outputs_list = [o['encoder_outputs'] for o in obs]
        action_mask_list = [o['action_mask'] for o in obs]
        curr_v_ids = [o['curr_v_node_id'] for o in obs]
        vnfs_remaining = [o['vnfs_remaining'] for o in obs]

        obs_p_net = Batch.from_data_list(p_net_data_list).to(device)
        hist_padded = pad_sequence(history_feats_list, batch_first=True).to(device)


        batch_size = len(encoder_outputs_list)
        max_seq_len = max(eo.shape[1] for eo in encoder_outputs_list)
        emb_dim = encoder_outputs_list[0].shape[2]
        enc_padded = torch.zeros((batch_size, max_seq_len, emb_dim), dtype=torch.float32, device=device)

        for i, eo in enumerate(encoder_outputs_list):
            slen = eo.shape[1]
            enc_padded[i, :slen, :] = torch.as_tensor(eo, device=device)

        action_mask_np = np.array(action_mask_list)
        act_mask_t = torch.as_tensor(action_mask_np, dtype=torch.float32, device=device)

        result = {
            'p_net': obs_p_net,
            'history_features': hist_padded,
            'encoder_outputs': enc_padded,
            'action_mask': act_mask_t,
            'curr_v_node_id': torch.tensor(curr_v_ids, dtype=torch.long, device=device),
            'vnfs_remaining': torch.tensor(vnfs_remaining, dtype=torch.long, device=device),
            'mask': None
        } 

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
        is_rejection=kwargs.get("allow_rejection"),
        use_amp=kwargs.get("use_amp"),
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
        self.max_seq_len = kwargs.get("max_seq_len", 15)
        make_policy = kwargs.pop("make_policy", policy_builder)
        obs_as_tensor_func = kwargs.pop("obs_as_tensor", obs_as_tensor )
        self.v_dimension_features = kwargs.get("v_dimension_features", None)
        self.p_dimension_features = kwargs.get("p_dimension_features", None)
        self.use_amp =  kwargs.get("use_amp", False)

        A2CSolver.__init__(  self,  controller,   recorder, counter, policy_builder,   obs_as_tensor_func,  **kwargs )
        
        self.preprocess_encoder_obs = encoder_obs_to_tensor

        InstanceAgent.__init__(self, InstanceEnv)
        
        # New hyperparameters
        self.coef_entropy_loss = kwargs.get("coef_entropy_loss", 0.1)
        self.coef_critic_loss = kwargs.get("coef_critic_loss", 0.5)
        self.normalize_advantage = kwargs.get("normalize_advantage", True)
        self.initial_temperature =    kwargs.get("initial_temperature", 2.0)
        self.temperature_decay =   kwargs.get("temperature_decay", 0.97)
        self.softmax_temp = 1.0 
 
        # Special start token (we use p_net.num_nodes as start token)
        self.start_token = self.policy.actor.decoder.start_token
        self.pad_token   = self.policy.actor.decoder.pad_token

        self.preprocess_encoder_obs = encoder_obs_to_tensor
        
        # # Retrieve pretrained RL model path (if any)
        self.rl_pretrained_path = kwargs.get("pretrained_model_path", None) 
        self.grad_accum_steps = 4  # or whatever you want
        self._grad_step = 0 
        self.num_workers
        
        
        self.use_amp = kwargs.get('use_amp', False) 
        self.scaler = GradScaler() if self.use_amp else None 
                 
    
    def select_action(self, observation, sample: bool = True):
        """
        Policy evaluation wrapper.
        Expects policy.act() to return logits that are already:
        • masked with –∞  (or the closest representable number)
        • clamped to [‑15, 15] for *valid* actions
        No further masking or clamping is performed here.
        """
        with torch.no_grad():
            raw_logits = self.policy.act(observation, training=False)  # May be float16 if AMP is on
            
        assert torch.isfinite(raw_logits).all(), "NaN or Inf detected in logits from policy.act()"
 
        # === Apply temperature and Categorical in FP32 ===
        T = 1.0
        if sample:
            epoch = getattr(self, "training_epoch_id", 0)
            T_raw = self.initial_temperature * (self.temperature_decay ** epoch)
            T = max(0.5, min(T_raw, 10.0))

        with torch.amp.autocast(device_type="cuda",enabled=False):  # Force FP32 for this part
            logits_f32 = (raw_logits / T).float()
            logits_last = logits_f32  # Already shape [B, A]
            log_probs_all = F.log_softmax(logits_last, dim=-1)  # [B, A]

            # Use softmax for stable probabilities
            probs = torch.exp(log_probs_all)

            # Sample from valid probs
            dist = Categorical(probs=probs)
            action = dist.sample() if sample else probs.argmax(dim=-1)

            # Get log-prob of chosen action
            logp = log_probs_all.gather(dim=-1, index=action.unsqueeze(-1)).squeeze(-1)

        # Final checks and return
        if not torch.isfinite(logp).all():
            logp = torch.nan_to_num(logp, nan=-20.0, neginf=-20.0, posinf=-20.0)

        if action.numel() == 1:
            return action.item(), logp.item()
        return action.cpu().numpy(), logp.cpu().numpy()
     
    # Inside A3CGcnPreTrainTransformerSolver class
    def solve(self, instance):
        phase = -1
        v_net, p_net = instance['v_net'], instance['p_net']

        instance_env = self.InstanceEnv(
            p_net, v_net,
            self.controller, self.recorder, self.counter,
            preprocess_obs_fn=self.preprocess_obs,  #   REQUIRED to support revoke()
            **self.basic_config
        )

        encoder_obs = instance_env.get_observation()
        encoder_outputs = self.policy.encode(self.preprocess_encoder_obs(encoder_obs, device=self.device))
        history_features = []

        done = False
        while not done:  
            instance_obs = self.make_instance_obs(  history_features, encoder_obs, encoder_outputs, instance_env)

            #   Cache for revoke() support
            instance_env.prev_obs = {
                **instance_obs,
                'encoder_outputs': encoder_outputs.detach().cpu().numpy()
            }

            tensor_obs = self.preprocess_obs(instance_obs, device=self.device)
            instance_env.prev_tensor_obs = {
                k: v.cpu() if torch.is_tensor(v) else v
                for k, v in tensor_obs.items()
            }

            action, action_logprob = self.select_action(tensor_obs, sample=False)
            obs, reward, done, info = instance_env.step(action)
            
            if action == self.policy.actor.decoder.num_actions - 2:
                selected_node_feats = self.policy.actor.decoder.revoke_embedding.detach().cpu().numpy()
            elif action == self.policy.actor.decoder.num_actions - 1:
                selected_node_feats = self.policy.actor.decoder.reject_embedding.detach().cpu().numpy()
            else:
                selected_node_feats = encoder_obs['p_net_x'][action]
            history_features.append(selected_node_feats)

            if not done:
                encoder_obs = obs   

        return instance_env.solution 

    
    def backward_loss(self, loss):
        if self.use_amp:
            self.scaler.scale(loss).backward()
        else:
            loss.backward()

    def optimizer_step(self, optimizer):
        if optimizer is None:
            raise ValueError("optimizer must be provided to optimizer_step.")
        if self.use_amp:
            self.scaler.step(optimizer)
            self.scaler.update()
        else:
            optimizer.step()
    
    def clip_grads(self, model, optimizer):
        if self.clip_grad:
            if self.use_amp:
                self.scaler.unscale_(optimizer)
            grads = [p.grad for p in model.parameters() if p.grad is not None]
            return torch.nn.utils.clip_grad_norm_(grads, self.max_grad_norm) if grads else torch.tensor(0.0, device=self.device)
        return torch.tensor(0.0, device=self.device)

    def zero_grads(self, model, optimizer):
        optimizer.zero_grad(set_to_none=True)
        model.zero_grad(set_to_none=True)
    
    def update(self, print_logs=False):
        """Performs memory-efficient policy update using gradient accumulation."""
        grad_accum_steps = self.grad_accum_steps
        buffer_size = self.buffer.size()

        if buffer_size == 0:
            return None, 0.0, None, None, None

        micro_batch_size = buffer_size // grad_accum_steps
        all_returns = torch.FloatTensor(self.buffer.returns).to(self.device)
        all_values = self.policy.evaluate(self.preprocess_obs(self.buffer.observations, self.device, pad_token=self.pad_token)).squeeze(-1).detach()
        all_advantages = all_returns - all_values

        if print_logs:
            print("[debug] returns mean:", all_returns.mean().item(), "values mean:", all_values.mean().item())
            print("[debug] raw advantages mean:", all_advantages.mean().item(), "std:", all_advantages.std().item())

        if self.normalize_advantage and all_advantages.numel() > 0:
            all_advantages = (all_advantages - all_advantages.mean()) / (all_advantages.std() + 1e-8)

        actor_loss_val, critic_loss_val, entropy_val = 0.0, 0.0, 0.0
        total_loss_value = 0.0

        for step in range(grad_accum_steps):
            start_idx = step * micro_batch_size
            end_idx = (step + 1) * micro_batch_size if step < grad_accum_steps - 1 else buffer_size

            obs_slice = self.buffer.observations[start_idx:end_idx]
            actions = torch.LongTensor(self.buffer.actions[start_idx:end_idx]).to(self.device)
            returns = torch.FloatTensor(self.buffer.returns[start_idx:end_idx]).to(self.device)

            obs_tensors = self.preprocess_obs(obs_slice, self.device, pad_token=self.pad_token)

            # Step 1: Network Forward Pass in AMP
            amp_ctx = torch.amp.autocast("cuda") if self.use_amp else nullcontext()
            with amp_ctx:
                logits_raw = self.policy.act(obs_tensors)
                #print("logits_raw shape before reshape:", logits_raw.shape)
                values_raw = self.policy.evaluate(obs_tensors).squeeze(-1)

            # Step 2: Distribution & Loss Calculation in FP32
            with torch.amp.autocast(device_type="cuda", enabled=False):
                logits_f32 = logits_raw.float()
                values_f32 = values_raw.float()
                advantages_f32 = all_advantages[start_idx:end_idx].float()
                returns_f32 = returns.float()

                # --- Manual Log Probability and Entropy Calculation ---
                logits_last = logits_f32[:, -1, :]  #[batch_size, num_actions]
                #logits_last = logits_last.clamp(min=-10.0, max=8.0)  # prevent sharp choices dominating
                log_probs_all = F.log_softmax(logits_last, dim=-1)  # [B, A]

                #print("log_probs_all.shape =", log_probs_all.shape)
                #print("actions.shape =", actions.shape)

                # Log probs for the chosen actions
                action_logprobs = log_probs_all.gather(dim=-1, index=actions.unsqueeze(-1)).squeeze(-1)

                # Probabilities for entropy
                probs = torch.exp(log_probs_all)

                # Entropy: -sum(p * log(p)) but guarded against 0 * -inf
                entropy_term = torch.where(probs > 0, probs * log_probs_all, torch.zeros_like(probs))
                dist_entropy = -entropy_term.sum(dim=-1)
                

                actor_loss = -(action_logprobs * advantages_f32).mean() 
                # Normalize returns to have zero mean and unit variance (optional but recommended)
                returns_f32 = (returns_f32 - returns_f32.mean()) / (returns_f32.std() + 1e-8)
                critic_loss = F.mse_loss(returns_f32, values_f32)

                entropy_loss = dist_entropy.mean()
                total_loss = actor_loss + self.coef_critic_loss * critic_loss - self.coef_entropy_loss * entropy_loss

            # Logging
            if print_logs:
                print(f"[update step {step}] actor_loss: {actor_loss.item():.4f}")
                print(f"[update step {step}] critic_loss: {critic_loss.item():.4f}")
                print(f"[update step {step}] mean logprob: {action_logprobs.mean().item():.4f}, std: {action_logprobs.std().item():.4f}")
                print(f"[update step {step}] mean advantage: {advantages_f32.mean().item():.4f}, std: {advantages_f32.std().item():.4f}")
                print(f"[update step {step}] entropy: {entropy_loss.item():.4f}")
                print(f"[update step {step}] raw logits range: min={logits_raw.min().item():.4f}, max={logits_raw.max().item():.4f}")

            # Accumulate losses
            actor_loss_val += actor_loss.item()
            critic_loss_val += critic_loss.item()
            entropy_val += entropy_loss.item()
            total_loss_value += total_loss.item()

            # Step 3: Backpropagation
            scaled_loss = total_loss / grad_accum_steps
            self.backward_loss(scaled_loss)

            # Cleanup
            gc.collect()
            torch.cuda.empty_cache()

        # Average losses
        actor_loss_val /= grad_accum_steps
        critic_loss_val /= grad_accum_steps
        entropy_val /= grad_accum_steps
        avg_total_loss = total_loss_value / grad_accum_steps

        if print_logs:
            print(f"\n[update summary] avg_actor_loss: {actor_loss_val:.4f}, avg_critic_loss: {critic_loss_val:.4f}, avg_entropy: {entropy_val:.4f}")

        grad_clipped_value = self.perform_accumulated_step_and_sync()

        self.buffer.clear()
        if self.lr_scheduler is not None:
            self.lr_scheduler.step()
        self.update_time += 1

        if self.distributed_training:
            self.sync_parameters()

        return avg_total_loss, grad_clipped_value, actor_loss_val, critic_loss_val, entropy_val

    def perform_accumulated_step_and_sync(self):
        """
        Finalizes a gradient accumulation cycle by syncing gradients,
        performing the optimizer step, updating the scaler, and zeroing gradients.
        Assumes gradients were already computed across multiple micro-batches.
        """
        grad_norm = None

        if self.distributed_training:
            if self.shared_optimizer is None or self.shared_policy is None or self.lock is None:
                raise RuntimeError(f"[Rank {self.rank}] Missing shared components in distributed mode.")

            with self.lock: # 1. Sync accumulated grads to shared policy 
                sync_gradients(self.shared_policy, self.policy)
                
                # Average gradients by dividing by num_workers
                for param in self.shared_policy.parameters():
                    if param.grad is not None:
                        param.grad.div_(self.num_workers) 
                grad_norm = self.clip_grads(self.shared_policy, self.shared_optimizer)  # 2. Clip gradients on shared policy
                self.optimizer_step(self.shared_optimizer)   # 3. Step optimizer
                self.zero_grads(self.policy, self.shared_optimizer) # 4. Clear grads

        else:
            if self.optimizer is None:
                raise RuntimeError(f"[Rank {self.rank}] Missing local optimizer in non-distributed mode.")

            grad_norm = self.clip_grads(self.policy, self.optimizer)
            self.optimizer_step(self.optimizer)
            self.zero_grads(self.policy, self.optimizer)

        if isinstance(grad_norm, torch.Tensor):
            return grad_norm.item()
        return float(grad_norm or 0.0)
    
        
        
    
    def make_instance_obs(self, history_features, encoder_obs, encoder_outputs, sub_env ):
        """
        Constructs an observation dict using the given history of physical node feature vectors.
        """
        max_len = self.max_seq_len

        # Step 1: Prepend start token to history
        start_token = self.policy.actor.decoder.start_embedding.detach().cpu().numpy()
        trimmed_history = [start_token] + history_features[:max_len - 1]  # total length will be <= max_len

        # Step 2: Pad history to max_len
        dim = len(trimmed_history[0])
        if len(trimmed_history) < max_len:
            pad = np.zeros((max_len - len(trimmed_history), dim), dtype=np.float32)
            trimmed_history = np.vstack([trimmed_history, pad])
        else:
            trimmed_history = np.vstack(trimmed_history[:max_len])
 
        obs = {
            'p_net_x': encoder_obs['p_net_x'],
            'p_net_edge_index': encoder_obs['p_net_edge_index'],
            'edge_attr': encoder_obs['edge_attr'],
            'history_features': np.array(trimmed_history, dtype=np.float32),  # 🔁 new key
            'encoder_outputs': encoder_outputs,
            'action_mask': np.expand_dims(sub_env.generate_action_mask(), axis=0), 
            'curr_v_node_id': encoder_obs['curr_v_node_id'],
            'vnfs_remaining': encoder_obs['vnfs_remaining'],
        }

        return obs
 
 
    
    def learn_with_instance(self, instance):
        """Collect one trajectory and store it in the buffer."""
        sub_buffer = RolloutBuffer()
        v_net, p_net = instance['v_net'], instance['p_net']
        
        # Curriculum logic: decide which phase we're in (5 workers = 5*5epochs = 25th epoch)
        if self.training_epoch_id < (20 / self.num_workers) :
            phase = 1 #include no special actions
            self.coef_entropy_loss = 0.2
        elif self.training_epoch_id < (40 / self.num_workers):
            phase = 2 #include revoke
            self.coef_entropy_loss = 0.1
        elif self.training_epoch_id < (60 / self.num_workers):
            phase = 3 #include reject
            self.coef_entropy_loss = 0.01
        else:
            phase = 4 #include pruning-- very slow
            self.coef_entropy_loss = 0.005
        phase = 4 #include pruning-- very slow
        self.coef_entropy_loss = 0.05
    
        sub_env = self.InstanceEnv(p_net, v_net, self.controller, self.recorder, self.counter,
                                preprocess_obs_fn=self.preprocess_obs, phase=phase, **self.basic_config)

        encoder_obs = sub_env.get_observation()
        encoder_outputs = self.policy.encode(self.preprocess_encoder_obs(encoder_obs, device=self.device))
        history_features = []  # List of [D] feature vectors
        instance_done = False
         
        while not instance_done:
            
            #dummy first pass 
            instance_obs = self.make_instance_obs(history_features, encoder_obs, encoder_outputs, sub_env )

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
            #print(f"[Loop] v_nodes placed: {len(sub_env.placed_v_net_nodes)}, action={action}, instance_done={instance_done}")

            # --- Determine which embedding to insert ---
            if action == self.policy.actor.decoder.num_actions - 2:  # revoke
                selected_node_feats = self.policy.actor.decoder.revoke_embedding.detach().cpu().numpy()
            elif action == self.policy.actor.decoder.num_actions - 1:  # reject
                selected_node_feats = self.policy.actor.decoder.reject_embedding.detach().cpu().numpy()
            else:
                selected_node_feats = encoder_obs['p_net_x'][action]

            history_features.append(selected_node_feats)

            value = self.estimate_value(tensor_instance_obs) if hasattr(self.policy, 'evaluate') else None
            
            #print(f"[Worker {self.rank}] Step begin: action={action}, num_placed={len(sub_env.placed_v_net_nodes)}")
            next_obs, reward, instance_done, info = sub_env.step(action)  
            #print(f"[Worker {self.rank}] Step done: reward={reward}, done={instance_done}")
            
            sub_buffer.add(instance_obs, action, reward, instance_done, action_logprob, value=value) 
            
            if not instance_done:
                encoder_obs = next_obs
 
        last_value = 0.
        if hasattr(self.policy, 'evaluate'):
            final_obs = self.make_instance_obs(history_features, encoder_obs, encoder_outputs, sub_env )
            final_tensor_obs = self.preprocess_obs(final_obs, device=self.device)
            last_value = self.estimate_value(final_tensor_obs)
         

        return sub_env.solution, sub_buffer, last_value

def make_policy(agent, p_dimension_features, v_dimension_features, is_revocable, is_rejection,use_amp, **kwargs):
    """
    Create the ActorCritic policy with the same hyperparameters as used in pretraining.
    """
    max_seq_len = kwargs.get("max_seq_len", 15)  # Default to 15 if not specified
    action_dim = agent.p_net_setting_num_nodes  # ← this exists and is defined in RLSolver

    policy = ActorCritic(
        p_net_num_nodes=action_dim,
        p_net_feature_dim=p_dimension_features,
        v_net_feature_dim=v_dimension_features,
        embedding_dim=128,
        n_heads=8,
        n_layers=6,
        dropout=0.2,
        allow_revocable=is_revocable,
        allow_rejection=is_rejection,
        use_amp=use_amp,
        max_seq_len=max_seq_len
    ).to(agent.device) 
    
    return policy 


def encoder_obs_to_tensor(obs, device, policy=None):
    """
    Processes the v_net_x for encoder, and injects encoder_outputs if policy is provided.
    """
    if isinstance(obs, dict):
        if torch.is_tensor(obs['v_net_x']):
            obs_v_net_x = obs['v_net_x'].float().to(device)
        else:
            obs_v_net_x = torch.tensor(obs['v_net_x'], dtype=torch.float32, device=device)

        if obs_v_net_x.dim() == 2:
            obs_v_net_x = obs_v_net_x.unsqueeze(0)
        elif obs_v_net_x.dim() != 3:
            raise ValueError(f"Expected 2D or 3D tensor, got {obs_v_net_x.dim()}D")

        # ✅ Inject encoder_outputs if possible
        if policy is not None and 'encoder_outputs' not in obs:
            with torch.no_grad():
                encoder_outputs = policy.encode({'v_net_x': obs_v_net_x})
                obs['encoder_outputs'] = encoder_outputs.detach().cpu().numpy()

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

