#!/usr/bin/env python3
"""
Batch Train K-Specific Models with Resource Management

This script intelligently manages multiple training jobs to maximize throughput
while avoiding memory issues.

Usage:
    python batch_train_k_models.py --concurrent 2  # Run 2 jobs at once
    python batch_train_k_models.py --network-sizes small medium --k-values 1 2 10
"""

import subprocess
import time
import argparse
import psutil
import GPUtil
from pathlib import Path
from typing import List, Dict
import json
from datetime import datetime

class BatchTrainer:
    def __init__(self, base_dir: str = "/home/stephen-reilly/dev/virne", max_concurrent: int = 1):
        self.base_dir = Path(base_dir)
        self.max_concurrent = max_concurrent
        self.running_jobs = []
        self.completed_jobs = []
        self.failed_jobs = []
        
        # Resource monitoring thresholds
        self.max_memory_percent = 85  # Don't start new job if RAM > 85%
        self.max_gpu_memory_percent = 85  # Don't start new job if GPU > 85%
        
    def get_system_resources(self) -> Dict:
        """Get current system resource usage"""
        # CPU and RAM
        memory = psutil.virtual_memory()
        
        # GPU (if available)
        gpu_memory_used = 0
        gpu_memory_total = 1
        try:
            gpus = GPUtil.getGPUs()
            if gpus:
                gpu = gpus[0]  # Assuming single GPU
                gpu_memory_used = gpu.memoryUsed
                gpu_memory_total = gpu.memoryTotal
        except:
            pass
            
        gpu_memory_percent = (gpu_memory_used / gpu_memory_total) * 100
        
        return {
            "memory_percent": memory.percent,
            "gpu_memory_percent": gpu_memory_percent,
            "gpu_memory_used_mb": gpu_memory_used,
            "gpu_memory_total_mb": gpu_memory_total
        }
    
    def can_start_new_job(self) -> bool:
        """Check if we can start a new training job based on resources"""
        if len(self.running_jobs) >= self.max_concurrent:
            return False
            
        resources = self.get_system_resources()
        
        if resources["memory_percent"] > self.max_memory_percent:
            print(f"RAM usage too high: {resources['memory_percent']:.1f}% > {self.max_memory_percent}%")
            return False
            
        if resources["gpu_memory_percent"] > self.max_gpu_memory_percent:
            print(f"GPU memory usage too high: {resources['gpu_memory_percent']:.1f}% > {self.max_gpu_memory_percent}%")
            return False
            
        return True
    
    def start_training_job(self, network_size: str, k_values: List[int]) -> Dict:
        """Start a training job for specific network size and k values"""
        k_str = " ".join(map(str, k_values))
        cmd = f"python train_k_specific_models.py --k-values {k_str} --network-sizes {network_size}"
        
        print(f"Starting: {network_size} network with k={k_values}")
        print(f"Command: {cmd}")
        
        # Start the process
        process = subprocess.Popen(
            cmd,
            shell=True,
            cwd=self.base_dir,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            text=True
        )
        
        job = {
            "network_size": network_size,
            "k_values": k_values,
            "process": process,
            "cmd": cmd,
            "start_time": time.time(),
            "start_datetime": datetime.now().isoformat()
        }
        
        self.running_jobs.append(job)
        return job
    
    def check_running_jobs(self):
        """Check status of running jobs and move completed ones"""
        completed = []
        
        for job in self.running_jobs:
            poll = job["process"].poll()
            
            if poll is not None:  # Process finished
                end_time = time.time()
                duration = end_time - job["start_time"]
                
                stdout, stderr = job["process"].communicate()
                
                job.update({
                    "end_time": end_time,
                    "duration": duration,
                    "return_code": poll,
                    "stdout": stdout,
                    "stderr": stderr,
                    "success": poll == 0
                })
                
                if poll == 0:
                    print(f"✓ Completed: {job['network_size']} (duration: {duration/60:.1f} min)")
                    self.completed_jobs.append(job)
                else:
                    print(f"✗ Failed: {job['network_size']} (return code: {poll})")
                    self.failed_jobs.append(job)
                
                completed.append(job)
        
        # Remove completed jobs from running list
        for job in completed:
            self.running_jobs.remove(job)
    
    def run_batch_training(self, network_sizes: List[str], k_values: List[int]):
        """Run batch training for multiple network sizes"""
        print("Batch K-Specific Model Training")
        print(f"Network sizes: {network_sizes}")
        print(f"K values: {k_values}")
        print(f"Max concurrent jobs: {self.max_concurrent}")
        print(f"Resource limits: RAM < {self.max_memory_percent}%, GPU < {self.max_gpu_memory_percent}%")
        print()
        
        # Create job queue
        job_queue = []
        for network_size in network_sizes:
            job_queue.append({
                "network_size": network_size,
                "k_values": k_values
            })
        
        print(f"Job queue: {len(job_queue)} training jobs")
        for i, job_spec in enumerate(job_queue, 1):
            print(f"  {i}. {job_spec['network_size']} network")
        print()
        
        # Process job queue
        while job_queue or self.running_jobs:
            # Check running jobs
            self.check_running_jobs()
            
            # Start new jobs if possible
            while job_queue and self.can_start_new_job():
                job_spec = job_queue.pop(0)
                self.start_training_job(job_spec["network_size"], job_spec["k_values"])
                time.sleep(5)  # Brief delay between job starts
            
            # Show status
            if self.running_jobs or job_queue:
                resources = self.get_system_resources()
                print(f"Status: {len(self.running_jobs)} running, {len(job_queue)} queued, "
                      f"RAM: {resources['memory_percent']:.1f}%, "
                      f"GPU: {resources['gpu_memory_percent']:.1f}%")
                
                for job in self.running_jobs:
                    elapsed = time.time() - job["start_time"]
                    print(f"  Running: {job['network_size']} ({elapsed/60:.1f} min)")
            
            time.sleep(30)  # Check every 30 seconds
        
        print("\n" + "="*60)
        print("BATCH TRAINING COMPLETED!")
        print("="*60)
        print(f"Completed: {len(self.completed_jobs)}")
        print(f"Failed: {len(self.failed_jobs)}")
        
        if self.failed_jobs:
            print("\nFailed jobs:")
            for job in self.failed_jobs:
                print(f"  - {job['network_size']}: {job['return_code']}")
        
        # Save results summary
        self.save_batch_summary()
    
    def save_batch_summary(self):
        """Save summary of batch training results"""
        timestamp = datetime.now().strftime("%m.%d.%Y_%H%M%S")
        results_dir = self.base_dir / "batch_training_results"
        results_dir.mkdir(exist_ok=True)
        
        summary = {
            "timestamp": timestamp,
            "max_concurrent": self.max_concurrent,
            "completed_jobs": len(self.completed_jobs),
            "failed_jobs": len(self.failed_jobs),
            "total_duration": sum(job["duration"] for job in self.completed_jobs),
            "jobs": {
                "completed": self.completed_jobs,
                "failed": self.failed_jobs
            }
        }
        
        # Remove process objects for JSON serialization
        for job_list in [summary["jobs"]["completed"], summary["jobs"]["failed"]]:
            for job in job_list:
                if "process" in job:
                    del job["process"]
        
        summary_file = results_dir / f"batch_summary_{timestamp}.json"
        with open(summary_file, 'w') as f:
            json.dump(summary, f, indent=2)
        
        print(f"\nBatch summary saved to: {summary_file}")

