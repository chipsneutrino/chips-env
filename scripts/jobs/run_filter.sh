#! /bin/bash

PRODDIR=/unix/chips/prod

python $CHIPSENV/scripts/run.py $PRODDIR/beam_all/nuel/ --filter
python $CHIPSENV/scripts/run.py $PRODDIR/beam_all/anuel/ --filter
python $CHIPSENV/scripts/run.py $PRODDIR/beam_all/numu/ --filter
python $CHIPSENV/scripts/run.py $PRODDIR/beam_all/anumu/ --filter

python $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel/cccoh/ --filter
python $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel/nccoh/ --filter
python $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel/ccdis/ --filter
python $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel/ncdis/ --filter
python $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel/ccqel/ --filter
python $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel/ncqel/ --filter
python $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel/ccres/ --filter
python $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel/ncres/ --filter
python $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel/charmccqel/ --filter
python $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel/nueelastic/ --filter
python $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel/imd/ --filter
python $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel/ccmec/ --filter
python $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel/ncmec/ --filter

python $CHIPSENV/scripts/run.py $PRODDIR/beam_numu/cccoh/ --filter
python $CHIPSENV/scripts/run.py $PRODDIR/beam_numu/nccoh/ --filter
python $CHIPSENV/scripts/run.py $PRODDIR/beam_numu/ccdis/ --filter
python $CHIPSENV/scripts/run.py $PRODDIR/beam_numu/ncdis/ --filter
python $CHIPSENV/scripts/run.py $PRODDIR/beam_numu/ccqel/ --filter
python $CHIPSENV/scripts/run.py $PRODDIR/beam_numu/ncqel/ --filter
python $CHIPSENV/scripts/run.py $PRODDIR/beam_numu/ccres/ --filter
python $CHIPSENV/scripts/run.py $PRODDIR/beam_numu/ncres/ --filter
python $CHIPSENV/scripts/run.py $PRODDIR/beam_numu/charmccqel/ --filter
python $CHIPSENV/scripts/run.py $PRODDIR/beam_numu/nueelastic/ --filter
python $CHIPSENV/scripts/run.py $PRODDIR/beam_numu/imd/ --filter
python $CHIPSENV/scripts/run.py $PRODDIR/beam_numu/ccmec/ --filter
python $CHIPSENV/scripts/run.py $PRODDIR/beam_numu/ncmec/ --filter

python $CHIPSENV/scripts/run.py $PRODDIR/cosmic_all/ --filter --cosmicdetector chips_1200
python $CHIPSENV/scripts/run.py $PRODDIR/cosmic_all/ --filter --cosmicdetector chips_1000
python $CHIPSENV/scripts/run.py $PRODDIR/cosmic_all/ --filter --cosmicdetector chips_800
python $CHIPSENV/scripts/run.py $PRODDIR/cosmic_all/ --filter --cosmicdetector chips_600
python $CHIPSENV/scripts/run.py $PRODDIR/cosmic_all/ --filter --cosmicdetector chips_400
python $CHIPSENV/scripts/run.py $PRODDIR/cosmic_all/ --filter --cosmicdetector chips_275