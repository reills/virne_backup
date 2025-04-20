# virne/virne/base/controller.py functions named: def safely_place_and_route, def has_feasible_path, def create_available_network, def find_candidate_nodes
# virne/virne/base/scenario.py functions named: ready,run, 
# virne/virne/solver/learning/a3c_gcn_pre_train_transformer/instance_env.py functions named: get_observation, generate_action_mask, compute_reward

# virne/virne/solver/learning/a3c_gcn_pre_train_transformer/solver.py functions named:learn_with_instance,make_instance_obs, perform_accumulated_step_and_sync, update, solve
# virne/virne/solver/learning/rl_base/instance_agent.py learn_singly, merge_instance_experience 
# virne/virne/solver/learning/rl_base/instance_rl_environment.py reset, revoke, step, reject
# virne/virne/solver/learning/rl_base/rl_solver.py run_worker_process, select_action, evaluate_actions, get_worker_config, learn_distributedly

#!/bin/bash

# Where to extract to
OUTPUT_DIR="./extracted_functions"
mkdir -p "$OUTPUT_DIR"

# Function to extract Python function by name
extract_function() {
    local filepath=$1
    local funcname=$2
    local outfile=$OUTPUT_DIR/$(basename "$filepath" .py)__"$funcname".py

    # Check if file exists
    if [ ! -f "$filepath" ]; then
        echo "❌ File not found: $filepath"
        return
    fi

    # Extract function using awk
    awk "/^def $funcname\\b/,/^def / && NR>1" "$filepath" | awk 'NR==1{print line};{print};{line=$0}' > "$outfile"

    echo "✅ Extracted $funcname → $outfile"
}

# controller.py
extract_function virne/virne/base/controller.py safely_place_and_route
extract_function virne/virne/base/controller.py has_feasible_path
extract_function virne/virne/base/controller.py create_available_network
extract_function virne/virne/base/controller.py find_candidate_nodes

# scenario.py
extract_function virne/virne/base/scenario.py ready
extract_function virne/virne/base/scenario.py run

# instance_env.py
extract_function virne/virne/solver/learning/a3c_gcn_pre_train_transformer/instance_env.py get_observation
extract_function virne/virne/solver/learning/a3c_gcn_pre_train_transformer/instance_env.py generate_action_mask
extract_function virne/virne/solver/learning/a3c_gcn_pre_train_transformer/instance_env.py compute_reward

# solver.py
extract_function virne/virne/solver/learning/a3c_gcn_pre_train_transformer/solver.py learn_with_instance
extract_function virne/virne/solver/learning/a3c_gcn_pre_train_transformer/solver.py make_instance_obs
extract_function virne/virne/solver/learning/a3c_gcn_pre_train_transformer/solver.py perform_accumulated_step_and_sync
extract_function virne/virne/solver/learning/a3c_gcn_pre_train_transformer/solver.py update
extract_function virne/virne/solver/learning/a3c_gcn_pre_train_transformer/solver.py solve

# instance_agent.py
extract_function virne/virne/solver/learning/rl_base/instance_agent.py learn_singly
extract_function virne/virne/solver/learning/rl_base/instance_agent.py merge_instance_experience

# instance_rl_environment.py
extract_function virne/virne/solver/learning/rl_base/instance_rl_environment.py reset
extract_function virne/virne/solver/learning/rl_base/instance_rl_environment.py revoke
extract_function virne/virne/solver/learning/rl_base/instance_rl_environment.py step
extract_function virne/virne/solver/learning/rl_base/instance_rl_environment.py reject

# rl_solver.py
extract_function virne/virne/solver/learning/rl_base/rl_solver.py run_worker_process
extract_function virne/virne/solver/learning/rl_base/rl_solver.py select_action
extract_function virne/virne/solver/learning/rl_base/rl_solver.py evaluate_actions
extract_function virne/virne/solver/learning/rl_base/rl_solver.py get_worker_config
extract_function virne/virne/solver/learning/rl_base/rl_solver.py learn_distributedly
