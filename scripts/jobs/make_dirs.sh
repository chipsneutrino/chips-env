#! /bin/bash

PRODDIR=/unix/chips/prod 
mkdir $PRODDIR

mkdir $PRODDIR/beam_all/
mkdir $PRODDIR/beam_all/nuel/ && python $CHIPSENV/scripts/run.py $PRODDIR/beam_all/nuel/ --make
mkdir $PRODDIR/beam_all/anuel/ && python $CHIPSENV/scripts/run.py $PRODDIR/beam_all/anuel/ --make
mkdir $PRODDIR/beam_all/numu/ && python $CHIPSENV/scripts/run.py $PRODDIR/beam_all/numu/ --make
mkdir $PRODDIR/beam_all/anumu/ && python $CHIPSENV/scripts/run.py $PRODDIR/beam_all/anumu/ --make

mkdir $PRODDIR/beam_nuel/
mkdir $PRODDIR/beam_nuel/cccoh/ && python $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel/cccoh/ --make
mkdir $PRODDIR/beam_nuel/nccoh/ && python $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel/nccoh/ --make
mkdir $PRODDIR/beam_nuel/ccdis/ && python $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel/ccdis/ --make
mkdir $PRODDIR/beam_nuel/ncdis/ && python $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel/ncdis/ --make
mkdir $PRODDIR/beam_nuel/ccqel/ && python $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel/ccqel/ --make
mkdir $PRODDIR/beam_nuel/ncqel/ && python $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel/ncqel/ --make
mkdir $PRODDIR/beam_nuel/ccres/ && python $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel/ccres/ --make
mkdir $PRODDIR/beam_nuel/ncres/ && python $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel/ncres/ --make
mkdir $PRODDIR/beam_nuel/ccmec/ && python $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel/ccmec/ --make

mkdir $PRODDIR/beam_numu/
mkdir $PRODDIR/beam_numu/cccoh/ && python $CHIPSENV/scripts/run.py $PRODDIR/beam_numu/cccoh/ --make
mkdir $PRODDIR/beam_numu/nccoh/ && python $CHIPSENV/scripts/run.py $PRODDIR/beam_numu/nccoh/ --make
mkdir $PRODDIR/beam_numu/ccdis/ && python $CHIPSENV/scripts/run.py $PRODDIR/beam_numu/ccdis/ --make
mkdir $PRODDIR/beam_numu/ncdis/ && python $CHIPSENV/scripts/run.py $PRODDIR/beam_numu/ncdis/ --make
mkdir $PRODDIR/beam_numu/ccqel/ && python $CHIPSENV/scripts/run.py $PRODDIR/beam_numu/ccqel/ --make
mkdir $PRODDIR/beam_numu/ncqel/ && python $CHIPSENV/scripts/run.py $PRODDIR/beam_numu/ncqel/ --make
mkdir $PRODDIR/beam_numu/ccres/ && python $CHIPSENV/scripts/run.py $PRODDIR/beam_numu/ccres/ --make
mkdir $PRODDIR/beam_numu/ncres/ && python $CHIPSENV/scripts/run.py $PRODDIR/beam_numu/ncres/ --make
mkdir $PRODDIR/beam_numu/ccmec/ && python $CHIPSENV/scripts/run.py $PRODDIR/beam_numu/ccmec/ --make

mkdir $PRODDIR/cosmic_all/ && python $CHIPSENV/scripts/run.py $PRODDIR/cosmic_all/ --make