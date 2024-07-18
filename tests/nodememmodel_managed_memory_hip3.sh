#!/bin/bash

module load rocm
XNACK_COUNT=`rocminfo | grep xnack | wc -l`
if [ ${XNACK_COUNT} -lt 1 ]; then
   echo "Skip"
else
   REPO_DIR="$(dirname "$(dirname "$(readlink -fm "$0")")")"
   cd ${REPO_DIR}/ManagedMemory/vectorAdd

   sed -i 's/\/opt\/rocm/${ROCM_PATH}/g' Makefile

   make vectoradd_hip3.exe

   ./vectoradd_hip3.exe

   make clean
fi
