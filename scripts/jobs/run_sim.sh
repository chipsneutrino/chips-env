#! /bin/bash

CURRENTDIR=$(pwd)
PRODDIR=/unix/chips/prod

cd $PRODDIR/beam_all/nuel/scripts/sim/ && source $PRODDIR/beam_all/nuel/scripts/chips_1200_sim.sh
cd $PRODDIR/beam_all/anuel/scripts/sim/ && source $PRODDIR/beam_all/anuel/scripts/chips_1200_sim.sh
cd $PRODDIR/beam_all/numu/scripts/sim/ && source $PRODDIR/beam_all/numu/scripts/chips_1200_sim.sh
cd $PRODDIR/beam_all/anumu/scripts/sim/ && source $PRODDIR/beam_all/anumu/scripts/chips_1200_sim.sh

cd $PRODDIR/beam_nuel/cccoh/scripts/sim/ && source $PRODDIR/beam_nuel/cccoh/scripts/chips_1200_sim.sh
cd $PRODDIR/beam_nuel/nccoh/scripts/sim/ && source $PRODDIR/beam_nuel/nccoh/scripts/chips_1200_sim.sh
cd $PRODDIR/beam_nuel/ccdis/scripts/sim/ && source $PRODDIR/beam_nuel/ccdis/scripts/chips_1200_sim.sh
cd $PRODDIR/beam_nuel/ncdis/scripts/sim/ && source $PRODDIR/beam_nuel/ncdis/scripts/chips_1200_sim.sh
cd $PRODDIR/beam_nuel/ccqel/scripts/sim/ && source $PRODDIR/beam_nuel/ccqel/scripts/chips_1200_sim.sh
cd $PRODDIR/beam_nuel/ncqel/scripts/sim/ && source $PRODDIR/beam_nuel/ncqel/scripts/chips_1200_sim.sh
cd $PRODDIR/beam_nuel/ccres/scripts/sim/ && source $PRODDIR/beam_nuel/ccres/scripts/chips_1200_sim.sh
cd $PRODDIR/beam_nuel/ncres/scripts/sim/ && source $PRODDIR/beam_nuel/ncres/scripts/chips_1200_sim.sh
cd $PRODDIR/beam_nuel/charmccdis/scripts/sim/ && source $PRODDIR/beam_nuel/charmccdis/scripts/chips_1200_sim.sh
cd $PRODDIR/beam_nuel/charmccqel/scripts/sim/ && source $PRODDIR/beam_nuel/charmccqel/scripts/chips_1200_sim.sh
cd $PRODDIR/beam_nuel/nueelastic/scripts/sim/ && source $PRODDIR/beam_nuel/nueelastic/scripts/chips_1200_sim.sh
cd $PRODDIR/beam_nuel/imd/scripts/sim/ && source $PRODDIR/beam_nuel/imd/scripts/chips_1200_sim.sh
cd $PRODDIR/beam_nuel/ccmec/scripts/sim/ && source $PRODDIR/beam_nuel/ccmec/scripts/chips_1200_sim.sh
cd $PRODDIR/beam_nuel/ncmec/scripts/sim/ && source $PRODDIR/beam_nuel/ncmec/scripts/chips_1200_sim.sh

cd $PRODDIR/beam_numu/cccoh/scripts/sim/ && source $PRODDIR/beam_numu/cccoh/scripts/chips_1200_sim.sh
cd $PRODDIR/beam_numu/nccoh/scripts/sim/ && source $PRODDIR/beam_numu/nccoh/scripts/chips_1200_sim.sh
cd $PRODDIR/beam_numu/ccdis/scripts/sim/ && source $PRODDIR/beam_numu/ccdis/scripts/chips_1200_sim.sh
cd $PRODDIR/beam_numu/ncdis/scripts/sim/ && source $PRODDIR/beam_numu/ncdis/scripts/chips_1200_sim.sh
cd $PRODDIR/beam_numu/ccqel/scripts/sim/ && source $PRODDIR/beam_numu/ccqel/scripts/chips_1200_sim.sh
cd $PRODDIR/beam_numu/ncqel/scripts/sim/ && source $PRODDIR/beam_numu/ncqel/scripts/chips_1200_sim.sh
cd $PRODDIR/beam_numu/ccres/scripts/sim/ && source $PRODDIR/beam_numu/ccres/scripts/chips_1200_sim.sh
cd $PRODDIR/beam_numu/ncres/scripts/sim/ && source $PRODDIR/beam_numu/ncres/scripts/chips_1200_sim.sh
cd $PRODDIR/beam_numu/charmccdis/scripts/sim/ && source $PRODDIR/beam_numu/charmccdis/scripts/chips_1200_sim.sh
cd $PRODDIR/beam_numu/charmccqel/scripts/sim/ && source $PRODDIR/beam_numu/charmccqel/scripts/chips_1200_sim.sh
cd $PRODDIR/beam_numu/nueelastic/scripts/sim/ && source $PRODDIR/beam_numu/nueelastic/scripts/chips_1200_sim.sh
cd $PRODDIR/beam_numu/imd/scripts/sim/ && source $PRODDIR/beam_numu/imd/scripts/chips_1200_sim.sh
cd $PRODDIR/beam_numu/ccmec/scripts/sim/ && source $PRODDIR/beam_numu/ccmec/scripts/chips_1200_sim.sh
cd $PRODDIR/beam_numu/ncmec/scripts/sim/ && source $PRODDIR/beam_numu/ncmec/scripts/chips_1200_sim.sh

cd $PRODDIR/cosmic_all/scripts/sim/ && source $PRODDIR/cosmic_all/scripts/chips_1200_sim.sh

cd $CURRENTDIR