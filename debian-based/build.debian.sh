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

# Copy the dictionary
cp -f ../mozcdic-ut-builder/dist/mozcdic-ut.txt ./

mkdir -p ./dist.debian/
docker build -t mozc-ut-debian -f ./Dockerfile.debian ./ --build-arg="DISTRIBUTION_TAG=$DISTRIBUTION_TAG" -o ./dist.debian/
