#!/bin/bash
#Sync files using owncloud

logger --tag "sync-owncloud.sh" "Syncing ownCloud..."
#$( pgrep oclient > /dev/null ) || /usr/local/bin/oclient | logger --tag "sync-owncloud.sh"

ionice -c3 nice owncloudcmd --confdir /home/pi/.owncloud/owncloud.cfg /home/pi/ownCloud \
  ownclouds://c.falk-petersen.no/remote.php/webdav/Bilder

logger --tag "sync-owncloud.sh" "Syncing done."
