#! /usr/bin/env mpibash


FRAMEWORK=(caffe caffe2)


# Initialization
enable -f mpibash.so mpi_init
mpi_init
mpi_comm_rank rank
mpi_comm_size nranks


echo ${FRAMEWORK[$rank]}


mpi_finalize
echo "    Goodbye from rank $rank."
