#!/usr/bin/env python3
"""
Test the optimized AlphaZero solver end-to-end.
This runs a small training session to verify everything works.
"""
import os
import sys
import time
sys.path.insert(0, '/home/stephen-reilly/dev/virne')

def test_optimized_solver():
    print("🧪 TESTING OPTIMIZED ALPHAZERO SOLVER")
    print("=" * 50)
    
    try:
        import hydra
        from omegaconf import DictConfig
        from virne.system import BaseSystem
        
        # Load config with optimizations
        with hydra.initialize(config_path="settings", version_base=None):
            config = hydra.compose(config_name="main")
        
        # Override for quick test
        config.training.num_train_epochs = 2  # Just 2 epochs for testing
        config.training.distributed_training = False  # Single worker for testing
        config.v_sim_setting.num_v_nets = 10  # Only 10 VNRs for quick test
        
        print(f"📋 Test config:")
        print(f"   num_train_epochs: {config.training.num_train_epochs}")
        print(f"   computation_budget: {config.training.computation_budget}")
        print(f"   use_batched_gpu: {getattr(config.training, 'use_batched_gpu', 'Not set')}")
        print(f"   num_v_nets: {config.v_sim_setting.num_v_nets}")
        
        # Create system
        print(f"\n⚙️  Creating system...")
        start_time = time.perf_counter()
        
        system = BaseSystem.from_config(config)
        solver = system.solver
        
        setup_time = time.perf_counter() - start_time
        print(f"✅ System created in {setup_time:.1f}s")
        print(f"   Solver type: {type(solver).__name__}")
        
        # Test single VNR solve
        print(f"\n🎯 Testing single VNR solve...")
        env = system.environment
        instance = env.reset(config.experiment.seed)
        
        solve_start = time.perf_counter()
        solution = solver.solve(instance)
        solve_time = time.perf_counter() - solve_start
        
        print(f"✅ Single VNR solved in {solve_time:.2f}s")
        print(f"   Success: {solution.get('result', False)}")
        
        # Extrapolate timing
        total_vnrs = config.v_sim_setting.num_v_nets
        estimated_epoch_time = solve_time * total_vnrs
        estimated_total_time = estimated_epoch_time * config.training.num_train_epochs
        
        print(f"\n📊 TIME EXTRAPOLATION:")
        print(f"   VNRs per epoch: {total_vnrs}")
        print(f"   Est. time per epoch: {estimated_epoch_time/60:.1f} minutes")
        print(f"   Est. total training time: {estimated_total_time/60:.1f} minutes")
        
        if estimated_total_time < 600:  # < 10 minutes for this small test
            print(f"✅ LOOKS GOOD: Should complete small test in <10 mins")
            
            # Run actual training test
            print(f"\n🚀 Running training test...")
            training_start = time.perf_counter()
            
            solver.learn(env, num_epochs=config.training.num_train_epochs)
            
            training_time = time.perf_counter() - training_start
            print(f"✅ Training completed in {training_time/60:.1f} minutes")
            
            # Check GPU stats if available
            if hasattr(solver.actor, 'get_gpu_stats'):
                stats = solver.actor.get_gpu_stats()
                if stats:
                    print(f"📊 GPU Worker Stats: {stats}")
            
        else:
            print(f"⚠️  Still seems slow: {estimated_total_time/60:.1f} minutes for small test")
        
        # Cleanup
        solver.close()
        print(f"✅ Cleanup completed")
        
    except Exception as e:
        print(f"❌ Test failed: {e}")
        import traceback
        traceback.print_exc()

if __name__ == "__main__":
    test_optimized_solver()