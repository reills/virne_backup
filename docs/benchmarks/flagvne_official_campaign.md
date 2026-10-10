# Official FlagVNE Computer Networks campaign

Run the complete baseline campaign with one command from the repository root:

```bash
bash tools/run_flagvne_compnet_campaign.sh
```

The runner clones the official FlagVNE author repository, checks out the fixed
revision `06c65225a6bd42ffaa85c1046196b90b096b6ac1`, trains and evaluates ten
matched cells, validates the result matrix, and publishes the paper-facing
artifacts. Every Python command runs through `conda run -n virne`.

The author checkout is stored at `third_party/flag-vne/`. That path is ignored
by Git, and the campaign refuses to clone into it if the ignore rule is absent.
The checkout must remain at the pinned revision with a clean worktree. Source
URL, revision, cleanliness, and the project commit are recorded with the
results. The upstream repository does not contain a visible license file, so
its source is never copied into this repository or the manuscript bundle.

The runner uses the existing `virne` Conda environment. The author's current
install script requires `torchopt`; if that import is missing, the runner
installs the pinned `torchopt==0.7.3` package with
`conda run -n virne pip`. Set `AUTO_INSTALL_FLAGVNE_DEPS=0` to make a missing
dependency a hard preflight failure instead.

## Why an adapter is required

The author repository includes its own older Virne simulator. Its standard
entry point derives or generates request streams and expects the older dataset
configuration layout. Calling the supplied experiment script directly would
therefore fail to guarantee the same requests used by the manuscript.

`tools/flagvne_official_adapter.py` keeps the author model, task-policy training
procedure, bidirectional action policy, and solver logic, while loading the
existing fixed physical and virtual network datasets explicitly. It also
converts the author output into a validated per-cell schema for aggregation.
The author checkout itself is not patched.

## Matched experiment matrix

The campaign contains ten train/evaluation cells:

- topologies: BRAIN and GEANT;
- seeds: 0, 1, 2, 3, and 4;
- training requests:
  `datasets/generated/journal/nominal/<topology>/seed_<seed>/train`;
- evaluation requests:
  `datasets/generated/journal/nominal/<topology>/seed_<seed>/test`;
- training length: 100 epochs, following the author overall-performance
  runner;
- meta-learning epochs: 0, matching the author overall-performance runner;
- bidirectional action policy enabled and curriculum scheduling disabled,
  matching the author command-line defaults used by that runner;
- routing: `k_shortest` with `k=10`, matching the journal comparison;
- evaluation: greedy decoding over 1,000 fixed requests.

The routing setting is a declared comparison override. The author example
defaults to breadth-first shortest-path routing, whereas the manuscript's main
comparison uses `k_shortest=10`. The generated provenance records this choice.

FlagVNE runs inside the simulator version shipped by its authors. The campaign
matches the topology, complete arrival/departure trace, resources, seed, and
routing parameters. The author repository's routing implementation may still
differ internally from the newer Virne version used by AlphaVNE; this boundary
must be stated when reporting the result.

## Resume behavior

The stable default run tag is `flagvne_compnet_nominal_v1`. Each cell receives
its own output directory and an `eval/.complete` marker. A marker is written
only after `validate-cell` succeeds. On restart, marked cells are validated
again before being reused. An invalid marked cell stops the campaign so stale
or partial results cannot be accepted silently.

Stage markers are stored under:

```text
results/flagvne_campaign/flagvne_compnet_nominal_v1/stages/
```

Resume with the same command. To rerun an entire completed stage intentionally:

```bash
FORCE_STAGES="summarize publish validate" \
  bash tools/run_flagvne_compnet_campaign.sh
```

Cell markers remain authoritative. Remove a specific invalid cell directory
before intentionally retraining that cell.

## Planning and controls

Print the complete command plan without cloning, training, evaluating, or
writing campaign files:

```bash
PLAN_ONLY=1 bash tools/run_flagvne_compnet_campaign.sh
```

Use a different stable campaign identifier or GPU:

```bash
RUN_TAG=flagvne_compnet_nominal_v2 CUDA_DEVICE=1 \
  bash tools/run_flagvne_compnet_campaign.sh
```

Run selected stages after the ten cells are complete:

```bash
STAGES="summarize publish validate" \
  bash tools/run_flagvne_compnet_campaign.sh
```

Do not run this campaign concurrently with the main Computer Networks pipeline
on the same GPU. Preflight detects the known journal processes and waits in the
queue until they finish, so the command can be started once while the current
campaign is active. Set `WAIT_FOR_GPU=0` to fail immediately instead.
`ALLOW_GPU_SHARING=1` bypasses this gate when the processes have intentionally
been assigned to different devices.

## Validation gates

Before training, the runner requires all twenty fixed train/test directories,
their generation metadata, physical network, event stream, and exactly 1,000
virtual network files. The adapter performs the deeper content checks.

For every cell, validation must establish:

- the author checkout is clean and has the pinned commit;
- the train and test dataset payloads match their recorded source hashes;
- each request ID has one arrival and one departure in chronological order;
- CPU and bandwidth resources are preserved without adding author-default GPU
  or RAM resources;
- the saved configuration uses seed `<seed>`, 100 training epochs, and
  `k_shortest=10` for training and evaluation;
- evaluation uses the same trained solver object in the same process, before
  any model can be reinitialized; the saved checkpoint is hashed for
  provenance;
- evaluation contains 1,000 arrivals, finite metrics, and a consistent
  acceptance/success count.

The final gate requires ten unique per-seed rows and two topology aggregates.

## Outputs

Runtime data, checkpoints, logs, raw author summaries, normalized summaries,
and stage state are written beneath:

```text
results/flagvne_campaign/flagvne_compnet_nominal_v1/
```

Paper-facing files are copied to:

```text
paperjournal/compnet/generated/flagvne_official/
```

The published bundle contains:

- `per_seed.csv` and `aggregate.csv`;
- `paired_alpha.csv` and `paired_summary.csv`;
- `manuscript_fragment.tex`;
- `report.md`;
- analysis, official-source, and run manifests;
- `SHA256SUMS`.

The summarizer uses the corrected five-seed BRAIN AlphaVNE campaign
`journal_suite__brain_k10_steps5000_20260513T224921Z`. It must not use the
older BRAIN rows in `paperjournal/results_data/new_alpha_per_seed.csv`. The
candidate comparison table is published separately and does not overwrite the
active manuscript table automatically.
