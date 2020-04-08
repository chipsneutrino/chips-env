# chips-env

Repository for CHIPS software (gen/sim/map/reco) environment, running and configuration 

## Environment Setup

To setup the environment to use the event generation, simulation, mapper and reconstruction etc...

```
$ git submodule update --init
$ source env-setup.sh
```

This will install all the required dependencies, chips software and data. All the required environment variables will also be set.
For any future uses you just need to call...

```
$ source env-setup.sh
```

## Usage

View the documentation at the top of the run/run.py script for usage instructions, for argument help run...

```
$ cd ./run && python run.py -h
```

## Build Singularity Containers

In order to build the default environment for use with the simulation, event hit mapper and reconstruction use...

```
$ cd ./deps && sudo singularity build chips-env.sif chips-env.def
```

## The Submodules

This repository contains three submodules for chips-gen, chips-sim and chips-reco in the ./chips directory.
These have been added with...

```
$ git submodule add -b new_build https://gitlab.com/chipsneutrino/chips-gen.git chips/chips-gen
$ git submodule add -b new_build https://gitlab.com/chipsneutrino/chips-sim.git chips/chips-sim
$ git submodule add -b new_build https://gitlab.com/chipsneutrino/chips-reco.git chips/chips-reco
$ git submodule init
```

To update to the most recent versions use...

```
$ git submodule update --remote
```

and then commit the changes to this chips-env repository