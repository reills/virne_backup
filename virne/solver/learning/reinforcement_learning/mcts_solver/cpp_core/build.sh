#!/bin/bash

set -e

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd "$SCRIPT_DIR"
echo "INFO: Building mcts_cpp_core in $(pwd)"

if ! command -v conda >/dev/null 2>&1; then
  echo "ERROR: Conda is required to build the extension."
  exit 1
fi

echo "INFO: Activating conda environment 'virne'..."
eval "$(conda shell.bash hook)"
conda activate virne

PYTHON_EXEC=$(which python)
echo "INFO: Using python at ${PYTHON_EXEC}"

BUILD_DIR="build"
rm -rf "$BUILD_DIR"
mkdir -p "$BUILD_DIR"
cd "$BUILD_DIR"

cmake -DPython3_EXECUTABLE="$PYTHON_EXEC" -DCMAKE_BUILD_TYPE=Release ..

make -j"$(nproc)"

MODULE=$(ls mcts_cpp_core*.so)
if [ -z "$MODULE" ]; then
  echo "ERROR: Build succeeded but no module was produced."
  exit 1
fi

ln -sf "$(pwd)/$MODULE" ..
echo "SUCCESS: Built and linked $MODULE"
