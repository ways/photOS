#!/bin/bash
#Sync files using owncloud

logger --tag "sync-owncloud.sh" "Syncing ownCloud..."
$( pgrep oclient > /dev/null ) || /usr/local/bin/oclient | logger --tag "sync-owncloud.sh"
logger --tag "sync-owncloud.sh" "Syncing done."
