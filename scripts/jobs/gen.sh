#! /bin/bash

PRODDIR=/unix/chips/production

python $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel_all/ --gen -e 2000000 -p nuel
python $CHIPSENV/scripts/run.py $PRODDIR/beam_anuel_all/ --gen -e 2000000 -p anuel
python $CHIPSENV/scripts/run.py $PRODDIR/beam_numu_all/ --gen -e 2000000 -p numu
python $CHIPSENV/scripts/run.py $PRODDIR/beam_anumu_all/ --gen -e 2000000 -p anumu

python $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel_coh_cc/ --gen -e 500000 -p nuel -t COH-CC
python $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel_coh_nc/ --gen -e 500000 -p nuel -t COH-NC
python $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel_dis_cc/ --gen -e 500000 -p nuel -t DIS-CC
python $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel_dis_nc/ --gen -e 500000 -p nuel -t DIS-NC
python $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel_qel_cc/ --gen -e 500000 -p nuel -t QEL-CC
python $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel_qel_nc/ --gen -e 500000 -p nuel -t QEL-NC
python $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel_res_cc/ --gen -e 500000 -p nuel -t RES-CC
python $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel_res_nc/ --gen -e 500000 -p nuel -t RES-NC
python $CHIPSENV/scripts/run.py $PRODDIR/beam_numu_coh_cc/ --gen -e 500000 -p numu -t COH-CC
python $CHIPSENV/scripts/run.py $PRODDIR/beam_numu_coh_nc/ --gen -e 500000 -p numu -t COH-NC
python $CHIPSENV/scripts/run.py $PRODDIR/beam_numu_dis_cc/ --gen -e 500000 -p numu -t DIS-CC
python $CHIPSENV/scripts/run.py $PRODDIR/beam_numu_dis_nc/ --gen -e 500000 -p numu -t DIS-NC
python $CHIPSENV/scripts/run.py $PRODDIR/beam_numu_qel_cc/ --gen -e 500000 -p numu -t QEL-CC
python $CHIPSENV/scripts/run.py $PRODDIR/beam_numu_qel_nc/ --gen -e 500000 -p numu -t QEL-NC
python $CHIPSENV/scripts/run.py $PRODDIR/beam_numu_res_cc/ --gen -e 500000 -p numu -t RES-CC
python $CHIPSENV/scripts/run.py $PRODDIR/beam_numu_res_nc/ --gen -e 500000 -p numu -t RES-NC

python $CHIPSENV/scripts/run.py $PRODDIR/cosmic_numu_all/ --gen -e 2000000 -p cosmic --cosmicdetector chips_1200
python $CHIPSENV/scripts/run.py $PRODDIR/cosmic_numu_all/ --gen -e 2000000 -p cosmic --cosmicdetector chips_1000
python $CHIPSENV/scripts/run.py $PRODDIR/cosmic_numu_all/ --gen -e 2000000 -p cosmic --cosmicdetector chips_800
python $CHIPSENV/scripts/run.py $PRODDIR/cosmic_numu_all/ --gen -e 2000000 -p cosmic --cosmicdetector chips_600
python $CHIPSENV/scripts/run.py $PRODDIR/cosmic_numu_all/ --gen -e 2000000 -p cosmic --cosmicdetector chips_400
python $CHIPSENV/scripts/run.py $PRODDIR/cosmic_numu_all/ --gen -e 2000000 -p cosmic --cosmicdetector chips_275


