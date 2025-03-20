#!/bin/bash
set -e

BUILD_SOURCE_DIR=${BUILD_SOURCE_DIR:-/build/}

### https://github.com/rocker-org/rocker-versioned2/blob/master/scripts/install_python.sh

bash ${BUILD_SOURCE_DIR}/script/apt_install.sh \
    libpng-dev \
    libpython3-dev \
    python3-dev \
    python3-pip \
    python3-venv \
    swig

which python3

# python3 -m pip --no-cache-dir install --upgrade pip

# Some TF tools expect a "python" binary
if [ ! -e /usr/local/bin/python ]; then
    ln -s "$(which python3)" /usr/local/bin/python
fi

Rscript ${BUILD_SOURCE_DIR}/script/install_Rpkgs.R reticulate

bash ${BUILD_SOURCE_DIR}/script/clean_install.sh

bash ${BUILD_SOURCE_DIR}/script/check_reticulate.sh

