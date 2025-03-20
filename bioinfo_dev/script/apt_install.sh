#!/bin/bash
set -e

# For the god damn Chinese GREAT WALL !!!!!!!!!!!!!!!!!!!!!!
my_proxy=$HTTP_PROXY
if [ -n $my_proxy ]; then
    echo "Use proxy: $my_proxy"
    echo -e "Acquire::http::Proxy \"${my_proxy}\";\nAcquire::https::Proxy \"${my_proxy}\";" | tee -a /etc/apt/apt.conf.d/proxy.conf > /dev/null;
fi
if ! dpkg -s "$@" > /dev/null 2>&1; then
    if [ "$(find /var/lib/apt/lists/* | wc -l)" = "0" ]; then
        apt-get update
    fi
#    for i in $@; do apt-get install -y --no-install-recommends "$i"; sleep 10; done
    apt-get install -y --no-install-recommends $@
    apt-get install -y --no-install-recommends $@
fi
rm -rf /etc/apt/apt.conf.d/proxy.conf

