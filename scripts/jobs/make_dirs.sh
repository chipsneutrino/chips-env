#! /bin/bash

mkdir $PRODDIR/beam_all/
mkdir $PRODDIR/beam_all/nuel/ && chips run $CHIPSENV $PRODDIR/beam_all/nuel/ --job make
#mkdir $PRODDIR/beam_all/anuel/ && chips run $CHIPSENV $PRODDIR/beam_all/anuel/ --job make
#mkdir $PRODDIR/beam_all/numu/ && chips run $CHIPSENV $PRODDIR/beam_all/numu/ --job make
#mkdir $PRODDIR/beam_all/anumu/ && chips run $CHIPSENV $PRODDIR/beam_all/anumu/ --job make

#mkdir $PRODDIR/beam_nuel/
#mkdir $PRODDIR/beam_nuel/cccoh/ && chips run $CHIPSENV $PRODDIR/beam_nuel/cccoh/ --job make
#mkdir $PRODDIR/beam_nuel/nccoh/ && chips run $CHIPSENV $PRODDIR/beam_nuel/nccoh/ --job make
#mkdir $PRODDIR/beam_nuel/ccdis/ && chips run $CHIPSENV $PRODDIR/beam_nuel/ccdis/ --job make
#mkdir $PRODDIR/beam_nuel/ncdis/ && chips run $CHIPSENV $PRODDIR/beam_nuel/ncdis/ --job make
#mkdir $PRODDIR/beam_nuel/ccqel/ && chips run $CHIPSENV $PRODDIR/beam_nuel/ccqel/ --job make
#mkdir $PRODDIR/beam_nuel/ncqel/ && chips run $CHIPSENV $PRODDIR/beam_nuel/ncqel/ --job make
#mkdir $PRODDIR/beam_nuel/ccres/ && chips run $CHIPSENV $PRODDIR/beam_nuel/ccres/ --job make
#mkdir $PRODDIR/beam_nuel/ncres/ && chips run $CHIPSENV $PRODDIR/beam_nuel/ncres/ --job make
#mkdir $PRODDIR/beam_nuel/ccmec/ && chips run $CHIPSENV $PRODDIR/beam_nuel/ccmec/ --job make

#mkdir $PRODDIR/beam_numu/
#mkdir $PRODDIR/beam_numu/cccoh/ && chips run $CHIPSENV $PRODDIR/beam_numu/cccoh/ --job make
#mkdir $PRODDIR/beam_numu/nccoh/ && chips run $CHIPSENV $PRODDIR/beam_numu/nccoh/ --job make
#mkdir $PRODDIR/beam_numu/ccdis/ && chips run $CHIPSENV $PRODDIR/beam_numu/ccdis/ --job make
#mkdir $PRODDIR/beam_numu/ncdis/ && chips run $CHIPSENV $PRODDIR/beam_numu/ncdis/ --job make
#mkdir $PRODDIR/beam_numu/ccqel/ && chips run $CHIPSENV $PRODDIR/beam_numu/ccqel/ --job make
#mkdir $PRODDIR/beam_numu/ncqel/ && chips run $CHIPSENV $PRODDIR/beam_numu/ncqel/ --job make
#mkdir $PRODDIR/beam_numu/ccres/ && chips run $CHIPSENV $PRODDIR/beam_numu/ccres/ --job make
#mkdir $PRODDIR/beam_numu/ncres/ && chips run $CHIPSENV $PRODDIR/beam_numu/ncres/ --job make
#mkdir $PRODDIR/beam_numu/ccmec/ && chips run $CHIPSENV $PRODDIR/beam_numu/ccmec/ --job make

#mkdir $PRODDIR/cosmic_all/ && chips run $CHIPSENV $PRODDIR/cosmic_all/ --job make