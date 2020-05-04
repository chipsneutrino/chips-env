#! /bin/bash

PRODDIR=/unix/chips/prod

python $CHIPSENV/scripts/run.py $PRODDIR/beam_all/nuel/ --sim -g chips_1200 -n 1000 --start 0
python $CHIPSENV/scripts/run.py $PRODDIR/beam_all/anuel/ --sim -g chips_1200 -n 1000 --start 0
python $CHIPSENV/scripts/run.py $PRODDIR/beam_all/numu/ --sim -g chips_1200 -n 1000 --start 0
python $CHIPSENV/scripts/run.py $PRODDIR/beam_all/anumu/ --sim -g chips_1200 -n 1000 --start 0

python $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel/cccoh/ --sim -g chips_1200 -n 100 --start 0
python $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel/nccoh/ --sim -g chips_1200 -n 100 --start 0
python $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel/ccdis/ --sim -g chips_1200 -n 100 --start 0
python $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel/ncdis/ --sim -g chips_1200 -n 100 --start 0
python $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel/ccqel/ --sim -g chips_1200 -n 100 --start 0
python $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel/ncqel/ --sim -g chips_1200 -n 100 --start 0
python $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel/ccres/ --sim -g chips_1200 -n 100 --start 0
python $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel/ncres/ --sim -g chips_1200 -n 100 --start 0
python $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel/ccmec/ --sim -g chips_1200 -n 100 --start 0

python $CHIPSENV/scripts/run.py $PRODDIR/beam_numu/cccoh/ --sim -g chips_1200 -n 100 --start 0
python $CHIPSENV/scripts/run.py $PRODDIR/beam_numu/nccoh/ --sim -g chips_1200 -n 100 --start 0
python $CHIPSENV/scripts/run.py $PRODDIR/beam_numu/ccdis/ --sim -g chips_1200 -n 100 --start 0
python $CHIPSENV/scripts/run.py $PRODDIR/beam_numu/ncdis/ --sim -g chips_1200 -n 100 --start 0
python $CHIPSENV/scripts/run.py $PRODDIR/beam_numu/ccqel/ --sim -g chips_1200 -n 100 --start 0
python $CHIPSENV/scripts/run.py $PRODDIR/beam_numu/ncqel/ --sim -g chips_1200 -n 100 --start 0
python $CHIPSENV/scripts/run.py $PRODDIR/beam_numu/ccres/ --sim -g chips_1200 -n 100 --start 0
python $CHIPSENV/scripts/run.py $PRODDIR/beam_numu/ncres/ --sim -g chips_1200 -n 100 --start 0
python $CHIPSENV/scripts/run.py $PRODDIR/beam_numu/ccmec/ --sim -g chips_1200 -n 100 --start 0

python $CHIPSENV/scripts/run.py $PRODDIR/cosmic_all/ --sim -g chips_1200 -n 500 --start 0 -p cosmic --cosmicdetector chips_1200