#! /bin/bash

CURRENTDIR=$(pwd)

cd $PRODDIR/beam_all/nuel/scripts/reco/ && source $PRODDIR/beam_all/nuel/scripts/chips_1200_reco.sh
cd $PRODDIR/beam_all/numu/scripts/reco/ && source $PRODDIR/beam_all/numu/scripts/chips_1200_reco.sh

cd $CURRENTDIR