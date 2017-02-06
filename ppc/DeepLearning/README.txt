// To Create
sudo singularity create --size 20000 deeplearning_ppc.img
sudo singularity bootstrap deeplearning_ppc.img deeplearning.def

// To Run(Single node)
singularity exec -H `pwd`:/ccs/home/atj tensorflow_ppc.img ./launch_p3b1.sh
