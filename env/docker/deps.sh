# Install required packages
yum update -y && yum install -y wget git gcc-c++ gcc binutils \
    libX11-devel libXpm-devel libXft-devel libXext-devel wget tar make openssl-devel \
    xorg-x11-server-Xorg xorg-x11-xauth xorg-x11-apps libX11-devel libXmu-devel \
    python3-devel freeglut-devel libxml2-devel \
    gmp-devel mpfr-devel libmpc-devel bzip2 which

# Clean yum
yum clean all

# Install some handy python packages
pip3 install numpy pandas matplotlib flake8 autopep8 tqdm seaborn root_numpy root_pandas

# Create directories for building and later mounting
mkdir /opt/tmp/ && mkdir /opt/data/ && mkdir /opt/prod/
cd /opt/tmp/

# gcc-9 Install (/opt/gcc-9)
mkdir /opt/gcc-9
wget http://mirrors.concertpass.com/gcc/releases/gcc-9.3.0/gcc-9.3.0.tar.xz --no-check-certificate
tar xf gcc-9.3.0.tar.xz && rm gcc-9.3.0.tar.xz && cd gcc-9.3.0/
mkdir build && cd build
../configure --disable-multilib --program-suffix=-9 --prefix=/opt/gcc-9
make -j$(nproc)
make install -j$(nproc)
ln -s /opt/gcc-9/bin/gcc-9 /opt/gcc-9/bin/gcc
ln -s /opt/gcc-9/bin/g++-9 /opt/gcc-9/bin/g++
ln -s /opt/gcc-9/bin/gfortran-9 /opt/gcc-9/bin/gfortran
source /opt/gcc-setup.sh
cd /opt/tmp/

# cmake3 Install (/usr)
wget https://github.com/Kitware/CMake/releases/download/v3.17.2/cmake-3.17.2.tar.gz --no-check-certificate
tar xf cmake-3.17.2.tar.gz && rm cmake-3.17.2.tar.gz && cd cmake-3.17.2/
./bootstrap --parallel=$(nproc) -- -DCMAKE_BUILD_TYPE:STRING=Release
make -j$(nproc)
make install -j$(nproc)
cd /opt/tmp/

# pythia6 Install (/usr)
wget https://root.cern.ch/download/pythia6.tar.gz --no-check-certificate
tar xf pythia6.tar.gz && rm -rf pythia6.tar.gz
wget http://www.hepforge.org/archive/pythiasix/pythia-6.4.28.f.gz --no-check-certificate
gzip -d pythia-6.4.28.f.gz && mv pythia-6.4.28.f pythia6/pythia6428.f && rm -rf pythia6/pythia6416.f && cd pythia6
./makePythia6.linuxx8664
mv libPythia6.so /usr/local/lib
cd /opt/tmp/

# GSL Install (/usr)
wget ftp://ftp.gnu.org/gnu/gsl/gsl-2.6.tar.gz --no-check-certificate
tar xf gsl-2.6.tar.gz && rm gsl-2.6.tar.gz && cd gsl-2.6
./configure
make -j$(nproc)
make install -j$(nproc)
cd /opt/tmp/

# log4cpp install (/usr)
wget https://netcologne.dl.sourceforge.net/project/log4cpp/log4cpp-1.1.x%20%28new%29/log4cpp-1.1/log4cpp-1.1.3.tar.gz --no-check-certificate
tar xf log4cpp-1.1.3.tar.gz && rm -rf log4cpp-1.1.3.tar.gz && cd log4cpp
./configure
make -j$(nproc)
make install -j$(nproc)
cd /opt/tmp/

# ROOT Install (/usr)
wget https://root.cern/download/root_v6.20.04.source.tar.gz --no-check-certificate
tar xf root_v6.20.04.source.tar.gz && rm root_v6.20.04.source.tar.gz
mkdir root-build && cd root-build
export CPLUS_INCLUDE_PATH=/usr/include/python3.6m/:$CPLUS_INCLUDE_PATH
export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH
cmake -Dminuit2=ON \
    -Dpythia6=ON -DPYTHIA6_LIBRARY=/usr/local/lib/libPythia6.so \
    -DCMAKE_C_COMPILER=/opt/gcc-9/bin/gcc-9 \
    -DCMAKE_CXX_COMPILER=/opt/gcc-9/bin/g++-9 \
    -DCMAKE_Fortran_COMPILER=/opt/gcc-9/bin/gfortran-9 \
    -Dcxx11=ON \
    -Dsqlite=OFF \
    -Dpython3=ON \
    -DPYTHON_EXECUTABLE=/usr/bin/python3 \
    -DPYTHON_INCLUDE_DIR=/usr/include/python3.6m/ \
    -DPYTHON_LIBRARY=/usr/lib64/ \
    -DGSL_ROOT_DIR=/usr/local/ \
    -DGSL_CONFIG_EXECUTABLE=/usr/local/bin/gsl-config \
    ../root-6.20.04
