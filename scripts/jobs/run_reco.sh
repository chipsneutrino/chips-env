#! /bin/bash

CURRENTDIR=$(pwd)
PRODDIR=/unix/chips/prod

cd $PRODDIR/beam_all/nuel/scripts/reco/ && source $PRODDIR/beam_all/nuel/scripts/chips_1200_reco.sh
cd $PRODDIR/beam_all/anuel/scripts/reco/ && source $PRODDIR/beam_all/anuel/scripts/chips_1200_reco.sh
cd $PRODDIR/beam_all/numu/scripts/reco/ && source $PRODDIR/beam_all/numu/scripts/chips_1200_reco.sh
cd $PRODDIR/beam_all/anumu/scripts/reco/ && source $PRODDIR/beam_all/anumu/scripts/chips_1200_reco.sh

cd $PRODDIR/beam_nuel/cccoh/scripts/reco/ && source $PRODDIR/beam_nuel/cccoh/scripts/chips_1200_reco.sh
cd $PRODDIR/beam_nuel/nccoh/scripts/reco/ && source $PRODDIR/beam_nuel/nccoh/scripts/chips_1200_reco.sh
cd $PRODDIR/beam_nuel/ccdis/scripts/reco/ && source $PRODDIR/beam_nuel/ccdis/scripts/chips_1200_reco.sh
cd $PRODDIR/beam_nuel/ncdis/scripts/reco/ && source $PRODDIR/beam_nuel/ncdis/scripts/chips_1200_reco.sh
cd $PRODDIR/beam_nuel/ccqel/scripts/reco/ && source $PRODDIR/beam_nuel/ccqel/scripts/chips_1200_reco.sh
cd $PRODDIR/beam_nuel/ncqel/scripts/reco/ && source $PRODDIR/beam_nuel/ncqel/scripts/chips_1200_reco.sh
cd $PRODDIR/beam_nuel/ccres/scripts/reco/ && source $PRODDIR/beam_nuel/ccres/scripts/chips_1200_reco.sh
cd $PRODDIR/beam_nuel/ncres/scripts/reco/ && source $PRODDIR/beam_nuel/ncres/scripts/chips_1200_reco.sh
cd $PRODDIR/beam_nuel/charmccqel/scripts/reco/ && source $PRODDIR/beam_nuel/charmccqel/scripts/chips_1200_reco.sh
cd $PRODDIR/beam_nuel/nueelastic/scripts/reco/ && source $PRODDIR/beam_nuel/nueelastic/scripts/chips_1200_reco.sh
cd $PRODDIR/beam_nuel/imd/scripts/reco/ && source $PRODDIR/beam_nuel/imd/scripts/chips_1200_reco.sh
cd $PRODDIR/beam_nuel/ccmec/scripts/reco/ && source $PRODDIR/beam_nuel/ccmec/scripts/chips_1200_reco.sh
cd $PRODDIR/beam_nuel/ncmec/scripts/reco/ && source $PRODDIR/beam_nuel/ncmec/scripts/chips_1200_reco.sh

cd $PRODDIR/beam_numu/cccoh/scripts/reco/ && source $PRODDIR/beam_numu/cccoh/scripts/chips_1200_reco.sh
cd $PRODDIR/beam_numu/nccoh/scripts/reco/ && source $PRODDIR/beam_numu/nccoh/scripts/chips_1200_reco.sh
cd $PRODDIR/beam_numu/ccdis/scripts/reco/ && source $PRODDIR/beam_numu/ccdis/scripts/chips_1200_reco.sh
cd $PRODDIR/beam_numu/ncdis/scripts/reco/ && source $PRODDIR/beam_numu/ncdis/scripts/chips_1200_reco.sh
cd $PRODDIR/beam_numu/ccqel/scripts/reco/ && source $PRODDIR/beam_numu/ccqel/scripts/chips_1200_reco.sh
cd $PRODDIR/beam_numu/ncqel/scripts/reco/ && source $PRODDIR/beam_numu/ncqel/scripts/chips_1200_reco.sh
cd $PRODDIR/beam_numu/ccres/scripts/reco/ && source $PRODDIR/beam_numu/ccres/scripts/chips_1200_reco.sh
cd $PRODDIR/beam_numu/ncres/scripts/reco/ && source $PRODDIR/beam_numu/ncres/scripts/chips_1200_reco.sh
cd $PRODDIR/beam_numu/charmccqel/scripts/reco/ && source $PRODDIR/beam_numu/charmccqel/scripts/chips_1200_reco.sh
cd $PRODDIR/beam_numu/nueelastic/scripts/reco/ && source $PRODDIR/beam_numu/nueelastic/scripts/chips_1200_reco.sh
cd $PRODDIR/beam_numu/imd/scripts/reco/ && source $PRODDIR/beam_numu/imd/scripts/chips_1200_reco.sh
cd $PRODDIR/beam_numu/ccmec/scripts/reco/ && source $PRODDIR/beam_numu/ccmec/scripts/chips_1200_reco.sh
cd $PRODDIR/beam_numu/ncmec/scripts/reco/ && source $PRODDIR/beam_numu/ncmec/scripts/chips_1200_reco.sh

cd $PRODDIR/cosmic_all/scripts/reco/ && source $PRODDIR/cosmic_all/scripts/chips_1200_reco.sh

cd $CURRENTDIR