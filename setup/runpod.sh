#!/bin/bash
set -e

echo "Installing nano..."
apt update && apt install -y nano

echo "Installing Miniconda..."
wget -q https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh
bash miniconda.sh -b -p $HOME/miniconda3
rm miniconda.sh

eval "$($HOME/miniconda3/bin/conda shell.bash hook)"
conda init
source ~/.bashrc || true
source $HOME/miniconda3/etc/profile.d/conda.sh

echo "Creating and activating Conda environment..."
conda env create -f setup/nfv_env.yml
conda activate nfv

echo "📁 Cloning project repo..."
git clone git@github.com:reills/virne.git
cd virne
 
echo "Running experiment..."
python -m virne.main

# Optional: Auto-push results
# echo "📤 Attempting to push results..."
# git config --global user.name "Stephen Reilly"
# git config --global user.email "you@example.com"
# git add -f dataset/results-sfc-trans
# git commit -m "Auto-pushed results from RunPod on $(date)"
# git push origin main