#!/bin/bash

set -e

cd "$(dirname "$0")"

if ! ls ./dist.debian/mozc-server_*.deb 1> /dev/null 2>&1; then
    # Build mozc
    bash ./build.debian.sh
fi

sudo apt install ./dist.debian/mozc-server_*.deb --reinstall \
    && sudo apt-mark hold mozc-server
