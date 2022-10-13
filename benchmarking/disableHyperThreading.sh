#!/usr/bin/env bash

### Execute as ROOT 

for i in {8..15}; do
   echo "HT OFF for CPU Core: $i."
   echo 0 > /sys/devices/system/cpu/cpu${i}/online;
done


