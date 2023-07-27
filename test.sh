#!/bin/sh

docker container run --rm --entrypoint '' ${IMAGE_NAME:-aquelle1/nodejs-chrome} cat /etc/alpine-release
docker container run --rm --entrypoint '' ${IMAGE_NAME:-aquelle1/nodejs-chrome} chromium-browser --version