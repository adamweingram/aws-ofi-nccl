#!/usr/bin/env bash

set -e -x -o pipefail

./automake.sh

mkdir -p build

./configure \
    --with-libfabric=/opt/amazon/efa \
    --with-cuda=/usr/local/cuda \
    --with-mpi=/opt/amazon/openmpi \
    --prefix="$(realpath ./build)"

make -j