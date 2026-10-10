# vneMoon

`vneMoon` is a single-GPU autonomous research controller for Virne/AlphaVNE. It deliberately separates AI reasoning from experiment execution:

1. A short, ephemeral `codex exec` invocation inspects the isolated research worktree, implements one candidate, emits compact structured metadata, and exits.
2. The controller proves that invocation is gone.
3. Ordinary local subprocesses build/test/train/evaluate the candidate while no LLM is alive. Experiment subprocesses run sequentially with networking disabled.
4. Machine-readable metrics and Git commits are persisted. Only a compact history is sent to the next fresh Codex invocation.

The original dirty checkout is never reset or committed. On first launch, its tracked diff and non-ignored untracked source files are copied into a dedicated `vnemoon/autoresearch` worktree and committed there as the research baseline. Datasets, existing results, checkpoints, the controller, and the evaluation harness are outside Codex's editable worktree and are integrity-checked.

Every autonomous reasoning turn explicitly passes `--model gpt-6.1-sol -c model_reasoning_effort=medium` to `codex exec`. These defaults live in `vneMoon/config.json`; the controller never modifies `~/.codex/config.toml`. They can be changed in that local config or overridden for one campaign with `run --model MODEL --reasoning-effort EFFORT`.

Before each reasoning turn, the controller starts a local `codex app-server`, calls `account/rateLimits/read`, and checks the shared plus all reported model-specific primary and secondary windows. It pauses in ordinary Python when any window has 10% or less remaining, when quota data is missing/stale/inconsistent, or when spend control is reported. The reserve is configurable with `codex_quota_reserve_percent`. Pauses and reset times are recorded in `runtime/lifecycle.jsonl`; this check never performs inference, buys credits, changes accounts, or uses API-key billing.

Actual subscription-limit errors from `codex exec` are retried only within the same candidate with bounded exponential backoff. Repeated pre-experiment controller failures pause the campaign rather than creating an unbounded stream of failed candidates. A failed baseline smoke run blocks all Codex invocations.

Development uses copied prefixes of the existing **train** traces. The **test** traces are materialized and evaluated once, after the last Codex invocation; no later tuning is allowed. Acceptance is considered only when the run is complete, reported embeddings have zero violations, and the fixed request/runtime limits are met.

## First, run the short self-test

```bash
conda run -n virne python vneMoon/moon.py self-test
```

This uses mock workers, not a live Codex call or a Virne experiment. It verifies the crucial ordering (`codex_exited` before `experiment_started`), checks that the Codex-marked process is absent, and confirms that the experiment sandbox has no network access and receives no LLM credentials.

Optionally create and inspect the isolated research worktree without starting any experiment:

```bash
conda run -n virne python vneMoon/moon.py init
```

## Overnight command

```bash
conda run -n virne python -u vneMoon/moon.py run --hours 8
```

For an explicit one-campaign override:

```bash
conda run -n virne python -u vneMoon/moon.py run --hours 8 --model gpt-6.1-sol --reasoning-effort medium
```

Re-run the same command after a crash or reboot. `runtime/state.json`, `runtime/queue.json`, `runtime/experiments.jsonl`, per-candidate logs, patches, and the dedicated worktree provide recovery. A file lock prevents two controllers (and therefore two GPU-heavy experiments) from running at once.

Useful read-only commands:

```bash
conda run -n virne python vneMoon/moon.py preflight
conda run -n virne python vneMoon/moon.py status
```

To intentionally begin a brand-new campaign, use a different config/branch/worktree. Do not delete `runtime/` unless its experiment history has been archived.

