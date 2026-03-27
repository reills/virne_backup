"""
GPU Batch Worker for AlphaZero MCTS (spawn-safe)
===============================================

This module implements a batched GPU worker using the 'spawn' start method to be CUDA-safe.
It batches evaluation requests, runs NN forward passes on GPU/CPU, and returns results.
"""
from typing import Dict, Any, Tuple, List
import multiprocessing as mp
import queue
import time
import traceback
import os

import torch
from torch import amp as torch_amp

from .model_factory import build_actor_critic


def _batch_observations(observations: List[Dict], device: torch.device) -> Dict:
    """Convert list of observations to a batched observation on device."""
    from torch_geometric.data import Batch as PyGBatch
    from torch_geometric.data import Data as PyGData

    # Batch physical networks
    p_nets = []
    for obs in observations:
        p_net = obs['p_net']
        if isinstance(p_net, dict):
            # Support serialized dict form
            p_net = PyGData(
                x=torch.tensor(p_net.get('x', []), dtype=torch.float32),
                edge_index=torch.tensor(p_net.get('edge_index', []), dtype=torch.long),
                edge_attr=torch.tensor(p_net.get('edge_attr', []), dtype=torch.float32) if p_net.get('edge_attr') is not None else None,
            )
        p_nets.append(p_net)
    batched_p_net = PyGBatch.from_data_list(p_nets).to(device)

    # Batch other tensors (ensure proper dtype)
    def to_tensor_list(key):
        vals = []
        for obs in observations:
            v = obs[key]
            if not isinstance(v, torch.Tensor):
                t = torch.as_tensor(v)
            else:
                t = v
            # enforce dtypes
            if key in ('curr_v_node_id', 'vnfs_remaining'):
                t = t.to(torch.long)
            elif key == 'action_mask':
                t = t.to(torch.bool)
            else:
                t = t.to(torch.float32)
            vals.append(t)
        return vals

    enc_list = to_tensor_list('encoder_outputs')
    hist_list = to_tensor_list('history_features')
    history_lengths = []
    for h in hist_list:
        if h.dim() == 3:
            history_lengths.append(int(h.size(1)))
        elif h.dim() >= 1:
            history_lengths.append(int(h.size(0)))
        else:
            history_lengths.append(1)
    curr_list = to_tensor_list('curr_v_node_id')
    remain_list = to_tensor_list('vnfs_remaining')
    mask_list = to_tensor_list('action_mask')

    # Normalize to 3D [1, T, F] and pad variable-length T
    def pad_3d_list(ts_list):
        fixed = []
        for t in ts_list:
            if t.dim() == 2:
                t = t.unsqueeze(0)
            elif t.dim() == 1:
                t = t.view(1, t.size(0), 1)
            fixed.append(t)
        Ts = [t.size(1) for t in fixed]
        Tm = max(Ts)
        outs = []
        for t in fixed:
            if t.size(1) < Tm:
                pad = (0, 0, 0, Tm - t.size(1), 0, 0)  # pad T dimension
                t = torch.nn.functional.pad(t, pad)
            outs.append(t)
        return torch.cat(outs, dim=0)

    # Simple concat helper for non-sequence tensors
    def cat_or_stack(tensors):
        try:
            return torch.cat(tensors, dim=0)
        except Exception:
            t = torch.stack(tensors, dim=0)
            if t.dim() >= 2 and t.size(1) == 1:
                return t.squeeze(1)
            return t

    encoder_outputs = pad_3d_list(enc_list).to(device)
    history_features = pad_3d_list(hist_list).to(device)
    history_lengths = torch.tensor(history_lengths, dtype=torch.long, device=device)
    # Ensure scalar/1D shapes are consistent before concat
    curr_list = [t.view(1) if t.dim() == 0 else t for t in curr_list]
    remain_list = [t.view(1) if t.dim() == 0 else t for t in remain_list]
    curr_v_node_id = cat_or_stack(curr_list).to(device)
    vnfs_remaining = cat_or_stack(remain_list).to(device)

    # Normalize action_mask to 2D [1, A] and pad A to max in batch
    norm_masks = []
    max_actions = 0
    for m in mask_list:
        if m.dim() == 1:
            m = m.unsqueeze(0)
        elif m.dim() == 0:
            m = m.view(1, 1)
        max_actions = max(max_actions, m.size(-1))
        norm_masks.append(m)
    padded_masks = []
    for m in norm_masks:
        if m.size(-1) < max_actions:
            pad = (0, max_actions - m.size(-1))
            m = torch.nn.functional.pad(m, pad, value=False)
        elif m.size(-1) > max_actions:
            m = m[..., :max_actions]
        padded_masks.append(m)
    action_mask = cat_or_stack(padded_masks).to(device)

    return {
        'p_net': batched_p_net,
        'encoder_outputs': encoder_outputs,
        'history_features': history_features,
        'history_lengths': history_lengths,
        'curr_v_node_id': curr_v_node_id,
        'vnfs_remaining': vnfs_remaining,
        'action_mask': action_mask,
    }


