#!/bin/bash

### Create symlinks between /opt/cray/nvidia/lib64/* and /usr/lib

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
  ln -s /opt/cray/nvidia/lib64/${lib}.352.101 /usr/lib/${lib}.352.101
  ln -s /usr/lib/${lib}.352.101 /usr/lib/${lib}.1
  ln -s /usr/lib/${lib}.1 /usr/lib/${lib}
  
done

ln -s /opt/cray/nvidia/lib64/libOpenCL.so.1.0.0 /usr/lib/libOpenCL.so.1.0.0
ln -s /usr/lib/libOpenCL.so.1.0.0 /usr/lib/libOpenCL.so.1
ln -s /usr/lib/libOpenCL.so.1 /usr/lib/libOpenCL.so 

ln -s /opt/cray/nvidia/lib64/libGLESv2.so.352.101 /usr/lib/libGLESv2.so.352.101
ln -s /usr/lib/libGLESv2.so.352.101 /usr/lib/libGLESv2.so.2
ln -s /usr/lib/libGLESv2.so.2 /usr/lib/libGLESv2.so

ln -s /opt/cray/nvidia/lib64/nvidia_drv.so /usr/lib/nvidia_drv.so
ln -s /opt/cray/nvidia/lib64/tls_test_dso.so /usr/lib/tls_test_dso.so
mkdir /usr/lib/tls
ln -s /opt/cray/nvidia/lib64/tls/libnvidia-tls.so.352.101 /usr/lib/tls/libnvidia-tls.so.352.101

### Create symlinks between libmpi* and Cray's mpich
mv /usr/lib/x86_64-linux-gnu/libmpich.so.12.1.0 /usr/lib/x86_64-linux-gnu/libmpich.so.12.1.0.original
mv /usr/lib/x86_64-linux-gnu/libmpichcxx.so.12.1.0 /usr/lib/x86_64-linux-gnu/libmpichcxx.so.12.1.0.original
mv /usr/lib/x86_64-linux-gnu/libmpichfort.so.12.1.0 /usr/lib/x86_64-linux-gnu/libmpichfort.so.12.1.0.original

ln -s /opt/cray/mpt/7.5.2/gni/mpich-gnu/5.1/lib/libmpich.so /usr/lib/x86_64-linux-gnu/libmpich.so.12.1.0
ln -s /opt/cray/mpt/7.5.2/gni/mpich-gnu/5.1/lib/libmpichcxx.so /usr/lib/x86_64-linux-gnu/libmpichcxx.so.12.1.0
ln -s /opt/cray/mpt/7.5.2/gni/mpich-gnu/5.1/lib/libfmpich.so /usr/lib/x86_64-linux-gnu/libmpichfort.so.12.1.0
