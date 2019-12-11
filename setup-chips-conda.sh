#! /bin/bash

if [ -d "$(pwd)/miniconda/envs/chips-conda/" ]
then
    source miniconda/bin/activate
    conda activate chips-conda
else
    # We want to install this in the chips-env directory
    echo "We need to install miniconda and the chips-conda environment!"
    echo "Are you in the chips-env directory and want to continue?"
    echo "Press any key to continue..."
    read key

    # Download the latest version of miniconda3
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh

    # Install miniconda3 in the current directory
    bash miniconda.sh -b -p $(pwd)/miniconda
    rm miniconda.sh

    # Activate miniconda and create the chips-conda environment
    source miniconda/bin/activate
    conda config --add envs_dirs $(pwd)/miniconda/envs
    conda config --add envs_dirs $(pwd)/miniconda/envs
    conda env create -f chips-conda.yml

    # Clean the miniconda install
    conda clean --all -y

    # Make sure the base environement is not enabled by default
    conda config --set auto_activate_base false
fi



