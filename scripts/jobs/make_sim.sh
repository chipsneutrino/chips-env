#! /bin/bash

chips scripts numu_all_numuflux --job sim -d chips_1200 -n 600 -s 0
chips scripts nuel_all_numuflux --job sim -d chips_1200 -n 600 -s 0
chips scripts numu_cccoh_numuflux --job sim -d chips_1200 -n 125 -s 0
chips scripts numu_nccoh_numuflux --job sim -d chips_1200 -n 125 -s 0
chips scripts numu_ccdis_numuflux --job sim -d chips_1200 -n 125 -s 0
chips scripts numu_ncdis_numuflux --job sim -d chips_1200 -n 125 -s 0
chips scripts numu_ccqel_numuflux --job sim -d chips_1200 -n 125 -s 0
chips scripts numu_ccres_numuflux --job sim -d chips_1200 -n 125 -s 0
chips scripts numu_ncres_numuflux --job sim -d chips_1200 -n 125 -s 0
chips scripts numu_ccmec_numuflux --job sim -d chips_1200 -n 125 -s 0
chips scripts nuel_cccoh_numuflux --job sim -d chips_1200 -n 125 -s 0
chips scripts nuel_nccoh_numuflux --job sim -d chips_1200 -n 125 -s 0
chips scripts nuel_ccdis_numuflux --job sim -d chips_1200 -n 125 -s 0
chips scripts nuel_ncdis_numuflux --job sim -d chips_1200 -n 125 -s 0
chips scripts nuel_ccqel_numuflux --job sim -d chips_1200 -n 125 -s 0
chips scripts nuel_ccres_numuflux --job sim -d chips_1200 -n 125 -s 0
chips scripts nuel_ncres_numuflux --job sim -d chips_1200 -n 125 -s 0
chips scripts nuel_ccmec_numuflux --job sim -d chips_1200 -n 125 -s 0
chips scripts nuel_all_nuelflux --job sim -d chips_1200 -n 125 -s 0
chips scripts anumu_all_anumuflux --job sim -d chips_1200 -n 125 -s 0
chips scripts anuel_all_anuelflux --job sim -d chips_1200 -n 125 -s 0
chips scripts cosmics --job sim -d chips_1200 -n 1250 -s 0 -p cosmic