def _sha256_state_dict(model: torch.nn.Module) -> str:
    import hashlib
    h = hashlib.sha256()
    with torch.no_grad():
        for name, p in model.state_dict().items():
            h.update(name.encode())
            h.update(p.detach().cpu().numpy().tobytes())
    return h.hexdigest()


def _gpu_worker_main(model_config: Dict[str, Any], policy_path: str, device_id: int, batch_size: int,
                     timeout_ms: int, request_queue: mp.queues.Queue, status_queue: mp.queues.Queue):
    """Spawned worker process entry point."""
    try:
        print(f"🚀 Starting GPU Worker on device {device_id}")
        device = torch.device(f"cuda:{device_id}" if torch.cuda.is_available() else "cpu")
        if torch.cuda.is_available():
            torch.cuda.set_device(device_id)

        # Lazy import to avoid CUDA init in parent
        model = build_actor_critic(model_config).to(device)
        model.eval()

        if policy_path and os.path.exists(policy_path):
            print(f"📦 Loading weights from {policy_path}")
            state = torch.load(policy_path, map_location=device)
            model.load_state_dict(state)
            try:
                sha = _sha256_state_dict(model)
                n_params = sum(p.numel() for p in model.parameters())
                first_lin = getattr(model.encoder, 'token_embed', None)
                if first_lin is None:
                    first_lin = getattr(model.encoder, 'input_proj', None)
                l2 = float(first_lin.weight.detach().norm().item()) if first_lin is not None else float('nan')
                mem_alloc = torch.cuda.memory_allocated(device) if torch.cuda.is_available() else 0
                mem_res = torch.cuda.memory_reserved(device) if torch.cuda.is_available() else 0
                print(f"🔎 Model stats: sha256={sha[:12]}.. params={n_params} token_embed_L2={l2:.3f} mem={mem_alloc/1e6:.1f}MB/{mem_res/1e6:.1f}MB")
            except Exception as e:
                print(f"⚠️  Could not compute model stats: {e}")
        print(f"✅ GPU Worker ready on {device}")
        try:
            status_queue.put_nowait({
                "status": "ready",
                "device": str(device),
                "cuda_available": bool(torch.cuda.is_available()),
            })
        except Exception:
            pass

        timeout_s = timeout_ms / 1000.0
        while True:
            try:
                # Get first request (with timeout)
                first = request_queue.get(timeout=timeout_s)
            except queue.Empty:
                continue

            if first is None:
                break  # shutdown signal

            pending = [first]
            deadline = time.time() + timeout_s
            # Non-blocking drain up to batch_size
            while len(pending) < batch_size and time.time() < deadline:
                try:
                    req = request_queue.get_nowait()
                    if req is None:
                        # push back shutdown for later and break
                        pending.append(None)
                        break
                    pending.append(req)
                except queue.Empty:
                    break

            # Remove any trailing None shutdown signals
            pending = [x for x in pending if x is not None]
            if not pending:
                continue

            observations, reply_conns = [], []
            for obs, conn in pending:
                observations.append(obs)
                reply_conns.append(conn)

            # Handle ping requests (obs dict with __ping__ key)
            if observations and isinstance(observations[0], dict) and observations[0].get("__ping__"):
                for conn in reply_conns:
                    try:
                        conn.send(("success", ("pong", 0.0)))
                    except Exception:
                        pass
                    finally:
                        try:
                            conn.close()
                        except Exception:
                            pass
                continue

            try:
                with torch.no_grad():
                    batched = _batch_observations(observations, device)
                    if torch.cuda.is_available():
                        # Prefer BF16 if supported (wider exponent range, avoids FP16 overflow).
                        if torch.cuda.is_bf16_supported():
                            with torch_amp.autocast('cuda', dtype=torch.bfloat16, enabled=True):
                                logits_batch, values_batch = model.act_and_evaluate(batched)  # [B, A], [B, 1]
                        else:
                            # FP16 autocast can overflow in the value head; shared forward stays in FP32.
                            with torch_amp.autocast('cuda', dtype=torch.float16, enabled=True):
                                logits_batch, values_batch = model.act_and_evaluate(batched)  # [B, A], [B, 1]
                    else:
                        logits_batch, values_batch = model.act_and_evaluate(batched)

                for i, conn in enumerate(reply_conns):
                    try:
                        logits = logits_batch[i].detach().cpu()
                        value = float(values_batch[i].detach().cpu().item())
                        conn.send(("success", (logits, value)))
                    except Exception as e:
                        try:
                            conn.send(("error", str(e)))
                        except Exception:
                            pass
                    finally:
                        try:
                            conn.close()
                        except Exception:
                            pass
            except Exception as e:
                # Keep worker alive; report error back to all pending callers.
                for conn in reply_conns:
                    try:
                        conn.send(("error", f"GPU worker batch failed: {e}"))
                    except Exception:
                        pass
                    finally:
                        try:
                            conn.close()
                        except Exception:
                            pass
                continue

    except Exception as e:
        try:
            status_queue.put_nowait({
                "status": "error",
                "message": str(e),
                "traceback": traceback.format_exc(),
            })
        except Exception:
            pass
        print(f"❌ GPU Worker crashed: {e}")
        traceback.print_exc()
    finally:
        print("🔄 GPU Worker shutting down...")


