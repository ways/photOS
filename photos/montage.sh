#!/bin/bash
# Display a montage (lots of small thumbnails) of all photos given on CLI, then die.

. /home/pi/photOS/helpers/include.sh

FILES="$REPOSITORY"
[[ -z "$1" ]] || FILES="$@"

logger --tag "basic.sh" "Displaying photos from $FILES"

DISPLAY=:0 feh \
  --random --auto-zoom --zoom zoom --fullscreen --reload 3600 \
  --recursive --slideshow-delay 30 --montage --cycle-once\
  $FILES > /dev/null 2>&1 &

pidofchild=$!

sleep 60
kill ${pidofchild}
