#! /bin/bash

CURRENTDIR=$(pwd)

# If we don't have the deps directory first make it and then cd into it
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

if [ -d "$DIR/miniconda/envs/chips-conda/" ]
then
    echo "Conda env installed"
    source miniconda/bin/activate
    conda activate chips-conda
else
    # Download the latest version of miniconda3
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh --no-check-certificate

    # Install miniconda3 in the current directory
    bash miniconda.sh -b -p $DIR/miniconda
    rm miniconda.sh

    # Activate miniconda and create the chips-conda environment
    source miniconda/bin/activate
    conda config --add envs_dirs $DIR/miniconda/envs
    conda config --add envs_dirs $DIR/miniconda/envs
    conda env create -f ../chips-conda.yml

    # Clean the miniconda install
    conda clean --all -y

    # Make sure the base environement is not enabled by default
    conda config --set auto_activate_base false

    conda activate chips-conda
fi

echo "chips-conda setup done"

# Go back to the user directory
cd $CURRENTDIR



