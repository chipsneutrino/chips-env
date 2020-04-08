#! /bin/bash

CURRENTDIR=$(pwd)

# If we don't have the deps directory first make it and then cd into it
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

export CHIPSENV=$DIR
INSTALLDIR=$DIR/deps
cd $INSTALLDIR

NB_CORES=$(grep -c '^processor' /proc/cpuinfo)
export MAKEFLAGS="-j$((NB_CORES+1)) -l${NB_CORES}"

C_RED=`tput setaf 1`
C_GREEN=`tput setaf 2`
C_RESET=`tput sgr0`

echo "${C_RED}####################"
echo "Setting up chips-env"
echo "####################${C_RESET}"

# First we build all the required dependencies in ./deps
# Environments variables for ll deps are also set...

# Geant4 Setup (Detector simulation)
if [ -d "$INSTALLDIR/geant4/" ]
then
    echo "Geant4 installed----"
else
    echo "Installing Geant4..."
    wget http://geant4-data.web.cern.ch/geant4-data/releases/geant4.10.05.p01.tar.gz --no-check-certificate
    tar -xzvf geant4.10.05.p01.tar.gz
    rm geant4.10.05.p01.tar.gz
    mkdir geant4
    mkdir geant4-build
    cd geant4-build
    cmake -DCMAKE_INSTALL_PREFIX=$INSTALLDIR/geant4 -DGEANT4_INSTALL_DATA=ON -DGEANT4_BUILD_MULTITHREADED=ON -DGEANT4_USE_QT=ON -DGEANT4_USE_OPENGL_X11=ON -DGEANT4_USE_RAYTRACER_X11=ON -DGEANT4_USE_XM=ON ../geant4.10.05.p01/
    make
    make install
    cd $INSTALLDIR
    rm -rf geant4-build geant4.10.05.p01
fi
source $INSTALLDIR/geant4/bin/geant4.sh

# Pythia 6 setup (Event generation)
if [ -d "$INSTALLDIR/pythia6/" ]
then
    echo "Pythia6 installed---"
else
    echo "Installing Pythia6..."
    wget https://root.cern.ch/download/pythia6.tar.gz
    tar -xzvf pythia6.tar.gz
    rm -rf pythia6.tar.gz
    wget http://www.hepforge.org/archive/pythiasix/pythia-6.4.28.f.gz
    gzip -d pythia-6.4.28.f.gz
    mv pythia-6.4.28.f pythia6/pythia6428.f
    rm -rf pythia6/pythia6416.f
    cd pythia6
    ./makePythia6.linuxx8664
    cd $INSTALLDIR
fi
export LD_LIBRARY_PATH=$INSTALLDIR/pythia6:$LD_LIBRARY_PATH

# ROOT setup (Data analysis)
if [ -d "$INSTALLDIR/root/" ]
then
    echo "ROOT installed------"
else
    echo "Installing ROOT..."
    wget https://root.cern/download/root_v6.20.04.source.tar.gz --no-check-certificate
    tar -xzvf root_v6.20.04.source.tar.gz
    rm root_v6.20.04.source.tar.gz
    mkdir root
    mkdir root-build
    cd root-build
    cmake -DCMAKE_INSTALL_PREFIX=$INSTALLDIR/root -Dminuit2=ON -Dpythia6=ON -DPYTHIA6_LIBRARY=$INSTALLDIR/pythia6/libPythia6.so ../root-6.20.04
    make
    make install
    cd $INSTALLDIR
    rm -rf root-build root-6.20.04
fi
export ROOTSYS=$INSTALLDIR/root
source $INSTALLDIR/root/bin/thisroot.sh
export LD_LIBRARY_PATH=$ROOTSYS/lib:$LD_LIBRARY_PATH
export PATH=$ROOTSYS/bin:$PATH

# log4cpp Setup (Logging for c++)
if [ -d "$INSTALLDIR/log4cpp/" ]
then
    echo "log4cpp installed---"
else
    echo "Installing log4cpp..."
    wget https://netcologne.dl.sourceforge.net/project/log4cpp/log4cpp-1.1.x%20%28new%29/log4cpp-1.1/log4cpp-1.1.3.tar.gz
    tar -xzvf log4cpp-1.1.3.tar.gz
    rm -rf log4cpp-1.1.3.tar.gz
    mv log4cpp log4cpp-source
    mkdir log4cpp
    cd log4cpp-source
    ./configure --prefix=$INSTALLDIR/log4cpp
    make
    make install
    cd $INSTALLDIR
    rm -rf log4cpp-source
