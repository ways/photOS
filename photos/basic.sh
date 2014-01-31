#!/bin/bash

FILES=""
[[ -z "$1" ]] || FILES="$HOME/ownCloud"
RUNNING=$( pgrep feh )

DISPLAY=:0 feh --random --zoom auto --fullscreen --reload 3600 --recursive --slideshow-delay 20 $FILES > /dev/null 2>&1 &

sleep 5
kill $RUNNING 2> /dev/null
