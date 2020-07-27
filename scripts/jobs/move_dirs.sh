#! /bin/bash

FROM=map/chips_1200
TO=map/chips_1200_old

mv $PRODDIR/numu_all_numuflux/$FROM $PRODDIR/numu_all_numuflux/$TO
mv $PRODDIR/nuel_all_numuflux/$FROM $PRODDIR/nuel_all_numuflux/$TO
mv $PRODDIR/numu_cccoh_numuflux/$FROM $PRODDIR/numu_cccoh_numuflux/$TO
mv $PRODDIR/numu_nccoh_numuflux/$FROM $PRODDIR/numu_nccoh_numuflux/$TO
mv $PRODDIR/numu_ccdis_numuflux/$FROM $PRODDIR/numu_ccdis_numuflux/$TO
mv $PRODDIR/numu_ncdis_numuflux/$FROM $PRODDIR/numu_ncdis_numuflux/$TO
mv $PRODDIR/numu_ccqel_numuflux/$FROM $PRODDIR/numu_ccqel_numuflux/$TO
mv $PRODDIR/numu_ncqel_numuflux/$FROM $PRODDIR/numu_ncqel_numuflux/$TO
mv $PRODDIR/numu_ccres_numuflux/$FROM $PRODDIR/numu_ccres_numuflux/$TO
mv $PRODDIR/numu_ncres_numuflux/$FROM $PRODDIR/numu_ncres_numuflux/$TO
mv $PRODDIR/numu_ccmec_numuflux/$FROM $PRODDIR/numu_ccmec_numuflux/$TO
mv $PRODDIR/nuel_cccoh_numuflux/$FROM $PRODDIR/nuel_cccoh_numuflux/$TO
mv $PRODDIR/nuel_nccoh_numuflux/$FROM $PRODDIR/nuel_nccoh_numuflux/$TO
mv $PRODDIR/nuel_ccdis_numuflux/$FROM $PRODDIR/nuel_ccdis_numuflux/$TO
mv $PRODDIR/nuel_ncdis_numuflux/$FROM $PRODDIR/nuel_ncdis_numuflux/$TO
mv $PRODDIR/nuel_ccqel_numuflux/$FROM $PRODDIR/nuel_ccqel_numuflux/$TO
mv $PRODDIR/nuel_ncqel_numuflux/$FROM $PRODDIR/nuel_ncqel_numuflux/$TO
mv $PRODDIR/nuel_ccres_numuflux/$FROM $PRODDIR/nuel_ccres_numuflux/$TO
mv $PRODDIR/nuel_ncres_numuflux/$FROM $PRODDIR/nuel_ncres_numuflux/$TO
mv $PRODDIR/nuel_ccmec_numuflux/$FROM $PRODDIR/nuel_ccmec_numuflux/$TO
mv $PRODDIR/nuel_all_nuelflux/$FROM $PRODDIR/nuel_all_nuelflux/$TO
mv $PRODDIR/anumu_all_anumuflux/$FROM $PRODDIR/anumu_all_anumuflux/$TO 
mv $PRODDIR/anuel_all_anuelflux/$FROM $PRODDIR/anuel_all_anuelflux/$TO
mv $PRODDIR/cosmics/$FROM $PRODDIR/cosmics/$TO