fi
export LD_LIBRARY_PATH=$INSTALLDIR/log4cpp/lib:$LD_LIBRARY_PATH
export CPLUS_INCLUDE_PATH=$INSTALLDIR/log4cpp/include:$CPLUS_INCLUDE_PATH
export PATH=$INSTALLDIR/log4cpp/bin:$PATH

# CRY Setup (Cosmic event generation)
if [ -d "$INSTALLDIR/cry/" ]
then
    echo "CRY installed-------"
else
    echo "Installing CRY..."
    wget https://nuclear.llnl.gov/simulation/cry_v1.7.tar.gz --no-check-certificate
    tar -xzvf cry_v1.7.tar.gz
    rm cry_v1.7.tar.gz
    mv cry_v1.7/ cry/
    cd cry/
    make setup
    make lib
    cd $INSTALLDIR
fi
export CRYDIR=$INSTALLDIR/cry
export CRYDATA=$INSTALLDIR/cry/data
export LD_LIBRARY_PATH=$INSTALLDIR/cry/lib:$LD_LIBRARY_PATH
export CPLUS_INCLUDE_PATH=$INSTALLDIR/cry/src:$CPLUS_INCLUDE_PATH

# GLoBES Setup (Detector sensitivity simulation)
if [ -d "$INSTALLDIR/globes/" ]
then
    echo "GLoBES installed----"
else
    echo "Installing GLoBES..."
    wget https://www.mpi-hd.mpg.de/personalhomes/globes/download/globes-3.0.11.tar.gz --no-check-certificate
    tar -xzvf globes-3.0.11.tar.gz
    rm globes-3.0.11.tar.gz
    mkdir globes
    cd globes-3.0.11/
    ./configure --prefix=$INSTALLDIR/globes
    make
    make install
    cd $INSTALLDIR
    rm -rf globes-3.0.11
fi
export LD_LIBRARY_PATH=$INSTALLDIR/globes/lib:$LD_LIBRARY_PATH
export CPLUS_INCLUDE_PATH=$INSTALLDIR/globes/include:$CPLUS_INCLUDE_PATH
export PATH=$INSTALLDIR/globes/bin:$PATH

export GENIE=$INSTALLDIR/genie
export PATH=$PATH:$GENIE/bin
export LD_LIBRARY_PATH=$GENIE/lib:$LD_LIBRARY_PATH
export CPLUS_INCLUDE_PATH=$GENIE/include:$CPLUS_INCLUDE_PATH

# GENIE Setup (Neutrino event generation)
if [ -d "$INSTALLDIR/genie/" ]
then
    echo "Genie installed-----"
else
    echo "Installing Genie..."
    git clone https://github.com/GENIE-MC/Generator.git
    mv Generator genie
    cd genie
    git checkout R-3_00_06
    ./configure --enable-fnal --with-pythia6-lib=$INSTALLDIR/pythia6 --disable-lhapdf5
    make
    cd $INSTALLDIR
fi

export CHIPSGEN=$DIR/chips/chips-gen
export PATH=$CHIPSGEN:$PATH

export G4VIS_USE=1
export G4VIS_USE_OPENGLQT=1
export CHIPSSIM=$DIR/chips/chips-sim
export LD_LIBRARY_PATH=$CHIPSSIM:$LD_LIBRARY_PATH
export CPLUS_INCLUDE_PATH=$CHIPSSIM/include:$CPLUS_INCLUDE_PATH
export PATH=$CHIPSSIM:$PATH

export CHIPSRECO=$DIR/chips/chips-reco
export LD_LIBRARY_PATH=$CHIPSRECO:$LD_LIBRARY_PATH
export CPLUS_INCLUDE_PATH=$CHIPSRECO/include:$CPLUS_INCLUDE_PATH
export PATH=$CHIPSRECO:$PATH

# Now we build all the chips packages
if [ -f "$DIR/chips/chips-sim/WCSim" ]
then
    echo "${C_GREEN}chips software built${C_RESET}"
else
    echo "${C_RED}building chips software${C_RESET}"
    NB_CORES=$(grep -c '^processor' /proc/cpuinfo)
    export MAKEFLAGS="-j$((NB_CORES+1)) -l${NB_CORES}"
    cd $DIR
    cmake .
    make
    echo "${C_GREEN}chips software built${C_RESET}"
fi

echo "${C_GREEN}####################"
echo "chips-env setup done"
echo "####################${C_RESET}"

# Go back to the user directory
cd $CURRENTDIR
