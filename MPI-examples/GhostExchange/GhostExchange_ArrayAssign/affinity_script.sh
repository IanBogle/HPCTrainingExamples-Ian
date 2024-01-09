#!/bin/bash

export GPU_NUMBER_STRIDE=`expr ${OMPI_COMM_WORLD_SIZE} / ${SLURM_GPUS}`
export GPU_NUMBER_INDEX=`expr ${OMPI_COMM_WORLD_LOCAL_RANK} / ${GPU_NUMBER_STRIDE}`
GPU_ORDER=`rocm-smi --showtopo |grep Node | sort -k 4 |cut -f 1 | sed  -e '1,1d' -e '1,$s/]//' -e'1,$s/GPU\[//' | tr '\n' ' ' |sed -e 's/,$//'`
gpu_list=(${GPU_ORDER})
export my_gpu=${gpu_list[${GPU_NUMBER_INDEX}]}
#echo "MPI Rank  ${OMPI_COMM_WORLD_LOCAL_RANK} will run on index ${GPU_NUMBER_INDEX} GPU ${my_gpu}"

export ROCR_VISIBLE_DEVICES=$my_gpu

"$@"
