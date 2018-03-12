#!/bin/bash 

## Add a new user with permissions to execute on GPU
newUser=$1
sudo useradd -m $newUser -s /bin/bash -g video
sudo passwd $newUser

