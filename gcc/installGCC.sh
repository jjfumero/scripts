#! /bin/bash

wget https://ftp.gnu.org/gnu/gcc/gcc-5.5.0/gcc-5.5.0.tar.gz
tar xvzf gcc-5.5.0.tar.gz

./contrib/download_prerequisites

cd ..
mkdir build
cd build
../gcc-5.5.0/configure --prefix=$HOME/bin/gcc/GCC-5.5.0 --enable-languages=c,c++ --disable-multilib 
make -j 8

make install

export PATH=$HOME/bin/gcc/GCC-5.5.0/bin/:$PATH
export LD_LIBRARY_PATH=$HOME/bin/gcc/GCC-5.5.0/lib64:$LD_LIBRARY_PATH


