# Repository Guidelines

## Project Structure & Module Organization
- `virne/`: Core package. Key areas: `solver/` (heuristic, exact, meta-heuristic, learning), `utils/`, `resource/`, `settings/` (YAML), `main.py` (entry), `config.py` (runtime config).
- Root scripts: `generate_sfc_datasets.py`, `run_sfc_study.py`, `ablation_study.py` (experiments), `visualizer.py` (plots).
- Data & results: `dataset/`, `sfc_datasets/`, `k_specific_training/`, `outputs/`, `results/`, `sfc_study_results/`.
- Tests: Experiment-style scripts at repo root (e.g., `test_sfc_study.py`, `test_k_specific_models.py`). See also `SFC_STUDY_README.md`.

## Build, Test, and Development Commands
- Create env (Conda): `conda env create -f setup/nfv_env.yml -n nfv` then `conda activate nfv`.
- Install (pip alternative): `pip install -r requirements.txt` (GPU/CUDA wheels may vary).
- Run main simulation: `python -m virne.main` (uses `virne/config.py` and YAML in `virne/settings/`).
- Generate SFC datasets: `python generate_sfc_datasets.py` (writes to `sfc_datasets/`).
- SFC study (paired comparisons): `python test_sfc_study.py --auto-find --k-values 1 5 9 15`.
- K-specific evaluation: `python test_k_specific_models.py --auto-find`.

## Coding Style & Naming Conventions
- Python 3.10+, 4-space indentation, PEP 8 guidelines.
- Modules/files: `snake_case.py`; classes: `PascalCase`; functions/vars: `snake_case`.
- Keep config in `virne/config.py` and YAMLs under `virne/settings/`. Prefer parameterizing via CLI/env over hardcoding.
- Optional tooling: format with Black and import-order via isort; lint with Ruff (not enforced in repo).

## Testing Guidelines
- Framework: script-driven experiments (no pytest suite).
- Naming: test scripts live at repo root and start with `test_*.py`.
- Run tests: examples above. Many tests read/write CSVs in dataset folders; ensure paths exist.
- Note: Some scripts temporarily edit `virne/config.py` and settings YAMLs; avoid concurrent runs unless scripts handle locking.

## Commit & Pull Request Guidelines
- Commits: concise, imperative subject (e.g., "update masking logic", "fix actor syncing issue"). Group related changes.
- PRs: include a clear description, rationale, and how to reproduce results; link issues if applicable. Add sample commands, affected paths, and screenshots/plots when visual output changes.
- Checks: verify scripts run (`python -m virne.main`) and experiment tests you touched complete without errors.

## Architecture Overview
- `Config` → loads YAML settings and resolves `save_dir`/dataset paths.
- `REGISTRY` → maps `solver_name` to `Env` and `Solver` types.
- `virne.main.run()` → builds `BasicScenario` and executes `scenario.run()`.
