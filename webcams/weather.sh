#!/bin/bash

. ${HOME}/photOS/helpers/include.sh

RUNNING=$( pgrep feh )

logger --tag "weather.sh" "Starting weather."
DISPLAY=:0 feh --auto-zoom --zoom stretch --fullscreen --reload 600 --draw-filename http://www.yr.no/place/Norway/Oslo/Oslo/Oslo/avansert_meteogram.png > /dev/null 2>&1 &

sleep 5
kill $RUNNING 2> /dev/null
