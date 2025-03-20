#!/bin/bash
set -e

build_dir=/install_jupyter/

### https://github.com/rocker-org/rocker-versioned2/blob/master/scripts/install_jupyter.sh

## build ARGs
NB_USER=${DEFAULT_USER:-"mydocker"}

# a function to install apt packages only if they are not installed
function apt_install() {
    if ! dpkg -s "$@" >/dev/null 2>&1; then
        if [ "$(find /var/lib/apt/lists/* | wc -l)" = "0" ]; then
            apt-get update
        fi
        apt-get install -y --no-install-recommends "$@"
    fi
}

apt_install git libzmq3-dev sudo

# set up the default user if it does not exist
if ! id -u "${NB_USER}" >/dev/null 2>&1; then
    bash ${build_dir}/default_user.sh "${NB_USER}"
fi

pip3 install --no-cache-dir jupyter jupyter-rsession-proxy jupyterlab notebook
pip3 install lckr-jupyterlab-variableinspector jupyterlab-code-formatter

pip3 config set global.index-url https://mirrors.aliyun.com/pypi/simple/

Rscript -e 'remotes::install_github("IRkernel/IRkernel@*release")'
Rscript -e 'IRkernel::installspec(user = FALSE)'

#echo -e ".jp-InputArea-prompt {\n\tflex: none;\n\twidth: 10px;\n\ttext-indent: 100%;\n}" >> /usr/local/share/jupyter/lab/themes/@jupyterlab/theme-light-extension/index.css

echo "${NB_USER}:${NB_USER}" | chpasswd \
    && jupyter server extension enable jupyterlab_code_formatter

# Clean up
rm -rf /var/lib/apt/lists/*
rm -rf /tmp/downloaded_packages /tmp/Rtmp*

## Strip binary installed lybraries from RSPM
## https://github.com/rocker-org/rocker-versioned2/issues/340
#strip /usr/local/lib/R/site-library/*/libs/*.so

# Check jupyter
echo -e "Check the avalable jupyter kernels...\n"

jupyter kernelspec list

echo -e "\nInstall jupyter, done!"

