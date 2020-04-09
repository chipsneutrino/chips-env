#! /bin/bash

PRODDIR=/unix/chips/production

python $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel_all/ --sim -g chips_1200_sk1pe -n 1000 --start 0
python $CHIPSENV/scripts/run.py $PRODDIR/beam_anuel_all/ --sim -g chips_1200_sk1pe -n 1000 --start 0
python $CHIPSENV/scripts/run.py $PRODDIR/beam_numu_all/ --sim -g chips_1200_sk1pe -n 1000 --start 0
python $CHIPSENV/scripts/run.py $PRODDIR/beam_anumu_all/ --sim -g chips_1200_sk1pe -n 1000 --start 0

python $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel_coh_cc/ --sim -g chips_1200_sk1pe -n 250 --start 0
python $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel_coh_nc/ --sim -g chips_1200_sk1pe -n 250 --start 0
python $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel_dis_cc/ --sim -g chips_1200_sk1pe -n 250 --start 0
python $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel_dis_nc/ --sim -g chips_1200_sk1pe -n 250 --start 0
python $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel_qel_cc/ --sim -g chips_1200_sk1pe -n 250 --start 0
python $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel_qel_nc/ --sim -g chips_1200_sk1pe -n 250 --start 0
python $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel_res_cc/ --sim -g chips_1200_sk1pe -n 250 --start 0
python $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel_res_nc/ --sim -g chips_1200_sk1pe -n 250 --start 0
python $CHIPSENV/scripts/run.py $PRODDIR/beam_numu_coh_cc/ --sim -g chips_1200_sk1pe -n 250 --start 0
python $CHIPSENV/scripts/run.py $PRODDIR/beam_numu_coh_nc/ --sim -g chips_1200_sk1pe -n 250 --start 0
python $CHIPSENV/scripts/run.py $PRODDIR/beam_numu_dis_cc/ --sim -g chips_1200_sk1pe -n 250 --start 0
python $CHIPSENV/scripts/run.py $PRODDIR/beam_numu_dis_nc/ --sim -g chips_1200_sk1pe -n 250 --start 0
python $CHIPSENV/scripts/run.py $PRODDIR/beam_numu_qel_cc/ --sim -g chips_1200_sk1pe -n 250 --start 0
python $CHIPSENV/scripts/run.py $PRODDIR/beam_numu_qel_nc/ --sim -g chips_1200_sk1pe -n 250 --start 0
python $CHIPSENV/scripts/run.py $PRODDIR/beam_numu_res_cc/ --sim -g chips_1200_sk1pe -n 250 --start 0
python $CHIPSENV/scripts/run.py $PRODDIR/beam_numu_res_nc/ --sim -g chips_1200_sk1pe -n 250 --start 0

python $CHIPSENV/scripts/run.py $PRODDIR/cosmic_numu_all/ --sim -g chips_1200_sk1pe -n 1000 --start 0 -p cosmic --cosmicdetector chips_1200