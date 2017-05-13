#!/bin/bash

### Create directories and symlinks between /opt/cray/nvidia/lib64/* and /usr/lib
# sudo singularity exec -w ./TitanPrep.sh

# Print commands executed
set -x

echo "unset PYTHONSTARTUP" >> /environment

####
# Setup Cray MPI
# These variables are expected to be set at container runtime(e.g. in the module file loading the container)
# SYSUTILS_DEFAULT_DIR=`readlink -f /opt/cray/sysutils/default`
# WLM_DEFAULT_DIR=`readlink -f /opt/cray/wlm_detect/default`
# GNU_MPICH_LIB_DIR=`readlink -f /opt/cray/mpt/default/gni/mpich-GNU/5.1/lib`
# CRAY_NVIDIA_DRIVER_LIB_DIR=`readlink -f /opt/cray/nvidia/default/lib64`
####

# Make sure Cray MPICH libraries are in container LD_LIBRARY_PATH
echo "export LD_LIBRARY_PATH="'${GNU_MPICH_LIB_DIR}:${LD_LIBRARY_PATH}:${CRAY_LD_LIBRARY_PATH}:${SYSUTILS_DEFAULT_DIR}/lib64:${WLM_DEFAULT_DIR}/lib64'":/lib64:/usr/lib/x86_64-linux-gnu" >> /environment

####
# Setup Cray-NVIDIA driver lib/bins
# These variables are expected to be set at container runtime(e.g. in the module file loading the container)
# CRAY_NVIDIA_DRIVER_LIB_DIR=`readlink -f /opt/cray/nvidia/default/lib64`
# CRAY_NVIDIA_DRIVER_BIN_DIR=`readlink -f /opt/cray/nvidia/default/bin`
####
echo "export LD_LIBRARY_PATH="'${LD_LIBRARY_PATH}:${CRAY_NVIDIA_DRIVER_LIB_DIR}' >> /environment
echo "export PATH='$PATH:${CRAY_NVIDIA_DRIVER_BIN_DIR}'"


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
c_mpich=`ldconfig -p | grep libmpich.so | awk 'NR==1 {print $4}' | xargs readlink -f`
cxx_mpich=`ldconfig -p | grep libmpichcxx.so | awk 'NR==1 {print $4}' | xargs readlink -f`
f_mpich=`ldconfig -p | grep libmpichfort.so | awk 'NR1==1 {print $4}' | xargs readlink -f`

if [ ! -f ${c_mpich} ]; then
  echo "libmpich.so not found!"
fi
if [ ! -f ${cxx_mpich} ]; then
echo "libmpichcxx.so not found!"
fi
if [ ! -f ${f_mpich} ]; then
  echo "libmpichfort.so not found!"
fi

mv ${c_mpich} ${c_mpich}.original
mv ${cxx_mpich} ${cxx_mpich}.original
mv ${f_mpich} ${f_mpich}.original

ln -nsf /opt/cray/mpt/7.5.2/gni/mpich-gnu/5.1/lib/libmpich.so ${c_mpich}
ln -nsf /opt/cray/mpt/7.5.2/gni/mpich-gnu/5.1/lib/libmpichcxx.so ${cxx_mpich}
ln -nsf /opt/cray/mpt/7.5.2/gni/mpich-gnu/5.1/lib/libfmpich.so ${f_mpich}
