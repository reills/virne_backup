import numpy as np # Assuming needed for potential future use, not strictly required now

action_sequence =  [75, 37, 52, 101, 3, 101, 15, 101, 92, 101, 19, 101, 85, 101, 78, 101, 98, 101, 101, 85, 52, 37, 87, 19, 43, 53, 99, 15, 10, 78, 101, 101, 78, 101, 101, 1, 10, 78, 101, 101, 78, 101, 101, 73, 10, 78, 101, 101, 78, 101, 101, 11, 10, 78, 101, 101, 78, 101, 101, 10, 78, 101, 101, 78, 10, 101, 101, 101, 10, 15, 99, 78, 101, 101, 78, 101, 101, 1, 99, 78, 101, 101, 78, 101, 101, 73, 99, 78, 101, 101, 78, 101, 101, 11, 99, 78, 101, 101, 78, 101, 101, 78, 99, 101, 101, 101, 101, 20, 99, 15, 10, 78, 101, 101, 78, 101, 101, 1, 10, 78, 101, 101, 78, 101, 101, 73, 10, 78, 101, 101, 78, 101, 101, 11, 10, 78, 101, 101, 78, 101, 101, 10, 78, 101, 101, 78, 10, 101, 101, 101, 10, 15, 99, 78, 101, 101, 78, 101, 101, 1, 99, 78, 101, 101, 78, 101, 101, 73, 99, 78, 101, 101, 78, 101, 101, 11, 99, 78, 101, 101, 78, 101, 101, 78, 99, 101, 101, 101, 101, 10, 99, 15, 78, 101, 101, 1, 78, 101, 101, 73, 78, 101, 101, 11, 78, 101, 101, 78, 101, 101, 101, 2, 99, 15, 10, 78, 101, 101, 78, 101, 101, 1, 10, 78, 101, 101, 78, 101, 101, 73, 10, 78, 101, 101, 78, 101, 101, 11, 10, 78, 101, 101, 78, 101, 101, 10, 78, 101, 101, 78, 10, 101, 101, 101, 10, 15, 99, 78, 101, 101, 78, 101, 101, 1, 99, 78, 101, 101, 78, 101, 101, 73, 99, 78, 101, 101, 78, 101, 101, 11, 99, 78, 101, 101, 78, 101, 101, 78, 99, 101, 101, 101, 101, 78, 99, 15, 10, 101, 101, 1, 10, 101, 101, 73, 10, 101, 101, 11, 10, 101, 101, 10]

# --- Simulation Parameters ---
VNET_NODES = 15
MAX_REVOKES = 15*8
VNET_R2C_RATIO = 0.52 # Assumption
# ---


# --- State Initialization ---
solution = {
    'successful_steps': 0, # Tracks raw count of non-revoke/reject steps
    'num_placed_nodes': 0, # Tracks VNet nodes successfully placed (capped at VNET_NODES)
    'revoke_times': 0,
    'early_rejection': False,
    'result': False,
    'route_result': False, # Still needed for the logic structure
    'v_net_r2c_ratio': VNET_R2C_RATIO,
    'v_net_reward': 0.0
}
# ---

def compute_reward_estimator(current_solution, v_net_nodes, max_revokes_for_pct, current_action_is_revoke=False, is_intermediate_success=False, is_final_step_success=False, is_final_step_partial=False, is_final_step_failure=False):
    """
    Calculates reward using structure of original function.
    Intermediate success uses Case 4 logic with capped placed nodes.
    MODIFIES current_solution['v_net_reward'] directly.
    """
    vnodes = v_net_nodes
    value = current_solution['v_net_r2c_ratio'] * 20 # 10
    # Use the capped count for percentage calculations
    # Get the count *before* potential increment if it's an intermediate success step
    # Or use the final value if it's a final eval step
    num_placed_for_calc = current_solution.get('num_placed_nodes', 0)

    # If it's an intermediate success, the increment happens *before* this call,
    # so num_placed_for_calc reflects the state *after* the success.
    # Ensure it's capped for percentage calculation.
    effective_placed = min(num_placed_for_calc, vnodes)
    completion_pct = effective_placed / vnodes if vnodes > 0 else 0

    revokes = current_solution['revoke_times'] # Use current revoke count
    revoke_pct = revokes / max(1, max_revokes_for_pct)

    reward = 0 # Default

    # --- Final Step Evaluation ---
    if is_final_step_success: # Case 3
        # Ensure calculation uses VNET_NODES placed
        final_completion_pct = vnodes / vnodes if vnodes > 0 else 0
        # Note: Case 3 original formula doesn't use completion_pct directly
        bonus = max(0, value - revoke_pct)
        reward = value + bonus
    elif is_final_step_partial: # Case 4 (Applied at End)
        # Use the state at the end of the episode
        completion_reward_final = (completion_pct / vnodes) if vnodes > 0 else 0 # Use final completion_pct
        penalty_final = completion_reward_final * revoke_pct
        bonus_final = completion_reward_final - penalty_final
        reward = (value * completion_reward_final) + bonus_final
    elif is_final_step_failure: # Case 5 (Applied at End)
         reward = -3.0

    # --- Per-Step Evaluation (if not a final evaluation step) ---
    elif current_solution['early_rejection']: # Case 1
        reward = -30.0
    elif current_action_is_revoke: # Case 2
        reward =  -1 # revokes   Uses revoke count AFTER increment
    elif is_intermediate_success: # Apply Case 4 logic for intermediate steps
        # Uses completion_pct calculated from effective_placed (capped)
        completion_reward_step = (completion_pct / vnodes) if vnodes > 0 else 0
        penalty_step = completion_reward_step * revoke_pct
        bonus_step = completion_reward_step - penalty_step
        reward = (value * completion_reward_step) + bonus_step # Apply user's formula

    # --- Accumulate Reward ---
    # This function is called AFTER state is updated, reward adds to cumulative
    # current_solution['v_net_reward'] += reward # Accumulation happens OUTSIDE now
    return reward # Return step reward ONLY


