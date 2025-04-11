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
 
echo "📁 Copying results-seq-sfc into dataset/results-sfc-trans..."
mkdir -p dataset/results-sfc-trans
cp -r results-seq-sfc/* dataset/results-sfc-trans/


echo "Running experiment..."
python -m virne.main

echo "done" > /root/training_complete.flag