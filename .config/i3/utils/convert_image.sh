#!/bin/sh
# Add a lock icon and text to the center of an image
convert ./Pictures/dark_souls.jpg -scale 1920x1080 -font Courier -size 24 \
    -pointsize 26 -fill white -gravity center \
    -annotate +0+160 "Who goes there?" /usr/share/i3lock-fancy/icons/lock.png \
    -gravity center -composite lockscreen.png
