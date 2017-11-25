#!/bin/bash

# Register the following display resolutions for Dell XPS 13 
# Info is obtained via cvt command
# Example: $ cvt 1920 1080

# Then add the following lines (with the correct parameters) 
# to /etc/gdm/Init/Default after the line OLD_IFS=$IFS

OUTPUT=eDP-1
xrandr --newmode "1280x720_60.00"   74.50  1280 1344 1472 1664  720 723 728 748 -hsync +vsync
xrandr --addmode $OUTPUT 1280x720_60.00
xrandr --output $OUTPUT --mode 1280x720_60.00 

xrandr --newmode "1920x1080_60.00"  173.00  1920 2048 2248 2576  1080 1083 1088 1120 -hsync +vsync
xrandr --addmode $OUTPUT 1920x1080_60.00
xrandr --output $OUTPUT --mode 1920x1080_60.00

xrandr --newmode "1600x900_60.00"  118.25  1600 1696 1856 2112  900 903 908 934 -hsync +vsync
xrandr --addmode $OUTPUT 1600x900_60.00
xrandr --output $OUTPUT --mode 1600x900_60.00

xrandr --newmode "2560x1440_60.00"  312.25  2560 2752 3024 3488  1440 1443 1448 1493 -hsync +vsync
xrandr --addmode $OUTPUT 2560x1440_60.00
xrandr --output $OUTPUT --mode 2560x1440_60.00

