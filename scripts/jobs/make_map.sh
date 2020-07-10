#! /bin/bash

chips scripts beam_all/nuel/ --job map -d chips_1200 --height 1200 --radius 1250 --all
chips scripts beam_all/anuel/ --job map -d chips_1200 --height 1200 --radius 1250 --all
chips scripts beam_all/numu/ --job map -d chips_1200 --height 1200 --radius 1250 --all
chips scripts beam_all/anumu/ --job map -d chips_1200 --height 1200 --radius 1250 --all

chips scripts beam_nuel/cccoh/ --job map -d chips_1200 --height 1200 --radius 1250 --all
chips scripts beam_nuel/nccoh/ --job map -d chips_1200 --height 1200 --radius 1250 --all
chips scripts beam_nuel/ccdis/ --job map -d chips_1200 --height 1200 --radius 1250 --all
chips scripts beam_nuel/ncdis/ --job map -d chips_1200 --height 1200 --radius 1250 --all
chips scripts beam_nuel/ccqel/ --job map -d chips_1200 --height 1200 --radius 1250 --all
chips scripts beam_nuel/ncqel/ --job map -d chips_1200 --height 1200 --radius 1250 --all
chips scripts beam_nuel/ccres/ --job map -d chips_1200 --height 1200 --radius 1250 --all
chips scripts beam_nuel/ncres/ --job map -d chips_1200 --height 1200 --radius 1250 --all
chips scripts beam_nuel/ccmec/ --job map -d chips_1200 --height 1200 --radius 1250 --all

chips scripts beam_numu/cccoh/ --job map -d chips_1200 --height 1200 --radius 1250 --all
chips scripts beam_numu/nccoh/ --job map -d chips_1200 --height 1200 --radius 1250 --all
chips scripts beam_numu/ccdis/ --job map -d chips_1200 --height 1200 --radius 1250 --all
chips scripts beam_numu/ncdis/ --job map -d chips_1200 --height 1200 --radius 1250 --all
chips scripts beam_numu/ccqel/ --job map -d chips_1200 --height 1200 --radius 1250 --all
chips scripts beam_numu/ncqel/ --job map -d chips_1200 --height 1200 --radius 1250 --all
chips scripts beam_numu/ccres/ --job map -d chips_1200 --height 1200 --radius 1250 --all
chips scripts beam_numu/ncres/ --job map -d chips_1200 --height 1200 --radius 1250 --all
chips scripts beam_numu/ccmec/ --job map -d chips_1200 --height 1200 --radius 1250 --all

chips scripts cosmic_all/ --job map -d chips_1200 --height 1200 --radius 1250 --all