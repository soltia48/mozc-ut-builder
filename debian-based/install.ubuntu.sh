#!/bin/bash

set -e

cd "$(dirname "$0")"

if ! ls ./dist.ubuntu/mozc-server_*.deb 1> /dev/null 2>&1; then
    # Build mozc
    bash ./build.ubuntu.sh
fi

sudo apt -y install ./dist.ubuntu/mozc-server_*.deb --reinstall --allow-change-held-packages \
    && sudo apt-mark hold mozc-server
