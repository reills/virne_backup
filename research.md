I’d put the evidence in this order for your exact failure mode: the biggest risk is not that your backbone is too weak, but that your search targets are too flat/noisy, your search budget is being spent on too many barely-distinguishable feasible actions, and your replay/targets are not aligned with an acceptance-first single-player objective. The strongest papers below mostly point in that direction, with architecture as a secondary lever and “bigger model” as a distant third.

Ranked papers
1) Danihelka et al., Policy Improvement by Planning with Gumbel (ICLR 2022)

Best match to your “large feasible set + flat visit targets + weak search improvement” problem. Gumbel AlphaZero / Gumbel MuZero replaces some of AlphaZero’s heuristic root-action handling with a policy-improvement view and is reported to improve performance especially when planning with few simulations. For SFC/VNE, that maps directly onto “many feasible placements, but only a few that preserve future routability.” Highest-leverage area: search target quality.

Why it matters for you: if your visit distribution is diffuse because PUCT cannot cleanly separate many masked-feasible substrate nodes, this is the first paper I would try to operationalize.

2) Hubert et al., Learning and Planning in Complex Action Spaces / Sampled MuZero (ICML 2021)

This is the clearest primary-source treatment of MuZero-style planning when full action enumeration is infeasible or undesirable. The core idea is to plan over sampled action subsets within a principled policy-iteration framework, rather than pretending every action should be fully expanded every time. For SFC/VNE, this strongly supports candidate filtering / sampled expansion / top-k expansion when the feasible host set is large. Highest-leverage area: search + branching control.

Why it matters for you: your “candidate physical node per virtual node” space is exactly the kind of setting where sampled or filtered search can beat brute-force masked PUCT.

3) Willemsen et al., Value Targets in Off-Policy AlphaZero: A New Greedy Backup (2021/2022)

This is unusually relevant because your setup sounds closer to a practical off-policy / replay-heavy AlphaZero variant than the clean original board-game loop. They argue standard AlphaZero value targets can become misaligned when exploration-heavy search data is used to train a value function that is later judged under greedy execution, and show a greedy backup target can improve training efficiency and greedy play. For acceptance-first SFC/VNE, that is a strong hint that your value network may be learning the wrong notion of “goodness.” Highest-leverage area: target design / value calibration.

Why it matters for you: if acceptance is binary at the request level, a value trained on diffuse exploratory backups can look numerically “better” while still failing to drive good placement choices.

4) Moro et al., Goal-Directed Planning via Hindsight Experience Replay (ICLR 2022 workshop/poster)

This is the best direct reference I found for AlphaZero-like planning in sparse-reward deterministic control. The paper explicitly says AlphaZero-style methods struggle in goal-directed sparse-reward domains and proposes marrying AlphaZero with HER-style relabeling. Your request-level acceptance objective is not identical to multi-goal RL, but it is close in spirit: many trajectories fail late and provide weak supervision unless you relabel or reshape them. Highest-leverage area: replay composition / sparse-signal training.

Why it matters for you: rejected chains still contain useful information about partial feasibility, bottleneck links, and “almost-accepted” decisions; standard AlphaZero replay underuses that.

5) Pirnay et al., Policy-Based Self-Competition for Planning Problems (2023)

This paper is very close to your setting because it is explicitly about single-player planning problems where AlphaZero-type methods stall because the value network cannot approximate episode outcomes well enough. Their proposed fix is not just scalar self-competition, but policy-based self-competition on top of Gumbel AlphaZero, and they report gains on TSP and Job-Shop Scheduling. Highest-leverage area: training target redesign for single-player planning.

Why it matters for you: SFC/VNE is also a single-player constructive planning problem; the paper is basically warning that “plain AlphaZero losses” can be the wrong training signal.

6) Ye et al., Mastering Atari Games with Limited Data / EfficientZero (NeurIPS 2021)

EfficientZero is not a graph-combinatorial paper, but it is one of the best primary sources on getting MuZero-style planning to work under limited data. The paper shows a MuZero-derived method achieving strong performance in a very data-limited regime, which is relevant because your self-play distribution is likely much smaller and lower-entropy than AlphaZero’s original game domains. For your case, the main lesson is that training dynamics and representation learning tricks matter a lot when search data is scarce or low quality. Highest-leverage area: training stability / data efficiency.

Why it matters for you: if PPO is winning, it may simply be extracting more learning signal per environment step than your tree-search pipeline.

7) Wang et al., Joint Admission Control and Resource Allocation of Virtual Network Embedding via Hierarchical Deep Reinforcement Learning (IEEE TSC 2024)

This is not AlphaZero-style, but it is one of the strongest domain-near references explaining why PPO-style methods can win in VNE. They decompose the problem hierarchically, use PPO as the base learner, add average-reward treatment for the upper-level admission decision, and design a custom intrinsic reward to reduce sparse-reward difficulty; they report improved acceptance ratio and long-term revenue. Highest-leverage area: reward decomposition / hierarchy, not search.

Why it matters for you: it is evidence that PPO baselines may be beating your AlphaZero solver not because search is bad in principle, but because their optimization target is better aligned with sequential admission/resource allocation.

8) Huang et al., Coloring Big Graphs with AlphaGoZero (2019)

One of the best examples of AlphaZero-style search applied to a very large graph combinatorial problem. The paper’s main contribution is not just search, but a custom scalable architecture (FastColorNet) built to expose full-graph context while keeping inference affordable. Highest-leverage area: graph-specific architecture + scaling discipline.

Why it matters for you: it supports using graph-structured encoders, but also suggests the architecture must be tightly matched to the decision granularity and search budget; generic “bigger transformer/GNN” is probably not enough.

9) Li, Chen, and Koltun, Combinatorial Optimization with Graph Convolutional Networks and Guided Tree Search (NeurIPS 2018)

This is the classic “learn a graph prior, then use tree search to explore diverse solutions” paper. It is foundational for neural-guided search in graph combinatorial optimization and is worth reading because it crystallizes the standard recipe: node scores → diversified candidates → tree search over partial solutions. Highest-leverage area: candidate pruning and prior shaping.

Why it matters for you: conceptually similar to substrate-node ranking before expansion. But read it together with Böther et al. below, because the original positive story is not the whole story.

10) Böther et al., What’s Wrong with Deep Learning in Tree Search for Combinatorial Optimization (2022)

This is the most important “don’t fool yourself” paper on your list. They revisit a popular guided tree-search method and conclude the learned GNN in that setup did not learn a meaningful solution representation, with performance largely coming from classical algorithmic components rather than neural guidance. Highest-leverage area: diagnostics / ablation discipline.

Why it matters for you: if your policy head is learning “something” and value loss is dropping, you still may be getting most of your real performance from masking, candidate ordering, and routing heuristics rather than from the neural-search loop itself.

11) Xing et al., A Graph Neural Network Assisted Monte Carlo Tree Search Approach to Traveling Salesman Problem (2020)

A direct graph+MCTS constructive solver: a GNN produces priors over next-node choices, and MCTS improves those choices in a greedy constructive framework. The paper is relevant because it shows how to combine graph structure, local/edge features, and constructive search in a domain where poor early decisions can wreck the remainder of the solution. Highest-leverage area: policy prior over partial-solution expansions.

Why it matters for you: SFC/VNE also suffers from irrevocable early commitments; the analogy is strong.

12) Abe et al., Solving NP-Hard Problems on Graphs with Extended AlphaGo Zero (2019)

This is one of the more explicit attempts to adapt AlphaGo Zero to single-player graph combinatorial problems with graph inputs and varying graph sizes. It is useful less because it is the final answer, and more because it exposes the core friction points when moving from games to graph optimization: graph input representation, non-game rewards, and single-agent construction. Highest-leverage area: problem formulation choices.

Why it matters for you: it is a direct precedent that your setting is structurally different enough from chess/Go that “standard AlphaZero” should not be expected to transfer cleanly.

13) Silver et al., AlphaZero (2017) and Schrittwieser et al., MuZero (2020)

These are still essential, mainly as a baseline for what assumptions your domain violates. AlphaZero assumes the search itself produces strong enough policy-improvement targets from self-play; MuZero adds a learned model that predicts reward, policy, and value quantities relevant for planning. Your domain differs because it is single-player, acceptance-sparse, heavily constrained, graph-structured, and large-branching, so use these papers as the control condition—not as proof that the vanilla recipe should work. Highest-leverage area: understanding mismatch to canonical success cases.

14) Martin & Sandholm, AlphaZeroES: Direct Score Maximization Outperforms Planning Loss Minimization (AAMAS 2025 extended abstract)

I would treat this as provocative but important. Keeping the same search and architecture, they report that directly maximizing episode score can outperform the usual AlphaZero planning loss in single-agent environments. The evidence is much thinner than for Gumbel or Sampled MuZero, but the paper is highly relevant to an acceptance-first constructive problem like yours. Highest-leverage area: objective mismatch.

Why it matters for you: it is one of the clearest warnings that the standard policy/value imitation of search may simply be the wrong training objective for single-player combinatorial optimization.

15) Heo et al., Reinforcement Learning of Graph Neural Networks for Service Function Chaining (2020)

A smaller but domain-near SFC paper showing GNN-based RL can generalize across changing topologies without re-design/re-training to the same extent as fixed-topology supervised methods. It is not AlphaZero-style, but it is useful as evidence that graph encoders are plausibly helpful in SFC, while the bigger issue is likely the planning/training loop rather than the mere presence of a GNN. Highest-leverage area: architecture is not the first bottleneck.

