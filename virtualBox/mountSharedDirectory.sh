#!/bin/bash 

sudo mount -t vboxsf -o uid=$UID,gid=$(id -g) shared ~/shared

