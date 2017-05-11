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

# Expand full path, following symlink which isn't visible in container
# note that root doesn't correctly see /etc/alternatives on Titan so we hardcode the current path
#nvidia_path=`readlink -f /opt/cray/nvidia/default`
nvidia_path=/opt/cray/nvidia/352.101-1_1.0502.2465.0.0.gem

libs=(
    'libEGL.so'
    'libcuda.so'
    'libnvidia-eglcore.so'
    'libnvidia-ifr.so'
    'libGLESv1_CM.so'
    'tls_test_dso.so'
    'libnvidia-wfb.so'
    'libnvidia-compiler.so'
    'libvdpau.so'
    'libvdpau_trace.so'
    'libnvidia-cfg.so'
    'libGL.so'
    'libnvidia-glsi.so'
    'libnvidia-glcore.so'
    'libnvidia-ml.so'
    'libnvcuvid.so'
    'libglx.so'
    'libnvidia-opencl.so'
    'libvdpau_nvidia.so'
    'libnvidia-fbc.so'
    'libnvidia-encode.so'
    'libnvidia-tls.so'
)

for lib in ${libs[@]}; do
  ln -nsf ${nvidia_path}/lib64/${lib}.352.101 /usr/lib/${lib}.352.101
  ln -nsf /usr/lib/${lib}.352.101 /usr/lib/${lib}.1
  ln -nsf /usr/lib/${lib}.1 /usr/lib/${lib}
done

ln -nsf ${nvidia_path}/lib64/libOpenCL.so.1.0.0 /usr/lib/libOpenCL.so.1.0.0
ln -nsf /usr/lib/libOpenCL.so.1.0.0 /usr/lib/libOpenCL.so.1
ln -nsf /usr/lib/libOpenCL.so.1 /usr/lib/libOpenCL.so 

ln -nsf ${nvidia_path}/lib64/libGLESv2.so.352.101 /usr/lib/libGLESv2.so.352.101
ln -nsf /usr/lib/libGLESv2.so.352.101 /usr/lib/libGLESv2.so.2
ln -nsf /usr/lib/libGLESv2.so.2 /usr/lib/libGLESv2.so

ln -nsf ${nvidia_path}/lib64/nvidia_drv.so /usr/lib/nvidia_drv.so
ln -nsf ${nvidia_path}/tls_test_dso.so /usr/lib/tls_test_dso.so
mkdir -p /usr/lib/tls
ln -nsf ${nvidia_path}/tls/libnvidia-tls.so.352.101 /usr/lib/tls/libnvidia-tls.so.352.101

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

### Create symlinks between /opt/cray/nvidia/bin/* and /usr/bin
ln -nsf ${nvidia_path}/bin/nvidia-debugdump  /usr/bin/nvidia-debugdump
ln -nsf ${nvidia_path}/bin/nvidia-smi  /usr/bin/nvidia-smi
