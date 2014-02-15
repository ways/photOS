#!/usr/bin/env bash
# Download images from an rss feed.
#
# Usage example:
# ${PHOTOS}/photos/slideshow.sh $( ${PHOTOS}/webcams/rss-images.sh maxcount url )

. /home/pi/photOS/helpers/include.sh

TMPDIR=/dev/shm/rss-images
maxcount=20
url="http://feeds.feedburner.com/TheThrillingWonderStory"
[[ -z $1 ]] || maxcount="$1"
[[ -z $2 ]] || url="$2"

logger --tag="rss-images.sh" "Fetching ${maxcount} images from ${url} to ${TMPDIR}."

mkdir -p ${TMPDIR}
cd ${TMPDIR} || exit 1
rm -f ${TMPDIR}/*

links=$( wget -O - --quiet --random-wait \
  "${url}" \
  | grep -Eo 'http://[^&]+jpg' )

echo $links | head -n ${maxcount} | xargs wget -nc --quiet --random-wait

echo ${TMPDIR}
