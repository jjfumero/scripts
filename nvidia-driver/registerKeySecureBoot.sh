openssl req -new -x509 -newkey rsa:2048 -keyout /home/$USER/bin/drivers/Nvidia.key -outform DER -out /home/$USER/bin/drivers/Nvidia.der -nodes -days 100000 -subj "/CN=Graphics Drivers"

sudo mokutil --import /home/$USER/bin/drivers/Nvidia.der

## Then reboot and follow the steps

