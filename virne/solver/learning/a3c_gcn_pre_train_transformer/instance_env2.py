"""
Pinned Instance Environment for endpoint-constrained placement.

This extends InstanceEnv to allow pinning specific virtual nodes to specific
physical nodes by restricting the action mask at those decoder steps.

Only the action mask is constrained; all feasibility checks and revoke logic
remain unchanged. This file is additive and does not modify existing code.
"""

from typing import Dict, Optional
import numpy as np

from .instance_env import InstanceEnv


class PinnedInstanceEnv(InstanceEnv):
    """
    Instance environment that supports endpoint pinning via `pinned_v_to_p`.

    If the current virtual node is pinned, the action mask will only allow the
    pinned physical node (plus revoke/reject if those special actions are enabled).
    """

    def __init__(self, *args, pinned_v_to_p: Optional[Dict[int, int]] = None, **kwargs):
        # Store the pinning map before parent init so it is available during mask generation
        self.pinned_v_to_p: Optional[Dict[int, int]] = pinned_v_to_p or {}
        super().__init__(*args, **kwargs)

    def generate_action_mask(self):
        """
        Generates a valid action mask with the following behavior:
        - Length is always p_net.num_nodes + 2 to match the decoder's action space
          [0..N-1 physical nodes] + [N: revoke] + [N+1: reject].
        - If the current vnode is pinned, only the pinned physical node is enabled
          (plus revoke if applicable). Reject remains off unless explicitly enabled
          by phase gating.
        - If not pinned, falls back to the cached candidates (filtered for repeats),
          then adds revoke/reject flags according to env logic.
        """
        full_len = self.p_net.num_nodes + 2
        mask = np.zeros((full_len,), dtype=bool)

        # Build candidate physical nodes using the cached list populated in get_observation()
        current_candidates = list(self._cached_candidates) if self._cached_candidates is not None else []
        valid_candidates = self.filter_repeats(current_candidates)

        # Special action indices as expected by the policy decoder
        revoke_idx = self.p_net.num_nodes
        reject_idx = self.p_net.num_nodes + 1

        # Identify any already-placed neighbors' physical nodes to avoid zero-hop routing
        placed_neighbor_pnodes = set()
        try:
            for n_v in self.v_net.adj.get(self.curr_v_node_id, []):
                if n_v in self.solution['node_slots']:
                    placed_neighbor_pnodes.add(self.solution['node_slots'][n_v])
        except Exception:
            # Fallback for different graph structures
            for n_v in self.v_net.neighbors(self.curr_v_node_id):
                if n_v in self.solution['node_slots']:
                    placed_neighbor_pnodes.add(self.solution['node_slots'][n_v])

        # Pinning logic: restrict to the pinned physical node for this step
        if self.pinned_v_to_p and self.curr_v_node_id in self.pinned_v_to_p:
            pinned_p = int(self.pinned_v_to_p[self.curr_v_node_id])
            # Disallow selecting a pinned node that is already used by a prior placement
            # (mirrors the standard behavior of excluding selected_p_net_nodes)
            # Also disallow selecting the same p-node as any already-placed neighbor
            if (
                pinned_p not in self.selected_p_net_nodes
                and pinned_p not in placed_neighbor_pnodes
                and 0 <= pinned_p < self.p_net.num_nodes
            ):
                mask[pinned_p] = True  # Force pin even if it wasn't in the cached candidates
        else:
            # No pin: enable all valid physical candidates, but exclude any future-reserved
            # pinned physical nodes to avoid downstream conflicts when endpoints are pinned.
            future_reserved = set()
            if self.pinned_v_to_p:
                for vnode, p in self.pinned_v_to_p.items():
                    # Reserve for vnodes that are not yet placed (future steps)
                    if vnode not in self.solution['node_slots']:
                        future_reserved.add(int(p))
            for p in valid_candidates:
                if (
                    0 <= p < self.p_net.num_nodes
                    and p not in future_reserved
                    and p not in placed_neighbor_pnodes
                ):
                    mask[p] = True

        # Allow revoke if budgets permit
        if self.has_more_revokes():
            mask[revoke_idx] = True

        # Keep reject disabled by default (phase gating mirrors parent env)
        if (self.phase >= 4 or self.phase == -2) and self.allow_rejection and self.solution['num_interactions'] > 0:
            mask[reject_idx] = True

        # Guarantee at least one valid action (pinned node or some candidate)
        # If everything is False (rare), enable a harmless fallback: the first physical node
        if not mask.any():
            # Prefer revoke if available; otherwise, pick an arbitrary safe node 0
            if self.has_more_revokes():
                mask[revoke_idx] = True
            else:
                mask[0] = True

        return mask
