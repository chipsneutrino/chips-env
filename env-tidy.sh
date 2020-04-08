#! /bin/bash

CURRENTDIR=$(pwd)

cd $CHIPSENV

echo "${C_RED}tidy chips-env${C_RESET}"
make clean
rm ./cmake_install.cmake
rm ./CMakeCache.txt
rm -r ./CMakeFiles
rm ./Makefile
rm ./chips/cmake_install.cmake
rm -r ./chips/CMakeFiles
rm ./chips/Makefile

echo "${C_RED}tidy chips-sim${C_RESET}"
source chips/chips-sim/sim-tidy.sh

echo "${C_RED}tidy chips-reco${C_RESET}"
source chips/chips-reco/reco-tidy.sh

cd $CURRENTDIR
echo "${C_GREEN}tidy done${C_RESET}"