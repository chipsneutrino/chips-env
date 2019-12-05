# env

Repository for setting up and containerising software environments for CHIPS

## Usage

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