#!/bin/bash
# Display photos given on CLI using feh. Random order, zoom to display size.

. /home/pi/photOS/helpers/include.sh

FILES="$REPOSITORY"
[[ -z "$1" ]] || FILES="$@"

killall mplayer vlc 2> /dev/null

logger --tag "playall.sh" "Displaying videos from $FILES"

find ${FILES} -type f -iname \*.avi -or -iname \*.mp\* -print0 \
  | sort --random-sort --zero-terminated \
  | while read -d $'\0' video; do
  echo "playing ${video}"
  DISPLAY=:0 omxplayer --blank "${video}" 
done

logger --tag "playall.sh" "Done"
