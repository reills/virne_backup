 The repository implements an AlphaZero-inspired solver for service function chaining (SFC) deployment. The key modules reside under virne/solver/learning/reinforcement_learning/mcts_solver.

Core Files
alpha_zero_sfc_solver.py – A wrapper that orchestrates Monte Carlo Tree Search (MCTS) with the actor/learner setup. The class AlphaZeroSFCSolver is registered as the solver entry point. Its learn method alternates between self-play data generation and policy updates, writing updated models to policy_latest.pt in the replay directory.

actor.py – Implements AlphaZeroActor, which loads the current policy and creates trajectories with MCTS. During observation construction, candidate nodes are masked using controller.find_candidate_nodes. Episodes are stored as JSON files under replay_buffer/.

learner.py – Defines AlphaZeroLearner. It samples stored trajectories from replay_buffer/, rebuilds observations, and performs gradient steps on the shared network weights.

net.py – Contains the ActorCritic neural network. Its AutoregressiveDecoder uses GNN layers and cross‑attention to produce logits over physical nodes and special actions (revoke/reject).

node.py – Provides State and Node for the MCTS tree. compute_final_reward returns 1000 + revenue - cost when placement succeeds, otherwise a large negative value.

mcts.py – Supplies base MCTS logic used by both the actor and learner.

Workflow Summary
Actors (actor.py) run MCTS on SFC placement instances, guided by the neural policy, and save each episode to replay_buffer/.

Learner (learner.py) repeatedly loads these episodes, reconstructs observations, and optimizes the ActorCritic model.

Updated parameters are written back to policy_latest.pt for the next self-play iteration.

This design adapts AlphaZero-style self-play from games to network resource allocation, coupling MCTS search with a transformer‑GNN policy network.
