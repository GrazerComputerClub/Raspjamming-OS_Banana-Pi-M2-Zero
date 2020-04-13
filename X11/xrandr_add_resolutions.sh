#!/bin/bash

# 1280x720 59.86 Hz (CVT 0.92M9) hsync: 44.77 kHz; pclk: 74.50 MHz
sudo xrandr --newmode "1280x720_60.00" 74.50  1280 1344 1472 1664  720 723 728 748 -hsync +vsync
# 800x600 59.86 Hz (CVT 0.48M3) hsync: 37.35 kHz; pclk: 38.25 MHz
sudo xrandr --newmode "800x600_60.00"   38.25  800 832 912 1024  600 603 607 624 -hsync +vsync
# 1920x1080 59.96 Hz (CVT 2.07M9) hsync: 67.16 kHz; pclk: 173.00 MHz
sudo xrandr --newmode "1920x1080_60.00"  173.00  1920 2048 2248 2576  1080 1083 1088 1120 -hsync +vsync

OUTPUT="default"
sudo xrandr --addmode "$OUTPUT" 1920x1080_60.00
sudo xrandr --addmode "$OUTPUT" 1280x720_60.00
sudo xrandr --addmode "$OUTPUT" 800x600_60.00