class BatchedGPUManager:
    """Spawn-safe manager that coordinates the GPU worker."""
    def __init__(self, model_config: Dict, policy_path: str, batch_size: int = 32, timeout_ms: int = 10,
                 device_id: int = 0, max_queue_size: int = 1000, min_reload_interval_s: int = 10):
        self.ctx = mp.get_context('spawn')
        self.max_queue_size = max_queue_size
        self.request_queue: mp.queues.Queue = self.ctx.Queue(maxsize=max_queue_size)
        self.status_queue: mp.queues.Queue = self.ctx.Queue(maxsize=8)
        self.batch_size = batch_size
        self.timeout_ms = timeout_ms
        self.device_id = device_id
        self.model_config = model_config
        self.policy_path = policy_path
        self.process = None
        self.started = False
        self._cached_mtime = None
        self._last_reload_time = 0.0
        self._min_reload_interval_s = float(min_reload_interval_s)
        # Max time to wait for a worker response (seconds); prevents hangs on dead workers.
        self._max_wait_s = max(5.0, (float(timeout_ms) / 1000.0) * 50.0)
        self._startup_timeout_s = max(15.0, self._max_wait_s)

    def _reset_ipc(self):
        self.request_queue = self.ctx.Queue(maxsize=self.max_queue_size)
        self.status_queue = self.ctx.Queue(maxsize=8)

    def start(self):
        if not self.started:
            try:
                self._cached_mtime = os.path.getmtime(self.policy_path) if self.policy_path and os.path.exists(self.policy_path) else None
            except Exception:
                self._cached_mtime = None
            self._reset_ipc()
            self.process = self.ctx.Process(
                target=_gpu_worker_main,
                args=(
                    self.model_config,
                    self.policy_path,
                    self.device_id,
                    self.batch_size,
                    self.timeout_ms,
                    self.request_queue,
                    self.status_queue,
                ),
                daemon=True,
            )
            self.process.start()
            self.started = True
            deadline = time.time() + self._startup_timeout_s
            last_status = None
            while time.time() < deadline:
                if self.process is not None and not self.process.is_alive():
                    exit_code = self.process.exitcode
                    raise RuntimeError(
                        f"GPU worker exited during startup with code {exit_code}. "
                        f"Last status: {last_status}"
                    )
                try:
                    status = self.status_queue.get(timeout=0.2)
                except queue.Empty:
                    continue
                last_status = status
                if status.get("status") == "ready":
                    return
                if status.get("status") == "error":
                    raise RuntimeError(
                        "GPU worker failed during startup: "
                        f"{status.get('message')}\n{status.get('traceback', '')}"
                    )
            raise RuntimeError(
                "GPU worker did not report ready status within "
                f"{self._startup_timeout_s:.1f}s. Last status: {last_status}"
            )

    def _obs_ipc_safe(self, observation: Dict) -> Dict:
        """Ensure all tensors are detached CPU tensors for IPC."""
        safe = {}
        for k, v in observation.items():
            if isinstance(v, torch.Tensor):
                safe[k] = v.detach().cpu()
            else:
                safe[k] = v
        return safe

    def evaluate(self, observation: Dict) -> Tuple[torch.Tensor, float]:
        if not self.started:
            self.start()
        if self.process is not None and not self.process.is_alive():
            raise RuntimeError("GPU Worker process is not alive")
        # Hot reload weights if file changed: restart worker so it reloads on init
        try:
            mtime = os.path.getmtime(self.policy_path) if self.policy_path and os.path.exists(self.policy_path) else None
            now = time.time()
            if self._cached_mtime is not None and mtime is not None and mtime != self._cached_mtime:
                if now - self._last_reload_time >= self._min_reload_interval_s:
                    print("🔄 Detected updated policy weights on disk; restarting GPU worker to reload.")
                    self.shutdown()
                    self.start()
                    self._last_reload_time = now
        except Exception:
            pass
        parent_conn, child_conn = self.ctx.Pipe(duplex=False)
        obs = self._obs_ipc_safe(observation)
        try:
            self.request_queue.put((obs, child_conn), timeout=1.0)
            if not parent_conn.poll(self._max_wait_s):
                raise RuntimeError(f"GPU Worker timed out after {self._max_wait_s:.1f}s")
            status, result = parent_conn.recv()
            if status == 'success':
                return result
            raise RuntimeError(f"GPU Worker error: {result}")
        except queue.Full:
            raise RuntimeError("GPU Worker queue is full")
        except EOFError:
            raise RuntimeError("GPU Worker connection closed")
        finally:
            try:
                parent_conn.close()
            except Exception:
                pass

    def shutdown(self):
        if self.started:
            try:
                self.request_queue.put(None, timeout=0.1)
            except Exception:
                pass
            if self.process is not None:
                self.process.join(timeout=2.0)
                if self.process.is_alive():
                    self.process.terminate()
                    self.process.join(timeout=1.0)
            self.process = None
            self.started = False

    def restart(self):
        """Hard-restart the GPU worker process."""
        try:
            self.shutdown()
        finally:
            self.start()

    def get_stats(self) -> Dict:
        return {'status': 'running' if self.started else 'not_started'}

    def __del__(self):
        self.shutdown()
