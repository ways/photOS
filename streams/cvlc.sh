#!/bin/bash

# Stream videos using cvlc
# Usage: add to crontab:
# @hourly $PHOTOS/streams/vlc-stream.sh http://url:port

FILES=""
[[ -z "$1" ]] || FILES="$@"
RUNNING=$( pgrep -f 'vlc ' )

echo "$FILES"
DISPLAY=:0 cvlc $FILES > /dev/null 2>&1 &  #--fullscreen

sleep 5
kill $RUNNING 2> /dev/null
