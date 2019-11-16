#!/usr/bin/bash

echo "NOTE: It needs GCC 7.0"

git clone https://github.com/ibmruntimes/openj9-openjdk-jdk8
cd openj9-openjdk-jdk8
bash ./get_source.sh
current=`pwd`


cd /tmp
wget https://sourceforge.net/projects/freemarker/files/freemarker/2.3.8/freemarker-2.3.8.tar.gz/download -O freemarker.tgz
tar -xzf freemarker.tgz freemarker-2.3.8/lib/freemarker.jar --strip=2 
mv freemarker.jar $current
rm -f freemarker.tgz
cd - 

bash ./configure  --with-freemarker-jar=$current/freemarker.jar --enable-cuda --with-cuda=/usr/local/cuda-10.0/
make all

