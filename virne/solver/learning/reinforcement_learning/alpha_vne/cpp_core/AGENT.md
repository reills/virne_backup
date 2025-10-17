# AlphaZero SFC C++ Core

This directory hosts the performance‑critical components of the AlphaZero SFC
solver implemented in C++ with [LibTorch](https://pytorch.org/cppdocs/) and
[pybind11](https://pybind11.readthedocs.io). The goal is to offload the hot
path (MCTS expansion and policy inference) from Python while keeping the higher
level orchestration unchanged.

## Layout

```
cpp_core/
├── CMakeLists.txt          # Build configuration
├── include/                # C++ headers
│   ├── state.hpp
│   ├── node.hpp
│   ├── mcts_engine.hpp
│   └── policy_network.hpp
└── src/                    # C++ sources
    ├── state.cpp
    ├── node.cpp
    ├── mcts_engine.cpp
    ├── policy_network.cpp
    └── bindings.cpp        # pybind11 glue
```

## Building

1. Install prerequisites:
   - LibTorch (matching your Python PyTorch build). Download the precompiled
     archive and set `LIBTORCH_PATH` to its root (e.g. `export LIBTORCH_PATH=$HOME/libtorch`).
   - `pybind11` headers with CMake support (`pip install pybind11` installs them).
   - A compiler with C++17 support and OpenMP (GCC ≥ 9 or Clang ≥ 10 recommended).

2. Configure and build:

```bash
cd virne/solver/learning/reinforcement_learning/mcts_solver/cpp_core
cmake -B build -DCMAKE_BUILD_TYPE=Release
cmake --build build --config Release
```

You can point CMake directly at your LibTorch install with
`-DTorch_DIR=/path/to/libtorch/share/cmake/Torch`. On Windows, pass the generator
appropriate for MSVC and ensure you use the matching runtime (MT vs MD).

3. The compiled extension (`alpha_zero_cpp_core.*.so/pyd`) will be placed in
`build`. You can copy or symlink it next to `actor_optimized.py`, or set
`PYTHONPATH` to include the build directory.

4. Enable the backend in Hydra config by toggling:

```yaml
training:
  use_cpp_mcts: true
```

When the flag is `true` and the extension can be imported, the actor will
delegate tree search to the C++ engine. Otherwise it falls back to the Python
implementation automatically.

## Status

The initial version focuses on establishing the scaffolding and API parity with
the existing Python implementation. The `alpha_zero_cpp_core` module exposes:

- `PolicyNetwork` – LibTorch wrapper that loads TorchScript artefacts.
- `StateView` and `TreeNode` – Light‑weight views of the environment state.
- `MCTSEngine` – Batched tree search with OpenMP parallel expansion.

Once validated, the Python actor will forward requests to the C++ engine for
search while keeping data marshaling and replay buffer logic in Python.
