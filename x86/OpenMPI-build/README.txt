sudo singularity create --size 5000 ompi_base.img
HOME=`pwd` sudo -E singularity bootstrap ompi_base.img ompi_base.def
aprun -n 1 singularity exec -H `pwd`:/ccs/home/atj -W `pwd` ompi_base.img ./launch.sh