def main():
    parser = argparse.ArgumentParser(description='Batch Train K-Specific Models')
    parser.add_argument('--network-sizes', choices=['small', 'medium', 'large'], 
                       nargs='+', default=['small', 'medium', 'large'],
                       help='Network sizes to train')
    parser.add_argument('--k-values', type=int, nargs='+', 
                       default=[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15],
                       help='K values to train for each network')
    parser.add_argument('--concurrent', type=int, default=1,
                       help='Maximum concurrent training jobs (default: 1)')
    parser.add_argument('--base-dir', default='/home/stephen-reilly/dev/virne',
                       help='Base directory for the project')
    parser.add_argument('--memory-limit', type=int, default=85,
                       help='Max RAM usage percent before pausing new jobs (default: 85)')
    parser.add_argument('--gpu-memory-limit', type=int, default=85,
                       help='Max GPU memory usage percent before pausing new jobs (default: 85)')
    
    args = parser.parse_args()
    
    trainer = BatchTrainer(base_dir=args.base_dir, max_concurrent=args.concurrent)
    trainer.max_memory_percent = args.memory_limit
    trainer.max_gpu_memory_percent = args.gpu_memory_limit
    
    print("Batch Training Configuration:")
    print(f"  Network sizes: {args.network_sizes}")
    print(f"  K values: {args.k_values}")
    print(f"  Max concurrent jobs: {args.concurrent}")
    print(f"  Memory limits: RAM < {args.memory_limit}%, GPU < {args.gpu_memory_limit}%")
    print(f"  Total models to train: {len(args.network_sizes) * len(args.k_values)}")
    print()
    
    try:
        trainer.run_batch_training(args.network_sizes, args.k_values)
    except KeyboardInterrupt:
        print("\nBatch training interrupted by user")
        # Kill any running processes
        for job in trainer.running_jobs:
            job["process"].terminate()
    except Exception as e:
        print(f"Error during batch training: {e}")
        raise

if __name__ == "__main__":
    main()