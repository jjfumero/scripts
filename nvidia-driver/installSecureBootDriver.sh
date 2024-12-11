#!/bin/bash

## usage:
#bash ./installNVIDIADriver.sh NVIDIA-Linux-x86_64-550.67.run 

if [ -z "${1}" ]; then
   echo "Usage:"
   echo "bash ./installNVIDIADriver.sh NVIDIA-Linux-x86_64-550.67.run"
   exit 1
fi

sudo bash ${1} --module-signing-secret-key=$HOME/bin/drivers/Nvidia.key --module-signing-public-key=$HOME/bin/drivers/Nvidia.der

