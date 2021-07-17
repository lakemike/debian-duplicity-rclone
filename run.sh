#!/bin/bash

MYUID=$(id -u)
MYGID=$(id -g)
mkdir -p     ./DOTconfig_rclone ./DOTgnupg ./RESTORE ./DOTcache_duplicity ./DOTssh
chown $MYUID ./DOTconfig_rclone ./DOTgnupg ./RESTORE ./DOTcache_duplicity ./DOTssh
chgrp $MYGID ./DOTconfig_rclone ./DOTgnupg ./RESTORE ./DOTcache_duplicity ./DOTssh
docker run --rm -it \
  -e UID=$MYUID \
  -e GID=$MYGID \
  -v /etc/localtime:/etc/localtime:ro \
  -v $PWD/RESTORE:/home/akito/RESTORE \
  -v $PWD/DOTssh:/home/akito/.ssh \
  -v $PWD/DOTgnupg:/home/akito/.gnupg \
  -v $PWD/DOTconfig_rclone:/home/akito/.config/rclone \
  -v $PWD/DOTcache_duplicity:/home/akito/.cache/duplicity \
  lakemike/debian-duplicity-rclone:buster-slim

exit

DOCKERID=`docker ps | grep debian-duplicity-rclone | awk '{print $1}'`
docker exec -it $DOCKERID /bin/bash


