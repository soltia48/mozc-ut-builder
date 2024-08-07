#!/bin/bash

set -e

cd ./mozc-*/ \
    && cat ../mozcdic-ut.txt >> ./src/data/dictionary_oss/dictionary00.txt \
    && dpkg-buildpackage -b -us -uc
