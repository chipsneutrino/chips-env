#! /bin/bash

# Set the chips-sim directory
export WCSIMHOME=/unix/chips/software/chips-sim/
export PATH=$PATH:$WCSIMHOME/bin

# Set the chips-reco directory
export WCSIMANAHOME=/unix/chips/software/chips-reco/
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$WCSIMANAHOME/lib/
export PATH=$PATH:$WCSIMANAHOME/

# Setup the CRY paths
export CRYDIR=/unix/chips/software/chips-gen/cry_v1.7
export CRYDATA=/unix/chips/software/chips-gen/cry_v1.7/data
export PATH=$PATH:/unix/chips/software/chips-gen/

# Setup all other packages
source /unix/lartpc/software/root/setup.sh
source /unix/lartpc/software/geant4/setup.sh
source /unix/lartpc/software/genie/setup.sh

# Put genie executables into the path
export PATH=$PATH:/unix/lartpc/software/genie/genie-2.6.6/bin/

# We need to add some libraries to the path for compatability across platforms
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/unix/chips/software/libs/
