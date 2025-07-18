The repository implements an AlphaZero-inspired solver for service function chaining (SFC) deployment. The design uses a decoupled Actor-Learner architecture to allow for scalable, asynchronous training. The key modules reside under virne/solver/learning/reinforcement_learning/mcts_solver.
Core Files
alpha_zero_sfc_solver.py – This file contains the main Orchestrator and is the registered entry point (alpha_zero_sfc) for the solver within the framework. Its primary responsibilities are:
Managing Lifecycle: Its learn() method launches the AlphaZeroLearner in a dedicated background process and can run an initial data generation phase.
Acting: Its solve() method makes the main process behave as the primary Actor. It finds a solution for the current request while saving the game trajectory to the replay buffer.
Cleanup: It ensures the background learner process is properly terminated when the system closes.
actor.py – Defines the AlphaZeroActor class, a reusable component responsible for executing a single self-play "game." It uses Monte Carlo Tree Search (MCTS) guided by the current neural network policy to generate a high-quality trajectory, which it then saves to disk.
learner.py – Implements the AlphaZeroLearner, which is designed to run in a dedicated background process. It continuously:
Samples batches of game trajectories from the replay buffer.
Performs gradient updates on the ActorCritic network weights.
Saves the improved model back to disk for the actors to use.
net.py – Contains the ActorCritic neural network. Its AutoregressiveDecoder uses GNN layers and cross-attention to produce logits over physical nodes.
node.py – Provides the State and Node classes used to construct the MCTS tree. The State.compute_final_reward method calculates the terminal reward (1000 + revenue - cost on success).
mcts.py – Supplies the base MCTS logic used by the AlphaZeroActor to intelligently search for optimal placements.
Workflow Summary
The system operates via asynchronous communication between processes, using the file system as a bridge.
Initiation: When the framework calls the learn() method on the AlphaZeroSFCSolver (the Orchestrator), it launches the Learner in a background process.
Acting: The main process, through calls to the Orchestrator's solve() method, acts as the primary Actor. It loads the latest policy from policy_latest.pt, plays a game, and writes the full trajectory to a new JSON file in the replay_buffer/.
Learning: Concurrently, the background Learner process watches the replay_buffer/. It loads batches of completed games, trains the network, and periodically overwrites policy_latest.pt with the new, improved weights.
Policy Update: The next time the Actor starts a game, it loads the newer policy from policy_latest.pt, thus completing the self-play improvement cycle.
This decoupled design faithfully adapts AlphaZero-style self-play to the domain of network resource allocation, coupling an intelligent MCTS search with a powerful transformer-GNN policy network for continuous improvement.
