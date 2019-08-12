#!/usr/bin bash

sudo yum install yum-plugin-copr
sudo yum copr enable jdanecki/intel-opencl
sudo yum install intel-opencl

