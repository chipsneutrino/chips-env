#! /bin/bash

chips scripts beam_all/nuel/ --job select
chips scripts beam_all/anuel/ --job select
chips scripts beam_all/numu/ --job select
chips scripts beam_all/anumu/ --job select

chips scripts beam_nuel/cccoh/ --job select
chips scripts beam_nuel/nccoh/ --job select
chips scripts beam_nuel/ccdis/ --job select
chips scripts beam_nuel/ncdis/ --job select
chips scripts beam_nuel/ccqel/ --job select
chips scripts beam_nuel/ncqel/ --job select
chips scripts beam_nuel/ccres/ --job select
chips scripts beam_nuel/ncres/ --job select
chips scripts beam_nuel/ccmec/ --job select

chips scripts beam_numu/cccoh/ --job select
chips scripts beam_numu/nccoh/ --job select
chips scripts beam_numu/ccdis/ --job select
chips scripts beam_numu/ncdis/ --job select
chips scripts beam_numu/ccqel/ --job select
chips scripts beam_numu/ncqel/ --job select
chips scripts beam_numu/ccres/ --job select
chips scripts beam_numu/ncres/ --job select
chips scripts beam_numu/ccmec/ --job select

chips scripts cosmic_all/ --job select -d chips_1200
chips scripts cosmic_all/ --job select -d chips_1000
chips scripts cosmic_all/ --job select -d chips_800
chips scripts cosmic_all/ --job select -d chips_600
chips scripts cosmic_all/ --job select -d chips_400
chips scripts cosmic_all/ --job select -d chips_275