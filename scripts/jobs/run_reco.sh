#! /bin/bash

CURRENTDIR=$(pwd)

cd $PRODDIR/numu_all_numuflux/scripts/reco/ && source ../chips_1200_reco.sh
cd $PRODDIR/nuel_all_numuflux/scripts/reco/ && source ../chips_1200_reco.sh

cd $CURRENTDIR