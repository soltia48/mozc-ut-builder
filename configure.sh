#!/bin/bash

# Detect GNU/Linux
# Refered: https://stackoverflow.com/questions/394230/how-to-detect-the-os-from-a-bash-script
if [[ ! "$OSTYPE" == "linux-gnu"* ]]; then
    echo "This software for GNU/Linux only."
    exit
fi

# Detect distribution and version
# Refered: https://unix.stackexchange.com/questions/6345/how-can-i-get-distribution-name-and-version-number-in-a-simple-shell-script
if [ -f /etc/os-release ]; then
    # freedesktop.org and systemd
    . /etc/os-release
    export DISTRIBUTION=$NAME
    export DISTRIBUTION_VERSION=$VERSION_ID
elif type lsb_release >/dev/null 2>&1; then
    # linuxbase.org
    export DISTRIBUTION=$(lsb_release -si)
    export DISTRIBUTION_VERSION=$(lsb_release -sr)
elif [ -f /etc/lsb-release ]; then
    # For some versions of Debian/Ubuntu without lsb_release command
    . /etc/lsb-release
    export DISTRIBUTION=$DISTRIB_ID
    export DISTRIBUTION_VERSION=$DISTRIB_RELEASE
else
    echo "Unsupported distribution detected."
    exit
fi
