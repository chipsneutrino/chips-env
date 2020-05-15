#! /bin/bash

C_RED=`tput setaf 1`
C_GREEN=`tput setaf 2`
C_BLUE=`tput setaf 4`
C_RESET=`tput sgr0`

CURRENTDIR=$(pwd)

# Ensure that the script has been sourced rather than just executed
if [[ "${BASH_SOURCE[0]}" = "${0}" ]]; then
    echo "${C_RED}ERROR:${C_RESET}   Please use 'source' to execute setup.sh"
    return
fi

# Export the environment variables
export CHIPSENV="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
export SINGULARITYENV_HOSTENV=$CHIPSENV

export GEANT4DATA=$CHIPSENV/chips/chips-sim/config/geant4
export SINGULARITYENV_HOSTGEANT4=$GEANT4DATA

if [[ -z "${PRODDIR}" ]]; then
    export SINGULARITY_BIND="$CHIPSENV:/opt/chips-env,$GEANT4DATA:/opt/data/geant4"
else
    echo "${C_BLUE}INFO:${C_RESET}    Will mount production directory $PRODDIR"
    export SINGULARITY_BIND="$CHIPSENV:/opt/chips-env,$GEANT4DATA:/opt/data/geant4,$PRODDIR:/opt/prod"
    export SINGULARITYENV_HOSTPROD=$PRODDIR
fi

# Check if singularity is installed
if ! [ -x "$(command -v singularity)" ]; then
    echo "${C_RED}ERROR:${C_RESET}   Singularity is not installed"
    return
fi

# Check the chips-env.sif image is present if not download it
if ! [ -f "$CHIPSENV/env/chips-env.sif" ]; then
    echo "${C_BLUE}INFO:${C_RESET}    Downloading singularity image"
    singularity pull $CHIPSENV/env/chips-env.sif library://joshtingey/default/chips-env:latest
fi

# Setup the 'chips' alias
singularity_run() {
    if [ $# -eq 0 ]; then
        echo "${C_BLUE}INFO:${C_RESET}    Starting chips singularity shell"
        singularity shell $CHIPSENV/env/chips-env.sif
        echo "${C_BLUE}INFO:${C_RESET}    Leaving chips singularity shell"
    else
        if [ $1 == "help" ]; then
            echo "${C_BLUE}INFO:${C_RESET}    usage: chips [option] [args]"
            echo "${C_BLUE}INFO:${C_RESET}    calling without an option or args will start a bash prompt within the container"
            echo "${C_BLUE}INFO:${C_RESET}    valid options: exec, build, make, clean, scripts"
            echo "${C_BLUE}INFO:${C_RESET}    exec: execute a command within the container"
            echo "${C_BLUE}INFO:${C_RESET}    build: call both cmake and make within the chips-env directory to build the CHIPS software"
            echo "${C_BLUE}INFO:${C_RESET}    make: call just make within the chips-env directory to build the CHIPS software"
            echo "${C_BLUE}INFO:${C_RESET}    clean: clean all build files from the chips-env directory"
            echo "${C_BLUE}INFO:${C_RESET}    scripts: run the scripts.py python script to generate job scripts"
        elif [ $1 == "exec" ]; then
            echo "${C_BLUE}INFO:${C_RESET}    Executing command (${@:2}) in container"
            singularity 'exec' $CHIPSENV/env/chips-env.sif ${@:2}
        elif [ $1 == "build" ]; then
            echo "${C_BLUE}INFO:${C_RESET}    Building CHIPS software with cmake args (${@:2})"
            singularity run --app build $CHIPSENV/env/chips-env.sif ${@:2}
        elif [ $1 == "make" ]; then
            echo "${C_BLUE}INFO:${C_RESET}    Making CHIPS software"
            singularity run --app make $CHIPSENV/env/chips-env.sif
        elif [ $1 == "clean" ]; then
            echo "${C_BLUE}INFO:${C_RESET}    Cleaning CHIPS software"
            singularity run --app clean $CHIPSENV/env/chips-env.sif
        elif [ $1 == "scripts" ]; then
            echo "${C_BLUE}INFO:${C_RESET}    Generating batch-farm scripts with args (${@:2})"
            singularity run --app scripts $CHIPSENV/env/chips-env.sif ${@:2}
        else
            echo "${C_RED}ERROR:${C_RESET}   Not a valid command, see 'chips help' for usage"
        fi
    fi
}

alias chips=singularity_run

cd $CURRENTDIR
echo "${C_BLUE}INFO:${C_RESET}    Setup done"
