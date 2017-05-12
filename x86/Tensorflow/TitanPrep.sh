#!/bin/bash

### Create directories and symlinks between /opt/cray/nvidia/lib64/* and /usr/lib
# sudo singularity exec -w ./TitanPrep.sh

# Print commands executed
set -x

# Mount point for Cray files needed for MPI
mkdir -p ${SINGULARITY_ROOTFS}/opt/cray

# Mount point for Cray files needed for ALSP runtime
mkdir -p ${SINGULARITY_ROOTFS}/var/spool/alps
mkdir -p ${SINGULARITY_ROOTFS}/var/opt/cray

# Mount point for lustre
mkdir -p ${SINGULARITY_ROOTFS}/lustre/atlas
mkdir -p ${SINGULARITY_ROOTFS}/lustre/atlas1
mkdir -p ${SINGULARITY_ROOTFS}/lustre/atlas2

### Create symlinks between libmpi* and Cray's mpich
c_mpich=`ldconfig -p | grep libmpich.so | awk '{print $4}'`
cxx_mpich=`ldconfig -p | grep libmpichcxx.so | awk '{print $4}'`
f_mpich=`ldconfig -p | grep libmpichfort.so | awk '{print $4}'`

mv ${c_mpich} ${c_mpich}.original
mv ${cxx_mpich} ${cxx_mpich}.original
mv ${f_mpich} ${f_mpich}.original

ln -nsf /opt/cray/mpt/7.5.2/gni/mpich-gnu/5.1/lib/libmpich.so ${c_mpich}
ln -nsf /opt/cray/mpt/7.5.2/gni/mpich-gnu/5.1/lib/libmpichcxx.so ${cxx_mpich}
ln -nsf /opt/cray/mpt/7.5.2/gni/mpich-gnu/5.1/lib/libfmpich.so ${f_mpich}
