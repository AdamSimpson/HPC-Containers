sudo singularity create --size 20000 tensorflow_x86.img
HOME=`pwd` sudo -E singularity bootstrap tensorflow_x86.img tensorflow.def

#aprun -n 1 singularity exec -H `pwd`:/ccs/home/atj -W `pwd` ompi_base.img ./launch.sh
