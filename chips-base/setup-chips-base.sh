#! /bin/bash

if [ -d "$(pwd)/software/" ]
then

    DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

    # CRY Setup
    export CRYDIR=$DIR/software/cry
    export CRYDATA=$DIR/software/cry/data

    # Pythia6 Setup
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$DIR/software/pythia6

    # lhapdf Setup
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$DIR/software/lhapdf/lib
    export CPLUS_INCLUDE_PATH=$CPLUS_INCLUDE_PATH:$DIR/software/lhapdf/include
    export PATH=$PATH:$DIR/software/lhapdf/bin

    # log4cpp setup
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$DIR/software/log4cpp/lib
    export CPLUS_INCLUDE_PATH=$CPLUS_INCLUDE_PATH:$DIR/software/log4cpp/include
    export PATH=$PATH:$DIR/software/log4cpp/bin

    # GSL Setup
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$DIR/software/gsl/lib
    export CPLUS_INCLUDE_PATH=$CPLUS_INCLUDE_PATH:$DIR/software/gsl/include
    export PATH=$PATH:$DIR/software/gsl/bin

    # CLHEP Setup
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$DIR/software/clhep/lib
    export CPLUS_INCLUDE_PATH=$CPLUS_INCLUDE_PATH:$DIR/software/clhep/include
    export PATH=$PATH:$DIR/software/clhep/bin

    # GLoBES Setup
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$DIR/software/globes/lib
    export CPLUS_INCLUDE_PATH=$CPLUS_INCLUDE_PATH:$DIR/software/globes/include
    export PATH=$PATH:$DIR/software/globes/bin

    # ROOT Setup
    #source $DIR/software/root/bin/thisroot.sh
    #export ROOTSYS=$DIR/software/root

    # Geant4 Setup
    source $DIR/software/geant4/share/geant4-9.4.2/config/geant4-9.4.2.sh

    # Genie Setup
    #source $DIR/software/genie/setup.sh
    #export PATH=$PATH:/unix/lartpc/software/genie/genie-2.6.6/bin/

