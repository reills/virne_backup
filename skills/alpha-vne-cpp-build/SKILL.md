---
name: alpha-vne-cpp-build
description: Rebuild and verify the alpha_vne C++ extension (`alpha_zero_cpp_core`) with a deterministic, first-try workflow. Use when an agent is working on `virne/solver/learning/reinforcement_learning/alpha_vne/cpp_core` and needs the canonical bash-based rebuild path, import verification, and direct fixes for common build/test invocation errors.
---

# Alpha VNE C++ Build

Use a strict rebuild flow. Start with the helper script.

## Do This First

1. Rebuild + import verify:
`bash skills/alpha-vne-cpp-build/scripts/rebuild_alpha_vne_cpp.sh`
2. Smoke test (path-safe):
`conda run -n virne python -m pytest <test-path> -q`

## Rules

- Do not start with ad-hoc `cmake`/`make`.
- Do not use `conda run -n virne pytest ...`; use `python -m pytest`.
- Treat compile success and GPU runtime checks as separate concerns.

## If It Fails

- `ModuleNotFoundError: virne`: rerun tests with `python -m pytest`.
- Missing `torch`/`pybind11`: `conda run -n virne pip install torch==2.6.0 pybind11`.
- Import fails after build: rerun helper script (it rebuilds and relinks).
- `nvidia-smi` fails in sandbox: verify GPU in host shell before concluding runtime is unavailable.

## Resources

- Helper script: `skills/alpha-vne-cpp-build/scripts/rebuild_alpha_vne_cpp.sh`
