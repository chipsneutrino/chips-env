# Install required packages
yum update -y && yum install -y git gcc-c++ gcc binutils \
libX11-devel libXpm-devel libXft-devel libXext-devel \
libgsl-dev wget tar dpkg-dev python-dev make openssl-devel \
xorg-x11-server-Xorg xorg-x11-xauth xorg-x11-apps libX11-devel libXmu-devel \
gcc-gfortran python-devel freeglut-devel libxml2-devel gsl-static

yum clean all

cd /opt  # Go to the /opt directory
mkdir /opt/data

# Install cmake3
wget https://github.com/Kitware/CMake/releases/download/v3.17.0/cmake-3.17.0.tar.gz --no-check-certificate
tar -xzvf cmake-3.*
rm *.tar.gz
cd cmake-3.*
./bootstrap --parallel=$(nproc) -- -DCMAKE_BUILD_TYPE:STRING=Release
make -j$(nproc)
make install
cd /opt
rm -rf cmake-3.*

# Install pythia6
wget https://root.cern.ch/download/pythia6.tar.gz --no-check-certificate
tar -xzvf pythia6.tar.gz
rm -rf pythia6.tar.gz
wget http://www.hepforge.org/archive/pythiasix/pythia-6.4.28.f.gz --no-check-certificate
gzip -d pythia-6.4.28.f.gz
mv pythia-6.4.28.f pythia6/pythia6428.f
rm -rf pythia6/pythia6416.f
cd pythia6
./makePythia6.linuxx8664
cd /opt
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/pythia6

# Install GSL
wget ftp://ftp.gnu.org/gnu/gsl/gsl-2.6.tar.gz --no-check-certificate
tar -xzvf gsl-2.6.tar.gz
rm gsl-2.6.tar.gz
cd gsl-2.6
./configure
make -j$(nproc)
make install
cd /opt
rm -rf gsl-2.6

# Install GLoBES
wget https://www.mpi-hd.mpg.de/personalhomes/globes/download/globes-3.2.17.tar.gz --no-check-certificate
tar -xzvf globes-3.2.17.tar.gz
rm globes-3.2.17.tar.gz
cd globes-3.2.17/
./configure
make -j$(nproc)
make install
cd /opt
rm -rf globes-3.2.17

# Install CRY
wget https://nuclear.llnl.gov/simulation/cry_v1.7.tar.gz --no-check-certificate
tar -xzvf cry_v1.7.tar.gz
rm cry_v1.7.tar.gz
mv cry_v1.7/ cry/
cd cry/
make setup -j$(nproc)
make lib -j$(nproc)
cd /opt

# Install log4cpp
wget https://netcologne.dl.sourceforge.net/project/log4cpp/log4cpp-1.1.x%20%28new%29/log4cpp-1.1/log4cpp-1.1.3.tar.gz --no-check-certificate
tar -xzvf log4cpp-1.1.3.tar.gz
rm -rf log4cpp-1.1.3.tar.gz
cd log4cpp
./configure
make -j$(nproc)
make install
cd /opt
rm -rf log4cpp

# Install geant4 (not the data)
wget http://geant4-data.web.cern.ch/geant4-data/releases/geant4.10.05.p01.tar.gz --no-check-certificate
tar -xzvf geant4.10.05.p01.tar.gz
rm geant4.10.05.p01.tar.gz
mkdir geant4-build
mkdir /opt/data/geant4
cd geant4-build
cmake -DGEANT4_INSTALL_DATADIR=/opt/data/geant4 -DGEANT4_USE_OPENGL_X11=ON /opt/geant4.10.05.p01
make -j$(nproc)
make install
cd /opt
rm -rf geant4-build geant4.10.05.p01

# Install ROOT
wget https://root.cern/download/root_v6.20.04.source.tar.gz --no-check-certificate
tar -xzvf root_v6.20.04.source.tar.gz
rm root_v6.20.04.source.tar.gz
mkdir root-build
cd root-build
cmake -Dminuit2=ON -Dpythia6=ON -DPYTHIA6_LIBRARY=/opt/pythia6/libPythia6.so /opt/root-6.20.04
make -j$(nproc)
make install
cd /opt
rm -rf root-build root-6.20.04
source /usr/local/bin/thisroot.sh

# Install GENIE
export GENIE=/opt/Generator
export PATH=$PATH:$GENIE/bin
export LD_LIBRARY_PATH=$GENIE/lib:$LD_LIBRARY_PATH
export CPLUS_INCLUDE_PATH=$GENIE/include:$CPLUS_INCLUDE_PATH
git clone https://github.com/GENIE-MC/Generator.git
cd Generator
git checkout R-3_00_06
./configure --enable-fnal --with-pythia6-lib=/opt/pythia6/ --disable-lhapdf5
sed -i 's/genie-config --libs)/genie-config --libs) -lgfortran/g' ./src/Apps/Makefile
make -j$(nproc)
make install
cd /opt
rm -rf Generator