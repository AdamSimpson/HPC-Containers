# Create image base
sudo singularity create --size 2000 ompi_base.img

# we must use -E to pass in variables such as PKG_CONFIG_PATH
sudo -E singularity bootstrap ompi_base.img ompi_base.def

# Build debs outside of bootstrap to get around an issue with bind mounts not mounding in bootstrap
mkdir build && cd build
cp ../build_omp.sh .
singularity exec ../ompi_zesty.img ./build_omp.sh 
