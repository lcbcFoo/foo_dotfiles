#!/bin/bash
while [ "$select" != "NO" -a "$select" != "YES" ]; do
    select=$(echo -e 'YES\nNO' | dmenu -nb '#151515' -nf '#ffffff' -sb '#404040' -sf '#ffffff' -fn '-*-*-medium-r-normal-*-*-*-*-*-*-100-*-*' -i -p "Do you really want to exit i3? This will end your X session.")
    [ -z "$select" ] && exit 0
done
[ "$select" = "NO" ] && exit 0
i3-msg exit
