# chips-env

Repository for CHIPS software (gen/sim/map/reco) environment, running and configuration 

## Environment Setup

To setup the environment to use the event generation, simulation, mapper and reconstruction etc...

```
$ git submodule update --init
$ source setup.sh
```

This will install all the required dependencies, chips software and data. All the required environment variables will also be set.
For any future uses you just need to call...

```
$ source setup.sh
```

## Usage

View the documentation at the top of the run/run.py script for usage instructions, for argument help run...

```
$ python scripts/run.py -h
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

## GENIE cross-section files

If you look in the [GENIE manual](https://genie-docdb.pp.rl.ac.uk/DocDB/0000/000002/006/man.pdf) there are descriptions of all the different models and 'tunes' availiable. The data is then located [here](http://scisoft.fnal.gov/scisoft/packages/genie_xsec). Then we just use the gxspl-FNALsmall.xml file as this contains everything we need.

## chips-env containers

The aim of containerising CHIPS software is to make is easily reproducable and easy to use anywhere. This allows it to be run on any computing resources availiable with little effort.

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

### Dependency Image

We create a docker "dependency" image containing,

 - cmake3 (build tool)
 - pythia6 (event generator)
 - GSL (scientific library)
 - GLoBES (detector sensitivity)
 - CRY (cosmic event generator)
 - log4cpp (c++ logging utility)
 - geant4 (detector simulation)
 - ROOT (analysis framework)
 - Genie (beam neutrino event generator)

From this we can then build all the singularity/docker images we want for specific generation, simulation and reconstructions tasks.
Note, we specify /opt/data/geant4 as the geant4 data path in this image. Therefore, we need to mount the corresponding data there whenever using geant4.

We require 'sudo' to build the image and push it to the gitlab container registry for chips-env using...

```
$ cd $CHIPSENV/containers
$ sudo docker build -t registry.gitlab.com/chipsneutrino/chips-env .
$ sudo docker login registry.gitlab.com
$ sudo docker push registry.gitlab.com/chipsneutrino/chips-env
```

### Test Singularity image

Using the test.def singularity definition file we use the dependency docker image at "registry.gitlab.com/chipsneutrino" to create a test container using...

```
$ cd $CHIPSENV/containers
$ cp ../data/genie/GHepUtils.cxx .
$ sudo singularity build test.sif test.def
```

We don't add any additional software to the image, we just set the 'runscript' to start ROOT within the container, so when we run...

```
$ sudo singularity run test.sif
```

you get a ROOT prompt
