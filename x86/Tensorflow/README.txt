# Tensorflow Container
Provides Tensorflow/1.0.1 with Python2/3 interface. Additional Keras support provided.

lfs setstripe -c 4 tensorflow_x86.img
sudo singularity create --force --size 20000 tensorflow_x86_s.img
cp tensorflow_x86_s.img tensorflow_x86.img
HOME=`pwd` sudo -E singularity bootstrap tensorflow_x86.img tensorflow.def

#aprun -n 1 singularity exec -H `pwd`:/ccs/home/atj -W `pwd` ompi_base.img ./launch.sh
