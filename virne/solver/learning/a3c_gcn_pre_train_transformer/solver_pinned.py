"""
Pinned Solver wrapper for the A3C GCN Pre-Train Transformer.

This subclass swaps in PinnedInstanceEnv to support endpoint pinning without
changing the existing solver logic. All other behaviors are inherited.
"""

from .solver import A3CGcnPreTrainTransformerSolver
from .instance_env2 import PinnedInstanceEnv


class A3CTransformerPinned(A3CGcnPreTrainTransformerSolver):
    """
    Same as A3CGcnPreTrainTransformerSolver, but uses PinnedInstanceEnv.
    The `pinned_v_to_p` mapping should be provided via the solver's
    `basic_config` (e.g., solver.basic_config['pinned_v_to_p'] = {...}).
    """

    def __init__(self, controller, recorder, counter, **kwargs):
        super().__init__(controller, recorder, counter, **kwargs)
        # Override the instance env to the pinned version after parent init
        self.InstanceEnv = PinnedInstanceEnv

