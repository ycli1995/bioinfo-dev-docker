#!/bin/bash
set -e

BUILD_SOURCE_DIR=${BUILD_SOURCE_DIR:-/build/}

bash ${BUILD_SOURCE_DIR}/script/install_emsdk.sh

npm i -g webr
