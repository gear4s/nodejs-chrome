#!/bin/sh

docker container run --rm --entrypoint '' ${IMAGE_NAME:-aquelle1/nodejs-chrome} cat /etc/lsb-release
docker container run --rm --entrypoint '' ${IMAGE_NAME:-aquelle1/nodejs-chrome} google-chrome --version