# chips-env

Repository for CHIPS software (gen/sim/map/reco) environment, running and configuration 

## Environment Setup

For the simulation, event hit mapper and reconstruction use the environment provided here by running...

```
$ source setup.sh
```

### UCL Installation
To use the UCL installation for event generation(GENIE) use...

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