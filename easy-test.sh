#!/usr/bin/env bash

set -e -x -o pipefail

mpirun --hostfile ~/hostfile --map-by ppr:8:node \
    -x CUDA_HOME="/usr/local/cuda" \
    -x CUDA_PATH="/usr/local/cuda" \
    -x NCCL_HOME="/opt/nccl/build" \
    -x MPI_HOME="/opt/amazon/openmpi" \
    -x LD_LIBRARY_PATH="/mnt/sharedfs/ly-experiments/aws-ofi-nccl-fork/build/lib:/opt/nccl/build/lib:/opt/amazon/openmpi/lib64:/usr/local/cuda/lib64:${LD_LIBRARY_PATH}" \
    -x NCCL_DEBUG="INFO" \
    -x FI_EFA_USE_DEVICE_RDMA=1 \
    -x FI_EFA_FORK_SAFE=1 \
    --mca btl vader,tcp,self --mca btl_tcp_if_exclude lo,docker0 --bind-to none \
    /mnt/sharedfs/stock-nccl/nccl-tests/build/all_reduce_perf \
        --nthreads 1 \
        --ngpus 1 \
        --minbytes 96K \
        --maxbytes 348M \
        --stepfactor 2 \
        --op sum \
        --datatype float \
        --iters 20 \
        --warmup_iters 5