make -j$(nproc)
make install -j$(nproc)
source /usr/local/bin/thisroot.sh
cd /opt/tmp/

# GENIE Install (/opt)
cd /opt
export GENIE=/opt/genie  
export PATH=$PATH:$GENIE/bin
export LD_LIBRARY_PATH=$GENIE/lib:$LD_LIBRARY_PATH
export CPLUS_INCLUDE_PATH=$GENIE/include:$CPLUS_INCLUDE_PATH
git clone https://github.com/GENIE-MC/Generator.git && mv Generator genie && cd genie
git checkout R-3_00_06
./configure --enable-fnal --with-pythia6-lib=/usr/local/lib/ --disable-lhapdf5 \
    --with-libxml2-inc=/usr/include/libxml2 \
    --with-libxml2-lib=/usr/lib64 \
    --with-log4cpp-inc=/usr/local/include \
    --with-log4cpp-lib=/usr/local/lib
sed -i 's/= g++/= g++-9/g' ./src/make/Make.include
sed -i 's/= gcc/= gcc-9/g' ./src/make/Make.include
sed -i 's/genie-config --libs)/genie-config --libs) -lgfortran/g' ./src/Apps/Makefile
mv /opt/GHepUtils.cxx ./src/Framework/GHEP/GHepUtils.cxx  # CHIPS version for new nuance codes
make -j$(nproc)
cd /opt/tmp/

# Boost Install (/usr)
wget https://dl.bintray.com/boostorg/release/1.73.0/source/boost_1_73_0.tar.bz2 --no-check-certificate
tar xf boost_1_73_0.tar.bz2 && rm boost_1_73_0.tar.bz2 && cd boost_1_73_0/
./bootstrap.sh
echo "using gcc : 9.3 : /opt/gcc-9/bin/g++-9 ; " >> tools/build/src/user-config.jam
./b2 toolset=gcc-9.3 -j$(nproc)
./b2 install toolset=gcc-9.3 -j$(nproc)
cd /opt/tmp/

# GLoBES Install (/usr)
wget https://www.mpi-hd.mpg.de/personalhomes/globes/download/globes-3.2.17.tar.gz --no-check-certificate
tar xf globes-3.2.17.tar.gz && rm globes-3.2.17.tar.gz && cd globes-3.2.17/
./configure
make -j$(nproc)
make install -j$(nproc)
cd /opt/tmp/

# CRY Install (/usr)
wget https://nuclear.llnl.gov/simulation/cry_v1.7.tar.gz --no-check-certificate
tar xf cry_v1.7.tar.gz && rm cry_v1.7.tar.gz && cd cry_v1.7/
echo "CXX = /opt/gcc-9/bin/g++-9" >> Makefile.local
make lib -j$(nproc)
mv lib/libCRY.a /usr/local/lib
mv src/*.h /usr/local/include
mv data/ /usr/local/share/cry-data/
cd /opt/tmp/

# Geant4 Install (/usr)
wget http://geant4-data.web.cern.ch/geant4-data/releases/geant4.10.05.p01.tar.gz --no-check-certificate
tar xf geant4.10.05.p01.tar.gz && rm geant4.10.05.p01.tar.gz
mkdir geant4-build && mkdir /opt/data/geant4
cd geant4-build
cmake -DGEANT4_INSTALL_DATADIR=/opt/data/geant4 -DGEANT4_USE_OPENGL_X11=ON ../geant4.10.05.p01
make -j$(nproc)
make install -j$(nproc)
cd /opt/tmp

cd /opt
rm -rf /opt/tmp
mv /opt/gcc-setup.sh /opt/gcc-9/activate.sh

