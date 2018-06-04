#!/bin/bash 

git clone https://github.com/open-mpi/ompi.git

cd ompi
./autogen.pl

mkdir build
cd build
../configure  --prefix=/home/juan/bin/openmpi-lib/ --enable-mpi-java 
make -j 8
make install 