# --- Simulation Loop ---
print("Step | Action | SuccSteps | Placed | Revokes | Step Reward | Total Reward | Notes")
print("-----|--------|-----------|--------|---------|-------------|--------------|-------")

for i, action in enumerate(action_sequence):
    step_reward = 0
    notes = ""
    current_action_is_revoke = False
    is_intermediate_success = False
    is_final_step = (i == len(action_sequence) - 1)

    # 1. Update State
    if action == 101:
        current_action_is_revoke = True
        solution['revoke_times'] += 1
        if solution['num_placed_nodes'] > 0:
            solution['num_placed_nodes'] -= 1
            notes = "Revoke (Unplaced node)"
        else:
            notes = "Revoke (No node to unplace)"
    elif action == 100:
        solution['early_rejection'] = True
        notes = "Early Reject"
        step_reward = compute_reward_estimator(solution, VNET_NODES, MAX_REVOKES)
        solution['v_net_reward'] += step_reward
        print(f"{i:<4} | {action:<6} | {solution['successful_steps']:<9} | {solution['num_placed_nodes']:<6} | {solution['revoke_times']:<7} | {step_reward:<11.4f} | {solution['v_net_reward']:.4f}     | {notes}")
        break
    else:
        solution['successful_steps'] += 1
        if solution['num_placed_nodes'] < VNET_NODES:
            solution['num_placed_nodes'] += 1
        is_intermediate_success = True
        notes = f"Place+Route step {solution['successful_steps']} (VNode {solution['num_placed_nodes']}/{VNET_NODES})"

    # 2. Calculate step reward
    step_reward = compute_reward_estimator(
        solution, VNET_NODES, MAX_REVOKES,
        current_action_is_revoke=current_action_is_revoke,
        is_intermediate_success=is_intermediate_success
    )
    solution['v_net_reward'] += step_reward

    print(f"{i:<4} | {action:<6} | {solution['successful_steps']:<9} | {solution['num_placed_nodes']:<6} | {solution['revoke_times']:<7} | {step_reward:<11.4f} | {solution['v_net_reward']:.4f}     | {notes}")

# --- Post-loop Evaluation --- 
print(f"--- Post Loop Evaluation ---")
final_revoke_count = solution['revoke_times']
final_placed_count = solution['num_placed_nodes']
final_successful_steps = solution['successful_steps']

last_action = action_sequence[-1] if len(action_sequence) > 0 else None

final_step_reward = 0
final_notes = ""

# Avoid post-bonus if last action was a revoke
if last_action == 101:
    final_notes = "Final action was a revoke — no episode bonus applied."
elif solution['early_rejection']:
    # Already handled inside loop, nothing to do
    final_notes = "Early rejection already handled in loop — no bonus applied."
else:
    is_full_success = final_placed_count == VNET_NODES
    is_partial_success = 0 < final_placed_count < VNET_NODES
    is_failure = final_placed_count == 0

    solution_for_final = solution.copy()

    if is_full_success:
        solution_for_final['num_placed_nodes'] = VNET_NODES
        final_step_reward = compute_reward_estimator(
            solution_for_final, VNET_NODES, MAX_REVOKES, is_final_step_success=True)
        final_notes = f"Applied Full Success (Case 3) Reward Bonus: {final_step_reward:.4f}"
    elif is_partial_success:
        final_step_reward = compute_reward_estimator(
            solution_for_final, VNET_NODES, MAX_REVOKES, is_final_step_partial=True)
        final_notes = f"Applied Partial Success (Case 4) Reward Bonus: {final_step_reward:.4f}"
    elif is_failure:
        final_step_reward = compute_reward_estimator(
            solution_for_final, VNET_NODES, MAX_REVOKES, is_final_step_failure=True)
        final_notes = f"Applied Failure (Case 5) Penalty: {final_step_reward:.4f}"

# Always accumulate the post-loop reward
solution['v_net_reward'] += final_step_reward

print(f"Post | {'N/A':<6} | {final_successful_steps:<9} | {final_placed_count:<6} | {final_revoke_count:<7} | {final_step_reward:<11.4f} | {solution['v_net_reward']:.4f}     | {final_notes}")


# --- Final Result ---
print("\n--- Simulation Complete ---")
print(f"Final State (End of Sequence):")
print(f"  - Successful Place+Route Steps: {final_successful_steps}")
print(f"  - VNet Nodes Placed (Final State): {final_placed_count} / {VNET_NODES}") # Reflects state after last action + final assumption
print(f"  - Revoke Times: {final_revoke_count}")
print(f"  - Used MAX_REVOKES parameter: {MAX_REVOKES}")
print(f"  - Early Rejection: {solution['early_rejection']}")
print(f"  - Final Total Reward (Estimator): {solution['v_net_reward']:.4f}")
print(f"  - Target Reward (Actual System): 96")