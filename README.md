# env

Repository for CHIPS software environments and configuration 

## Usage

### Miniconda(chips-conda) Installation
To install miniconda and the associated "chips-conda" environment for running all CVN related software...

```
$ source setup-chips-conda.sh
```

### chips-env
In order to build the default environment for use with the event generation, simulation, reconstruction and GLoBES studies...

```
$ sudo singularity build chips-env.sif chips-env.def
```

### chips-conda
In order to build the miniconda environment for use with the CVN...

```
$ sudo singularity build chips-conda.sif chips-conda.def
```