else
    # We want to install this in the chips-env directory
    echo "We need to install all the dependencies!"
    echo "Are you in the chips-env/chips-base directory and want to continue?"
    echo "Press any key to continue..."
    read key

    mkdir software
    cd software
    INSTALLDIR=$(pwd)
    echo "Installing into $INSTALLDIR"

    # CRY Setup
    wget https://nuclear.llnl.gov/simulation/cry_v1.7.tar.gz
    tar -xzvf cry_v1.7.tar.gz
    rm cry_v1.7.tar.gz
    mv cry_v1.7/ cry/
    cd cry/
    make setup
    make lib
    cd $INSTALLDIR

    # Pythia 6 setup
    wget https://root.cern.ch/download/pythia6.tar.gz
    tar -xzvf pythia6.tar.gz
    rm -rf pythia6.tar.gz
    wget http://www.hepforge.org/archive/pythiasix/pythia-6.4.28.f.gz
    gzip -d pythia-6.4.28.f.gz
    mv pythia-6.4.28.f pythia6/pythia6428.f
    rm -rf pythia6/pythia6416.f
    cd pythia6
    ./makePythia6.linuxx8664
    cp libPythia6.so /usr/local/lib
    cd $INSTALLDIR
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$INSTALLDIR/pythia6

    # LHAPDF Setup, datasets are external to the container (/usr/local/share/LHAPDF)
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
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$INSTALLDIR/lhapdf/lib
    export CPLUS_INCLUDE_PATH=$CPLUS_INCLUDE_PATH:$INSTALLDIR/lhapdf/include
    export PATH=$PATH:$INSTALLDIR/lhapdf/bin

    # log4cpp Setup
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
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$INSTALLDIR/log4cpp/lib
    export CPLUS_INCLUDE_PATH=$CPLUS_INCLUDE_PATH:$INSTALLDIR/log4cpp/include
    export PATH=$PATH:$INSTALLDIR/log4cpp/bin

    # GSL Setup
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
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$INSTALLDIR/gsl/lib
    export CPLUS_INCLUDE_PATH=$CPLUS_INCLUDE_PATH:$INSTALLDIR/gsl/include
    export PATH=$PATH:$INSTALLDIR/gsl/bin

    # CLHEP Setup
    wget http://www.hep.ucl.ac.uk/~jtingey/clhep-2.1.0.1.tgz
    tar -xzvf clhep-2.1.0.1.tgz
    rm clhep-2.1.0.1.tgz
    mkdir clhep
    cd 2.1.0.1/CLHEP/
    ./configure --prefix=$INSTALLDIR/clhep
    make -j4
    make install
    cd $INSTALLDIR
    rm -rf 2.1.0.1
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$INSTALLDIR/clhep/lib
    export CPLUS_INCLUDE_PATH=$CPLUS_INCLUDE_PATH:$INSTALLDIR/clhep/include
    export PATH=$PATH:$INSTALLDIR/clhep/bin

    # GLoBES Setup
    wget https://www.mpi-hd.mpg.de/personalhomes/globes/download/globes-3.0.11.tar.gz
    tar -xzvf globes-3.0.11.tar.gz
    rm globes-3.0.11.tar.gz
    mkdir globes
    cd globes-3.0.11/
    ./configure --prefix=$INSTALLDIR/globes
    make -j4
    make install
    cd $INSTALLDIR
    rm -rf globes-3.0.11
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$INSTALLDIR/globes/lib
    export CPLUS_INCLUDE_PATH=$CPLUS_INCLUDE_PATH:$INSTALLDIR/globes/include
    export PATH=$PATH:$INSTALLDIR/globes/bin

    # ROOT setup
    wget https://root.cern.ch/download/root_v5.34.38.source.tar.gz
    tar -xzvf root_v5.34.38.source.tar.gz
    rm root_v5.34.38.source.tar.gz
    mv root root-source
    mkdir root-build
    mkdir root
    cd root-build
    cmake -DCMAKE_INSTALL_PREFIX=$INSTALLDIR/root -Dgsl_shared=ON -DGSL_ROOT_DIR=$INSTALLDIR/gsl -Dmathmore=ON -DPYTHIA6=ON -DPYTHIA6_LIBRARY=$INSTALLDIR/pythia6/libPythia6.so ../root-source/
    make -j4
    make install
    cd $INSTALLDIR
    rm -rf root-build root-source
    source root/bin/thisroot.sh

    # Geant4 Setup, datasets are external to the container
    wget http://www.hep.ucl.ac.uk/~jtingey/geant4.9.4.p02.tar.gz
    tar -xzvf geant4.9.4.p02.tar.gz
    rm geant4.9.4.p02.tar.gz
    mkdir geant4-build
    mkdir geant4
    cd geant4-build
    cmake -DGEANT4_VERBOSE_CODE=OFF -DCMAKE_INSTALL_PREFIX=$INSTALLDIR/geant4 ../geant4.9.4.p02/
    make -j4
    make install
    cd $INSTALLDIR
    rm -rf geant4-build geant4.9.4.p02

    # Geatn4 Data download
    mkdir $INSTALLDIR/geant4/share/geant4-9.4.2/data
    cd geant4/share/geant4-9.4.2/data
    wget http://geant4-data.web.cern.ch/geant4-data/datasets/G4NDL.4.6.tar.gz
    tar -xzvf G4NDL.4.6.tar.gz
    rm G4NDL.4.6.tar.gz
    wget http://geant4-data.web.cern.ch/geant4-data/datasets/G4EMLOW.7.9.tar.gz
    tar -xzvf G4EMLOW.7.9.tar.gz
    rm G4EMLOW.7.9.tar.gz
    wget http://geant4-data.web.cern.ch/geant4-data/datasets/G4PhotonEvaporation.5.5.tar.gz
    tar -xzvf G4PhotonEvaporation.5.5.tar.gz
    rm G4PhotonEvaporation.5.5.tar.gz
    wget http://geant4-data.web.cern.ch/geant4-data/datasets/G4RadioactiveDecay.5.4.tar.gz
    tar -xzvf G4RadioactiveDecay.5.4.tar.gz
    rm G4RadioactiveDecay.5.4.tar.gz
    wget http://geant4-data.web.cern.ch/geant4-data/datasets/G4SAIDDATA.2.0.tar.gz
    tar -xzvf G4SAIDDATA.2.0.tar.gz
    rm G4SAIDDATA.2.0.tar.gz
    wget http://geant4-data.web.cern.ch/geant4-data/datasets/G4PARTICLEXS.2.1.tar.gz
    tar -xzvf G4PARTICLEXS.2.1.tar.gz
    rm G4PARTICLEXS.2.1.tar.gz
    wget http://geant4-data.web.cern.ch/geant4-data/datasets/G4ABLA.3.1.tar.gz
    tar -xzvf G4ABLA.3.1.tar.gz
    rm G4ABLA.3.1.tar.gz
    wget http://geant4-data.web.cern.ch/geant4-data/datasets/G4INCL.1.0.tar.gz
    tar -xzvf G4INCL.1.0.tar.gz
    rm G4INCL.1.0.tar.gz
    wget http://geant4-data.web.cern.ch/geant4-data/datasets/G4PII.1.3.tar.gz
    tar -xzvf G4PII.1.3.tar.gz
    rm G4PII.1.3.tar.gz
    wget http://geant4-data.web.cern.ch/geant4-data/datasets/G4ENSDFSTATE.2.2.tar.gz
    tar -xzvf G4ENSDFSTATE.2.2.tar.gz
    rm G4ENSDFSTATE.2.2.tar.gz
    wget http://geant4-data.web.cern.ch/geant4-data/datasets/G4RealSurface.2.1.1.tar.gz
    tar -xzvf G4RealSurface.2.1.1.tar.gz
    rm G4RealSurface.2.1.1.tar.gz
    wget http://geant4-data.web.cern.ch/geant4-data/datasets/G4TENDL.1.3.2.tar.gz
    tar -xzvf G4TENDL.1.3.2.tar.gz
    rm G4TENDL.1.3.2.tar.gz
    cd $INSTALLDIR

    # GENIE Setup
    git clone https://github.com/GENIE-MC/Generator.git
    export GENIE=$INSTALLDIR/Generator
    export ROOTSYS=$INSTALLDIR/root
    mkdir genie
    cd Generator
    ./configure --enable-lhapdf6 --enable-gfortran --prefix=$INSTALLDIR/genie
    make -j4
    make install
    cd $INSTALLDIR
    rm -rf Generator
fi


