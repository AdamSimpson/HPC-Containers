#!/bin/bash

# COMPILE AND RUN OF EXECUTABLE MUST BE SEPERATE!!!!

#echo $LD_LIBRARY_PATH

#export PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin
#export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib:/usr/local/lib/openmpi:/usr/lib:/usr/lib64:/:/usr/local/share
#export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CRAY_LD_LIBRARY_PATH:/opt/cray/wlm_detect/1.0-1.0502.64649.2.2.gem/lib64
#export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/cray/sysutils/1.0-1.0502.60492.1.1.gem/lib64

#export OMPI_MCA_btl=ugni,self

#export OMPI_MCA_btl_base_verbose=1

export OMPI_MCA_mpi_leave_pinned=0
export OMPI_MCA_mpi_leave_pinned_pipeline=0

#ompi_info

#export PMI_DEBUG=1
#export ALPSLLI_DEBUG=1

mpicc helloMPI.c
#./a.out

#ldd ./a.out
#lddtree ./a.out
#strace -y ./a.out

#gcc -I/usr/include -L/usr/lib -L/usr/lib/openmpi testalps.c -lalps -lalpsutil -lalpslli -lmpi

#gcc helloMPI.c -I/usr/include/mpich -L/usr/lib/x86_64-linux-gnu/ -lmpich

#ldd ./locala.out

#gcc -I/usr/include -I/opt/cray/alps/5.2.4-2.0502.9950.37.1.gem/include -L/usr/lib -L/usr/local/lib -L/opt/cray/alps/5.2.4-2.0502.9950.37.1.gem/lib64 testalps.c -lalps -lalpsutil -lalpslli -lmpi

#ompi_info

#mpicc testpmi.c -I/opt/cray/pmi/default/include -L/opt/cray/pmi/default/lib64 -lpmi

#mpicc helloMPI.c

#ldd ./a.out

#mpicc helloMPI.c -o container.out

#ldd ./container.out

#ompi_info

#./a.out

#ldd ./container.out

#./container.out