What the literature suggests is highest-leverage

My read is:

Search target quality and branching control are the first things to fix. Gumbel-style policy improvement and Sampled-MuZero-style subset planning are the strongest evidence-backed ideas for large action sets.

Target design for single-player, acceptance-heavy tasks is next. Greedy value backups, HER-style relabeling, and policy-based self-competition are all directly about cases where vanilla AlphaZero targets are too weak or misaligned.

Reward/replay design matters more than enlarging the network. The PPO/VNE paper succeeds by decomposing the task and fixing sparse reward structure, not by adding fancier search.

Architecture is secondary unless you have evidence your model is underfitting obvious ranking structure. Graph-specific encoders help, but the cautionary CO literature says learned guidance can easily become cosmetic if the search/targets are wrong.

Top 5 interventions most likely to help your solver
1) Replace raw visit-count imitation with a sharper policy-improvement target

Best-supported option: test a Gumbel AlphaZero-style root improvement or, if that is too invasive, at least sharpen targets over a candidate subset instead of the full feasible set. In your domain, flat visit distributions over many feasible hosts are probably too weak to teach useful ranking. This is the most evidence-backed change.

2) Add candidate pruning / sampled expansion before MCTS

Do not ask MCTS to discriminate among every feasible physical node if many are obviously mediocre. Use a cheap learned or heuristic prescorer to keep only top-k hosts or sampled hosts per VNF, then search only there. This is exactly the kind of intervention Sampled MuZero motivates.

3) Redesign the value target around greedy acceptance-first play

Try a greedy-backup-style value target or a calibrated value normalization that reflects the metric you truly care about: final request acceptance under near-greedy inference. A falling value loss is not reassuring if the target itself is mismatched.

4) Make replay intentionally non-uniform

Over-sample: accepted chains, near-miss failures, and late-stage failures caused by routing/bandwidth bottlenecks. Under-sample easy early catastrophic failures. This is not generic replay advice; it follows from the sparse-signal papers and the domain papers that explicitly introduce intrinsic rewards/hierarchy to cope with sparse acceptance.

5) Add a single-player target hack, not a bigger network

Two plausible versions: policy-based self-competition or HER-like relabeling of partial goals/feasibility milestones. This is more speculative for SFC than the first three items, but still better-supported than “scale the transformer/GNN and hope.”

What I would not bother trying first

I would not start with:

A larger backbone. The literature does not support that as the first fix for underperforming single-player search in large-branching combinatorial problems.

More MCTS simulations without changing target quality. Gumbel’s value proposition is precisely that standard AlphaZero can waste low simulation budgets; adding budget alone often just makes the same weak ranking more expensive.

More root Dirichlet noise. In your regime it is more likely to worsen already-diffuse targets than to help. The action-set issue looks like excessive ambiguity, not under-exploration. This is an inference from the large-action papers, not a direct SFC result.

Purely cosmetic masking tweaks unless they materially reduce branching or improve ranking fidelity. The CO cautionary paper is a reminder that search can look “neural” while the actual wins come from classical pruning.

Final recommended experiment plan
3 low-risk changes

Top-k candidate expansion before tree search
Use a prescorer to keep only the top 8–16 host candidates per VNF, then renormalize priors over surviving children. Measure acceptance and policy entropy. This is the safest high-upside change.

Greedy-backup value target ablation
Keep everything else fixed and swap in a greedy-aligned backup target for value learning. Watch calibration of accepted vs rejected chains, not just MSE.

Replay rebalance
Stratify buffer sampling by outcome and failure stage: accept / late-fail / early-fail, with extra weight on accepted and late-fail cases. That is the cheapest way to make sparse acceptance signals denser without rewriting the planner.

2 medium-risk changes

Gumbel-style root policy improvement
Replace standard root visit imitation with Gumbel-style improvement over a candidate subset. This is probably the most promising “real” algorithmic upgrade, but it is more invasive.

HER-like relabeling for partial feasibility
Relabel failed episodes with auxiliary goals such as “place first m VNFs feasibly” or “preserve routability margin after step t.” This is not directly proven for SFC/VNE, so I’d call it moderately speculative but still grounded.

1 probably not worth it

Scaling the transformer/GNN before fixing search targets.
The graph-combinatorial literature gives too many examples where the neural prior was not the true bottleneck. In your case, I would only revisit model size after target sharpness, branching control, and replay design are demonstrably fixed.

My bottom line: treat this as a search-target problem first, a replay/credit-assignment problem second, and an architecture problem third. PPO beating your AlphaZero-style solver in SFC/VNE is completely plausible when the objective is sparse, the action set is large, and search-generated policy targets are too diffuse to teach useful ranking.