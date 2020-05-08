#! /bin/bash

python3 $CHIPSENV/scripts/run.py $PRODDIR/beam_all/nuel/ --map -g chips_1200 --saveextra
python3 $CHIPSENV/scripts/run.py $PRODDIR/beam_all/anuel/ --map -g chips_1200 --saveextra
python3 $CHIPSENV/scripts/run.py $PRODDIR/beam_all/numu/ --map -g chips_1200 --saveextra
python3 $CHIPSENV/scripts/run.py $PRODDIR/beam_all/anumu/ --map -g chips_1200 --saveextra

python3 $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel/cccoh/ --map -g chips_1200 --saveextra
python3 $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel/nccoh/ --map -g chips_1200 --saveextra
python3 $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel/ccdis/ --map -g chips_1200 --saveextra
python3 $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel/ncdis/ --map -g chips_1200 --saveextra
python3 $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel/ccqel/ --map -g chips_1200 --saveextra
python3 $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel/ncqel/ --map -g chips_1200 --saveextra
python3 $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel/ccres/ --map -g chips_1200 --saveextra
python3 $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel/ncres/ --map -g chips_1200 --saveextra
python3 $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel/ccmec/ --map -g chips_1200 --saveextra

python3 $CHIPSENV/scripts/run.py $PRODDIR/beam_numu/cccoh/ --map -g chips_1200 --saveextra
python3 $CHIPSENV/scripts/run.py $PRODDIR/beam_numu/nccoh/ --map -g chips_1200 --saveextra
python3 $CHIPSENV/scripts/run.py $PRODDIR/beam_numu/ccdis/ --map -g chips_1200 --saveextra
python3 $CHIPSENV/scripts/run.py $PRODDIR/beam_numu/ncdis/ --map -g chips_1200 --saveextra
python3 $CHIPSENV/scripts/run.py $PRODDIR/beam_numu/ccqel/ --map -g chips_1200 --saveextra
python3 $CHIPSENV/scripts/run.py $PRODDIR/beam_numu/ncqel/ --map -g chips_1200 --saveextra
python3 $CHIPSENV/scripts/run.py $PRODDIR/beam_numu/ccres/ --map -g chips_1200 --saveextra
python3 $CHIPSENV/scripts/run.py $PRODDIR/beam_numu/ncres/ --map -g chips_1200 --saveextra
python3 $CHIPSENV/scripts/run.py $PRODDIR/beam_numu/ccmec/ --map -g chips_1200 --saveextra

python3 $CHIPSENV/scripts/run.py $PRODDIR/cosmic_all/ --map -g chips_1200 --saveextra