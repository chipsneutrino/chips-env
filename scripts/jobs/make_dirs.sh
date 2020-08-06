#! /bin/bash

mkdir $PRODDIR/numu_all_numuflux/ && chips scripts numu_all_numuflux/ --job make
mkdir $PRODDIR/nuel_all_numuflux/ && chips scripts nuel_all_numuflux/ --job make
mkdir $PRODDIR/numu_cccoh_numuflux/ && chips scripts numu_cccoh_numuflux/ --job make
mkdir $PRODDIR/numu_nccoh_numuflux/ && chips scripts numu_nccoh_numuflux/ --job make
mkdir $PRODDIR/numu_ccdis_numuflux/ && chips scripts numu_ccdis_numuflux/ --job make
mkdir $PRODDIR/numu_ncdis_numuflux/ && chips scripts numu_ncdis_numuflux/ --job make
mkdir $PRODDIR/numu_ccqel_numuflux/ && chips scripts numu_ccqel_numuflux/ --job make
mkdir $PRODDIR/numu_ccres_numuflux/ && chips scripts numu_ccres_numuflux/ --job make
mkdir $PRODDIR/numu_ncres_numuflux/ && chips scripts numu_ncres_numuflux/ --job make
mkdir $PRODDIR/numu_ccmec_numuflux/ && chips scripts numu_ccmec_numuflux/ --job make
mkdir $PRODDIR/nuel_cccoh_numuflux/ && chips scripts nuel_cccoh_numuflux/ --job make
mkdir $PRODDIR/nuel_nccoh_numuflux/ && chips scripts nuel_nccoh_numuflux/ --job make
mkdir $PRODDIR/nuel_ccdis_numuflux/ && chips scripts nuel_ccdis_numuflux/ --job make
mkdir $PRODDIR/nuel_ncdis_numuflux/ && chips scripts nuel_ncdis_numuflux/ --job make
mkdir $PRODDIR/nuel_ccqel_numuflux/ && chips scripts nuel_ccqel_numuflux/ --job make
mkdir $PRODDIR/nuel_ccres_numuflux/ && chips scripts nuel_ccres_numuflux/ --job make
mkdir $PRODDIR/nuel_ncres_numuflux/ && chips scripts nuel_ncres_numuflux/ --job make
mkdir $PRODDIR/nuel_ccmec_numuflux/ && chips scripts nuel_ccmec_numuflux/ --job make
mkdir $PRODDIR/nuel_all_nuelflux/ && chips scripts nuel_all_nuelflux/ --job make
mkdir $PRODDIR/anumu_all_anumuflux/ && chips scripts anumu_all_anumuflux/ --job make
mkdir $PRODDIR/anuel_all_anuelflux/ && chips scripts anuel_all_anuelflux/ --job make
mkdir $PRODDIR/cosmics/ && chips scripts cosmics/ --job make