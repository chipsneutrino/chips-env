# chips-env

This repository sets up the CHIPS software environment and everything required to run it at scale. 

Based around the use of a pre-built [singularity](https://sylabs.io/guides/3.5/user-guide/introduction.html) container with
all the up-to-date dependencies required to run the CHIPS software, no user installation of any software (except singularity)
is required. Additionally, all data files required by either the dependencies or CHIPS software itself are dealt with.

Apart from ease-of-use this has the added advantage of providing a consistent environment in which to run CHIPS
software across any machines required (local, UCL, batch farm, grid node, etc...)

Singularity is now widely installed across many of the computing nodes we use, but if you need a local install see
https://sylabs.io/guides/3.5/user-guide/quick_start.html

## Getting started

To start using the singularity environment and all the CHIPS software run the following commands...

```
$ git clone https://gitlab.com/chipsneutrino/chips-cvn.git  # Clone the repository
$ git submodule update --init								# Get the chips-gen, chips-sim and chips-reco submodules
$ source setup.sh											# Setup environment (skip inputing production directory for now)
$ chips build												# Build all the software
```

Once the build is complete you have a fully working CHIPS software environment to use.
For example, running...

```
$ chips root
```

will start the up-to-date(6.20) ROOT installed in the container and preload the 'chips-style' for consistent plotting.

## Usage

Various directories are mounted into the singularity container when it starts, these are...
	- The chips-env ($CHIPSENV) directory at /opt/chips-env
	- The geant4 data directory ($GEANT4DATA) at /opt/data/geant4
	- The production ($PRODDIR) directory at /opt/prod

This gives us access to the CHIPS software in chips-env as well as the 'production directory' if specified to create/modify files
for use in event generation, detector simulation, hit mapping, reconstruction etc...

The general pipeline we run in CHIPS is... 

event generation -> event filtering -> detector simulation -> hit mapping(or reco) -> network training

We define a production directory structure to store the files created in this flow for each different type of event...

```
directory (for every event type)
├── _gen
|   ├── _all [all genie .vec events]
|   └── _filtered [filtered genie .vec events]
├── _map
|   └── _[geometry]
|       └── [mapper output .root files]
├── _plots [output plot files]
├── _reco
|   └── _[geometry]
|       └── [reconstruction output .root files]
├── _scripts
|   ├── gen [event generation scripts]
|   ├── map [event mapping scripts]
|   ├── reco [event reconstruction scripts]
|   ├── sim [event simulation scripts]
|   └── [batch farm submission scripts]
├── _sim
|   └── _[geometry]
|       └── [simulation output .root files]
└── _tf
    └── _[geometry]
        ├── _train [training .tfrecords files]
        ├── _val [validation .tfrecords files]
        └── _test [testing .tfrecords files]
```

The scripts/run.py python script uses this directory structure to generate scripts to run every stage of this pipeline on the batch
farm. Each directory is designed to contain events of a particular type. For an example of this structure visit /unix/chips/prod at UCL.

## Building the Dependency Docker Container

We create a docker "dependency" image containing from a base CentOS7 image, containing:

 - gcc-9 (ompiler)
 - cmake3 (build tool)
 - pythia6 (event generator)
 - GSL (scientific library)
 - log4cpp (c++ logging utility)
 - ROOT (analysis framework)
 - Genie (beam neutrino event generator)
 - BOOST (c++ libraries)
 - GLoBES (detector sensitivity framework)
 - CRY (cosmic event generator)
 - Geant4 (detector simulation)

From this we can then build all the singularity/docker images we want for specific tasks.
Note, we specify /opt/data/geant4 as the geant4 data path in this image. Therefore, we need to mount the corresponding data there whenever using Geant4.
We require 'sudo' to build the image and push it to the gitlab container registry for chips-env using...

```
$ cd $CHIPSENV/env/docker/
$ sudo docker build -t registry.gitlab.com/chipsneutrino/chips-env .
$ sudo docker login registry.gitlab.com
$ sudo docker push registry.gitlab.com/chipsneutrino/chips-env
```

The build will take many many hours (~3 on an 8 core machine)!!!

## Build Singularity Containers

In order to build the default singularity container that is used throughout chips-env use the following commands.
We require 'sudo' to build the image and push it to the singularity container registry using...

```
$ sudo singularity build ./env/chips-env.sif ./env/singularity/chips-env.def
$ sudo singularity remote login
$ sudo singularity key newpair
$ sudo singularity sign env/chips-env.sif
$ sudo singularity push env/chips-env.sif library://joshtingey/default/chips-env:latest
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

## GENIE cross-section files

If you look in the [GENIE manual](https://genie-docdb.pp.rl.ac.uk/DocDB/0000/000002/006/man.pdf) there are descriptions of all the different models and 'tunes' availiable. The data is then located [here](http://scisoft.fnal.gov/scisoft/packages/genie_xsec). Then we just use the gxspl-FNALsmall.xml file as this contains everything we need.

### Singularity Install (centos7)

To install singularity on centos7 run the following to install the dependencies...

```
$ sudo yum groupinstall -y 'Development Tools' && \
	sudo yum install -y epel-release && \
	sudo yum install -y golang libseccomp-devel \
  		squashfs-tools cryptsetup wget openssl-devel libuuid-devel
```

Then run the following to install singularity and test it works...

```
$ mkdir -p ${GOPATH}/src/github.com/sylabs && \
	cd ${GOPATH}/src/github.com/sylabs && \
	git clone https://github.com/sylabs/singularity.git && \
	cd singularity && git checkout v3.5.3 && \
	cd ${GOPATH}/src/github.com/sylabs/singularity && \
	./mconfig && cd ./builddir && make -j$(nproc) && \
	sudo make install && cd && singularity version
```