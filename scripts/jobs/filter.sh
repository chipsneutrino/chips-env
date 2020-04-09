#! /bin/bash

PRODDIR=/unix/chips/production

python $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel_all/ --filter
python $CHIPSENV/scripts/run.py $PRODDIR/beam_anuel_all/ --filter
python $CHIPSENV/scripts/run.py $PRODDIR/beam_numu_all/ --filter
python $CHIPSENV/scripts/run.py $PRODDIR/beam_anumu_all/ --filter

python $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel_coh_cc/ --filter
python $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel_coh_nc/ --filter
python $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel_dis_cc/ --filter
python $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel_dis_nc/ --filter
python $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel_qel_cc/ --filter
python $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel_qel_nc/ --filter
python $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel_res_cc/ --filter
python $CHIPSENV/scripts/run.py $PRODDIR/beam_nuel_res_nc/ --filter
python $CHIPSENV/scripts/run.py $PRODDIR/beam_numu_coh_cc/ --filter
python $CHIPSENV/scripts/run.py $PRODDIR/beam_numu_coh_nc/ --filter
python $CHIPSENV/scripts/run.py $PRODDIR/beam_numu_dis_cc/ --filter
python $CHIPSENV/scripts/run.py $PRODDIR/beam_numu_dis_nc/ --filter
python $CHIPSENV/scripts/run.py $PRODDIR/beam_numu_qel_cc/ --filter
python $CHIPSENV/scripts/run.py $PRODDIR/beam_numu_qel_nc/ --filter
python $CHIPSENV/scripts/run.py $PRODDIR/beam_numu_res_cc/ --filter
python $CHIPSENV/scripts/run.py $PRODDIR/beam_numu_res_nc/ --filter

python $CHIPSENV/scripts/run.py $PRODDIR/cosmic_numu_all/ --filter --cosmicdetector chips_1200
python $CHIPSENV/scripts/run.py $PRODDIR/cosmic_numu_all/ --filter --cosmicdetector chips_1000
python $CHIPSENV/scripts/run.py $PRODDIR/cosmic_numu_all/ --filter --cosmicdetector chips_800
python $CHIPSENV/scripts/run.py $PRODDIR/cosmic_numu_all/ --filter --cosmicdetector chips_600
python $CHIPSENV/scripts/run.py $PRODDIR/cosmic_numu_all/ --filter --cosmicdetector chips_400
python $CHIPSENV/scripts/run.py $PRODDIR/cosmic_numu_all/ --filter --cosmicdetector chips_275