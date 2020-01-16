#! /bin/bash

CURRENTDIR=$(pwd)

# If we don't have the deps directory first make it and then cd into it
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

INSTALLDIR=$DIR/deps
cd $INSTALLDIR

NB_CORES=$(grep -c '^processor' /proc/cpuinfo)
export MAKEFLAGS="-j$((NB_CORES+1)) -l${NB_CORES}"

echo "####################"

# Pythia 6 setup
if [ -d "$INSTALLDIR/pythia6/" ]
then
    echo "Pythia6 installed"
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

# LHAPDF Setup, datasets are external to the container (/usr/local/share/LHAPDF)
if [ -d "$INSTALLDIR/lhapdf/" ]
then
    echo "LHAPDF6 installed"
else
    echo "Installing LHAPDF..."
    wget https://lhapdf.hepforge.org/downloads/LHAPDF-6.2.3.tar.gz
    tar -xzvf LHAPDF-6.2.3.tar.gz
    rm -rf LHAPDF-6.2.3.tar.gz
    mkdir lhapdf
    cd LHAPDF-6.2.3
    ./configure --prefix=$INSTALLDIR/lhapdf
    make -j4
    make install
    cd $INSTALLDIR
    rm -rf LHAPDF-6.2.3
fi
export PYTHONPATH=$INSTALLDIR/lhapdf/lib64/python2.7/site-packages:$PYTHONPATH
export LD_LIBRARY_PATH=$INSTALLDIR/lhapdf/lib:$LD_LIBRARY_PATH
export CPLUS_INCLUDE_PATH=$INSTALLDIR/lhapdf/include:$CPLUS_INCLUDE_PATH
export PATH=$INSTALLDIR/lhapdf/bin:$PATH

# log4cpp Setup
if [ -d "$INSTALLDIR/log4cpp/" ]
then
    echo "log4cpp installed"
else
    echo "Installing log4cpp..."
    wget https://netcologne.dl.sourceforge.net/project/log4cpp/log4cpp-1.1.x%20%28new%29/log4cpp-1.1/log4cpp-1.1.3.tar.gz
    tar -xzvf log4cpp-1.1.3.tar.gz
    rm -rf log4cpp-1.1.3.tar.gz
    mv log4cpp log4cpp-source
    mkdir log4cpp
    cd log4cpp-source
    ./configure --prefix=$INSTALLDIR/log4cpp
    make -j4
    make install
    cd $INSTALLDIR
    rm -rf log4cpp-source
fi
export LD_LIBRARY_PATH=$INSTALLDIR/log4cpp/lib:$LD_LIBRARY_PATH
export CPLUS_INCLUDE_PATH=$INSTALLDIR/log4cpp/include:$CPLUS_INCLUDE_PATH
export PATH=$INSTALLDIR/log4cpp/bin:$PATH

# GSL Setup
if [ -d "$INSTALLDIR/gsl/" ]
then
    echo "GSL installed"
else
    echo "Installing GSL..."
    wget ftp://ftp.gnu.org/gnu/gsl/gsl-2.6.tar.gz
    tar -xzvf gsl-2.6.tar.gz
    rm gsl-2.6.tar.gz
    mkdir gsl
    cd gsl-2.6
    ./configure --prefix=$INSTALLDIR/gsl
    make -j4
    make install
    cd $INSTALLDIR
    rm -rf gsl-2.6
fi
export LD_LIBRARY_PATH=$INSTALLDIR/gsl/lib:$LD_LIBRARY_PATH
export CPLUS_INCLUDE_PATH=$INSTALLDIR/gsl/include:$CPLUS_INCLUDE_PATH
export PATH=$INSTALLDIR/gsl/bin:$PATH

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
cd root
source bin/thisroot.sh
export ROOTSYS=$INSTALLDIR/root
cd $INSTALLDIR

: '
# GENIE Setup
if [ -d "$INSTALLDIR/genie/" ]
then
    echo "Genie installed"
else
    echo "Installing Genie..."
    git clone https://github.com/GENIE-MC/Generator.git
    export GENIE=$INSTALLDIR/Generator
    mkdir genie
    cd Generator
    git checkout R-2_6_6
    ./configure --with-log4cpp-lib=$INSTALLDIR/log4cpp/lib --with-log4cpp-inc=$INSTALLDIR/log4cpp/include --enable-lhapdf6 --with-lhapdf-lib=$INSTALLDIR/lhapdf/lib --with-lhapdf-inc=$INSTALLDIR/lhapdf/include --with-pythia6-lib=$INSTALLDIR/pythia6 --enable-gfortran --prefix=$INSTALLDIR/genie
    gmake
    gmake install
    cd $INSTALLDIR
    rm -rf Generator
fi
export GENIE=$INSTALLDIR/genie
export LD_LIBRARY_PATH=$INSTALLDIR/genie/lib:$LD_LIBRARY_PATH
export CPLUS_INCLUDE_PATH=$INSTALLDIR/genie/include:$CPLUS_INCLUDE_PATH
export PATH=$INSTALLDIR/genie/bin:$PATH
'

echo "####################"
echo "chips-env setup done"
echo "####################"

# Go back to the user directory
cd $CURRENTDIR
