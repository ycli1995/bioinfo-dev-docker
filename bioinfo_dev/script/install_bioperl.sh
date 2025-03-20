#!/bin/bash
set -e

BUILD_SOURCE_DIR=${BUILD_SOURCE_DIR:-/build/}

apt-get update

echo -e "\n>>>>> Install bioperl...\n"
apt install -y bioperl
echo -e "$finish"

bash ${BUILD_SOURCE_DIR}/script/clean_install.sh

