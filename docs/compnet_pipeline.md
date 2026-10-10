# Computer Networks journal pipeline

Run the journal evidence workflow with one command:

```bash
bash tools/run_compnet_journal_pipeline.sh
```

The script uses the `virne` Conda environment for every Python command. It is
fail-fast and resumable. Its default `RUN_TAG` is stable, and it stores one
completion marker per stage under
`results/compnet_pipeline/compnet_journal_v1/stages/`. Rerunning the same
command skips completed stages. The experiment runners also check individual
training and evaluation cells before doing work.

The final CSV, Markdown, LaTeX-table, provenance, checksum, and manuscript PDF
artifacts are written under `paperjournal/compnet/generated/`. Both
`paperjournal/` and `results/` are ignored by Git. Model checkpoints remain in
the existing ignored results directories and are not copied into the paper
artifact bundle.

## Useful controls

Print the commands without running experiments or builds:

```bash
PLAN_ONLY=1 bash tools/run_compnet_journal_pipeline.sh
```

Resume a named campaign:

```bash
RUN_TAG=compnet_journal_v1 bash tools/run_compnet_journal_pipeline.sh
```

Run selected stages:

```bash
STAGES="preflight benchmark_additions publish validate" \
  BUILD_PAPER=0 \
  bash tools/run_compnet_journal_pipeline.sh
```

Intentionally rerun a completed stage:

```bash
FORCE_STAGES="aggregate publish validate paper" \
  bash tools/run_compnet_journal_pipeline.sh
```

Skip the LaTeX build while producing the evidence package:

```bash
BUILD_PAPER=0 bash tools/run_compnet_journal_pipeline.sh
```

Do not delete stage markers to resume an interrupted stage. A marker is written
only after its stage succeeds. The underlying GPPVNE, AlphaVNE, and
generalization runners resume completed cells from their own output summaries.

## Default stages

| Stage | Purpose | Resume behavior |
| --- | --- | --- |
| `preflight` | Check required commands, manuscript sources, CUDA, and the AlphaVNE C++ import. | Stage marker. |
| `benchmark_additions` | Run or reuse the five-seed GPPVNE and reachability-filter campaigns, then validate candidate tables. | Complete matrices go directly through provenance validation; otherwise GPPVNE uses `--resume` and AlphaVNE checks each cell. |
| `matched_search` | Compare neural-guided and no-neural-network feasibility-aware MCTS with the same 96-simulation budget. | Reuses each existing `summary.csv`. |
| `matched_external_mcts` | Evaluate the registered classical MCTS baseline at the same 96 simulations and pair it with AlphaVNE on identical traces. | Uses an isolated run namespace and resumes complete cells. |
| `hard_stress` | Re-aggregate the completed five-seed hard Waxman in-domain study without retraining. | Aggregation only. |
| `generalization` | Evaluate nominal-trained AlphaVNE on shifted request distributions for BRAIN, GEANT, and Waxman-100. | Reuses each existing `summary.csv`. |
| `aggregate` | Rebuild the general latest-per-cell journal summary tables while excluding the separate 96-simulation MCTS campaign. | Stage marker. |
| `publish` | Copy only paper-facing results into `paperjournal/compnet/generated/`. | Stage marker. |
| `paper` | Build `paperjournal/compnet/main.tex` and reject undefined citations or references. | Stage marker; disable with `BUILD_PAPER=0`. |
| `validate` | Enforce the expected result-matrix sizes and write SHA-256 checksums for the final artifact set. | Stage marker. |

## Scope of the evidence

The pipeline produces evidence for the closest available reviewer requests. It
does not silently label unsupported studies as complete. The generated
`evidence_status.md` records the exact boundary.

Implemented evidence includes matched GPPVNE, reachability ablation,
equal-simulation AlphaVNE comparisons against both its no-neural variant and
the registered classical MCTS baseline, joint node-and-link hard Waxman stress,
and request-distribution generalization on three substrate families.

No faithful production runner currently exists for:

- equal wall-clock-budget MCTS comparisons;
- PACT or VNE-NNMCTS reproduction;
- isolated node-constrained versus link-constrained regimes;
- policy-only versus policy-plus-value-head ablation and value calibration;
- transfer to a genuinely unseen substrate topology.

Those items require new experiment code and should remain limitations in the
paper until their runners and validation rules are implemented.
