#!/usr/bin/env bash
# Download imgurl photos from a subreddit.
#
# Usage example:
# ${PHOTOS}/photos/slideshow.sh $( ${PHOTOS}/webcams/reddit-images.sh newsporn )

. /home/pi/photOS/helpers/include.sh

TMPDIR=/dev/shm/reddit
subreddit="newsporn"
[[ -z $1 ]] || subreddit="$1"

logger --tag="reddit-images.sh" "Fetching images from ${subreddit} to ${TMPDIR}."
logger --tag="reddit-images.sh" "http://www.reddit.com/r/${subreddit}/top/.rss?sort=top&t=day"

mkdir -p ${TMPDIR}
cd ${TMPDIR} || exit 1
rm -f ${TMPDIR}/*

links=$( wget -O - --quiet --random-wait \
  "http://www.reddit.com/r/${subreddit}/top/.rss?sort=top&t=day" \
  | grep -Eo 'http://i.imgur.com[^&]+jpg' )

echo $links | xargs wget -nc --quiet --random-wait

echo ${TMPDIR}
