#!/bin/bash

# Build debian image based on
#  - bullseye-slim (debian)
#  - duplicity
#  - rclone
#  - java
#  - Cryptomator

PROJECT="lakemike/debian-duplicity-rclone"
DATE=`date '+%Y-%m-%d'`
docker login

BASEIMG="buster-slim"
docker build --build-arg BASEIMG=$BASEIMG \
  --target base -t $PROJECT:$BASEIMG-$DATE -t $PROJECT:$BASEIMG .

BASEIMG="bullseye-slim"
docker build --build-arg BASEIMG=$BASEIMG \
  --target base -t $PROJECT:$BASEIMG-$DATE -t $PROJECT:$BASEIMG -t $PROJECT:latest .
docker build --build-arg BASEIMG=$BASEIMG \
  --target cryptomator -t $PROJECT:$BASEIMG-cryptomator-$DATE -t $PROJECT:latest-cryptomator .
docker push --all-tags $PROJECT
docker images | grep "$PROJECT"

