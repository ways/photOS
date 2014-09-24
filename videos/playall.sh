#!/bin/bash
# Display photos given on CLI using feh. Random order, zoom to display size.

. /home/pi/photOS/helpers/include.sh

FILES="$REPOSITORY"
[[ -z "$1" ]] || FILES="$@"

killall mplayer vlc 2> /dev/null

logger --tag "playall.sh" "Displaying videos from $FILES"

find ${FILES} -type f -iname \*.avi -or -iname \*.mp\* -print0 \
  | sort --random-sort --zero-terminated \
  | xargs -0 -I {} omxplayer --vol 0 --blank "{}" > /dev/null 2>&1

logger --tag "playall.sh" "Done"
