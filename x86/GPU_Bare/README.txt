sudo singularity create --force --size 20000 gpu_x86.img
HOME=`pwd` sudo -E singularity bootstrap gpu_x86.img gpu.def

aprun -n 1 singularity exec ompi_base.img nvidia-smi
