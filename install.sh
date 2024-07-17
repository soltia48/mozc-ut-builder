#!/bin/bash

cd "$(dirname "$0")"

source ./configure.sh

if [[ "$DISTRIBUTION" == "Debian" ]]; then
    export DISTRIBUTION_TAG=$DISTRIBUTION_VERSION
    bash ./debian-based/install.debian.sh
elif [[ "$DISTRIBUTION" == "Ubuntu" ]]; then
    export DISTRIBUTION_TAG=$DISTRIBUTION_VERSION
    bash ./debian-based/install.ubuntu.sh
else
    echo "Unsupported distribution $DISTRIBUTION detected."
    exit
fi
