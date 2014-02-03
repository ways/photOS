#!/bin/bash

#kill image app

. /var/local/photOS/bin/include.sh

logger "kill.sh: killing existing slideshows, videos, streams"
killall feh vlc mplayer
