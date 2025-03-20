#!/bin/bash
set -e

build_dir=/

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

apt_install clang-format gdb

# Clean up
rm -rf /var/lib/apt/lists/*
rm -rf /tmp/downloaded_packages /tmp/Rtmp*


