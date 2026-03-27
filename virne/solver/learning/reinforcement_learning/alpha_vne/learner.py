# Learner component for AlphaZero-style training
from __future__ import annotations

import json
import os
import random
from collections import OrderedDict
from typing import Dict, List, Optional, Tuple

import numpy as np
import torch
import torch.nn.functional as F
from torch_geometric.data import Batch, Data
from torch.utils.tensorboard import SummaryWriter

from .model_factory import build_actor_critic, get_model_classes, prefers_trace_torchscript
from .utils import build_model_config
from .value_target import (
    build_value_target_builder,
    infer_total_cost_from_reward,
    infer_total_revenue_from_static_env,
)


# ---------------------------------------------------------------------------
# Transition Buffer: flattens episodes into individual transitions so the
# learner samples *positions* uniformly rather than one-per-file.
# ---------------------------------------------------------------------------
class TransitionBuffer:
    """Transition-level replay index with bounded episode cache.

    Stores lightweight (episode_file, step_idx) references in-memory and keeps a
    small LRU cache of parsed episodes to avoid repeated JSON parsing.
    """

    def __init__(
        self,
        max_size: int = 200_000,
        episode_cache_size: int = 128,
        accepted_ratio: float = 0.0,
        reject_tail_ratio: float = 0.0,
        reject_tail_k: int = 2,
        recent_fraction: float = 0.0,
        recent_window_size: int = 0,
    ):
        self.max_size = max_size
        self.buffer: List[Tuple[str, int]] = []
        self._buffer_entry_seq: List[int] = []
        self._write_idx = 0
        self._next_entry_seq = 0
        self._loaded_files: set = set()
        self._episode_meta: Dict[str, dict] = {}
        self._episode_ref_counts: Dict[str, int] = {}
        self._episode_cache: "OrderedDict[str, list]" = OrderedDict()
        self._episode_cache_size = max(1, int(episode_cache_size))
        self._replay_dir: Optional[str] = None
        self._accepted_ratio = max(0.0, float(accepted_ratio))
        self._reject_tail_ratio = max(0.0, float(reject_tail_ratio))
        ratio_total = self._accepted_ratio + self._reject_tail_ratio
        if ratio_total > 1.0:
            self._accepted_ratio /= ratio_total
            self._reject_tail_ratio /= ratio_total
        self._reject_tail_k = max(1, int(reject_tail_k))
        self._recent_fraction = min(max(float(recent_fraction), 0.0), 1.0)
        self._recent_window_size = max(0, int(recent_window_size))
        self.last_sample_stats: Dict[str, float] = {
            'accepted_fraction': 0.0,
            'reject_tail_fraction': 0.0,
            'uniform_fraction': 1.0,
            'recent_fraction': 0.0,
        }

    def _cache_put(self, fname: str, trajectory: list) -> None:
        self._episode_cache[fname] = trajectory
        self._episode_cache.move_to_end(fname)
        while len(self._episode_cache) > self._episode_cache_size:
            self._episode_cache.popitem(last=False)

    def _cache_get(self, fname: str) -> Optional[list]:
        traj = self._episode_cache.get(fname)
        if traj is None:
            return None
        self._episode_cache.move_to_end(fname)
        return traj

    def _read_episode(self, episode_path: str) -> Optional[dict]:
        try:
            with open(episode_path, 'r') as f:
                return json.load(f)
        except (json.JSONDecodeError, FileNotFoundError, OSError):
            return None

    def _on_ref_added(self, fname: str) -> None:
        self._episode_ref_counts[fname] = self._episode_ref_counts.get(fname, 0) + 1

    def _on_ref_removed(self, ref: Tuple[str, int]) -> None:
        fname = ref[0]
        count = self._episode_ref_counts.get(fname, 0) - 1
        if count > 0:
            self._episode_ref_counts[fname] = count
            return
        self._episode_ref_counts.pop(fname, None)
        # If no transitions from this file remain, drop heavy parsed trajectory.
        self._episode_cache.pop(fname, None)

    def _compact_unresolvable_refs(self, current_files: set) -> None:
        if not self.buffer:
            return
        keep: List[Tuple[str, int]] = []
        keep_entry_seq: List[int] = []
        self._episode_ref_counts.clear()
        for ref, entry_seq in zip(self.buffer, self._buffer_entry_seq):
            fname = ref[0]
            if fname in current_files or fname in self._episode_cache:
                keep.append(ref)
                keep_entry_seq.append(entry_seq)
                self._episode_ref_counts[fname] = self._episode_ref_counts.get(fname, 0) + 1
        if len(keep) != len(self.buffer):
            self.buffer = keep
            self._buffer_entry_seq = keep_entry_seq
            self._write_idx = len(self.buffer) % max(1, self.max_size)

    def ingest_directory(self, replay_dir: str, limit: int = 5000) -> int:
        """Load new episode files and index all usable timestep positions.

        Returns the number of new transitions added.
        """
        self._replay_dir = replay_dir
        # Collect (filename, mtime) in one pass to avoid race conditions
        # where workers rename/delete files between listdir and sort.
        file_mtimes = []
        for f in os.listdir(replay_dir):
            if f.endswith('.json'):
                try:
                    mtime = os.path.getmtime(os.path.join(replay_dir, f))
                    file_mtimes.append((f, mtime))
                except FileNotFoundError:
                    pass  # File renamed/removed by worker between listdir and stat
        file_mtimes.sort(key=lambda x: x[1], reverse=True)
        all_files = [f for f, _ in file_mtimes]
        current_files = set(all_files)
        stale_refs_exist = any(
            (fname not in current_files and fname not in self._episode_cache)
            for fname in self._episode_ref_counts.keys()
        )
        if stale_refs_exist:
            self._compact_unresolvable_refs(current_files)

        added = 0
        for fname in all_files:
            if added >= limit:
                break
            if fname in self._loaded_files:
                continue
            episode_path = os.path.join(replay_dir, fname)
            data = self._read_episode(episode_path)
            if data is None:
                continue

            trajectory = data.get('trajectory', [])
            static_environment = data.get('static_environment')
            final_reward = data.get('final_reward', 0.0)
            final_reward_raw = data.get('final_reward_raw', final_reward)
            accepted = data.get('accepted', None)
            total_cost = data.get('total_cost', None)
            total_revenue = data.get('total_revenue', None)
            value_target = data.get('value_target', None)
            if total_revenue is None:
                total_revenue = infer_total_revenue_from_static_env(data.get('static_environment'))
            if total_cost is None and accepted is True:
                total_cost = infer_total_cost_from_reward(total_revenue, final_reward_raw)
            if not trajectory:
                continue
            valid_step_indices = []
            for step_idx, step in enumerate(trajectory):
                if step.get('observation') is None or step.get('pi') is None:
                    continue
                valid_step_indices.append(step_idx)
            if not valid_step_indices:
                self._loaded_files.add(fname)
                continue

            self._episode_meta[fname] = {
                'final_reward': final_reward,
                'final_reward_raw': final_reward_raw,
                'accepted': accepted,
                'total_cost': total_cost,
                'total_revenue': total_revenue,
                'value_target': value_target,
                'static_environment': static_environment,
                'trajectory_len': len(trajectory),
            }
            # Cache parsed trajectory now; hot recent episodes are then sampled
            # without reparsing JSON on every learner step.
            self._cache_put(fname, trajectory)

            for step_idx in valid_step_indices:
                ref = (fname, step_idx)
                entry_seq = self._next_entry_seq
                self._next_entry_seq += 1
                if len(self.buffer) < self.max_size:
                    self.buffer.append(ref)
                    self._buffer_entry_seq.append(entry_seq)
                else:
                    slot = self._write_idx % self.max_size
                    old_ref = self.buffer[slot]
                    self.buffer[slot] = ref
                    self._buffer_entry_seq[slot] = entry_seq
                    self._on_ref_removed(old_ref)
                self._on_ref_added(fname)
                self._write_idx += 1
                added += 1

            self._loaded_files.add(fname)

        # Prune tracking maps to avoid unbounded growth with cleaned replay dirs.
        self._loaded_files &= current_files
        for stale in [k for k in self._episode_meta.keys() if k not in current_files and k not in self._episode_ref_counts]:
            self._episode_meta.pop(stale, None)
            self._episode_cache.pop(stale, None)
        if len(self._loaded_files) > len(all_files) * 2:
            current_set = set(all_files)
            self._loaded_files &= current_set

        return added

    def sample(self, batch_size: int) -> List[dict]:
        if len(self.buffer) < batch_size:
            return []

        max_candidates = min(len(self.buffer), max(batch_size * 8, batch_size + 32))
        candidate_refs, sampled_recent_fraction = self._sample_candidate_refs(max_candidates=max_candidates)
        if self._accepted_ratio <= 0.0 and self._reject_tail_ratio <= 0.0:
            transitions: List[dict] = []
            for fname, step_idx in candidate_refs:
                transition = self._resolve_transition(fname, step_idx)
                if transition is None:
                    continue
                transitions.append(transition)
                if len(transitions) >= batch_size:
                    break
            if len(transitions) < batch_size:
                return []
            self.last_sample_stats = {
                'accepted_fraction': 0.0,
                'reject_tail_fraction': 0.0,
                'uniform_fraction': 1.0,
                'recent_fraction': sampled_recent_fraction,
            }
            return transitions

        accepted_bucket: List[dict] = []
        reject_tail_bucket: List[dict] = []
        uniform_bucket: List[dict] = []
        for fname, step_idx in candidate_refs:
            transition = self._resolve_transition(fname, step_idx)
            if transition is None:
                continue
            category = self._classify_ref(fname, step_idx)
            transition['_sample_bucket'] = category
            if category == 'accepted':
                accepted_bucket.append(transition)
            elif category == 'reject_tail':
                reject_tail_bucket.append(transition)
            else:
                uniform_bucket.append(transition)

        transitions = self._sample_rebalanced_batch(
            batch_size=batch_size,
            accepted_bucket=accepted_bucket,
            reject_tail_bucket=reject_tail_bucket,
            uniform_bucket=uniform_bucket,
            sampled_recent_fraction=sampled_recent_fraction,
        )
        if len(transitions) < batch_size:
            return []
        return transitions

    def _classify_ref(self, fname: str, step_idx: int) -> str:
        meta = self._episode_meta.get(fname)
        if meta is None:
            return 'uniform'
        if bool(meta.get('accepted', False)):
            return 'accepted'
        trajectory_len = int(meta.get('trajectory_len', 0))
        if trajectory_len > 0 and step_idx >= max(0, trajectory_len - self._reject_tail_k):
            return 'reject_tail'
        return 'uniform'

    def _sample_rebalanced_batch(
        self,
        batch_size: int,
        accepted_bucket: List[dict],
        reject_tail_bucket: List[dict],
        uniform_bucket: List[dict],
        sampled_recent_fraction: float,
    ) -> List[dict]:
        accepted_target = min(len(accepted_bucket), int(round(batch_size * self._accepted_ratio)))
        reject_tail_target = min(len(reject_tail_bucket), int(round(batch_size * self._reject_tail_ratio)))

        selected: List[dict] = []
        if accepted_target > 0:
            selected.extend(random.sample(accepted_bucket, accepted_target))
        if reject_tail_target > 0:
            selected.extend(random.sample(reject_tail_bucket, reject_tail_target))

        remaining = max(0, batch_size - len(selected))
        remainder_pool = uniform_bucket[:]
        remainder_pool.extend(item for item in accepted_bucket if item not in selected)
        remainder_pool.extend(item for item in reject_tail_bucket if item not in selected)
        if remaining > 0 and remainder_pool:
            take = min(remaining, len(remainder_pool))
            selected.extend(random.sample(remainder_pool, take))

        if len(selected) >= batch_size:
            selected = selected[:batch_size]

        total = max(len(selected), 1)
        accepted_hits = sum(1 for t in selected if t.get('_sample_bucket') == 'accepted')
        reject_tail_hits = sum(1 for t in selected if t.get('_sample_bucket') == 'reject_tail')
        uniform_hits = max(0, len(selected) - accepted_hits - reject_tail_hits)
        self.last_sample_stats = {
            'accepted_fraction': accepted_hits / total,
            'reject_tail_fraction': reject_tail_hits / total,
            'uniform_fraction': uniform_hits / total,
            'recent_fraction': sampled_recent_fraction,
        }
        random.shuffle(selected)
        return selected

    def _sample_candidate_refs(self, max_candidates: int) -> Tuple[List[Tuple[str, int]], float]:
        if self._recent_fraction <= 0.0 or self._recent_window_size <= 0 or not self._buffer_entry_seq:
            return random.sample(self.buffer, max_candidates), 0.0

        newest_entry_seq = max(self._buffer_entry_seq)
        cutoff = newest_entry_seq - self._recent_window_size + 1
        recent_refs = [
            ref for ref, entry_seq in zip(self.buffer, self._buffer_entry_seq)
            if entry_seq >= cutoff
        ]
        if not recent_refs:
            return random.sample(self.buffer, max_candidates), 0.0

        recent_target = min(len(recent_refs), int(round(max_candidates * self._recent_fraction)))
        global_target = max_candidates - recent_target

        selected: List[Tuple[str, int]] = []
        selected_set = set()
        recent_set = set(recent_refs)
        if recent_target > 0:
            recent_selected = random.sample(recent_refs, recent_target)
            selected.extend(recent_selected)
            selected_set.update(recent_selected)

        if global_target > 0:
            remaining_pool = [ref for ref in self.buffer if ref not in selected_set]
            if len(remaining_pool) < global_target:
                remaining_pool = self.buffer[:]
            global_selected = random.sample(remaining_pool, min(global_target, len(remaining_pool)))
            selected.extend(global_selected)
            selected_set.update(global_selected)

        if len(selected) < max_candidates:
            remainder = [ref for ref in self.buffer if ref not in selected_set]
            if remainder:
                take = min(max_candidates - len(selected), len(remainder))
                remainder_selected = random.sample(remainder, take)
                selected.extend(remainder_selected)
                selected_set.update(remainder_selected)

        if not selected:
            return [], 0.0

        unique_selected: List[Tuple[str, int]] = []
        seen = set()
        for ref in selected:
            if ref in seen:
                continue
            seen.add(ref)
            unique_selected.append(ref)
            if len(unique_selected) >= max_candidates:
                break

        if len(unique_selected) < max_candidates:
            for ref in self.buffer:
                if ref in seen:
                    continue
                unique_selected.append(ref)
                seen.add(ref)
                if len(unique_selected) >= max_candidates:
                    break

        recent_selected = sum(1 for ref in unique_selected if ref in recent_set)
        return unique_selected[:max_candidates], (recent_selected / max(len(unique_selected), 1))

    def _resolve_transition(self, fname: str, step_idx: int) -> Optional[dict]:
        meta = self._episode_meta.get(fname)
        if meta is None:
            return None

        trajectory = self._cache_get(fname)
        if trajectory is None:
            if not self._replay_dir:
                return None
            episode_path = os.path.join(self._replay_dir, fname)
            data = self._read_episode(episode_path)
            if data is None:
                return None
            trajectory = data.get('trajectory', [])
            if not trajectory:
                return None
            self._cache_put(fname, trajectory)

        if step_idx < 0 or step_idx >= len(trajectory):
            return None
        step = trajectory[step_idx]
        obs = step.get('observation')
        pi = step.get('pi')
        if obs is None or pi is None:
            return None

        return {
            'observation': obs,
            'pi': pi,
            'mask': step.get('mask'),
            'step_idx': step_idx,
            'final_reward': meta.get('final_reward', 0.0),
            'final_reward_raw': meta.get('final_reward_raw', 0.0),
            'accepted': meta.get('accepted', None),
            'total_cost': meta.get('total_cost', None),
            'total_revenue': meta.get('total_revenue', None),
            'value_target': meta.get('value_target', None),
            'static_environment': meta.get('static_environment', None),
            'trajectory_len': meta.get('trajectory_len', 0),
        }

    def __len__(self):
        return len(self.buffer)


