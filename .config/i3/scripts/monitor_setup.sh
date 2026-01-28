#!/bin/bash

# 1. Define variables
# (This matches the 30Hz mode that worked for you)
MODE_NAME="3440x1440_30.00"
MODELINE="206.50  3440 3568 3912 4416  1440 1443 1448 1478 +hsync -vsync"
OUTPUT="HDMI-1-1"
INTERNAL="eDP-1-1"

# 2. Create the mode (suppressing error if it already exists)
xrandr --newmode "$MODE_NAME" $MODELINE 2>/dev/null

# 3. Add mode to the HDMI port
xrandr --addmode "$OUTPUT" "$MODE_NAME" 2>/dev/null

# 4. Activate configuration
# This turns on HDMI, sets it to 30Hz, places it right of laptop, and ensures laptop is on.
xrandr --output "$OUTPUT" --mode "$MODE_NAME" --right-of "$INTERNAL" --output "$INTERNAL" --auto
