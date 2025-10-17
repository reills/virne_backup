#!/bin/bash

# This script automates the build process for the C++ MCTS core.
# It ensures that the environment is set up correctly and that CMake can find LibTorch.

# Exit immediately if a command exits with a non-zero status.
set -e

# --- Step 0: Navigate to the script's own directory ---
# This makes the script runnable from anywhere.
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd "$SCRIPT_DIR"
echo "INFO: Running build script in $(pwd)"

# --- Step 1: Activate Conda Environment ---
# This is crucial for ensuring the correct python, cmake, and libraries are on the PATH.
# Note: In a script, `conda activate` may not work. We use the recommended hook.
echo "INFO: Activating conda environment..."
eval "$(conda shell.bash hook)"
conda activate virne

# --- Step 2: Find the PyTorch (LibTorch) C++ Path ---
echo "INFO: Finding PyTorch C++ library path..."
TORCH_CMAKE_PATH=$(python -c "import torch; import os; print(os.path.join(os.path.dirname(torch.__file__), 'share/cmake'))")

if [ -z "$TORCH_CMAKE_PATH" ]; then
    echo "ERROR: Could not find PyTorch CMAKE path. Is PyTorch installed in the 'virne' environment?"
    exit 1
fi
echo "INFO: Found PyTorch at: $TORCH_CMAKE_PATH"

# --- Step 3: Create a Clean Build Directory ---
# We build inside the 'cpp_core' directory.
BUILD_DIR="build"
echo "INFO: Creating a clean build directory at $(pwd)/$BUILD_DIR"
rm -rf "$BUILD_DIR"
mkdir -p "$BUILD_DIR"
cd "$BUILD_DIR"

# --- Step 4: Run CMake to Configure the Project ---
# This is the critical step where we pass the path to LibTorch.
echo "INFO: Configuring project with CMake..."
export NVCC_PREPEND_FLAGS="-allow-unsupported-compiler ${NVCC_PREPEND_FLAGS}"
CUDA_HOST_FLAG=""
COMPILER_OVERRIDES=""
if command -v g++-12 >/dev/null 2>&1 && command -v gcc-12 >/dev/null 2>&1; then
    CUDA_HOST_FLAG="-DCMAKE_CUDA_HOST_COMPILER=$(command -v g++-12)"
    COMPILER_OVERRIDES="-DCMAKE_C_COMPILER=$(command -v gcc-12) -DCMAKE_CXX_COMPILER=$(command -v g++-12)"
    export CUDAHOSTCXX="$(command -v g++-12)"
    export NVCC_PREPEND_FLAGS="-ccbin $(command -v g++-12) ${NVCC_PREPEND_FLAGS}"
fi
cmake -DCMAKE_PREFIX_PATH="$TORCH_CMAKE_PATH" -DCMAKE_BUILD_TYPE=Release $CUDA_HOST_FLAG $COMPILER_OVERRIDES ..

# --- Step 5: Compile the Code ---
echo "INFO: Compiling C++ code..."
# Use all available CPU cores to build in parallel.
make -j$(nproc)

# --- Step 6: Link the Compiled Module for Python ---
echo "INFO: Linking compiled module for easy Python import..."
# Find the compiled .so file (there should only be one).
# The name can vary slightly based on Python version and platform.
COMPILED_MODULE=$(ls alpha_zero_cpp_core*.so)

if [ -z "$COMPILED_MODULE" ]; then
    echo "ERROR: Could not find compiled .so file in $(pwd)"
    exit 1
fi

# Create a symbolic link in the parent directory (alpha_vne), where the Python code lives.
# This allows `import alpha_zero_cpp_core` to work without changing PYTHONPATH.
DEST_DIR=".."
ln -sf "$(pwd)/$COMPILED_MODULE" "$DEST_DIR/"
echo "INFO: Linked $COMPILED_MODULE to $DEST_DIR/"

echo "
SUCCESS: The C++ extension has been built and linked successfully.
- You no longer need to set PYTHONPATH to run your solver.
"
