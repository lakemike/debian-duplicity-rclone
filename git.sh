#!/bin/sh

docker run -v $PWD:/local bitnami/git:latest git -C /local $*

