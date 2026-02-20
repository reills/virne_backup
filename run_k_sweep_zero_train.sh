#!/bin/bash

# This script runs the k-sweep ablation study for the AlphaZero SFC solver.
# It automates the long command line for convenience and reproducibility.

# Exit immediately if a command exits with a non-zero status.
set -e

echo "INFO: Starting AlphaZero k-sweep ablation study..."

# Activate the conda environment.
# This ensures the correct python and all dependencies are available.
echo "INFO: Activating conda environment 'virne'..."
eval "$(conda shell.bash hook)"
conda activate virne

# Run the sweep script with all parameters.
# The backslashes allow the command to be spread across multiple lines for readability.
python tools/train_alpha_zero_k_sweep.py \
  --dataset-dir datasets/generated/2000_vnets \
  --k-values 2-3 \
  --max-workers 4 \
  --num-epochs 12 \
  --steps-per-epoch 128 \
  --max-training-steps 500 \
  --num-vnets 2000 \
  --save-root-dir results/alpha_zero_sfc_resweep \
  --log-dir results/alpha_zero_sfc_resweep/logs \
  --export-dir results/alpha_zero_sfc/exported_models \
  --extra-overrides \
  training.resume_training=true \
  training.enable_async_learner=true \
  training.use_cpp_mcts=true \
  training.use_neural_network=true \
  training.use_nn_policy=true \
  training.use_nn_value=true \
  training.computation_budget=64 \
  training.c_puct=1.4 \
  training.num_workers=4 \
  training.distributed_training=true \
  training.min_buffer_size=128 \
  training.max_empty_batches=100000 \
  training.save_interval=256 \
  training.save_checkpoint_history=false \
  training.disable_trajectory_writing=false \
  training.gpu_batch_size=32 \
  training.gpu_timeout_ms=5 \
  training.use_batched_gpu=true \
  training.if_use_random_training_seed=false \
  training.seed=0 \
  experiment.seed=0 \
  experiment.num_simulations=0

echo "INFO: Sweep script finished."
