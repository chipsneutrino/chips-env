#! /bin/bash

python run.py /unix/chips/jtingey/prod/beam_nuel_all/ --gen -e 2000000 -p nuel
python run.py /unix/chips/jtingey/prod/beam_anuel_all/ --gen -e 2000000 -p anuel
python run.py /unix/chips/jtingey/prod/beam_numu_all/ --gen -e 2000000 -p numu
python run.py /unix/chips/jtingey/prod/beam_anumu_all/ --gen -e 2000000 -p anumu

python run.py /unix/chips/jtingey/prod/beam_nuel_coh_cc/ --gen -e 500000 -p nuel -t COH-CC
python run.py /unix/chips/jtingey/prod/beam_nuel_coh_nc/ --gen -e 500000 -p nuel -t COH-NC
python run.py /unix/chips/jtingey/prod/beam_nuel_dis_cc/ --gen -e 500000 -p nuel -t DIS-CC
python run.py /unix/chips/jtingey/prod/beam_nuel_dis_nc/ --gen -e 500000 -p nuel -t DIS-NC
python run.py /unix/chips/jtingey/prod/beam_nuel_qel_cc/ --gen -e 500000 -p nuel -t QEL-CC
python run.py /unix/chips/jtingey/prod/beam_nuel_qel_nc/ --gen -e 500000 -p nuel -t QEL-NC
python run.py /unix/chips/jtingey/prod/beam_nuel_res_cc/ --gen -e 500000 -p nuel -t RES-CC
python run.py /unix/chips/jtingey/prod/beam_nuel_res_nc/ --gen -e 500000 -p nuel -t RES-NC
python run.py /unix/chips/jtingey/prod/beam_numu_coh_cc/ --gen -e 500000 -p numu -t COH-CC
python run.py /unix/chips/jtingey/prod/beam_numu_coh_nc/ --gen -e 500000 -p numu -t COH-NC
python run.py /unix/chips/jtingey/prod/beam_numu_dis_cc/ --gen -e 500000 -p numu -t DIS-CC
python run.py /unix/chips/jtingey/prod/beam_numu_dis_nc/ --gen -e 500000 -p numu -t DIS-NC
python run.py /unix/chips/jtingey/prod/beam_numu_qel_cc/ --gen -e 500000 -p numu -t QEL-CC
python run.py /unix/chips/jtingey/prod/beam_numu_qel_nc/ --gen -e 500000 -p numu -t QEL-NC
python run.py /unix/chips/jtingey/prod/beam_numu_res_cc/ --gen -e 500000 -p numu -t RES-CC
python run.py /unix/chips/jtingey/prod/beam_numu_res_nc/ --gen -e 500000 -p numu -t RES-NC

python run.py /unix/chips/jtingey/prod/cosmic_numu_all/ --gen -e 2000000 -p cosmic --cosmicdetector chips_1200
python run.py /unix/chips/jtingey/prod/cosmic_numu_all/ --gen -e 2000000 -p cosmic --cosmicdetector chips_1000
python run.py /unix/chips/jtingey/prod/cosmic_numu_all/ --gen -e 2000000 -p cosmic --cosmicdetector chips_800
python run.py /unix/chips/jtingey/prod/cosmic_numu_all/ --gen -e 2000000 -p cosmic --cosmicdetector chips_600
python run.py /unix/chips/jtingey/prod/cosmic_numu_all/ --gen -e 2000000 -p cosmic --cosmicdetector chips_400
python run.py /unix/chips/jtingey/prod/cosmic_numu_all/ --gen -e 2000000 -p cosmic --cosmicdetector chips_275


