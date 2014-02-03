#!/bin/bash

FILES="$HOME/ownCloud"
[[ -z "$1" ]] || FILES="$@"
RUNNING=$( pgrep feh )

echo "$FILES"
DISPLAY=:0 feh --random --zoom zoom --fullscreen --reload 3600 --recursive --slideshow-delay 30 --draw-filename $FILES > /dev/null 2>&1 &

sleep 5
kill $RUNNING 2> /dev/null
