#!/bin/bash

# Stream videos using cvlc
# Usage: add to crontab:
# @hourly $PHOTOS/streams/vlc-stream.sh http://url:port
#
# Should really have --fullscreen, but it doesn't work on the Pi.

FILES=""
[[ -z "$1" ]] || FILES="$@"
RUNNING=$( pgrep -f 'vlc ' )

logger --tag="cvlc.sh" "Streaming ${FILES}"
DISPLAY=:0 cvlc $FILES > /dev/null 2>&1 &

sleep 5
kill $RUNNING 2> /dev/null
