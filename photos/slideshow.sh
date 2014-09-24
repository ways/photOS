#!/bin/bash -x
# Display photos given on CLI using feh. Random order, zoom to display size.

. /home/pi/photOS/helpers/include.sh

FILES="$REPOSITORY"
[[ -z "$1" ]] || FILES="$@"
RUNNING=$( pgrep feh )

logger --tag "slideshow.sh" "Displaying photos from $FILES"

DISPLAY=:0 feh \
  --random --auto-zoom --zoom zoom --fullscreen --reload 3600 \
  --recursive --slideshow-delay 30 --draw-filename --draw-tinted \
  "${FILES}" > /dev/null 2>&1 &

sleep 5
kill $RUNNING 2> /dev/null
