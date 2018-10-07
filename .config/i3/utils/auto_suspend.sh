#!/bin/bash

# Lock screen after 5 minutes, turn back 1 minute before, suspend 5 minutes after lock
xautolock -detectsleep \
          -notify   60 -notifier "xset dpms force off" \
          -time     5  -locker   "/usr/bin/i3lock -i /home/foo/.config/i3/lockscreen.png" \
          -killtime 10 -killer   "systemctl suspend" &
