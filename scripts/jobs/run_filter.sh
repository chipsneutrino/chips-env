#! /bin/bash

python3 $CHIPSENV/scripts/run.py $PRODDIR/beam_all/nuel/ --filter
python3 $CHIPSENV/scripts/run.py $PRODDIR/beam_all/anuel/ --filter
python3 $CHIPSENV/scripts/run.py $PRODDIR/beam_all/numu/ --filter
python3 $CHIPSENV/scripts/run.py $PRODDIR/beam_all/anumu/ --filter

python3 $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel/cccoh/ --filter
python3 $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel/nccoh/ --filter
python3 $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel/ccdis/ --filter
python3 $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel/ncdis/ --filter
python3 $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel/ccqel/ --filter
python3 $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel/ncqel/ --filter
python3 $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel/ccres/ --filter
python3 $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel/ncres/ --filter
python3 $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel/ccmec/ --filter

python3 $CHIPSENV/scripts/run.py $PRODDIR/beam_numu/cccoh/ --filter
python3 $CHIPSENV/scripts/run.py $PRODDIR/beam_numu/nccoh/ --filter
python3 $CHIPSENV/scripts/run.py $PRODDIR/beam_numu/ccdis/ --filter
python3 $CHIPSENV/scripts/run.py $PRODDIR/beam_numu/ncdis/ --filter
python3 $CHIPSENV/scripts/run.py $PRODDIR/beam_numu/ccqel/ --filter
python3 $CHIPSENV/scripts/run.py $PRODDIR/beam_numu/ncqel/ --filter
python3 $CHIPSENV/scripts/run.py $PRODDIR/beam_numu/ccres/ --filter
python3 $CHIPSENV/scripts/run.py $PRODDIR/beam_numu/ncres/ --filter
python3 $CHIPSENV/scripts/run.py $PRODDIR/beam_numu/ccmec/ --filter

python3 $CHIPSENV/scripts/run.py $PRODDIR/cosmic_all/ --filter --cosmicdetector chips_1200
python3 $CHIPSENV/scripts/run.py $PRODDIR/cosmic_all/ --filter --cosmicdetector chips_1000
python3 $CHIPSENV/scripts/run.py $PRODDIR/cosmic_all/ --filter --cosmicdetector chips_800
python3 $CHIPSENV/scripts/run.py $PRODDIR/cosmic_all/ --filter --cosmicdetector chips_600
python3 $CHIPSENV/scripts/run.py $PRODDIR/cosmic_all/ --filter --cosmicdetector chips_400
python3 $CHIPSENV/scripts/run.py $PRODDIR/cosmic_all/ --filter --cosmicdetector chips_275