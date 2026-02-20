---
name: virne-run
description: Run repository commands in the correct environment for this project. Use when executing Python scripts, tests, or tooling in /home/stephen-reilly/dev/virne so commands consistently run with `conda run -n virne`.
---

# Virne Run

Run all Python-facing commands through the `virne` conda env.

## Command Pattern

- Prefer: `conda run -n virne <command> ...`
- Avoid: `conda activate virne` (non-interactive shells often do not load conda init hooks)

## Common Commands

- Script: `conda run -n virne python tools/journal_experiments.py --stage preflight`
- Tests: `conda run -n virne pytest`
- Module check: `conda run -n virne python -m py_compile tools/journal_experiments.py`

## Notes

- Keep current working directory at repo root (`/home/stephen-reilly/dev/virne`) unless a task requires another path.
- If a command still fails, print the exact failing command and stderr in the update.
