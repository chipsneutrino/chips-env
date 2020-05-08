#! /bin/bash

C_RED=`tput setaf 1`
C_GREEN=`tput setaf 2`
C_BLUE=`tput setaf 4`
C_RESET=`tput sgr0`

CURRENTDIR=$(pwd)

# Ensure that the script has been sourced rather than just executed
if [[ "${BASH_SOURCE[0]}" = "${0}" ]]; then
    echo "${C_RED}ERROR${C_RESET}:   Please use 'source' to execute setup.sh"
    return
fi

# Export the environment variables
export CHIPSENV="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
export GEANT4DATA=$CHIPSENV/chips/chips-sim/config/geant4
export SINGULARITY_BIND="$CHIPSENV:/opt/chips-env,$GEANT4DATA:/opt/data/geant4"


# Check if singularity is installed
if ! [ -x "$(command -v singularity)" ]; then
    echo "${C_RED}ERROR${C_RESET}:   Singularity is not installed"
    return
fi

# Check the chips-env.sif image is present if not download it
if ! [ -f "$CHIPSENV/env/chips-env.sif" ]; then
    echo "${C_BLUE}INFO${C_RESET}:    Downloading singularity image"
    singularity pull $CHIPSENV/env/chips-env.sif library://joshtingey/default/chips-env:latest
fi

singularity_run() {
    if [ $# -eq 0 ]; then
        echo "${C_BLUE}INFO${C_RESET}:    Starting shell"
        singularity shell $CHIPSENV/env/chips-env.sif
    else
        if [ $1 == "exec" ]; then
            echo "${C_BLUE}INFO${C_RESET}:    Executing command (${@:2}) in container"
            singularity 'exec' $CHIPSENV/env/chips-env.sif ${@:2}
        else
            echo "${C_BLUE}INFO${C_RESET}:    Running application ($1) with args (${@:2})"
            singularity run --app $1 $CHIPSENV/env/chips-env.sif ${@:2}
        fi
    fi
}

alias chips=singularity_run

# Go back to the user directory
cd $CURRENTDIR

echo "${C_BLUE}INFO${C_RESET}:    Setup done"
