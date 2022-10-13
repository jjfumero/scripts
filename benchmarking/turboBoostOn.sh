#!/usr/bin/env bash

echo "0" | sudo tee /sys/devices/system/cpu/intel_pstate/no_turbo
