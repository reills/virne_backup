"""
GPU Batch Worker for AlphaZero MCTS
===================================

This module implements a batched GPU worker that processes multiple MCTS leaf evaluations
simultaneously, providing massive speedup over one-by-one evaluation.

Key idea: All MCTS processes push evaluation requests to a queue, and a single GPU worker 
processes them in batches of 32-64, then returns results back to individual processes.
"""
import torch
import torch.nn.functional as F
import multiprocessing as mp
import threading
import queue
import time
from typing import Dict, Any, Tuple, List
import traceback


class BatchedGPUWorker(mp.Process):
    """
    GPU worker that processes batched neural network evaluations for MCTS.
    
    Runs in a separate process and handles:
    1. Batching individual evaluation requests
    2. Running NN forward passes on GPU
    3. Returning results to individual MCTS processes
    """
    
    def __init__(self, 
                 model_config: Dict[str, Any],
                 policy_path: str,
                 device_id: int = 0,
                 batch_size: int = 32,
                 timeout_ms: int = 10,
                 max_queue_size: int = 1000):
        super().__init__()
        self.model_config = model_config
        self.policy_path = policy_path
        self.device_id = device_id
        self.batch_size = batch_size
        self.timeout_s = timeout_ms / 1000.0
        self.max_queue_size = max_queue_size
        
        # Communication queues
        self.request_queue = mp.Queue(maxsize=max_queue_size)
        self.running = mp.Value('b', True)
        
        # Performance counters
        self.total_requests = mp.Value('i', 0)
        self.total_batches = mp.Value('i', 0)
        
        # Model will be loaded in the worker process
        self.model = None
        self.device = None
        
    def run(self):
        """Main worker loop - runs in separate process"""
        try:
            self._setup_worker()
            self._worker_loop()
        except Exception as e:
            print(f"❌ GPU Worker crashed: {e}")
            traceback.print_exc()
        finally:
            print(f"🔄 GPU Worker shutting down...")
            
    def _setup_worker(self):
        """Setup model and GPU in worker process"""
        print(f"🚀 Starting GPU Worker on device {self.device_id}")
        
        # Set CUDA device
        self.device = torch.device(f"cuda:{self.device_id}" if torch.cuda.is_available() else "cpu")
        torch.cuda.set_device(self.device_id) if torch.cuda.is_available() else None
        
        # Load model
        from .net import ActorCritic
        
        self.model = ActorCritic(**self.model_config).to(self.device)
        self.model.eval()
        
        # Load weights if available
        if self.policy_path and os.path.exists(self.policy_path):
            print(f"📦 Loading weights from {self.policy_path}")
            self.model.load_state_dict(torch.load(self.policy_path, map_location=self.device))
        
        print(f"✅ GPU Worker ready on {self.device}")
        
    def _worker_loop(self):
        """Main processing loop"""
        batch_requests = []
        
        while self.running.value:
            try:
                # Collect batch
                batch_requests = self._collect_batch()
                
                if not batch_requests:
                    time.sleep(0.001)  # Brief sleep if no requests
                    continue
                
                # Process batch
                self._process_batch(batch_requests)
                
                with self.total_batches.get_lock():
                    self.total_batches.value += 1
                    
            except Exception as e:
                print(f"❌ Error in worker loop: {e}")
                # Send error responses
                for _, reply_queue in batch_requests:
                    try:
                        reply_queue.put(("error", str(e)))
                    except:
                        pass
                batch_requests = []
    
    def _collect_batch(self) -> List[Tuple[Dict, mp.Queue]]:
        """Collect a batch of requests with timeout"""
        batch = []
        deadline = time.time() + self.timeout_s
        
        # Get first request (blocking with timeout)
        try:
            first_request = self.request_queue.get(timeout=self.timeout_s)
            batch.append(first_request)
        except queue.Empty:
            return batch
        
        # Collect additional requests (non-blocking)
        while len(batch) < self.batch_size and time.time() < deadline:
            try:
                request = self.request_queue.get_nowait()
                batch.append(request)
            except queue.Empty:
                break
        
        return batch
    
    def _process_batch(self, batch_requests: List[Tuple[Dict, mp.Queue]]):
        """Process a batch of NN evaluation requests"""
        if not batch_requests:
            return
            
        try:
            # Extract observations and reply queues
            observations = []
            reply_queues = []
            
            for obs_dict, reply_queue in batch_requests:
                observations.append(obs_dict)
                reply_queues.append(reply_queue)
            
            # Convert to batched tensors
            batched_obs = self._batch_observations(observations)
            
            # Run NN forward pass
            with torch.no_grad():
                logits_batch = self.model.act(batched_obs)      # [B, num_actions]
                values_batch = self.model.evaluate(batched_obs) # [B, 1]
            
            # Send results back to individual processes
            for i, reply_queue in enumerate(reply_queues):
                logits = logits_batch[i].cpu()
                value = values_batch[i].item()
                reply_queue.put(("success", (logits, value)))
                
            with self.total_requests.get_lock():
                self.total_requests.value += len(batch_requests)
                
        except Exception as e:
            print(f"❌ Error processing batch: {e}")
            # Send error to all requesters
            for _, reply_queue in batch_requests:
                try:
                    reply_queue.put(("error", str(e)))
                except:
                    pass
    
    def _batch_observations(self, observations: List[Dict]) -> Dict:
        """Convert list of observations to batched observation"""
        # This is the tricky part - need to batch PyG graphs
        from torch_geometric.data import Batch as PyGBatch
        
        # Batch physical networks
        p_nets = [obs['p_net'] for obs in observations]
        batched_p_net = PyGBatch.from_data_list(p_nets)
        
        # Batch other tensors
        encoder_outputs = torch.stack([obs['encoder_outputs'] for obs in observations])
        history_features = torch.stack([obs['history_features'] for obs in observations])
        curr_v_node_id = torch.stack([obs['curr_v_node_id'] for obs in observations])
        vnfs_remaining = torch.stack([obs['vnfs_remaining'] for obs in observations])
        action_mask = torch.stack([obs['action_mask'] for obs in observations])
        
        return {
            'p_net': batched_p_net.to(self.device),
            'encoder_outputs': encoder_outputs.to(self.device),
            'history_features': history_features.to(self.device),
            'curr_v_node_id': curr_v_node_id.to(self.device),
            'vnfs_remaining': vnfs_remaining.to(self.device),
            'action_mask': action_mask.to(self.device),
        }
    
    def evaluate_async(self, observation: Dict) -> Tuple[torch.Tensor, float]:
        """
        Submit evaluation request and wait for result.
        This is called from MCTS processes.
        """
        reply_queue = mp.Queue(maxsize=1)
        
        try:
            # Submit request
            self.request_queue.put((observation, reply_queue), timeout=1.0)
            
            # Wait for response
            status, result = reply_queue.get(timeout=5.0)
            
            if status == "success":
                return result  # (logits, value)
            else:
                raise RuntimeError(f"GPU Worker error: {result}")
                
        except queue.Full:
            raise RuntimeError("GPU Worker queue is full")
        except queue.Empty:
            raise RuntimeError("GPU Worker timeout")
    
    def shutdown(self):
        """Gracefully shutdown the worker"""
        self.running.value = False
        self.join(timeout=5.0)
        if self.is_alive():
            self.terminate()
    
    def get_stats(self) -> Dict:
        """Get performance statistics"""
        return {
            'total_requests': self.total_requests.value,
            'total_batches': self.total_batches.value,
            'avg_batch_size': self.total_requests.value / max(self.total_batches.value, 1),
            'queue_size': self.request_queue.qsize()
        }


import os  # Missing import

class BatchedGPUManager:
    """
    Manager class that handles the GPU worker lifecycle.
    Used by AlphaZero solver to coordinate batched evaluation.
    """
    
    def __init__(self, model_config: Dict, policy_path: str, **kwargs):
        self.worker = BatchedGPUWorker(
            model_config=model_config,
            policy_path=policy_path,
            **kwargs
        )
        self.started = False
    
    def start(self):
        """Start the GPU worker"""
        if not self.started:
            self.worker.start()
            self.started = True
            time.sleep(0.5)  # Give worker time to initialize
    
    def evaluate(self, observation: Dict) -> Tuple[torch.Tensor, float]:
        """Evaluate observation using batched GPU worker"""
        if not self.started:
            self.start()
        return self.worker.evaluate_async(observation)
    
    def shutdown(self):
        """Shutdown the GPU worker"""
        if self.started:
            self.worker.shutdown()
            self.started = False
    
    def get_stats(self) -> Dict:
        """Get performance statistics"""
        if self.started:
            return self.worker.get_stats()
        return {'status': 'not_started'}
    
    def __del__(self):
        """Cleanup on destruction"""
        self.shutdown()