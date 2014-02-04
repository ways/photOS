#!/bin/bash

#kill image app

. /home/pi/photOS/helpers/include.sh

logger --tag "kill.sh" "Stopping existing slideshows, videos, streams."
killall feh vlc mplayer > /dev/null 2>&1
