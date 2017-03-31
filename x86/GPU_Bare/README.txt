lfs setstripe -c 4 gpu_x86.img
sudo singularity create --force --size 20000 gpu_x86_s.img
cp gpu_x86_s.img gpu_x86.img
HOME=`pwd` sudo -E singularity bootstrap gpu_x86.img gpu.def

#aprun -n 1 singularity exec -H `pwd`:/ccs/home/atj -W `pwd` ompi_base.img ./launch.sh
