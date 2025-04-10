import numpy as np # Assuming needed for potential future use, not strictly required now

action_sequence = [
    62, 35, 12, 6, 78, 85, 101, 95, 101, 101, 101, 17, 78, 85, 101, 95, 101, 101, 101, 1, 78, 85, 101, 95, 101, 101, 101, 101, 95, 6, 78, 85, 101, 101, 101, 17, 78, 85, 101, 101, 101, 1, 78, 85, 101, 101, 101, 101, 101, 29, 12, 6, 78, 85, 101, 95, 101, 101, 101, 17, 78, 85, 101, 95, 101, 101, 101, 1, 78, 85, 101, 95, 101, 101, 101, 101, 95, 6, 78, 85, 101, 101, 101, 17, 78, 85, 100
     ]

# --- Simulation Parameters ---
VNET_NODES = 7
MAX_REVOKES = 93
VNET_R2C_RATIO = 0.5 # Assumption
# ---

# --- State Initialization ---
solution = {
    'num_placed_nodes': 0,
    'revoke_times': 0,
    'early_rejection': False,
    'result': False,            # Final success (placement + routing)
    'route_result': False,      # Final routing status (partial/full if placement done)
    'v_net_r2c_ratio': VNET_R2C_RATIO,
    'v_net_reward': 0.0         # Accumulator for total reward
}
# ---

def compute_reward(current_solution, v_net_nodes, max_revokes, current_action_is_revoke=False):
    """
    Calculates reward for the current step based on solution state.
    NOTE: This function *MODIFIES* current_solution['v_net_reward'] directly.
    """
    vnodes = v_net_nodes
    value = current_solution['v_net_r2c_ratio'] * 10
    # Ensure num_placed_nodes is not None before calculation
    num_placed = current_solution.get('num_placed_nodes', 0)
    completion_pct = num_placed / vnodes if vnodes > 0 else 0
    revokes = current_solution['revoke_times']
    revoke_pct = revokes / max(1, max_revokes)

    reward = 0 # Default reward for a basic step if no other condition met

    # Case 1: Early rejection — triggered by action 100
    if current_solution['early_rejection']:
        reward = -10.0
    # Case 2: Revoke was taken — triggered by action 101
    elif current_action_is_revoke:
        # Penalty increases with the number of revokes *already performed*
        reward = -0.01 * revokes # Use current revoke count for penalty
    # Case 3: Final step of a full success (Hypothetical - needs external flag)
    elif current_solution['result']:
        bonus = max(0, value - revoke_pct)
        reward = value + bonus
    # Case 4: Routing partially succeeded (Hypothetical - needs external flag)
    elif current_solution['route_result']:
        completion_reward = (completion_pct/vnodes)
        penalty = completion_reward * revoke_pct
        bonus = completion_reward - penalty
        reward = (value*completion_reward) + bonus # Simplified based on comments
        # Original had: reward = (value*completion_reward) + bonus -- seems like double counting value? Sticking to simpler version.
    else:
            #technically if revoked is enabled this will never hit because revoke will just call reject (revoke=true) when it hits max revokes
            reward = -3  # Large negative signal 
    
    # Case 5: All nodes placed and routing failure OR place failure (Default final state if loop ends without success/early reject)
    # This case is tricky to apply per-step. It applies if the *episode ends* in failure.
    # We will apply this *after* the loop if necessary. For now, intermediate placement steps yield 0 reward if not revoke/reject.

    # --- Let's refine Case 5 handling ---
    # The -2 penalty should likely apply only ONCE when the episode terminates in failure.
    # We won't apply it during intermediate steps.

    # The function, as provided, accumulates reward internally.
    current_solution['v_net_reward'] += reward
    return reward # Return step reward for printing/logging if needed

# --- Simulation Loop ---
total_reward_manual_sum = 0.0 # Manual sum for verification
episode_terminated = False

print("Step | Action | Placed | Revokes | Step Reward | Total Reward (Solution) | Notes")
print("-----|--------|--------|---------|-------------|-------------------------|-------")

for i, action in enumerate(action_sequence):
    step_reward = 0
    notes = ""
    current_action_is_revoke = False

    if episode_terminated:
        notes = "Skipped (Episode Ended)"
        print(f"{i:<4} | {action:<6} | {solution['num_placed_nodes']:<6} | {solution['revoke_times']:<7} | {'N/A':<11} | {solution['v_net_reward']:.4f}              | {notes}")
        continue

    # 1. Update State based on Action
    if action == 101:
        current_action_is_revoke = True
        solution['revoke_times'] += 1
        # Assuming revoke undoes a placement
        if solution['num_placed_nodes'] > 0:
            solution['num_placed_nodes'] -= 1
        notes = "Revoke"
    elif action == 100:
        solution['early_rejection'] = True
        episode_terminated = True # Stop processing further actions
        notes = "Early Reject"
    else: # Placement action
        solution['num_placed_nodes'] += 1
        notes = "Place"

    # Check if max revokes exceeded (treat as failure?) - Let's assume this leads to termination failure
    if solution['revoke_times'] > MAX_REVOKES:
        notes += " (Max Revokes Exceeded!)"
        episode_terminated = True
        # Apply the failure penalty here? Or let the post-loop logic handle it?
        # Let's apply the generic failure penalty (-2) if terminated this way.
        if not solution['early_rejection']: # Don't overwrite early rejection penalty
             solution['v_net_reward'] += -2.0 # Apply final failure penalty
             step_reward = -2.0 # Show this penalty happened at this step


    # 2. Calculate Reward for this step *using the updated state*
    # We call compute_reward which handles the internal accumulation
    # We only need the returned step_reward for printing purposes.
    # The actual accumulation happens inside the function.
    # Exception: If we applied the max_revoke penalty manually, don't call compute_reward again for this step.
    if step_reward == 0: # Only call compute_reward if no manual penalty was applied above
        step_reward = compute_reward(solution, VNET_NODES, MAX_REVOKES, current_action_is_revoke)

    total_reward_manual_sum += step_reward # Track sum manually for comparison

    print(f"{i:<4} | {action:<6} | {solution['num_placed_nodes']:<6} | {solution['revoke_times']:<7} | {step_reward:<11.4f} | {solution['v_net_reward']:.4f}              | {notes}")

    # Check termination condition inside loop
    if episode_terminated and action == 100: # If early rejection happened, break now
         break


# --- Post-Loop Evaluation (Final State Reward) ---
# If the loop finished without early rejection or max revokes, evaluate the final state
if not episode_terminated:
    notes = "End of Sequence"
    # Assume failure as per Case 5, since no 'result=True' or 'route_result=True' flag was set
    final_state_reward = -2.0
    solution['v_net_reward'] += final_state_reward
    total_reward_manual_sum += final_state_reward
    print(f"Post | {'N/A':<6} | {solution['num_placed_nodes']:<6} | {solution['revoke_times']:<7} | {final_state_reward:<11.4f} | {solution['v_net_reward']:.4f}              | {notes} (Applied Case 5 Failure Penalty)")

# --- Final Result ---
print("\n--- Simulation Complete ---")
print(f"Final State:")
print(f"  - Placed Nodes: {solution['num_placed_nodes']} / {VNET_NODES}")
print(f"  - Revoke Times: {solution['revoke_times']} / {MAX_REVOKES}")
print(f"  - Early Rejection: {solution['early_rejection']}")
# print(f"  - Final Manual Sum Reward: {total_reward_manual_sum:.4f}") # For debugging
print(f"  - Final Total Reward (from solution dict): {solution['v_net_reward']:.4f}")