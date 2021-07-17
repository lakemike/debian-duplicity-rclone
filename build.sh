#!/bin/bash

# Build debian image based on
#  - buster-slim (debian)
#  - duplicity
#  - rclone
#  - java
#  - Cryptomator

DATE=`date '+%Y-%m-%d'`
docker login
# requires Dockerfile
docker build -t lakemike/debian-duplicity-rclone:buster-slim \
  -t lakemike/debian-duplicity-rclone:latest \
  -t lakemike/debian-duplicity-rclone:stable \
  -t "lakemike/debian-duplicity-rclone:stable-$DATE" .
docker push --all-tags lakemike/debian-duplicity-rclone

