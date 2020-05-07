#! /bin/bash

CURRENTDIR=$(pwd)

# Ensure that the script has been sourced rather than just executed
if [[ "${BASH_SOURCE[0]}" = "${0}" ]]; then
    echo "Please use 'source' to execute setup.sh!"
    exit 1
fi

# Export the environment variable pointing at this directory
export CHIPSENV="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# Check if singularity is installed
if ! [ -x "$(command -v singularity)" ]; then
    echo 'Error: singularity is not installed.' >&2
    exit 1
fi

# Check the chips-env.sif image is present if not download it
if ! [ -f "$CHIPSENV/env/chips-env.sif" ]; then
    singularity pull $CHIPSENV/env/chips-env.sif library://joshtingey/default/chips-env:latest
fi

# Setup the correct binding for the container
export SINGULARITY_BIND="$CHIPSENV:/opt/chips-env,$CHIPSENV/chips/chips-sim/config/geant4:/opt/data/geant4"

singularity_run() {
    if [ $# -eq 0 ]; then
        singularity shell $CHIPSENV/env/chips-env.sif
    else
        if [ $1 == "exec" ]; then
            singularity 'exec' $CHIPSENV/env/chips-env.sif ${@:2}
        else
            singularity run --app $1 $CHIPSENV/env/chips-env.sif ${@:2}
        fi
    fi
}

alias chips=singularity_run

# Go back to the user directory
cd $CURRENTDIR
