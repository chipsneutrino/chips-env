#! /bin/bash

CURRENTDIR=$(pwd)
PRODDIR=/unix/chips/prod

cd $PRODDIR/beam_all/nuel/scripts/gen/ && source $PRODDIR/beam_all/nuel/scripts/gen.sh
cd $PRODDIR/beam_all/anuel/scripts/gen/ && source $PRODDIR/beam_all/anuel/scripts/gen.sh
cd $PRODDIR/beam_all/numu/scripts/gen/ && source $PRODDIR/beam_all/numu/scripts/gen.sh
cd $PRODDIR/beam_all/anumu/scripts/gen/ && source $PRODDIR/beam_all/anumu/scripts/gen.sh

cd $PRODDIR/beam_nuel/cccoh/scripts/gen/ && source $PRODDIR/beam_nuel/cccoh/scripts/gen.sh
cd $PRODDIR/beam_nuel/nccoh/scripts/gen/ && source $PRODDIR/beam_nuel/nccoh/scripts/gen.sh
cd $PRODDIR/beam_nuel/ccdis/scripts/gen/ && source $PRODDIR/beam_nuel/ccdis/scripts/gen.sh
cd $PRODDIR/beam_nuel/ncdis/scripts/gen/ && source $PRODDIR/beam_nuel/ncdis/scripts/gen.sh
cd $PRODDIR/beam_nuel/ccqel/scripts/gen/ && source $PRODDIR/beam_nuel/ccqel/scripts/gen.sh
cd $PRODDIR/beam_nuel/ncqel/scripts/gen/ && source $PRODDIR/beam_nuel/ncqel/scripts/gen.sh
cd $PRODDIR/beam_nuel/ccres/scripts/gen/ && source $PRODDIR/beam_nuel/ccres/scripts/gen.sh
cd $PRODDIR/beam_nuel/ncres/scripts/gen/ && source $PRODDIR/beam_nuel/ncres/scripts/gen.sh
cd $PRODDIR/beam_nuel/ccmec/scripts/gen/ && source $PRODDIR/beam_nuel/ccmec/scripts/gen.sh

cd $PRODDIR/beam_numu/cccoh/scripts/gen/ && source $PRODDIR/beam_numu/cccoh/scripts/gen.sh
cd $PRODDIR/beam_numu/nccoh/scripts/gen/ && source $PRODDIR/beam_numu/nccoh/scripts/gen.sh
cd $PRODDIR/beam_numu/ccdis/scripts/gen/ && source $PRODDIR/beam_numu/ccdis/scripts/gen.sh
cd $PRODDIR/beam_numu/ncdis/scripts/gen/ && source $PRODDIR/beam_numu/ncdis/scripts/gen.sh
cd $PRODDIR/beam_numu/ccqel/scripts/gen/ && source $PRODDIR/beam_numu/ccqel/scripts/gen.sh
cd $PRODDIR/beam_numu/ncqel/scripts/gen/ && source $PRODDIR/beam_numu/ncqel/scripts/gen.sh
cd $PRODDIR/beam_numu/ccres/scripts/gen/ && source $PRODDIR/beam_numu/ccres/scripts/gen.sh
cd $PRODDIR/beam_numu/ncres/scripts/gen/ && source $PRODDIR/beam_numu/ncres/scripts/gen.sh
cd $PRODDIR/beam_numu/ccmec/scripts/gen/ && source $PRODDIR/beam_numu/ccmec/scripts/gen.sh

cd $PRODDIR/cosmic_all/scripts/gen/ && source $PRODDIR/cosmic_all/scripts/chips_1200_gen.sh
cd $PRODDIR/cosmic_all/scripts/gen/ && source $PRODDIR/cosmic_all/scripts/chips_1000_gen.sh
cd $PRODDIR/cosmic_all/scripts/gen/ && source $PRODDIR/cosmic_all/scripts/chips_800_gen.sh
cd $PRODDIR/cosmic_all/scripts/gen/ && source $PRODDIR/cosmic_all/scripts/chips_600_gen.sh
cd $PRODDIR/cosmic_all/scripts/gen/ && source $PRODDIR/cosmic_all/scripts/chips_400_gen.sh
cd $PRODDIR/cosmic_all/scripts/gen/ && source $PRODDIR/cosmic_all/scripts/chips_275_gen.sh

cd $CURRENTDIR
