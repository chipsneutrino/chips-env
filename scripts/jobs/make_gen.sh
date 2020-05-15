#! /bin/bash

chips scripts beam_all/nuel/ --job gen -n 50 -p nuel
chips scripts beam_all/anuel/ --job gen -n 50 -p anuel
chips scripts beam_all/numu/ --job gen -n 50 -p numu
chips scripts beam_all/anumu/ --job gen -n 50 -p anumu

chips scripts beam_nuel/cccoh/ --job gen -n 50 -p nuel -t CCCOH
chips scripts beam_nuel/nccoh/ --job gen -n 50 -p nuel -t NCCOH
chips scripts beam_nuel/ccdis/ --job gen -n 50 -p nuel -t CCDIS
chips scripts beam_nuel/ncdis/ --job gen -n 50 -p nuel -t NCDIS
chips scripts beam_nuel/ccqel/ --job gen -n 50 -p nuel -t CCQE
chips scripts beam_nuel/ncqel/ --job gen -n 50 -p nuel -t NCEL
chips scripts beam_nuel/ccres/ --job gen -n 50 -p nuel -t CCRES
chips scripts beam_nuel/ncres/ --job gen -n 50 -p nuel -t NCRES
chips scripts beam_nuel/ccmec/ --job gen -n 50 -p nuel -t CCMEC

chips scripts beam_numu/cccoh/ --job gen -n 50 -p numu -t CCCOH
chips scripts beam_numu/nccoh/ --job gen -n 50 -p numu -t NCCOH
chips scripts beam_numu/ccdis/ --job gen -n 50 -p numu -t CCDIS
chips scripts beam_numu/ncdis/ --job gen -n 50 -p numu -t NCDIS
chips scripts beam_numu/ccqel/ --job gen -n 50 -p numu -t CCQE
chips scripts beam_numu/ncqel/ --job gen -n 50 -p numu -t NCEL
chips scripts beam_numu/ccres/ --job gen -n 50 -p numu -t CCRES
chips scripts beam_numu/ncres/ --job gen -n 50 -p numu -t NCRES
chips scripts beam_numu/ccmec/ --job gen -n 50 -p nuel -t CCMEC

chips scripts cosmic_all/ --job gen -n 50 -p cosmic -d chips_1200
chips scripts cosmic_all/ --job gen -n 50 -p cosmic -d chips_1000
chips scripts cosmic_all/ --job gen -n 50 -p cosmic -d chips_800
chips scripts cosmic_all/ --job gen -n 50 -p cosmic -d chips_600
chips scripts cosmic_all/ --job gen -n 50 -p cosmic -d chips_400
chips scripts cosmic_all/ --job gen -n 50 -p cosmic -d chips_275


