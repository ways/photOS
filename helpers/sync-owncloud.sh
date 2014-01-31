#!/bin/bash

#Sync files using owncloud
$( pgrep oclient > /dev/null ) || /usr/local/bin/oclient > /dev/null
