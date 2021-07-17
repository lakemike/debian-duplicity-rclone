#!/bin/bash

# PRUNE
# manage local images if necessary
docker image ls
docker image prune -f
IMAGEID=`docker images | grep -m1 debian-duplicity-rclone | awk '{print $3}'`
docker image rmi -f $IMAGEID

# remove images in registry if necessary
#   log into https://hub.docker.com
#   https://hub.docker.com/repository/docker/lakemike/debian-duplicity-rclone/tags
#   click delete and confirm

