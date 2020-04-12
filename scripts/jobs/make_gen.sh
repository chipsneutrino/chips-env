#! /bin/bash

PRODDIR=/unix/chips/prod

python $CHIPSENV/scripts/run.py $PRODDIR/beam_all/nuel/ --gen -e 2000000 -p nuel
python $CHIPSENV/scripts/run.py $PRODDIR/beam_all/anuel/ --gen -e 2000000 -p anuel
python $CHIPSENV/scripts/run.py $PRODDIR/beam_all/numu/ --gen -e 2000000 -p numu
python $CHIPSENV/scripts/run.py $PRODDIR/beam_all/anumu/ --gen -e 2000000 -p anumu

python $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel/cccoh/ --gen -e 200000 -p nuel -t CCCOH
python $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel/nccoh/ --gen -e 200000 -p nuel -t NCCOH
python $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel/ccdis/ --gen -e 200000 -p nuel -t CCDIS
python $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel/ncdis/ --gen -e 200000 -p nuel -t NCDIS
python $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel/ccqel/ --gen -e 200000 -p nuel -t CCQE
python $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel/ncqel/ --gen -e 200000 -p nuel -t NCEL
python $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel/ccres/ --gen -e 200000 -p nuel -t CCRES
python $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel/ncres/ --gen -e 200000 -p nuel -t NCRES
python $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel/charmccqel/ --gen -e 200000 -p nuel -t CharmCCQE
python $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel/nueelastic/ --gen -e 200000 -p nuel -t NuEElastic
python $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel/imd/ --gen -e 200000 -p nuel -t IMD
python $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel/ccmec/ --gen -e 200000 -p nuel -t CCMEC
python $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel/ncmec/ --gen -e 200000 -p nuel -t NCMEC

python $CHIPSENV/scripts/run.py $PRODDIR/beam_numu/cccoh/ --gen -e 200000 -p numu -t CCCOH
python $CHIPSENV/scripts/run.py $PRODDIR/beam_numu/nccoh/ --gen -e 200000 -p numu -t NCCOH
python $CHIPSENV/scripts/run.py $PRODDIR/beam_numu/ccdis/ --gen -e 200000 -p numu -t CCDIS
python $CHIPSENV/scripts/run.py $PRODDIR/beam_numu/ncdis/ --gen -e 200000 -p numu -t NCDIS
python $CHIPSENV/scripts/run.py $PRODDIR/beam_numu/ccqel/ --gen -e 200000 -p numu -t CCQE
python $CHIPSENV/scripts/run.py $PRODDIR/beam_numu/ncqel/ --gen -e 200000 -p numu -t NCEL
python $CHIPSENV/scripts/run.py $PRODDIR/beam_numu/ccres/ --gen -e 200000 -p numu -t CCRES
python $CHIPSENV/scripts/run.py $PRODDIR/beam_numu/ncres/ --gen -e 200000 -p numu -t NCRES
python $CHIPSENV/scripts/run.py $PRODDIR/beam_numu/charmccqel/ --gen -e 200000 -p nuel -t CharmCCQE
python $CHIPSENV/scripts/run.py $PRODDIR/beam_numu/nueelastic/ --gen -e 200000 -p nuel -t NuEElastic
python $CHIPSENV/scripts/run.py $PRODDIR/beam_numu/imd/ --gen -e 200000 -p nuel -t IMD
python $CHIPSENV/scripts/run.py $PRODDIR/beam_numu/ccmec/ --gen -e 200000 -p nuel -t CCMEC
python $CHIPSENV/scripts/run.py $PRODDIR/beam_numu/ncmec/ --gen -e 200000 -p nuel -t NCMEC

python $CHIPSENV/scripts/run.py $PRODDIR/cosmic_all/ --gen -e 1000000 -p cosmic --cosmicdetector chips_1200
python $CHIPSENV/scripts/run.py $PRODDIR/cosmic_all/ --gen -e 1000000 -p cosmic --cosmicdetector chips_1000
python $CHIPSENV/scripts/run.py $PRODDIR/cosmic_all/ --gen -e 1000000 -p cosmic --cosmicdetector chips_800
python $CHIPSENV/scripts/run.py $PRODDIR/cosmic_all/ --gen -e 1000000 -p cosmic --cosmicdetector chips_600
python $CHIPSENV/scripts/run.py $PRODDIR/cosmic_all/ --gen -e 1000000 -p cosmic --cosmicdetector chips_400
python $CHIPSENV/scripts/run.py $PRODDIR/cosmic_all/ --gen -e 1000000 -p cosmic --cosmicdetector chips_275


