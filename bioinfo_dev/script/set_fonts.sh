#!/bin/bash
set -e

BUILD_SOURCE_DIR=${BUILD_SOURCE_DIR:-/build/}

FONTS_DIR=${1:-/usr/share/fonts/truetype/myfonts/}

echo -e "\n>>>>> Install apt packages...\n"
bash ${BUILD_SOURCE_DIR}/script/apt_install.sh fontconfig
echo -e ">>>>> Done\n"

fc-cache -f -v $FONTS_DIR

bash ${BUILD_SOURCE_DIR}/script/clean_install.sh

