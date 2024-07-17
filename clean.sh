#!/bin/bash

cd "$(dirname "$0")"

source ./configure.sh

bash ./mozcdic-ut-builder/clean.sh
bash ./debian-based/clean.sh
