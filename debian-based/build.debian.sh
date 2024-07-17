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

if [ -n "$(docker ps -f "name=mozc-debian-build" -f "status=running" -q )" ]; then
    docker stop dict-build
fi

docker build -t mozc-debian -f ./Dockerfile.debian ./ --build-arg="DISTRIBUTION_TAG=$DISTRIBUTION_TAG" \
docker create -it --rm --name mozc-debian-build mozc-debian
docker start mozc-debian-build

# Build mozc
docker cp ../mozcdic-ut-builder/dist/mozcdic-ut.txt mozc-debian-build:/tmp/mozc-ut/mozcdic-ut.txt
docker exec mozc-debian-build ./scripts/download-src.sh
docker exec mozc-debian-build ./scripts/build-mozc.sh

# Copy built assets
mkdir -p ./dist.debian/
rm -f ./dist.debian/*
for f in $(docker exec mozc-debian-build bash -c "ls /tmp/mozc-ut/*.deb"); do
    docker cp mozc-debian-build:`echo $f | sed 's/\r//g'` ./dist.debian/
done

docker stop mozc-debian-build
