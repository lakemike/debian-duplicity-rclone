FROM debian:buster-slim

# avoids error messages
ARG DEBIAN_FRONTEND=noninteractive
# bugfix: https://github.com/debuerreotype/docker-debian-artifacts/issues/24
RUN mkdir -p /usr/share/man/man1

RUN apt-get update && apt-get --no-install-recommends --yes upgrade
RUN apt-get --yes install apt-utils dialog
RUN apt-get --no-install-recommends --yes install gosu \
       ca-certificates openssl openssh-client gnupg2 vim p7zip unzip \
       duplicity rclone rsync wget curl default-jdk

WORKDIR /usr/bin
RUN wget https://github.com/cryptomator/cli/releases/download/0.4.0/cryptomator-cli-0.4.0.jar

ARG DOCKER_USER=akito

RUN addgroup "$DOCKER_USER" \
 && adduser "$DOCKER_USER" --ingroup "$DOCKER_USER"

COPY files /

RUN chmod 0755 /entrypoint \
 && sed "s/\$DOCKER_USER/$DOCKER_USER/g" -i /entrypoint

VOLUME ["/home/akito/.gnupg", "/home/akito/.ssh", "/home/akito/.config/rclone", "/home/akito/.cache/duplicity", "/home/akito/RESTORE" ]

# Brief check that it works.
RUN duplicity --version
RUN rclone --version
RUN /usr/bin/java -version
RUN ls /usr/bin/crypto*jar

ENTRYPOINT ["/entrypoint"]
