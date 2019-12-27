#! /bin/bash

CURRENTDIR=$(pwd)

# If we don't have the deps directory first make it and then cd into it
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
if [ ! -d "$DIR/deps/" ]
then
    mkdir $DIR/deps 
fi

INSTALLDIR=$DIR/deps
cd $INSTALLDIR

NB_CORES=$(grep -c '^processor' /proc/cpuinfo)
export MAKEFLAGS="-j$((NB_CORES+1)) -l${NB_CORES}"

# CRY Setup (Cosmic event generator)
if [ -d "$INSTALLDIR/cry/" ]
then
    echo "CRY installed"
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

# GLoBES Setup (Detector sensitivity simulation)
if [ -d "$INSTALLDIR/globes/" ]
then
    echo "GLoBES installed"
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

# CLHEP Setup (Geant 4 dependency)
if [ -d "$INSTALLDIR/clhep/" ]
then
    echo "CLHEP installed"
else
    echo "Installing CLHEP..."
    wget http://www.hep.ucl.ac.uk/~jtingey/clhep-2.1.0.1.tgz --no-check-certificate
    tar -xzvf clhep-2.1.0.1.tgz
    rm clhep-2.1.0.1.tgz
    mkdir clhep
    cd 2.1.0.1/CLHEP/
    ./configure --prefix=$INSTALLDIR/clhep
    make
    make install
    cd $INSTALLDIR
    rm -rf 2.1.0.1
fi
export LD_LIBRARY_PATH=$INSTALLDIR/clhep/lib:$LD_LIBRARY_PATH
export CPLUS_INCLUDE_PATH=$INSTALLDIR/clhep/include:$CPLUS_INCLUDE_PATH
export PATH=$INSTALLDIR/clhep/bin:$PATH

# Geant4 Setup (Detector Simulation)
if [ -d "$INSTALLDIR/geant4/" ]
then
    echo "Geant4 installed"
else
    echo "Installing Geant4..."
    wget http://www.hep.ucl.ac.uk/~jtingey/geant4.9.4.p02.tar.gz --no-check-certificate
    tar -xzvf geant4.9.4.p02.tar.gz
    rm geant4.9.4.p02.tar.gz
    mkdir geant4
    mkdir geant4/data
    mkdir geant4-build
    cd geant4/data/
    wget http://geant4-data.web.cern.ch/geant4-data/datasets/G4NDL.3.14.tar.gz
    tar -xzvf G4NDL.3.14.tar.gz
    rm G4NDL.3.14.tar.gz
    wget http://geant4-data.web.cern.ch/geant4-data/datasets/G4EMLOW.6.19.tar.gz
    tar -xzvf G4EMLOW.6.19.tar.gz
    rm G4EMLOW.6.19.tar.gz
    wget http://geant4-data.web.cern.ch/geant4-data/datasets/G4PhotonEvaporation.2.1.tar.gz
    tar -xzvf G4PhotonEvaporation.2.1.tar.gz
    rm G4PhotonEvaporation.2.1.tar.gz
    wget http://geant4-data.web.cern.ch/geant4-data/datasets/G4RadioactiveDecay.3.3.tar.gz
    tar -xzvf G4RadioactiveDecay.3.3.tar.gz
    rm G4RadioactiveDecay.3.3.tar.gz
    wget http://geant4-data.web.cern.ch/geant4-data/datasets/G4ABLA.3.0.tar.gz
    tar -xzvf G4ABLA.3.0.tar.gz
    rm G4ABLA.3.0.tar.gz
    wget http://geant4-data.web.cern.ch/geant4-data/datasets/G4PII.1.2.tar.gz
    tar -xzvf G4PII.1.2.tar.gz
    rm G4PII.1.2.tar.gz
    wget http://geant4-data.web.cern.ch/geant4-data/datasets/RealSurface.1.0.tar.gz
    tar -xzvf RealSurface.1.0.tar.gz
    rm RealSurface.1.0.tar.gz
    wget http://geant4-data.web.cern.ch/geant4-data/datasets/G4NEUTRONXS.1.0.tar.gz
    tar -xzvf G4NEUTRONXS.1.0.tar.gz
    rm G4NEUTRONXS.1.0.tar.gz
    cd $INSTALLDIR/geant4-build
    cmake -DCMAKE_INSTALL_PREFIX=$INSTALLDIR/geant4 -DGEANT4_VERBOSE_CODE=OFF ../geant4.9.4.p02/
    make
    make install
    cd $INSTALLDIR
    rm -rf geant4-build geant4.9.4.p02
fi
source $INSTALLDIR/geant4/share/geant4-9.4.2/config/geant4-9.4.2.sh
export LD_LIBRARY_PATH=$INSTALLDIR/geant4/lib:$LD_LIBRARY_PATH
export CPLUS_INCLUDE_PATH=$INSTALLDIR/geant4/include:$CPLUS_INCLUDE_PATH
export PATH=$INSTALLDIR/geant4/bin:$PATH
export G4LEVELGAMMADATA=$INSTALLDIR/geant4/data/PhotonEvaporation2.1
export G4RADIOACTIVEDATA=$INSTALLDIR/geant4/data/RadioactiveDecay3.3
export G4LEDATA=$INSTALLDIR/geant4/data/G4EMLOW6.19
export G4NEUTRONHPDATA=$INSTALLDIR/geant4/data/G4NDL3.14
export G4ABLADATA=$INSTALLDIR/geant4/data/G4ABLA3.0
export G4REALSURFACEDATA=$INSTALLDIR/geant4/data/RealSurface1.0
export G4NEUTRONXSDATA=$INSTALLDIR/geant4/data/G4NEUTRONXS1.0
export G4PIIDATA=$INSTALLDIR/geant4/data/G4PII1.2

# ROOT setup (Data analysis package)
if [ -d "$INSTALLDIR/root/" ]
then
    echo "ROOT installed"
else
    echo "Installing ROOT..."
    wget https://root.cern.ch/download/root_v5.34.38.source.tar.gz --no-check-certificate
    tar -xzvf root_v5.34.38.source.tar.gz
    rm root_v5.34.38.source.tar.gz
    mv root root-source
    mkdir root-build
    mkdir root
    cd root-build
    cmake -DCMAKE_INSTALL_PREFIX=$INSTALLDIR/root -Dminuit2=ON ../root-source/
    make
    make install
    cd $INSTALLDIR
    rm -rf root-build root-source
fi
source root/bin/thisroot.sh
export ROOTSYS=$INSTALLDIR/root

echo "chips-base setup done"

# Go back to the user directory
cd $CURRENTDIR