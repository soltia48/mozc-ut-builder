#!/bin/bash

set -e

cd "$(dirname "$0")"

if [ -z ${DISTRIBUTION_TAG} ]; then
    DISTRIBUTION_TAG=latest
fi

if [ ! -f "../mozcdic-ut-builder/dist/mozcdic-ut.txt" ]; then
    # Build dict
    bash ../mozcdic-ut-builder/build.sh
fi

if [ -n "$(docker ps -f "name=mozc-ubuntu-build" -f "status=running" -q )" ]; then
    docker stop dict-build
fi

docker build -t mozc-ubuntu -f ./Dockerfile.ubuntu ./ --build-arg="DISTRIBUTION_TAG=$DISTRIBUTION_TAG"
docker create -it --rm --name mozc-ubuntu-build mozc-ubuntu
docker start mozc-ubuntu-build

# Build mozc
docker cp ../mozcdic-ut-builder/dist/mozcdic-ut.txt mozc-ubuntu-build:/tmp/mozc-ut/mozcdic-ut.txt
docker exec mozc-ubuntu-build ./scripts/download-src.sh
docker exec mozc-ubuntu-build ./scripts/build-mozc.sh

# Copy built assets
mkdir -p ./dist.ubuntu/
rm -f ./dist.ubuntu/*
for f in $(docker exec mozc-ubuntu-build bash -c "ls /tmp/mozc-ut/*.deb"); do
    docker cp mozc-ubuntu-build:`echo $f | sed 's/\r//g'` ./dist.ubuntu/
done

docker stop mozc-ubuntu-build
