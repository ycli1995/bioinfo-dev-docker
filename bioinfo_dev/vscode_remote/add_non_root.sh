#!/bin/bash
set -e

build_dir=/

### https://github.com/rocker-org/rocker-versioned2/blob/master/scripts/install_jupyter.sh

## build ARGs
NB_USER=${DEFAULT_USER:-"mydocker"}

# a function to install apt packages only if they are not installed
function apt_install() {
# For the god damn Chinese GREAT WALL !!!!!!!!!!!!!!!!!!!!!!
    my_proxy=$HTTP_PROXY
    if [ -n $my_proxy ]; then
        echo "Use proxy: $my_proxy"
        echo -e "Acquire::http::Proxy \"${my_proxy}\";\nAcquire::https::Proxy \"${my_proxy}\";" | tee -a /etc/apt/apt.conf.d/proxy.conf > /dev/null;
    fi
    if ! dpkg -s "$@" >/dev/null 2>&1; then
        if [ "$(find /var/lib/apt/lists/* | wc -l)" = "0" ]; then
            apt-get update
        fi
        apt-get install -y --no-install-recommends "$@"
    fi
    rm -rf /etc/apt/apt.conf.d/proxy.conf
}

apt_install git libzmq3-dev sudo openssh-server openssh-client

mkdir -p /var/run/sshd \
    && ssh-keygen -N '' -t rsa -f /etc/ssh/ssh_host_rsa_key <<< y \
    && ssh-keygen -N '' -t dsa -f /etc/ssh/ssh_host_dsa_key <<< y

/bin/sed -i 's/.*session.*required.*pam_loginuid.so.*/session optional pam_loginuid.so/g' /etc/pam.d/sshd

# set up the default user if it does not exist
if ! id -u "${NB_USER}" >/dev/null 2>&1; then
    bash ${build_dir}/default_user.sh "${NB_USER}"
fi

echo "${NB_USER}:${NB_USER}" | chpasswd 

# Clean up
rm -rf /var/lib/apt/lists/*
rm -rf /tmp/downloaded_packages /tmp/Rtmp*