class AlphaZeroLearner:
    """Learner that trains on trajectories generated by actors."""

    def __init__(self, controller, recorder, counter, logger, config,
                 replay_dir: str = None, models_dir: str = None,
                 device: torch.device | None = None, batch_size: int = 32):
        self.controller = controller
        self.recorder = recorder
        self.counter = counter
        self.logger = logger
        self.config = config

        # Use provided directories or fallback to default
        self.replay_dir = replay_dir if replay_dir else "replay_buffer"
        self.batch_size = batch_size

        # Policy path should be in models directory, not replay buffer
        if models_dir:
            self.policy_path = os.path.join(models_dir, "policy_latest.pt")
        else:
            self.policy_path = os.path.join(self.replay_dir, "policy_latest.pt")

        os.makedirs(os.path.dirname(self.policy_path), exist_ok=True)
        os.makedirs(self.replay_dir, exist_ok=True)

        # Respect training.use_cuda and use spawn-safe init
        use_cuda_cfg = getattr(getattr(config, 'training', {}), 'use_cuda', True)
        if device is not None:
            self.device = device
        else:
            self.device = torch.device("cuda" if (use_cuda_cfg and torch.cuda.is_available()) else "cpu")
        self.model_config = build_model_config(config)
        self.policy = build_actor_critic(self.model_config).to(self.device)
        configured_mode = str(getattr(config.training, "value_target_mode", "tanh")).lower()
        self.value_target_mode = configured_mode

        # Load pretrained weights if specified
        model_loaded = False
        loaded_ckpt = None
        alphazero_model_path = getattr(config.training, 'alphazero_model_path', '')
        resume_training = getattr(config.training, 'resume_training', True)

        # Priority 1: Specific model path
        if alphazero_model_path and os.path.exists(alphazero_model_path):
            self.policy.load_state_dict(torch.load(alphazero_model_path, map_location=self.device))
            logger.info(f"Loaded AlphaZero model from: {alphazero_model_path}")
            model_loaded = True
        # Priority 2: Resume from latest policy
        elif resume_training and os.path.exists(self.policy_path):
            # Prefer full checkpoint if available
            ckpt_full = os.path.join(os.path.dirname(self.policy_path), 'policy_latest_full.pt')
            if os.path.exists(ckpt_full):
                try:
                    ckpt = torch.load(ckpt_full, map_location=self.device)
                    self.policy.load_state_dict(ckpt['model'])
                    loaded_ckpt = ckpt
                    logger.info(f"Resumed training from: {ckpt_full}")
                    model_loaded = True
                except Exception as e:
                    logger.warning(f"Failed to load full ckpt, falling back to weights-only: {e}")
            if not model_loaded:
                self.policy.load_state_dict(torch.load(self.policy_path, map_location=self.device))
                logger.info(f"Resumed training from: {self.policy_path}")
                model_loaded = True

        if not model_loaded:
            logger.info("Starting training from scratch (no pretrained model loaded)")
        try:
            logger.info(f"Learner device: {self.device}, cuda.is_available={torch.cuda.is_available()}")
            if self.device.type == 'cuda':
                mem_alloc = torch.cuda.memory_allocated(self.device)
                mem_res = torch.cuda.memory_reserved(self.device)
                logger.info(f"Learner CUDA memory: alloc={mem_alloc/1e6:.1f}MB reserved={mem_res/1e6:.1f}MB")
        except Exception:
            pass

        learning_rate = getattr(config.training, 'policy_learning_rate', 1e-4)
        self.optimizer = torch.optim.Adam(self.policy.parameters(), lr=learning_rate)

        self.value_target_builder = build_value_target_builder(self.value_target_mode, config.training)
        # If we loaded a full checkpoint, restore optimizer state
        try:
            if resume_training:
                ckpt_full = os.path.join(os.path.dirname(self.policy_path), 'policy_latest_full.pt')
                ckpt = loaded_ckpt
                if ckpt is None and os.path.exists(ckpt_full):
                    ckpt = torch.load(ckpt_full, map_location=self.device)
                if ckpt is not None:
                    if 'optimizer' in ckpt:
                        self.optimizer.load_state_dict(ckpt['optimizer'])
                        logger.info("Optimizer state restored from latest full checkpoint")
                    if 'value_target_builder' in ckpt:
                        self.value_target_builder.load_state_dict(ckpt['value_target_builder'])
                        logger.info("Value target builder state restored")
        except Exception as e:
            logger.warning(f"Failed to restore optimizer state: {e}")

        # Transition-level replay index + bounded episode cache.
        buffer_max = getattr(config.training, 'transition_buffer_max_size', 200_000)
        episode_cache_size = getattr(config.training, 'episode_cache_size', 128)
        replay_sample_accepted_ratio = getattr(config.training, 'replay_sample_accepted_ratio', 0.5)
        replay_sample_reject_tail_ratio = getattr(config.training, 'replay_sample_reject_tail_ratio', 0.25)
        replay_reject_tail_k = getattr(config.training, 'replay_reject_tail_k', 2)
        replay_recent_fraction = getattr(config.training, 'replay_recent_fraction', 0.75)
        replay_recent_window_size = getattr(config.training, 'replay_recent_window_size', 25000)
        self.transition_buffer = TransitionBuffer(
            max_size=buffer_max,
            episode_cache_size=episode_cache_size,
            accepted_ratio=replay_sample_accepted_ratio,
            reject_tail_ratio=replay_sample_reject_tail_ratio,
            reject_tail_k=replay_reject_tail_k,
            recent_fraction=replay_recent_fraction,
            recent_window_size=replay_recent_window_size,
        )

        # TensorBoard logging
        from virne.utils.config import get_run_id_dir
        tb_log_dir = os.path.join(get_run_id_dir(config), "logs")
        self.writer = SummaryWriter(tb_log_dir)
        self.global_step = 0
        self._warned_ts_trace_fallback = False

    # ------------------------------------------------------------------
    def train_steps(self, num_steps: int) -> None:
        self.policy.train()
        save_interval = getattr(self.config.training, 'save_interval', 10)
        log_interval = getattr(self.config.training, 'log_interval', 1)
        keep_step_checkpoints = getattr(self.config.training, 'save_checkpoint_history', False)

        epoch_losses = {'policy': [], 'value': [], 'total': []}

        guaranteed_save_step = getattr(self.config.training, 'guaranteed_save_step', 50)
        throttle_ms = getattr(self.config.training, 'learner_throttle_ms', 0)

        # Ingest new episodes into transition buffer before training
        new_transitions = self.transition_buffer.ingest_directory(self.replay_dir)
        if new_transitions > 0:
            self.logger.info(f"Ingested {new_transitions} new transitions (buffer size: {len(self.transition_buffer)})")

        for step in range(num_steps):
            batch = self._load_and_prepare_batch()
            if batch is None:
                self.logger.warning("Replay buffer is not large enough to start training. Skipping step.")
                break

            batch_obs, batch_policies, batch_values, batch_masks = batch

            # Keep learner-side policy logits unscaled; actor-side action-selection
            # temperature controls exploration during data generation.
            self.policy.temperature = 1.0

            self.optimizer.zero_grad()

            # Use unified forward: shared backbone runs ONCE (Task 1)
            predicted_logits, predicted_values_raw = self.policy.act_and_evaluate(batch_obs)
            predicted_values = predicted_values_raw.squeeze()

            # AlphaZero policy loss: -sum(pi * log_softmax(logits))
            log_probs = F.log_softmax(predicted_logits, dim=-1)

            if batch_masks is not None:
                masked_log_probs = log_probs * batch_masks
                loss_policy = -(batch_policies * masked_log_probs).sum(dim=-1).mean()
            else:
                loss_policy = -(batch_policies * log_probs).sum(dim=-1).mean()

            # Value loss: MSE on configured value targets.
            loss_value = F.mse_loss(predicted_values, batch_values)

            # L2 regularization
            l2_weight = getattr(self.config.training, 'l2_weight', 1e-4)
            l2_reg = sum(p.pow(2).sum() for p in self.policy.parameters())

            total_loss = loss_policy + loss_value + l2_weight * l2_reg

            total_loss.backward()

            grad_norm = torch.nn.utils.clip_grad_norm_(self.policy.parameters(), max_norm=1.0)

            self.optimizer.step()
            self.global_step += 1

            # Store losses for epoch summary
            epoch_losses['policy'].append(loss_policy.item())
            epoch_losses['value'].append(loss_value.item())
            epoch_losses['total'].append(total_loss.item())

            # TensorBoard logging
            if self.global_step % log_interval == 0:
                self.writer.add_scalar('Loss/Policy', loss_policy.item(), self.global_step)
                self.writer.add_scalar('Loss/Value', loss_value.item(), self.global_step)
                self.writer.add_scalar('Loss/L2', (l2_weight * l2_reg).item(), self.global_step)
                self.writer.add_scalar('Loss/Total', total_loss.item(), self.global_step)
                self.writer.add_scalar('Training/GradNorm', grad_norm.item(), self.global_step)
                self.writer.add_scalar('Training/LearningRate', self.optimizer.param_groups[0]['lr'], self.global_step)
                self.writer.add_scalar('Training/BufferSize', len(self.transition_buffer), self.global_step)
                sample_stats = getattr(self.transition_buffer, 'last_sample_stats', {})
                if sample_stats:
                    self.writer.add_scalar(
                        'Replay/AcceptedFraction',
                        float(sample_stats.get('accepted_fraction', 0.0)),
                        self.global_step,
                    )
                    self.writer.add_scalar(
                        'Replay/RejectTailFraction',
                        float(sample_stats.get('reject_tail_fraction', 0.0)),
                        self.global_step,
                    )
                    self.writer.add_scalar(
                        'Replay/UniformFraction',
                        float(sample_stats.get('uniform_fraction', 1.0)),
                        self.global_step,
                    )
                    self.writer.add_scalar(
                        'Replay/RecentFraction',
                        float(sample_stats.get('recent_fraction', 0.0)),
                        self.global_step,
                    )
                accepted_cost_min = getattr(self.value_target_builder, 'accepted_cost_min', None)
                accepted_cost_max = getattr(self.value_target_builder, 'accepted_cost_max', None)
                if accepted_cost_min is not None:
                    self.writer.add_scalar(
                        'Training/AcceptedCostMin',
                        float(accepted_cost_min),
                        self.global_step,
                    )
                if accepted_cost_max is not None:
                    self.writer.add_scalar(
                        'Training/AcceptedCostMax',
                        float(accepted_cost_max),
                        self.global_step,
                    )

                pred_actions = predicted_logits.argmax(dim=-1)
                target_actions = batch_policies.argmax(dim=-1)
                policy_accuracy = (pred_actions == target_actions).float().mean()
                self.writer.add_scalar('Accuracy/Policy', policy_accuracy.item(), self.global_step)
                try:
                    if self.device.type == 'cuda':
                        mem_alloc = torch.cuda.memory_allocated(self.device)
                        mem_res = torch.cuda.memory_reserved(self.device)
                        mem_str = f" cuda_mem={mem_alloc/1e6:.1f}/{mem_res/1e6:.1f}MB"
                    else:
                        mem_str = ""
                except Exception:
                    mem_str = ""
                self.logger.info(
                    f"Learner Step {self.global_step}: policy_acc={policy_accuracy.item():.3f} "
                    f"loss_p={loss_policy.item():.4f} loss_v={loss_value.item():.4f}{mem_str}"
                )

            # Save model periodically
            if (step + 1) % save_interval == 0:
                self._save_model_atomically()
                self._save_full_checkpoint()
                if keep_step_checkpoints:
                    self._save_full_checkpoint(step=self.global_step)
                avg_policy_loss = sum(epoch_losses['policy'][-save_interval:]) / min(save_interval, len(epoch_losses['policy']))
                avg_value_loss = sum(epoch_losses['value'][-save_interval:]) / min(save_interval, len(epoch_losses['value']))
                self.logger.info(f"Learner Step {self.global_step}: Policy={avg_policy_loss:.4f}, Value={avg_value_loss:.4f}")
                try:
                    cal = self._eval_calibration(n_samples=128)
                    if cal is not None:
                        self.logger.info(f"Calibration: corr={cal['corr']:.3f} MAE={cal['mae']:.3f} ECE={cal['ece']:.3f}")
                        self.writer.add_scalar('Calib/Corr', cal['corr'], self.global_step)
                        self.writer.add_scalar('Calib/MAE', cal['mae'], self.global_step)
                        self.writer.add_scalar('Calib/ECE', cal['ece'], self.global_step)
                except Exception as e:
                    self.logger.debug(f"Calibration eval failed: {e}")
            # Guaranteed early checkpoint
            if self.global_step == guaranteed_save_step:
                try:
                    self._save_full_checkpoint(step=guaranteed_save_step)
                    self._save_model_atomically()
                    self.logger.info(f"Saved guaranteed checkpoint at step {guaranteed_save_step}")
                except Exception as e:
                    self.logger.warning(f"Failed to save guaranteed checkpoint: {e}")
            if throttle_ms and throttle_ms > 0:
                import time
                time.sleep(throttle_ms / 1000.0)

        # Always save at the end and return summary stats
        self._save_model_atomically()
        self._save_full_checkpoint()
        if keep_step_checkpoints:
            self._save_full_checkpoint(step=self.global_step)

        if epoch_losses['policy']:
            return {
                'avg_policy_loss': sum(epoch_losses['policy']) / len(epoch_losses['policy']),
                'avg_value_loss': sum(epoch_losses['value']) / len(epoch_losses['value']),
                'avg_total_loss': sum(epoch_losses['total']) / len(epoch_losses['total']),
                'num_training_steps': len(epoch_losses['policy'])
            }
        return None

    def _model_sha256(self) -> str:
        import hashlib
        h = hashlib.sha256()
        with torch.no_grad():
            for n, p in self.policy.state_dict().items():
                h.update(n.encode()); h.update(p.detach().cpu().numpy().tobytes())
        return h.hexdigest()

    def _atomic_rename(self, tmp_path: str, final_path: str):
        os.replace(tmp_path, final_path)

    def _save_model_atomically(self):
        """Save model weights only (for actors), atomically."""
        state = self.policy.state_dict()
        tmp = self.policy_path + '.tmp'
        torch.save(state, tmp)
        self._atomic_rename(tmp, self.policy_path)
        try:
            self._export_torchscript()
        except Exception as e:
            self.logger.warning(f"Failed to export TorchScript policy: {e}")

    def _save_full_checkpoint(self, step: int = None):
        """Save full checkpoint (model+optimizer+meta) with step in filename, atomically."""
        ckpt_dir = os.path.dirname(self.policy_path)
        sha = self._model_sha256()
        meta = {
            'model': self.policy.state_dict(),
            'optimizer': self.optimizer.state_dict(),
            'global_step': self.global_step,
            'sha256': sha,
            'value_target_mode': self.value_target_mode,
            'value_target_builder': self.value_target_builder.state_dict(),
        }
        if step is None:
            fname = os.path.join(ckpt_dir, 'policy_latest_full.pt')
        else:
            fname = os.path.join(ckpt_dir, f'policy_step_{int(step):05d}.pt')
        tmp = fname + '.tmp'
        torch.save(meta, tmp)
        self._atomic_rename(tmp, fname)

    def _export_torchscript(self):
        """Export a TorchScript model for C++ inference."""
        ts_path = os.path.join(os.path.dirname(self.policy_path), "policy_latest.ts")
        tmp = f"{ts_path}.tmp.{os.getpid()}"
        mode_path = f"{ts_path}.mode"
        mode_tmp = f"{mode_path}.tmp.{os.getpid()}"

        training_cfg = getattr(self.config, "training", None)
        use_cuda_cfg = True
        if isinstance(training_cfg, dict):
            use_cuda_cfg = bool(training_cfg.get("use_cuda", True))
        elif training_cfg is not None and hasattr(training_cfg, "use_cuda"):
            use_cuda_cfg = bool(getattr(training_cfg, "use_cuda"))

        if use_cuda_cfg:
            if torch.cuda.is_available():
                export_device = torch.device("cuda")
            else:
                export_device = torch.device("cpu")
                if self.logger is not None:
                    self.logger.warning(
                        "training.use_cuda=true but CUDA is unavailable; falling back to CPU for TorchScript export."
                    )
        else:
            export_device = torch.device("cpu")

        model = build_actor_critic(self.model_config).to(export_device)
        model.load_state_dict(self.policy.state_dict())
        model.eval()
        _, ActorCriticScriptWrapper = get_model_classes(self.model_config)
        wrapper = ActorCriticScriptWrapper(model).to(export_device)
        wrapper.eval()

        force_trace = prefers_trace_torchscript(self.model_config)
        used_trace = force_trace
        export_succeeded = False
        script_exc = None
        if not force_trace:
            try:
                scripted = torch.jit.script(wrapper)
                scripted.save(tmp)
                export_succeeded = True
            except Exception as exc:
                script_exc = exc
                used_trace = True
        if used_trace and not export_succeeded:
            num_nodes = self.model_config['p_net_num_nodes']
            p_feat = self.model_config['p_net_feature_dim']
            p_edge_feat = self.model_config['p_net_edge_dim']
            max_seq_len = self.model_config.get('max_seq_len', 15)

            p_net_x = torch.zeros((num_nodes, p_feat), dtype=torch.float32, device=export_device)
            edge_index = torch.zeros((2, max(1, num_nodes - 1)), dtype=torch.long, device=export_device)
            edge_attr = torch.zeros((edge_index.size(1), p_edge_feat), dtype=torch.float32, device=export_device)
            p_batch = torch.zeros((num_nodes,), dtype=torch.long, device=export_device)
            selected_p_nodes = torch.zeros((0,), dtype=torch.long, device=export_device)
            encoder_outputs = torch.zeros(
                (1, max_seq_len, model.backbone.embedding_dim), dtype=torch.float32, device=export_device
            )
            curr_v_node_id = torch.zeros((1,), dtype=torch.long, device=export_device)
            vnfs_remaining = torch.zeros((1,), dtype=torch.long, device=export_device)
            action_mask = torch.ones((1, model._policy_head.num_actions), dtype=torch.bool, device=export_device)
            candidate_features = torch.zeros(
                (1, model._policy_head.num_actions, model._policy_head.candidate_feature_dim),
                dtype=torch.float32,
                device=export_device,
            )
            history_features = torch.zeros((1, 1, p_feat), dtype=torch.float32, device=export_device)
            history_lengths = torch.tensor([1], dtype=torch.long, device=export_device)

            example = {
                "p_net_x": p_net_x,
                "p_net_edge_index": edge_index,
                "p_net_edge_attr": edge_attr,
                "p_net_batch": p_batch,
                "selected_p_nodes": selected_p_nodes,
                "history_features": history_features,
                "history_lengths": history_lengths,
                "encoder_outputs": encoder_outputs,
                "curr_v_node_id": curr_v_node_id,
                "vnfs_remaining": vnfs_remaining,
                "action_mask": action_mask,
                "candidate_features": candidate_features,
            }
            try:
                scripted = torch.jit.trace(wrapper, example, check_trace=False)
                scripted.save(tmp)
                export_succeeded = True
                if (
                    script_exc is not None
                    and self.logger is not None
                    and not self._warned_ts_trace_fallback
                ):
                    self.logger.warning(f"TorchScript script export failed; using trace fallback: {script_exc}")
                    self._warned_ts_trace_fallback = True
            except Exception as trace_exc:
                if self.logger is not None:
                    if script_exc is None:
                        self.logger.warning(
                            f"TorchScript trace export failed; keeping previous .ts if present. "
                            f"trace_error={trace_exc}"
                        )
                    else:
                        self.logger.warning(
                            f"TorchScript export failed (script and trace); keeping previous .ts if present. "
                            f"script_error={script_exc}; trace_error={trace_exc}"
                        )
                return

        if not export_succeeded:
            return

        mode = "trace" if used_trace else "script"
        with open(mode_tmp, "w", encoding="ascii") as f:
            f.write(mode)
        self._atomic_rename(tmp, ts_path)
        self._atomic_rename(mode_tmp, mode_path)

    def _obs_to_device(self, obs: dict) -> dict:
        """Convert observation tensors from CPU to target device."""
        obs_device = {}
        for key, value in obs.items():
            if key == 'p_net' and isinstance(value, dict):
                data = Data(
                    x=torch.tensor(value['x'], dtype=torch.float32),
                    edge_index=torch.tensor(value['edge_index'], dtype=torch.long),
                    edge_attr=torch.tensor(value['edge_attr'], dtype=torch.float32) if value.get('edge_attr') is not None else None,
                )
                obs_device[key] = data.to(self.device)
            elif isinstance(value, list):
                if key in ('curr_v_node_id', 'vnfs_remaining', 'history_lengths'):
                    tensor = torch.tensor(value, dtype=torch.long)
                elif key == 'action_mask':
                    tensor = torch.tensor(value, dtype=torch.bool)
                else:
                    tensor = torch.tensor(value, dtype=torch.float32)
                obs_device[key] = tensor.to(self.device)
            elif isinstance(value, torch.Tensor):
                obs_device[key] = value.to(self.device)
            else:
                obs_device[key] = value
        return obs_device

    # ------------------------------------------------------------------
    def _load_and_prepare_batch(self):
        """Load and prepare a batch from the flattened transition buffer."""
        # Try to top up the transition buffer with new episodes
        self.transition_buffer.ingest_directory(self.replay_dir, limit=2000)

        if len(self.transition_buffer) >= self.batch_size:
            return self._prepare_batch_from_buffer()

        return None

    def _prepare_batch_from_buffer(self):
        """Sample transitions from the in-memory buffer and assemble a batch."""
        transitions = self.transition_buffer.sample(self.batch_size)
        if not transitions:
            return None

        obs_list: List[dict] = []
        batch_policies = []
        batch_values_target = []
        batch_masks = []

        for t in transitions:
            obs = t['observation']
            pi = t['pi']
            mask = t.get('mask')

            if obs is None or pi is None:
                continue

            obs_gpu = self._obs_to_device(obs)
            obs_list.append(obs_gpu)
            batch_policies.append(torch.tensor(pi, dtype=torch.float32))

            explicit_target = t.get('value_target', None)
            if explicit_target is not None:
                try:
                    target = float(explicit_target)
                except Exception:
                    target = None
            else:
                target = None

            raw_reward = t.get('final_reward_raw', t.get('final_reward', 0.0))
            accepted_field = t.get('accepted', None)
            if accepted_field is None:
                accepted = float(raw_reward) > 0.0
            else:
                accepted = bool(accepted_field)

            total_cost = t.get('total_cost', None)
            total_revenue = t.get('total_revenue', None)
            if total_revenue is None:
                total_revenue = infer_total_revenue_from_static_env(t.get('static_environment'))
            if total_cost is None and accepted:
                total_cost = infer_total_cost_from_reward(total_revenue, raw_reward)

            if target is None:
                target = self.value_target_builder.compute_target(
                    accepted=accepted,
                    total_cost=total_cost,
                    total_revenue=total_revenue,
                    raw_reward=raw_reward,
                    update_stats=True,
                )
            elif accepted and total_cost is not None:
                self.value_target_builder.update_cost_stats(total_cost)
            batch_values_target.append(float(target))

            if mask is not None:
                batch_masks.append(torch.tensor(mask, dtype=torch.float32))
            else:
                batch_masks.append(None)

        if not obs_list:
            return None

        final_values = torch.tensor(batch_values_target, dtype=torch.float32)

        return self._collate_batch(obs_list, batch_policies, final_values, batch_masks)

    def _collate_batch(self, obs_list, batch_policies, batch_values, batch_masks):
        """Collate individual observations into a batched tensor dict."""
        candidate_feature_dim = int(getattr(self.policy._policy_head, 'candidate_feature_dim', 8))

        def ensure_candidate_features(obs: dict) -> dict:
            if 'candidate_features' in obs:
                return obs
            obs = dict(obs)
            action_mask = obs.get('action_mask')
            if isinstance(action_mask, torch.Tensor):
                batch_dim = int(action_mask.size(0)) if action_mask.dim() > 1 else 1
                num_actions = int(action_mask.size(-1))
                device = action_mask.device
            else:
                batch_dim = 1
                num_actions = int(getattr(self.policy._policy_head, 'num_actions', 0))
                device = self.device
            obs['candidate_features'] = torch.zeros(
                (batch_dim, num_actions, candidate_feature_dim),
                dtype=torch.float32,
                device=device,
            )
            return obs

        if len(obs_list) == 1:
            batch_obs = ensure_candidate_features(obs_list[0])
            if 'history_lengths' not in batch_obs and 'history_features' in batch_obs:
                batch_obs = dict(batch_obs)
                batch_obs['history_lengths'] = torch.tensor(
                    [int(batch_obs['history_features'].size(1))],
                    dtype=torch.long,
                    device=self.device,
                )
        else:
            obs_list = [ensure_candidate_features(obs) for obs in obs_list]
            p_net_batch = Batch.from_data_list([o['p_net'] for o in obs_list]).to(self.device)

            def pad_cat_3d(ts_list):
                lengths = [t.size(1) for t in ts_list]
                T_max = max(lengths)
                out = []
                for t in ts_list:
                    if t.size(1) < T_max:
                        pad_T = T_max - t.size(1)
                        t = torch.nn.functional.pad(t, (0, 0, 0, pad_T, 0, 0))
                    out.append(t)
                return torch.cat(out, dim=0)

            hist = pad_cat_3d([o['history_features'] for o in obs_list]).to(self.device)
            enc = pad_cat_3d([o['encoder_outputs'] for o in obs_list]).to(self.device)
            hist_lengths = torch.tensor(
                [int(o['history_features'].size(1)) for o in obs_list],
                dtype=torch.long,
                device=self.device,
            )
            curr = torch.cat([o['curr_v_node_id'] for o in obs_list], dim=0).to(self.device)
            remain = torch.cat([o['vnfs_remaining'] for o in obs_list], dim=0).to(self.device)
            mask = torch.cat([o['action_mask'] for o in obs_list], dim=0).to(self.device)
            candidate_features = torch.cat([o['candidate_features'] for o in obs_list], dim=0).to(self.device)
            v_x = pad_cat_3d([o['v_net_x'] for o in obs_list]).to(self.device)

            batch_obs = {
                'p_net': p_net_batch,
                'history_features': hist,
                'history_lengths': hist_lengths,
                'encoder_outputs': enc,
                'curr_v_node_id': curr,
                'vnfs_remaining': remain,
                'action_mask': mask,
                'candidate_features': candidate_features,
                'v_net_x': v_x,
            }

        policies = torch.stack(batch_policies).to(self.device)
        values = batch_values.to(self.device)

        if all(m is not None for m in batch_masks):
            masks = torch.stack(batch_masks).to(self.device)
        else:
            masks = None

        return batch_obs, policies, values, masks

    def _eval_calibration(self, n_samples: int = 128):
        """Compute correlation, MAE, and a simple ECE on random replay positions."""
        self.transition_buffer.ingest_directory(self.replay_dir, limit=2000)
        if len(self.transition_buffer) == 0:
            return None
        transitions = self.transition_buffer.sample(min(len(self.transition_buffer), n_samples))
        if not transitions:
            return None
        preds = []
        targets = []
        for t in transitions:
            try:
                obs = t.get('observation')
                if obs is None:
                    continue
                obs_gpu = self._obs_to_device(obs)
                with torch.no_grad():
                    pv = self.policy.evaluate(obs_gpu).squeeze().detach().cpu().item()
                raw_reward = t.get('final_reward_raw', t.get('final_reward', 0.0))
                explicit_target = t.get('value_target', None)
                accepted_field = t.get('accepted', None)
                accepted = bool(accepted_field) if accepted_field is not None else float(raw_reward) > 0.0
                total_cost = t.get('total_cost', None)
                total_revenue = t.get('total_revenue', None)
                if total_revenue is None:
                    total_revenue = infer_total_revenue_from_static_env(t.get('static_environment'))
                if total_cost is None and accepted:
                    total_cost = infer_total_cost_from_reward(total_revenue, raw_reward)
                if explicit_target is not None:
                    z = float(explicit_target)
                else:
                    z = float(
                        self.value_target_builder.compute_target(
                            accepted=accepted,
                            total_cost=total_cost,
                            total_revenue=total_revenue,
                            raw_reward=raw_reward,
                            update_stats=False,
                        )
                    )
                preds.append(pv)
                targets.append(z)
            except Exception:
                continue
        if len(preds) < 5:
            return None
        preds = np.array(preds, dtype=np.float64)
        targets = np.array(targets, dtype=np.float64)
        pcorr = float(np.corrcoef(preds, targets)[0,1]) if preds.std() > 1e-8 and targets.std() > 1e-8 else float('nan')
        mae = float(np.mean(np.abs(preds - targets)))
        bins = np.linspace(preds.min(), preds.max() + 1e-8, 11)
        ece = 0.0
        total = len(preds)
        for i in range(10):
            m = (preds >= bins[i]) & (preds < bins[i+1])
            if m.sum() == 0:
                continue
            e_bin = float(np.abs(preds[m].mean() - targets[m].mean()))
            ece += (m.sum() / total) * e_bin
        return {'corr': pcorr, 'mae': mae, 'ece': float(ece)}
