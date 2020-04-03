#! /bin/bash

python run.py /unix/chips/production/beam_nuel_all/ --map -g chips_1200_sk1pe
python run.py /unix/chips/production/beam_anuel_all/ --map -g chips_1200_sk1pe
python run.py /unix/chips/production/beam_numu_all/ --map -g chips_1200_sk1pe
python run.py /unix/chips/production/beam_anumu_all/ --map -g chips_1200_sk1pe

python run.py /unix/chips/production/beam_nuel_coh_cc/ --map -g chips_1200_sk1pe
python run.py /unix/chips/production/beam_nuel_coh_nc/ --map -g chips_1200_sk1pe
python run.py /unix/chips/production/beam_nuel_dis_cc/ --map -g chips_1200_sk1pe
python run.py /unix/chips/production/beam_nuel_dis_nc/ --map -g chips_1200_sk1pe
python run.py /unix/chips/production/beam_nuel_qel_cc/ --map -g chips_1200_sk1pe
python run.py /unix/chips/production/beam_nuel_qel_nc/ --map -g chips_1200_sk1pe
python run.py /unix/chips/production/beam_nuel_res_cc/ --map -g chips_1200_sk1pe
python run.py /unix/chips/production/beam_nuel_res_nc/ --map -g chips_1200_sk1pe
python run.py /unix/chips/production/beam_numu_coh_cc/ --map -g chips_1200_sk1pe
python run.py /unix/chips/production/beam_numu_coh_nc/ --map -g chips_1200_sk1pe
python run.py /unix/chips/production/beam_numu_dis_cc/ --map -g chips_1200_sk1pe
python run.py /unix/chips/production/beam_numu_dis_nc/ --map -g chips_1200_sk1pe
python run.py /unix/chips/production/beam_numu_qel_cc/ --map -g chips_1200_sk1pe
python run.py /unix/chips/production/beam_numu_qel_nc/ --map -g chips_1200_sk1pe
python run.py /unix/chips/production/beam_numu_res_cc/ --map -g chips_1200_sk1pe
python run.py /unix/chips/production/beam_numu_res_nc/ --map -g chips_1200_sk1pe

python run.py /unix/chips/production/cosmic_numu_all/ --map -g chips_1200_sk1pe