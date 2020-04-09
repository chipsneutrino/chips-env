#! /bin/bash

PRODDIR=/unix/chips/prod

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
python $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel/charmccdis/ --make
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
python $CHIPSENV/scripts/run.py $PRODDIR/beam_numu/charmccdis/ --make
python $CHIPSENV/scripts/run.py $PRODDIR/beam_numu/charmccqel/ --make
python $CHIPSENV/scripts/run.py $PRODDIR/beam_numu/nueelastic/ --make
python $CHIPSENV/scripts/run.py $PRODDIR/beam_numu/imd/ --make
python $CHIPSENV/scripts/run.py $PRODDIR/beam_numu/ccmec/ --make
python $CHIPSENV/scripts/run.py $PRODDIR/beam_numu/ncmec/ --make

python $CHIPSENV/scripts/run.py $PRODDIR/cosmic_all/ --make
