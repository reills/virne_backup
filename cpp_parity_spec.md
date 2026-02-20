# C++ AlphaZero SFC Parity Spec

This document defines the behavioral parity rules the C++ runtime must match relative to the Python AlphaZero SFC implementation. The Python logic is the source of truth.

## Parity Rules (Must Match)

1. **Virtual node ordering**
   - Ordering is by descending total demand: sum of virtual node resource demand + sum of incident virtual link demands.
   - Ties preserve original virtual node order (stable sort).
   - Source of truth: `virne/solver/learning/reinforcement_learning/alpha_vne/node.py` (`State.v_order`).

2. **Action space and reject action**
   - Action indices `0..(num_p_nodes-1)` map to physical nodes.
   - Reject action index is `num_p_nodes` when `allow_rejection=true`.
   - Reject action must be included in action mask whenever allowed.

3. **Candidate generation**
   - Uses node-level constraint checks only (link constraints disabled in candidate search).
   - Excludes already selected physical nodes.
   - Source of truth: `controller.find_candidate_nodes(..., check_link_constraint=False)`.

4. **Incremental link feasibility**
   - When placing a virtual node, route newly-activated virtual edges if the neighbor is already placed.
   - The first feasible path among the shortest-path candidate list is chosen.
   - Methods that check link constraints during search: `bfs_shortest`, `available_shortest`.
   - Methods that *do not* check constraints during path enumeration: `first_shortest`, `k_shortest`, `k_shortest_length`, `all_shortest`, `available_k_shortest`.

5. **Reward**
   - Success: `1000 + revenue - cost`.
   - Failure due to infeasibility: `-1000`.
   - Explicit rejection: `-reject_penalty`.
   - Source of truth: `State.compute_final_reward` and `counter.calculate_v_net_cost`.

6. **Observation features**
   - Physical and virtual node features use *resource attributes only* (ordering matches controller resource attr order).
   - History features start with `decoder.start_embedding` followed by selected physical node features.
   - `curr_v_node_id` is the *placement step index* (not the virtual node ID).
   - `vnfs_remaining = max(v_net.num_nodes - (step_idx + 1), 0)`.
   - Source of truth: `alpha_vne/common.py:state_to_obs` and `alpha_vne/observation_builder.py`.

7. **Replay JSON schema**
   - Schema must match `trajectory_writer.py` exactly.
   - Each timestep includes `observation`, `pi`, `v_root`, `a_taken`, and `mask`.

## Concrete Examples

### Virtual order tie-breaking
If v-nodes `{0,1,2}` all have equal demand and were created in ID order, the order must remain `[0,1,2]`.

### Reject action
For a 500-node physical network with rejection enabled:
- Action space size = 501
- Reject action index = 500
- `action_mask[500]` must be `True` even when no feasible nodes exist.

### Reward example
If revenue is `120`, total cost is `80`, success reward = `1000 + 120 - 80 = 1040`.
If placement fails: reward = `-1000`.
If explicit reject: reward = `-reject_penalty` (default 50.0).
