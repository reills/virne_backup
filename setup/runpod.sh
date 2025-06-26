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
 
echo "Copying test_1 into dataset/test_1."
mkdir -p dataset/test_1
cp -r test_1/* dataset/test_1/

pip install torch-scatter torch-sparse torch-cluster torch-spline-conv torch-geometric \
  -f https://data.pyg.org/whl/torch-2.5.1+cu118.html


echo "set -g mouse on" >> ~/.tmux.conf

echo "Launching experiment in tmux session 'train'..."
tmux new -s train -d 
tmux attach -t train

conda activate nfv 
python -m virne.main 

#echo 'done' > /root/training_complete.flag"
