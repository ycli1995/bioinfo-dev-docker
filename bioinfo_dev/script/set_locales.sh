#!/bin/bash
set -e

BUILD_SOURCE_DIR=${BUILD_SOURCE_DIR:-/build/}

CURRENT_LANG=${LANG:-en_US.UTF-8}
CURRENT_LC_ALL=${LC_ALL:-en_US.UTF-8}

echo -e "\n>>>>> Install apt packages...\n"
bash ${BUILD_SOURCE_DIR}/script/apt_install.sh locales
echo -e ">>>>> Done\n"

locale-gen $CURRENT_LANG \
    && update-locale LC_ALL=${CURRENT_LC_ALL} LANG=${CURRENT_LANG}

bash ${BUILD_SOURCE_DIR}/script/clean_install.sh

