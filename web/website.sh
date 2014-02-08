#!/bin/bash
# Display website

. /home/pi/photOS/helpers/include.sh

URL="http://nrk.no/nyheter/"
[[ -z "$1" ]] || URL="$@"
RUNNING=$( pgrep midori )

logger --tag "website.sh" "Displaying website $URL"

DISPLAY=:0 midori \
  -a $URL \
  -e Fullscreen \
  > /dev/null 2>&1 &

sleep 5
kill $RUNNING 2> /dev/null
