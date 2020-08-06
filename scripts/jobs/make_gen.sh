#! /bin/bash

chips scripts numu_all_numuflux --job gen -n 1500000 -p numu -f numu
chips scripts nuel_all_numuflux --job gen -n 1500000 -p nuel -f numu
chips scripts numu_cccoh_numuflux --job gen -n 300000 -p numu -f numu -t CCCOH
chips scripts numu_nccoh_numuflux --job gen -n 300000 -p numu -f numu -t NCCOH
chips scripts numu_ccdis_numuflux --job gen -n 300000 -p numu -f numu -t CCDIS
chips scripts numu_ncdis_numuflux --job gen -n 300000 -p numu -f numu -t NCDIS
chips scripts numu_ccqel_numuflux --job gen -n 300000 -p numu -f numu -t CCQE
chips scripts numu_ccres_numuflux --job gen -n 300000 -p numu -f numu -t CCRES
chips scripts numu_ncres_numuflux --job gen -n 300000 -p numu -f numu -t NCRES
chips scripts numu_ccmec_numuflux --job gen -n 300000 -p numu -f numu -t CCMEC
chips scripts nuel_cccoh_numuflux --job gen -n 300000 -p nuel -f numu -t CCCOH
chips scripts nuel_nccoh_numuflux --job gen -n 300000 -p nuel -f numu -t NCCOH
chips scripts nuel_ccdis_numuflux --job gen -n 300000 -p nuel -f numu -t CCDIS
chips scripts nuel_ncdis_numuflux --job gen -n 300000 -p nuel -f numu -t NCDIS
chips scripts nuel_ccqel_numuflux --job gen -n 300000 -p nuel -f numu -t CCQE
chips scripts nuel_ccres_numuflux --job gen -n 300000 -p nuel -f numu -t CCRES
chips scripts nuel_ncres_numuflux --job gen -n 300000 -p nuel -f numu -t NCRES
chips scripts nuel_ccmec_numuflux --job gen -n 300000 -p nuel -f numu -t CCMEC
chips scripts nuel_all_nuelflux --job gen -n 300000 -p nuel -f nuel
chips scripts anumu_all_anumuflux --job gen -n 300000 -p anumu -f anumu
chips scripts anuel_all_anuelflux --job gen -n 300000 -p anuel -f anuel
chips scripts cosmics --job gen -n 2500000 -p cosmic -d chips_1200
chips scripts cosmics --job gen -n 2500000 -p cosmic -d chips_1000
chips scripts cosmics --job gen -n 2500000 -p cosmic -d chips_800
chips scripts cosmics --job gen -n 2500000 -p cosmic -d chips_600
chips scripts cosmics --job gen -n 2500000 -p cosmic -d chips_400