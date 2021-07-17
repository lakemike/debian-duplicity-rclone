#!/bin/bash

mkdir -p ./DIR_gnupg ./DIR_RESTORE ./DIR_cache_duplicity
MYUID=$(id -u)
MYGID=$(id -g)
chown $MYUID.$MYGID ./DIR_gnupg ./DIR_RESTORE ./DIR_cache_duplicity
docker run --rm -it \
  -e UID=$MYUID \
  -e GID=$MYGID \
  -v /etc/localtime:/etc/localtime:ro \
  -v $PWD/DIR_gnupg:/home/akito/.gnupg \
  -v $PWD/DIR_RESTORE:/home/akito/RESTORE \
  -v $PWD/DIR_cache_duplicity:/home/akito/.cache/duplicity \
  lakemike/debian-duplicity-rclone:buster-slim

exit

DOCKERID=`docker ps | grep debian-duplicity-rclone | awk '{print $1}'`
docker exec -it $DOCKERID /bin/bash


