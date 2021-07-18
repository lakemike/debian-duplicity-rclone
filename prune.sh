#!/bin/bash

# PRUNE
# manage local images if necessary
docker image ls
docker image prune -f
IMAGEID=`docker images | grep debian-duplicity-rclone | awk '{print $3}' | sort | uniq | tr '\n' ' '`
echo IMAGES $IMAGEID
docker image rmi -f $IMAGEID

# remove images in registry if necessary
#   log into https://hub.docker.com
#   https://hub.docker.com/repository/docker/lakemike/debian-duplicity-rclone/tags
#   click delete and confirm

