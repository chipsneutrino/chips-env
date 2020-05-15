#! /bin/bash

mkdir $PRODDIR/beam_all/
mkdir $PRODDIR/beam_all/nuel/ && chips scripts beam_all/nuel/ --job make
mkdir $PRODDIR/beam_all/anuel/ && chips scripts beam_all/anuel/ --job make
mkdir $PRODDIR/beam_all/numu/ && chips scripts beam_all/numu/ --job make
mkdir $PRODDIR/beam_all/anumu/ && chips scripts beam_all/anumu/ --job make

mkdir $PRODDIR/beam_nuel/
mkdir $PRODDIR/beam_nuel/cccoh/ && chips scripts beam_nuel/cccoh/ --job make
mkdir $PRODDIR/beam_nuel/nccoh/ && chips scripts beam_nuel/nccoh/ --job make
mkdir $PRODDIR/beam_nuel/ccdis/ && chips scripts beam_nuel/ccdis/ --job make
mkdir $PRODDIR/beam_nuel/ncdis/ && chips scripts beam_nuel/ncdis/ --job make
mkdir $PRODDIR/beam_nuel/ccqel/ && chips scripts beam_nuel/ccqel/ --job make
mkdir $PRODDIR/beam_nuel/ncqel/ && chips scripts beam_nuel/ncqel/ --job make
mkdir $PRODDIR/beam_nuel/ccres/ && chips scripts beam_nuel/ccres/ --job make
mkdir $PRODDIR/beam_nuel/ncres/ && chips scripts beam_nuel/ncres/ --job make
mkdir $PRODDIR/beam_nuel/ccmec/ && chips scripts beam_nuel/ccmec/ --job make

mkdir $PRODDIR/beam_numu/
mkdir $PRODDIR/beam_numu/cccoh/ && chips scripts beam_numu/cccoh/ --job make
mkdir $PRODDIR/beam_numu/nccoh/ && chips scripts beam_numu/nccoh/ --job make
mkdir $PRODDIR/beam_numu/ccdis/ && chips scripts beam_numu/ccdis/ --job make
mkdir $PRODDIR/beam_numu/ncdis/ && chips scripts beam_numu/ncdis/ --job make
mkdir $PRODDIR/beam_numu/ccqel/ && chips scripts beam_numu/ccqel/ --job make
mkdir $PRODDIR/beam_numu/ncqel/ && chips scripts beam_numu/ncqel/ --job make
mkdir $PRODDIR/beam_numu/ccres/ && chips scripts beam_numu/ccres/ --job make
mkdir $PRODDIR/beam_numu/ncres/ && chips scripts beam_numu/ncres/ --job make
mkdir $PRODDIR/beam_numu/ccmec/ && chips scripts beam_numu/ccmec/ --job make

mkdir $PRODDIR/cosmic_all/ && chips scripts cosmic_all/ --job make