#!/usr/bin/env bash
set -euo pipefail

# Deterministic rebuild path for alpha_vne C++ extension.
# Run from anywhere inside the repository.

REPO_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || true)"
if [[ -z "${REPO_ROOT}" ]]; then
  echo "ERROR: Not inside a git repository. Run this from /home/stephen-reilly/dev/virne."
  exit 1
fi

cd "${REPO_ROOT}"

echo "INFO: Preflight checks in conda env 'virne'..."
conda run -n virne python -c "import torch, pybind11; print('torch', torch.__version__); print('pybind11', pybind11.__version__)"
conda run -n virne cmake --version | sed -n '1,2p'

echo "INFO: Building alpha_vne C++ extension..."
bash virne/solver/learning/reinforcement_learning/alpha_vne/cpp_core/build.sh

echo "INFO: Verifying extension import..."
conda run -n virne python -c "from virne.solver.learning.reinforcement_learning.alpha_vne import alpha_zero_cpp_core as m; print(m.__file__)"

echo "SUCCESS: alpha_vne C++ extension rebuilt and import verified."
