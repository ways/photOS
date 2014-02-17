#!/bin/bash
# Display gifs given on CLI using mplayer.
# Unable to go fullscreen with rpi (-zoom)

. /home/pi/photOS/helpers/include.sh

FILES="$REPOSITORY"
[[ -z "$1" ]] || FILES="$@"

killall mplayer 2> /dev/null

logger --tag "gifs.sh" "Displaying gifs from $FILES"

find ${FILES} -type f -iname \*.gif -print0 \
  | sort --random-sort --zero-terminated \
  | while read -d $'\0' video; do
  echo "playing ${video}"
  DISPLAY=:0 mplayer -fs -loop 10 -ao null -really-quiet "${video}" 2> /dev/null
done

logger --tag "gifs.sh" "Done"
