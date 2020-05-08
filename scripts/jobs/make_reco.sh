#! /bin/bash

python3 $CHIPSENV/scripts/run.py $PRODDIR/beam_all/nuel/ --reco -n 10 -s 100 -g chips_1200
python3 $CHIPSENV/scripts/run.py $PRODDIR/beam_all/anuel/ --reco -n 10 -s 100 -g chips_1200
python3 $CHIPSENV/scripts/run.py $PRODDIR/beam_all/numu/ --reco -n 10 -s 100 -g chips_1200
python3 $CHIPSENV/scripts/run.py $PRODDIR/beam_all/anumu/ --reco -n 10 -s 100 -g chips_1200

python3 $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel/cccoh/ --reco -n 10 -s 100 -g chips_1200
python3 $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel/nccoh/ --reco -n 10 -s 100 -g chips_1200
python3 $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel/ccdis/ --reco -n 10 -s 100 -g chips_1200
python3 $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel/ncdis/ --reco -n 10 -s 100 -g chips_1200
python3 $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel/ccqel/ --reco -n 10 -s 100 -g chips_1200
python3 $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel/ncqel/ --reco -n 10 -s 100 -g chips_1200
python3 $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel/ccres/ --reco -n 10 -s 100 -g chips_1200
python3 $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel/ncres/ --reco -n 10 -s 100 -g chips_1200
python3 $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel/ccmec/ --reco -n 10 -s 100 -g chips_1200

python3 $CHIPSENV/scripts/run.py $PRODDIR/beam_numu/cccoh/ --reco -n 10 -s 100 -g chips_1200
python3 $CHIPSENV/scripts/run.py $PRODDIR/beam_numu/nccoh/ --reco -n 10 -s 100 -g chips_1200
python3 $CHIPSENV/scripts/run.py $PRODDIR/beam_numu/ccdis/ --reco -n 10 -s 100 -g chips_1200
python3 $CHIPSENV/scripts/run.py $PRODDIR/beam_numu/ncdis/ --reco -n 10 -s 100 -g chips_1200
python3 $CHIPSENV/scripts/run.py $PRODDIR/beam_numu/ccqel/ --reco -n 10 -s 100 -g chips_1200
python3 $CHIPSENV/scripts/run.py $PRODDIR/beam_numu/ncqel/ --reco -n 10 -s 100 -g chips_1200
python3 $CHIPSENV/scripts/run.py $PRODDIR/beam_numu/ccres/ --reco -n 10 -s 100 -g chips_1200
python3 $CHIPSENV/scripts/run.py $PRODDIR/beam_numu/ncres/ --reco -n 10 -s 100 -g chips_1200
python3 $CHIPSENV/scripts/run.py $PRODDIR/beam_numu/ccmec/ --reco -n 10 -s 100 -g chips_1200

python3 $CHIPSENV/scripts/run.py $PRODDIR/cosmic_all/ --reco -n 10 -s 100 -g chips_1200