# chips-env

[![Pipeline](https://gitlab.com/chipsneutrino/chips-env/badges/master/pipeline.svg)](https://gitlab.com/chipsneutrino/chips-env/pipelines)

This repository contains the full setup for the CHIPS software environment and everything required to run it at scale.

Based around a pre-build [singularity](https://sylabs.io/guides/3.5/user-guide/introduction.html) container holding
all the up-to-date dependencies to run CHIPS software, no user installation of any software (except Singularity) is
required. Additionally, all default data files required by either the dependencies or the CHIPS software itself are
dealt with.

Apart from speeding up development time and the obvious ease-of-use this brings, a main advantage is the ability to
run a consistent software environment across any machine required (local-node, UCL-node, batch-farm, grid-node, etc...).

Singularity is now widely installed across many of the computing nodes we use, but if you need a local install see
https://sylabs.io/guides/3.5/user-guide/quick_start.html for more info.

---

## Usage

### Quick Start

To start using the singularity environment and all the CHIPS software run the following commands...

```
$ git clone https://gitlab.com/chipsneutrino/chips-env.git  # Clone the repository
$ cd chips-env  # Go to the directory
$ git submodule update --init  # Get the chips-gen, chips-sim and chips-reco submodules
$ source setup.sh  # Setup the environment
$ chips build  # Build all the software
```

Once the build is complete you have a fully working CHIPS software environment to use. To start a bash prompt
within the Singularity container run the alias...

```
$ chips
```

Once inside the container, you are the same user as you are on the host system, but the file system has been
switched out for the one inside the container except for a few specific paths that allow you to reach and modify 
files on the host. These are...

 - The current directory you where in when it started
 - Your $HOME directory at /home/$USER
 - The chips-env ($CHIPSENV) directory at /opt/chips-env
 - The geant4 data directory ($GEANT4DATA) at /opt/data/geant4

You can see all 'chips' alias commands with...

```
$ chips help
```

These have been implemented to make common tasks easier using the idea of singularity 'apps'. However, they are restrictive and you may find using the bash prompt within the container with the full flexibility you are used to more productive.

### Running at scale

The general pipeline we run in CHIPS is...

event-generation -> event-selection -> detector-simulation -> hit-mapping -> network-training

In order to help us run this flow on many different event types we define a directory structure for each type 
of event as follows...

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

The ./scripts/scripts.py python script is designed to generate bash scripts using this structure that run the
various jobs on the UCL batch farm. In order to use this functionality you first need to make a directory, set the
PRODDIR environment variable and call the setup.sh script again. For example...

```
$ mkdir /unix/chips/jtingey/prod
$ export PRODDIR=/unix/chips/jtingey/prod
$ source setup.sh
```

The PRODDIR will then be mounted inside the container at /opt/prod, which the scripts.py script can use to produce
the job scripts for the batch farm.

The scripts in ./scripts/jobs/ provide examples for how to use this functionality for many different types of events.

### Directory layout

 - ./chips/: the chips software submodules, chips-gen, chips-sim and chips-reco.
 - ./env/: build files and built containers for both docker and singularity images.
 - ./scripts/: python and bash scripts to run the chips software, mainly for batch farm use.

---

## Building the containers

### Docker dependency container

We create a docker "dependency" image containing from a base CentOS7 image, containing:

 - gcc-9 (compiler)
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
Note, we specify /opt/data/geant4 as the geant4 data path in this image. Therefore, we need to mount the corresponding data there whenever using Geant4. We require 'sudo' to build the image and push it to the gitlab container registry for chips-env using...

```
$ cd $CHIPSENV/env/docker/
$ sudo docker build -t registry.gitlab.com/chipsneutrino/chips-env .
$ sudo docker login registry.gitlab.com
$ sudo docker push registry.gitlab.com/chipsneutrino/chips-env
```

The build will take many many hours (3ish on an 8 core machine)!!! Note we use an updated version of GHepUtils.cxx when building
GENIE which contains additional nuance(interaction) codes. All other software implementations are dependent on this change. 

### Singularity containers

In order to build the default singularity container that is used throughout chips-env use the following commands.
We require 'sudo' to build the image and push it to the singularity container registry using...

```
$ sudo singularity build ./env/chips-env.sif ./env/singularity/chips-env.def
$ sudo singularity remote login
$ sudo singularity key newpair
$ sudo singularity sign env/chips-env.sif
$ sudo singularity push env/chips-env.sif library://joshtingey/default/chips-env:latest
```

You can also build a chips-soft container that contains all the chips software prebuilt and bundles all the required
data files within the container so everything is completely contained...

```
$ sudo singularity build ./env/chips-soft.sif ./env/singularity/chips-soft.def
```

---

## Other

### The Submodules

This repository contains three submodules for chips-gen, chips-sim and chips-reco in the ./chips directory.
These have been added with...

```
$ git submodule add https://gitlab.com/chipsneutrino/chips-gen.git chips/chips-gen
$ git submodule add https://gitlab.com/chipsneutrino/chips-sim.git chips/chips-sim
$ git submodule add https://gitlab.com/chipsneutrino/chips-reco.git chips/chips-reco
$ git submodule init
```

To update to the most recent versions use the following, and then commit the changes to this chips-env repository.

```
$ git submodule update --remote
```

When making changes to chips-gen, chips-sim or chips-reco you need to make sure to commit these in their respective
directories, but then also commit their changes to the chips-env repo to keep it up-to-date. Basically, watch out as
submodules are a different way of working to normal.

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