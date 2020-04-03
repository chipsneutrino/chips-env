#! /bin/bash

python run.py /unix/chips/jtingey/prod/beam_nuel_all/ --filter
python run.py /unix/chips/jtingey/prod/beam_anuel_all/ --filter
python run.py /unix/chips/jtingey/prod/beam_numu_all/ --filter
python run.py /unix/chips/jtingey/prod/beam_anumu_all/ --filter

python run.py /unix/chips/production/beam_nuel_coh_cc/ --filter
python run.py /unix/chips/production/beam_nuel_coh_nc/ --filter
python run.py /unix/chips/production/beam_nuel_dis_cc/ --filter
python run.py /unix/chips/production/beam_nuel_dis_nc/ --filter
python run.py /unix/chips/production/beam_nuel_qel_cc/ --filter
python run.py /unix/chips/production/beam_nuel_qel_nc/ --filter
python run.py /unix/chips/production/beam_nuel_res_cc/ --filter
python run.py /unix/chips/production/beam_nuel_res_nc/ --filter
python run.py /unix/chips/production/beam_numu_coh_cc/ --filter
python run.py /unix/chips/production/beam_numu_coh_nc/ --filter
python run.py /unix/chips/production/beam_numu_dis_cc/ --filter
python run.py /unix/chips/production/beam_numu_dis_nc/ --filter
python run.py /unix/chips/production/beam_numu_qel_cc/ --filter
python run.py /unix/chips/production/beam_numu_qel_nc/ --filter
python run.py /unix/chips/production/beam_numu_res_cc/ --filter
python run.py /unix/chips/production/beam_numu_res_nc/ --filter

python run.py /unix/chips/production/cosmic_numu_all/ --filter --cosmicdetector chips_1200
python run.py /unix/chips/production/cosmic_numu_all/ --filter --cosmicdetector chips_1000
python run.py /unix/chips/production/cosmic_numu_all/ --filter --cosmicdetector chips_800
python run.py /unix/chips/production/cosmic_numu_all/ --filter --cosmicdetector chips_600
python run.py /unix/chips/production/cosmic_numu_all/ --filter --cosmicdetector chips_400
python run.py /unix/chips/production/cosmic_numu_all/ --filter --cosmicdetector chips_275