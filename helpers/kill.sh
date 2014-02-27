#!/bin/bash

#kill image app

. /home/pi/photOS/helpers/include.sh

logger --tag "kill.sh" "Stopping existing slideshows, videos, streams."
killall midori feh vlc mplayer > /dev/null 2>&1

exit 0
