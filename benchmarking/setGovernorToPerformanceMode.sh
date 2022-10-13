

# It requires kernel-tools package install in Fedora OS 
sudo cpupower frequency-set --governor performance


# Check
cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor

