#! /bin/bash

PRODDIR=/unix/chips/prod

mkdir $PRODDIR

mkdir $PRODDIR/beam_all/
mkdir $PRODDIR/beam_nuel/
mkdir $PRODDIR/beam_numu/
mkdir $PRODDIR/cosmic_all/

mkdir $PRODDIR/beam_all/nuel/
mkdir $PRODDIR/beam_all/anuel/
mkdir $PRODDIR/beam_all/numu/
mkdir $PRODDIR/beam_all/anumu/

mkdir $PRODDIR/beam_nuel/cccoh/
mkdir $PRODDIR/beam_nuel/nccoh/
mkdir $PRODDIR/beam_nuel/ccdis/
mkdir $PRODDIR/beam_nuel/ncdis/
mkdir $PRODDIR/beam_nuel/ccqel/
mkdir $PRODDIR/beam_nuel/ncqel/
mkdir $PRODDIR/beam_nuel/ccres/
mkdir $PRODDIR/beam_nuel/ncres/
mkdir $PRODDIR/beam_nuel/charmccqel/
mkdir $PRODDIR/beam_nuel/nueelastic/
mkdir $PRODDIR/beam_nuel/imd/
mkdir $PRODDIR/beam_nuel/ccmec/
mkdir $PRODDIR/beam_nuel/ncmec/

mkdir $PRODDIR/beam_numu/cccoh/
mkdir $PRODDIR/beam_numu/nccoh/
mkdir $PRODDIR/beam_numu/ccdis/
mkdir $PRODDIR/beam_numu/ncdis/
mkdir $PRODDIR/beam_numu/ccqel/
mkdir $PRODDIR/beam_numu/ncqel/
mkdir $PRODDIR/beam_numu/ccres/
mkdir $PRODDIR/beam_numu/ncres/
mkdir $PRODDIR/beam_numu/charmccqel/
mkdir $PRODDIR/beam_numu/nueelastic/
mkdir $PRODDIR/beam_numu/imd/
mkdir $PRODDIR/beam_numu/ccmec/
mkdir $PRODDIR/beam_numu/ncmec/

python $CHIPSENV/scripts/run.py $PRODDIR/beam_all/nuel/ --make
python $CHIPSENV/scripts/run.py $PRODDIR/beam_all/anuel/ --make
python $CHIPSENV/scripts/run.py $PRODDIR/beam_all/numu/ --make
python $CHIPSENV/scripts/run.py $PRODDIR/beam_all/anumu/ --make

python $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel/cccoh/ --make
python $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel/nccoh/ --make
python $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel/ccdis/ --make
python $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel/ncdis/ --make
python $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel/ccqel/ --make
python $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel/ncqel/ --make
python $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel/ccres/ --make
python $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel/ncres/ --make
python $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel/charmccqel/ --make
python $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel/nueelastic/ --make
python $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel/imd/ --make
python $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel/ccmec/ --make
python $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel/ncmec/ --make

python $CHIPSENV/scripts/run.py $PRODDIR/beam_numu/cccoh/ --make
python $CHIPSENV/scripts/run.py $PRODDIR/beam_numu/nccoh/ --make
python $CHIPSENV/scripts/run.py $PRODDIR/beam_numu/ccdis/ --make
python $CHIPSENV/scripts/run.py $PRODDIR/beam_numu/ncdis/ --make
python $CHIPSENV/scripts/run.py $PRODDIR/beam_numu/ccqel/ --make
python $CHIPSENV/scripts/run.py $PRODDIR/beam_numu/ncqel/ --make
python $CHIPSENV/scripts/run.py $PRODDIR/beam_numu/ccres/ --make
python $CHIPSENV/scripts/run.py $PRODDIR/beam_numu/ncres/ --make
python $CHIPSENV/scripts/run.py $PRODDIR/beam_numu/charmccqel/ --make
python $CHIPSENV/scripts/run.py $PRODDIR/beam_numu/nueelastic/ --make
python $CHIPSENV/scripts/run.py $PRODDIR/beam_numu/imd/ --make
python $CHIPSENV/scripts/run.py $PRODDIR/beam_numu/ccmec/ --make
python $CHIPSENV/scripts/run.py $PRODDIR/beam_numu/ncmec/ --make

python $CHIPSENV/scripts/run.py $PRODDIR/cosmic_all/ --make
