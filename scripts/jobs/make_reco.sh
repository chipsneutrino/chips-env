#! /bin/bash

chips scripts beam_all/nuel/ --job reco -n 10 --split 100 -d chips_1200
chips scripts beam_all/anuel/ --job reco -n 10 --split 100 -d chips_1200
chips scripts beam_all/numu/ --job reco -n 10 --split 100 -d chips_1200
chips scripts beam_all/anumu/ --job reco -n 10 --split 100 -d chips_1200

chips scripts beam_nuel/cccoh/ --job reco -n 10 --split 100 -d chips_1200
chips scripts beam_nuel/nccoh/ --job reco -n 10 --split 100 -d chips_1200
chips scripts beam_nuel/ccdis/ --job reco -n 10 --split 100 -d chips_1200
chips scripts beam_nuel/ncdis/ --job reco -n 10 --split 100 -d chips_1200
chips scripts beam_nuel/ccqel/ --job reco -n 10 --split 100 -d chips_1200
chips scripts beam_nuel/ncqel/ --job reco -n 10 --split 100 -d chips_1200
chips scripts beam_nuel/ccres/ --job reco -n 10 --split 100 -d chips_1200
chips scripts beam_nuel/ncres/ --job reco -n 10 --split 100 -d chips_1200
chips scripts beam_nuel/ccmec/ --job reco -n 10 --split 100 -d chips_1200

chips scripts beam_numu/cccoh/ --job reco -n 10 --split 100 -d chips_1200
chips scripts beam_numu/nccoh/ --job reco -n 10 --split 100 -d chips_1200
chips scripts beam_numu/ccdis/ --job reco -n 10 --split 100 -d chips_1200
chips scripts beam_numu/ncdis/ --job reco -n 10 --split 100 -d chips_1200
chips scripts beam_numu/ccqel/ --job reco -n 10 --split 100 -d chips_1200
chips scripts beam_numu/ncqel/ --job reco -n 10 --split 100 -d chips_1200
chips scripts beam_numu/ccres/ --job reco -n 10 --split 100 -d chips_1200
chips scripts beam_numu/ncres/ --job reco -n 10 --split 100 -d chips_1200
chips scripts beam_numu/ccmec/ --job reco -n 10 --split 100 -d chips_1200

chips scripts cosmic_all/ --job reco -n 10 --split 100 -d chips_1200