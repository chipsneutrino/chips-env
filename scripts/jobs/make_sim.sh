#! /bin/bash

chips scripts beam_all/nuel/ --job sim -d chips_1200 -n 1000 -s 0
chips scripts beam_all/anuel/ --job sim -d chips_1200 -n 1000 -s 0
chips scripts beam_all/numu/ --job sim -d chips_1200 -n 1000 -s 0
chips scripts beam_all/anumu/ --job sim -d chips_1200 -n 1000 -s 0

chips scripts beam_nuel/cccoh/ --job sim -d chips_1200 -n 100 -s 0
chips scripts beam_nuel/nccoh/ --job sim -d chips_1200 -n 100 -s 0
chips scripts beam_nuel/ccdis/ --job sim -d chips_1200 -n 100 -s 0
chips scripts beam_nuel/ncdis/ --job sim -d chips_1200 -n 100 -s 0
chips scripts beam_nuel/ccqel/ --job sim -d chips_1200 -n 100 -s 0
chips scripts beam_nuel/ncqel/ --job sim -d chips_1200 -n 100 -s 0
chips scripts beam_nuel/ccres/ --job sim -d chips_1200 -n 100 -s 0
chips scripts beam_nuel/ncres/ --job sim -d chips_1200 -n 100 -s 0
chips scripts beam_nuel/ccmec/ --job sim -d chips_1200 -n 100 -s 0

chips scripts beam_numu/cccoh/ --job sim -d chips_1200 -n 100 -s 0
chips scripts beam_numu/nccoh/ --job sim -d chips_1200 -n 100 -s 0
chips scripts beam_numu/ccdis/ --job sim -d chips_1200 -n 100 -s 0
chips scripts beam_numu/ncdis/ --job sim -d chips_1200 -n 100 -s 0
chips scripts beam_numu/ccqel/ --job sim -d chips_1200 -n 100 -s 0
chips scripts beam_numu/ncqel/ --job sim -d chips_1200 -n 100 -s 0
chips scripts beam_numu/ccres/ --job sim -d chips_1200 -n 100 -s 0
chips scripts beam_numu/ncres/ --job sim -d chips_1200 -n 100 -s 0
chips scripts beam_numu/ccmec/ --job sim -d chips_1200 -n 100 -s 0

chips scripts cosmic_all/ --job sim -d chips_1200 -n 500 -s 0 -p cosmic --cosmicdetector chips_1200