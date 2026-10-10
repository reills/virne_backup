# GPPVNE independent reproduction

This repository registers `gpp_vne`, an independent Virne reproduction of Ali
and Ullah's 2025 GAT-augmented PPO method. It is not the authors' source code.

Primary sources:

- Preprint: *Simultaneous Node-Link Mapping for Virtual Network Embedding in
  5G/6G Environments Using GAT-Augmented PPO*, Research Square,
  <https://doi.org/10.21203/rs.3.rs-6853878/v1>
- Published article: *Joint-node-link Mapping for Virtual Network Embedding in
  5G/6G Environments Using GAT-Augmented PPO*,
  <https://doi.org/10.1007/s11036-025-02481-6>

## Paper-to-code mapping

| Paper element | Virne reproduction |
| --- | --- |
| GAT state encoder | Separate GAT encoders for the residual physical network and current VNR |
| Two GAT layers, hidden size 64 | `nn.num_layers=2`, `nn.embedding_dim=64` |
| PPO, gamma 0.99, GAE 0.95, clip 0.2 | Virne's on-policy PPO with those settings |
| Mini-batch 64 | `training.batch_size=64` |
| Actor/critic learning rate 1e-4 | `rl.learning_rate.actor/critic=0.0001` |
| Gradient norm 0.5, entropy 0.01, critic 0.5 | Matching PPO overrides in `journal_suite.yaml` |
| Critical virtual nodes | NRM ordering, based on node demand and incident bandwidth demand |
| Stepwise joint node/link mapping | Every three node-placement steps, all newly exposed links are feasibility-checked, routed, and reserved |
| Action masking | Infeasible and already-used physical nodes are masked before sampling |
| Revenue minus lambda times cost | Incremental embedding cost plus terminal accepted-request revenue |

## Declared reproduction choices

The paper does not provide enough detail to recreate several parts exactly:

- It defines a joint node/path action but gives no path-candidate construction or
  path-policy output head. The reproduction lets PPO choose a physical node and
  uses Virne's configured feasible k-shortest-path mapper for an exposed link.
- It says two or three virtual nodes are processed at a time, but does not give a
  subset-selection rule; Table 2 separately says "node embedding batch 32" and
  gives a three-step link-embedding interval. NRM provides a deterministic
  critical-node order, and the reproduction uses the reported three-step
  routing checkpoint (with a final checkpoint for incomplete groups).
- The reward trade-off factor lambda and failure penalty are not reported. The
  profile declares `cost_weight=0.1` and `failure_penalty=1.0`; these should be
  tuned on validation data, never on the reported test seeds.
- The paper reports PPO together with a 100,000-transition replay buffer,
  epsilon exploration, and Gaussian action noise, without specifying an
  off-policy correction or how continuous noise applies to its discrete node
  action. The reproduction uses standard on-policy PPO rollouts and categorical
  sampling.
- Dropout is named but its probability is not reported. The profile declares
  `nn.dropout_prob=0.1`.
- Table 2 says 10,000 simulation steps, while the learning figure extends to
  25,000 episodes. The main profile uses 25 epochs over 1,000 requests (25,000
  request episodes); shorten `training.num_train_epochs` if reproducing the
  table rather than the plotted training horizon.

These choices are available at runtime in
`GppVneSolver.reproduction_notes` and should be disclosed in any comparison.

The Brain/GEANT and hard-Waxman profiles are matched-protocol comparisons: they
use the same requests, capacities, constraints, routing candidates, seeds, and
training/test split as AlphaVNE and the other Virne baselines. They deliberately
do not copy GPPVNE-only simulation settings such as a 50-node substrate,
five-millisecond latency constraint, 0.02 failure rate, or 1.5 demand scaling,
because applying those settings only to one method would invalidate the
comparison. Consequently, do not compare the resulting absolute metric values
directly with the paper's plotted values.

## Run it

For the paper benchmark and the missing no-reachability cells, use the single
resumable production runner. It intentionally performs no smoke stage and uses
five seeds on BRAIN and GEANT. The runner does **not** rerun the completed Full
AlphaVNE ablation: it validates and reuses
`20260714Tjournal_components_5seed_v1`, runs only `no_reachability`, pairs the
new cells with the matching Full seeds, and publishes the resulting rows into
the existing component-ablation table in the July 17 paper snapshot:

```bash
bash tools/run_infocom_benchmark_additions.sh
```

If interrupted, rerun it with the `STAMP` printed at startup:

```bash
STAMP=YYYYMMDDTHHMMSSZ bash tools/run_infocom_benchmark_additions.sh
```

The production profile uses an isolated `gpp_vne_infocom` run-ID namespace.
This is deliberate: a completed one-epoch smoke checkpoint must never satisfy
the resume check for the 25-epoch paper run.

Quick integration run on Brain, seed 0, CPU:

```bash
PROFILE=gpp_vne_smoke bash tools/run_gpp_vne_benchmark.sh
```

Five-seed Brain and GEANT run at k=10:

```bash
bash tools/run_gpp_vne_benchmark.sh
```

Run only selected stages or print commands without executing them:

```bash
STAGES="preflight train eval" RESUME=1 bash tools/run_gpp_vne_benchmark.sh
DRY_RUN=1 bash tools/run_gpp_vne_benchmark.sh
```

Run it alone in the hard Waxman in-domain protocol:

```bash
METHODS="gpp_vne" SEEDS="0 1 2 3 4" \
  bash tools/run_waxman_hard_indomain_sweep.sh
```

The defensible result statement is "best among the evaluated methods under the
matched Virne protocol." A broader state-of-the-art claim requires matched
datasets, constraints, training budgets, seeds, and statistical testing.
