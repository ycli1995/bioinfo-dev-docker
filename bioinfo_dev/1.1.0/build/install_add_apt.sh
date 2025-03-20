#!/bin/bash
set -e

APT_PACKAGES=""

# a function to install apt packages only if they are not installed
function apt_install() {
    if ! dpkg -s "$@" > /dev/null 2>&1; then
        if [ "$(find /var/lib/apt/lists/* | wc -l)" = "0" ]; then
            apt-get update
        fi
        apt-get install -y --no-install-recommends "$@"
    fi
}

echo -e "\n>>>>> Install additional apt packages...\n"
apt_install ${APT_PACKAGES}
echo -e ">>>>> Done\n"

