#!/bin/sh

B='#00000000'  # blank
C='#ffffff22'  # clear ish
D='#F35F09AA'  # default
W='#880000bb'  # wrong
V='#F6F605BB'  # verifying
WHITE_BLUR="F0F0F0AA"
#T='#ee00eeee'  # text
T=$WHITE_BLUR

i3lock \
--insidevercolor=$C   \
--ringvercolor=$V     \
\
--insidewrongcolor=$C \
--ringwrongcolor=$W   \
\
--insidecolor=$B      \
--ringcolor=$D        \
--linecolor=$B        \
--separatorcolor=$D   \
\
--verifcolor=$T        \
--wrongcolor=$T        \
--timecolor=$T        \
--datecolor=$T        \
--layoutcolor=$T      \
--keyhlcolor=$W       \
--bshlcolor=$W        \
\
\ #--blur 15              \
-i ~/Pictures/arch_wallpaper.png -t \
--clock               \
--indicator           \
--timestr="%H:%M:%S"  \
--datestr="%A, %m %Y" \
--keylayout 2         \
--veriftext="Fool..." \
--wrongtext="You shall not PASS!" \
--greetertext="Say friend and enter!" \
--greetercolor=$WHITE_BLUR \
--greeterpos="ix:iy+300" \
--radius 150 \
--ring-width 10 \
\ #--textsize=20 \
--modsize=10 \
--time-font=monofur \
--date-font=monofur \
# etc
