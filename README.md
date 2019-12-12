# env

Repository for CHIPS software environments and configuration 

## Usage

### UCL(chips-base)
To use the UCL installation of all the chips-base code (gen/sim/reco)...

```
$ source chips-base/chips-base-ucl.sh
```

### Miniconda(chips-conda)
To install miniconda and the associated "chips-conda" environment or to use an existing one...

```
$ cd chips-conda
$ source setup-chips-conda.sh
```

### Singularity(chips-base)
In order to build the default environment for use with the event generation, simulation, reconstruction and GLoBES studies...

```
$ cd chips-base
$ sudo singularity build chips-base.sif chips-base.def
```

### Singularity(chips-conda)
In order to build the miniconda environment for use with the CVN...

```
$ cd chips-conda
$ sudo singularity build chips-conda.sif chips-conda.def
```