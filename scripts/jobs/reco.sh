#! /bin/bash

PRODDIR=/unix/chips/production

python $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel_all/ --reco -n 10 -s 100 -g chips_1200_sk1pe
python $CHIPSENV/scripts/run.py $PRODDIR/beam_anuel_all/ --reco -n 10 -s 100 -g chips_1200_sk1pe
python $CHIPSENV/scripts/run.py $PRODDIR/beam_numu_all/ --reco -n 10 -s 100 -g chips_1200_sk1pe
python $CHIPSENV/scripts/run.py $PRODDIR/beam_anumu_all/ --reco -n 10 -s 100 -g chips_1200_sk1pe

python $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel_coh_cc/ --reco -n 10 -s 100 -g chips_1200_sk1pe
python $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel_coh_nc/ --reco -n 10 -s 100 -g chips_1200_sk1pe
python $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel_dis_cc/ --reco -n 10 -s 100 -g chips_1200_sk1pe
python $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel_dis_nc/ --reco -n 10 -s 100 -g chips_1200_sk1pe
python $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel_qel_cc/ --reco -n 10 -s 100 -g chips_1200_sk1pe
python $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel_qel_nc/ --reco -n 10 -s 100 -g chips_1200_sk1pe
python $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel_res_cc/ --reco -n 10 -s 100 -g chips_1200_sk1pe
python $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel_res_nc/ --reco -n 10 -s 100 -g chips_1200_sk1pe
python $CHIPSENV/scripts/run.py $PRODDIR/beam_numu_coh_cc/ --reco -n 10 -s 100 -g chips_1200_sk1pe
python $CHIPSENV/scripts/run.py $PRODDIR/beam_numu_coh_nc/ --reco -n 10 -s 100 -g chips_1200_sk1pe
python $CHIPSENV/scripts/run.py $PRODDIR/beam_numu_dis_cc/ --reco -n 10 -s 100 -g chips_1200_sk1pe
python $CHIPSENV/scripts/run.py $PRODDIR/beam_numu_dis_nc/ --reco -n 10 -s 100 -g chips_1200_sk1pe
python $CHIPSENV/scripts/run.py $PRODDIR/beam_numu_qel_cc/ --reco -n 10 -s 100 -g chips_1200_sk1pe
python $CHIPSENV/scripts/run.py $PRODDIR/beam_numu_qel_nc/ --reco -n 10 -s 100 -g chips_1200_sk1pe
python $CHIPSENV/scripts/run.py $PRODDIR/beam_numu_res_cc/ --reco -n 10 -s 100 -g chips_1200_sk1pe
python $CHIPSENV/scripts/run.py $PRODDIR/beam_numu_res_nc/ --reco -n 10 -s 100 -g chips_1200_sk1pe

python $CHIPSENV/scripts/run.py $PRODDIR/cosmic_numu_all/ --reco -n 10 -s 100 -g chips_1200_sk1pe