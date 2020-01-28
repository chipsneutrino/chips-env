# chips-env

Repository for CHIPS software (gen/sim/map/reco) environment, running and configuration 

## Environment Setup

To setup the environment to use the event generation, simulation, mapper and reconstruction use...

```
$ source setup.sh
```

### UCL Installation
To use the old UCL installation of everything use...

```
$ source setup-ucl.sh
```

### Singularity (need sudo)
In order to build the default environment for use with the simulation, event hit mapper and reconstruction use...

```
$ cd ./deps && sudo singularity build chips-env.sif chips-env.def
```

## Usage

View the documentation at the top of the run/run.py script for usage instructions, for argument help run...

```
$ cd ./run && python run.py -h
```