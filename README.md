# env

Repository for CHIPS software environments and configuration 

## Usage

### UCL(chips-env)
To use the UCL installation of all the chips-env code (gen/sim/reco)...

```
$ source setup-chips-ucl.sh
```

### Miniconda(chips-conda)
To install miniconda and the associated "chips-conda" environment or to use an existing one...

```
$ source setup-chips-conda.sh
```

### Singularity(chips-env)
In order to build the default environment for use with the event generation, simulation, reconstruction and GLoBES studies...

```
$ sudo singularity build chips-env.sif chips-env.def
```

### Singularity(chips-conda)
In order to build the miniconda environment for use with the CVN...

```
$ sudo singularity build chips-conda.sif chips-conda.def
```