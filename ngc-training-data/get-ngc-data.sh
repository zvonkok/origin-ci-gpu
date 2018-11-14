#! /usr/bin/env mpibash


FRAMEWORK=(base  caffe  caffe2  cntk  cuda  dataset  digits  inferenceserver  keras  mxnet  pytorch  tensorflow  tensorrt  tensorrtserver  theano  torch)

# Initialization
enable -f mpibash.so mpi_init
mpi_init
mpi_comm_rank rank
mpi_comm_size nranks


data=${FRAMEWORK[$rank]}

echo $data


aws s3 sync  s3://zkosic-s3-dgx/${data} /ngc/${data}  --no-follow-symlinks 

mpi_finalize
echo "    Goodbye from rank $rank."
