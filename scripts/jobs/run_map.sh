#! /bin/bash

CURRENTDIR=$(pwd)

cd $PRODDIR/numu_all_numuflux/scripts/gen/ && source ../chips_1200_map.sh
cd $PRODDIR/nuel_all_numuflux/scripts/gen/ && source ../chips_1200_map.sh
cd $PRODDIR/numu_cccoh_numuflux/scripts/gen/ && source ../chips_1200_map.sh
cd $PRODDIR/numu_nccoh_numuflux/scripts/gen/ && source ../chips_1200_map.sh
cd $PRODDIR/numu_ccdis_numuflux/scripts/gen/ && source ../chips_1200_map.sh
cd $PRODDIR/numu_ncdis_numuflux/scripts/gen/ && source ../chips_1200_map.sh
cd $PRODDIR/numu_ccqel_numuflux/scripts/gen/ && source ../chips_1200_map.sh
cd $PRODDIR/numu_ncqel_numuflux/scripts/gen/ && source ../chips_1200_map.sh
cd $PRODDIR/numu_ccres_numuflux/scripts/gen/ && source ../chips_1200_map.sh
cd $PRODDIR/numu_ncres_numuflux/scripts/gen/ && source ../chips_1200_map.sh
cd $PRODDIR/numu_ccmec_numuflux/scripts/gen/ && source ../chips_1200_map.sh
cd $PRODDIR/nuel_cccoh_numuflux/scripts/gen/ && source ../chips_1200_map.sh
cd $PRODDIR/nuel_nccoh_numuflux/scripts/gen/ && source ../chips_1200_map.sh
cd $PRODDIR/nuel_ccdis_numuflux/scripts/gen/ && source ../chips_1200_map.sh
cd $PRODDIR/nuel_ncdis_numuflux/scripts/gen/ && source ../chips_1200_map.sh
cd $PRODDIR/nuel_ccqel_numuflux/scripts/gen/ && source ../chips_1200_map.sh
cd $PRODDIR/nuel_ncqel_numuflux/scripts/gen/ && source ../chips_1200_map.sh
cd $PRODDIR/nuel_ccres_numuflux/scripts/gen/ && source ../chips_1200_map.sh
cd $PRODDIR/nuel_ncres_numuflux/scripts/gen/ && source ../chips_1200_map.sh
cd $PRODDIR/nuel_ccmec_numuflux/scripts/gen/ && source ../chips_1200_map.sh
cd $PRODDIR/nuel_all_nuelflux/scripts/gen/ && source ../chips_1200_map.sh
cd $PRODDIR/anumu_all_anumuflux/scripts/gen/ && source ../chips_1200_map.sh
cd $PRODDIR/anuel_all_anuelflux/scripts/gen/ && source ../chips_1200_map.sh
cd $PRODDIR/cosmics/scripts/gen/ && source ../chips_1200_map.sh

cd $CURRENTDIR
