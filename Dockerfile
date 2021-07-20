
ARG BASEIMG=bullseye-slim
FROM debian:${BASEIMG} AS base

# docker location: https://hub.docker.com/repository/docker/lakemike/debian-duplicity-rclone/general
# github location: https://github.com/lakemike/debian-duplicity-rclone

# java and cryptomator add ~100MB
ENV CRYPTOMATOR_INSTALLED=0
# avoids error messages
ARG DEBIAN_FRONTEND=noninteractive
# bugfix: https://github.com/debuerreotype/docker-debian-artifacts/issues/24
RUN mkdir -p /usr/share/man/man1 \
 && apt-get update \
 && apt-get --no-install-recommends --yes install apt-utils dialog wget curl \
       gosu procps toilet ca-certificates openssl openssh-client gnupg2 vim  \
       p7zip unzip duplicity rclone rsync syncthing \
 && rm -fr /var/lib/apt/lists/*

# NECESSARY FOR DUPLICITY 0.7x // NICE TO HAVE (UPDATED BACKEND) FOR DUPLICITY 0.8
WORKDIR /usr/lib/python3/dist-packages/duplicity/backends/
RUN wget https://raw.githubusercontent.com/lakemike/duplicity-rclone/master/rclonebackend.py
WORKDIR /usr/lib/python2.7/dist-packages/duplicity/backends/
RUN wget https://raw.githubusercontent.com/lakemike/duplicity-rclone/0.7.x/rclonebackend.py

RUN curl https://getcroc.schollz.com | bash

ARG DOCKER_USER=akito

RUN addgroup "$DOCKER_USER" \
 && adduser "$DOCKER_USER" --ingroup "$DOCKER_USER"

COPY files /

RUN chmod 0755 /entrypoint \
 && sed "s/\$DOCKER_USER/$DOCKER_USER/g" -i /entrypoint

VOLUME ["/home/akito/.gnupg", "/home/akito/.ssh", "/home/akito/.config/rclone", "/home/akito/.cache/duplicity", "/home/akito/RESTORE" ]

ENTRYPOINT ["/entrypoint"]


FROM base AS cryptomator

ENV CRYPTOMATOR_INSTALLED=1
RUN apt-get update \
 && apt-get --no-install-recommends --yes install default-jre-headless \
 && rm -fr /var/lib/apt/lists/*
WORKDIR /usr/bin
RUN wget https://github.com/cryptomator/cli/releases/download/0.4.0/cryptomator-cli-0.4.0.jar

