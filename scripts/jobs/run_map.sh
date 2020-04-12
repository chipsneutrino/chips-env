#! /bin/bash

CURRENTDIR=$(pwd)
PRODDIR=/unix/chips/prod

cd $PRODDIR/beam_all/nuel/scripts/map/ && source $PRODDIR/beam_all/nuel/scripts/chips_1200_map.sh
cd $PRODDIR/beam_all/anuel/scripts/map/ && source $PRODDIR/beam_all/anuel/scripts/chips_1200_map.sh
cd $PRODDIR/beam_all/numu/scripts/map/ && source $PRODDIR/beam_all/numu/scripts/chips_1200_map.sh
cd $PRODDIR/beam_all/anumu/scripts/map/ && source $PRODDIR/beam_all/anumu/scripts/chips_1200_map.sh

cd $PRODDIR/beam_nuel/cccoh/scripts/map/ && source $PRODDIR/beam_nuel/cccoh/scripts/chips_1200_map.sh
cd $PRODDIR/beam_nuel/nccoh/scripts/map/ && source $PRODDIR/beam_nuel/nccoh/scripts/chips_1200_map.sh
cd $PRODDIR/beam_nuel/ccdis/scripts/map/ && source $PRODDIR/beam_nuel/ccdis/scripts/chips_1200_map.sh
cd $PRODDIR/beam_nuel/ncdis/scripts/map/ && source $PRODDIR/beam_nuel/ncdis/scripts/chips_1200_map.sh
cd $PRODDIR/beam_nuel/ccqel/scripts/map/ && source $PRODDIR/beam_nuel/ccqel/scripts/chips_1200_map.sh
cd $PRODDIR/beam_nuel/ncqel/scripts/map/ && source $PRODDIR/beam_nuel/ncqel/scripts/chips_1200_map.sh
cd $PRODDIR/beam_nuel/ccres/scripts/map/ && source $PRODDIR/beam_nuel/ccres/scripts/chips_1200_map.sh
cd $PRODDIR/beam_nuel/ncres/scripts/map/ && source $PRODDIR/beam_nuel/ncres/scripts/chips_1200_map.sh
cd $PRODDIR/beam_nuel/charmccqel/scripts/map/ && source $PRODDIR/beam_nuel/charmccqel/scripts/chips_1200_map.sh
cd $PRODDIR/beam_nuel/nueelastic/scripts/map/ && source $PRODDIR/beam_nuel/nueelastic/scripts/chips_1200_map.sh
cd $PRODDIR/beam_nuel/imd/scripts/map/ && source $PRODDIR/beam_nuel/imd/scripts/chips_1200_map.sh
cd $PRODDIR/beam_nuel/ccmec/scripts/map/ && source $PRODDIR/beam_nuel/ccmec/scripts/chips_1200_map.sh
cd $PRODDIR/beam_nuel/ncmec/scripts/map/ && source $PRODDIR/beam_nuel/ncmec/scripts/chips_1200_map.sh

cd $PRODDIR/beam_numu/cccoh/scripts/map/ && source $PRODDIR/beam_numu/cccoh/scripts/chips_1200_map.sh
cd $PRODDIR/beam_numu/nccoh/scripts/map/ && source $PRODDIR/beam_numu/nccoh/scripts/chips_1200_map.sh
cd $PRODDIR/beam_numu/ccdis/scripts/map/ && source $PRODDIR/beam_numu/ccdis/scripts/chips_1200_map.sh
cd $PRODDIR/beam_numu/ncdis/scripts/map/ && source $PRODDIR/beam_numu/ncdis/scripts/chips_1200_map.sh
cd $PRODDIR/beam_numu/ccqel/scripts/map/ && source $PRODDIR/beam_numu/ccqel/scripts/chips_1200_map.sh
cd $PRODDIR/beam_numu/ncqel/scripts/map/ && source $PRODDIR/beam_numu/ncqel/scripts/chips_1200_map.sh
cd $PRODDIR/beam_numu/ccres/scripts/map/ && source $PRODDIR/beam_numu/ccres/scripts/chips_1200_map.sh
cd $PRODDIR/beam_numu/ncres/scripts/map/ && source $PRODDIR/beam_numu/ncres/scripts/chips_1200_map.sh
cd $PRODDIR/beam_numu/charmccqel/scripts/map/ && source $PRODDIR/beam_numu/charmccqel/scripts/chips_1200_map.sh
cd $PRODDIR/beam_numu/nueelastic/scripts/map/ && source $PRODDIR/beam_numu/nueelastic/scripts/chips_1200_map.sh
cd $PRODDIR/beam_numu/imd/scripts/map/ && source $PRODDIR/beam_numu/imd/scripts/chips_1200_map.sh
cd $PRODDIR/beam_numu/ccmec/scripts/map/ && source $PRODDIR/beam_numu/ccmec/scripts/chips_1200_map.sh
cd $PRODDIR/beam_numu/ncmec/scripts/map/ && source $PRODDIR/beam_numu/ncmec/scripts/chips_1200_map.sh

cd $PRODDIR/cosmic_all/scripts/map/ && source $PRODDIR/cosmic_all/scripts/chips_1200_map.sh

cd $CURRENTDIR