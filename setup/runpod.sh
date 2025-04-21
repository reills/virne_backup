#!/bin/bash
set -e
 
 

echo "Installing micro..."
apt update && apt install -y micro
apt install -y tmux

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
 
echo "Copying garbage_1 into dataset/garbage_1_trans..."
mkdir -p dataset/garbage_1_trans
cp -r garbage_1/* dataset/garbage_1_trans/

pip install torch-scatter torch-sparse torch-cluster torch-spline-conv torch-geometric \
  -f https://data.pyg.org/whl/torch-2.5.1+cu118.html


echo "set -g mouse on" >> ~/.tmux.conf

echo "Launching experiment in tmux session 'train'..."
tmux new -s train -d 

echo "Started in tmux session. Run this to reattach:"
echo "  tmux attach -t train"

conda activate nfv 
#python -m virne.main 

#echo 'done' > /root/training_complete.flag"
