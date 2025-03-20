#!/bin/bash
set -e

BUILD_SOURCE_DIR=${BUILD_SOURCE_DIR:-/build/}

### https://github.com/rocker-org/rocker-versioned2/blob/master/scripts/install_R_ppa.sh

CRAN_LINUX_VERSION=${CRAN_LINUX_VERSION:-cran40}
LANG=${LANG:-en_US.UTF-8}
LC_ALL=${LC_ALL:-en_US.UTF-8}
DEBIAN_FRONTEND=${DEBIAN_FRONTEND:-noninteractive}

# Set up and install R
R_HOME=${R_HOME:-/usr/lib/R}

#R_VERSION=${R_VERSION}

bash ${BUILD_SOURCE_DIR}/script/apt_install.sh ca-certificates \
      less \
      locales \
      lsb-release \
      software-properties-common \
      vim-tiny \
      wget \
      dirmngr \
      gpg \
      gpg-agent

UBUNTU_VERSION=${UBUNTU_VERSION:-$(lsb_release -cs)}

#echo "deb http://cloud.r-project.org/bin/linux/ubuntu ${UBUNTU_VERSION}-${CRAN_LINUX_VERSION}/" >> /etc/apt/sources.list

#gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
#gpg -a --export E298A3A825C0D65DFD57CBB651716619E084DAB9 | apt-key add -

wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc
add-apt-repository -y "deb https://cloud.r-project.org/bin/linux/ubuntu ${UBUNTU_VERSION}-${CRAN_LINUX_VERSION}/"

# Wildcard * at end of version will grab (latest) patch of requested version
echo "R_VERSION: ${R_VERSION}"
if [ ${R_VERSION} -a -z ${R_VERSION} ]; then
    r_base=r-base=${R_VERSION}*
else 
    r_base=r-base
fi
echo "r-base: $r_base"
apt-get update && apt-get -y install --no-install-recommends $r_base

Rscript -e 'update.packages(ask = FALSE)'

## Add PPAs: NOTE this will mean that installing binary R packages won't be version stable.
##
## These are required at least for bionic-based images since 3.4 r binaries are

#echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
#locale-gen en_US.utf8
#/usr/sbin/update-locale LANG=${LANG}

#Rscript -e "install.packages(c('BiocManager', 'devtools', 'docopt', 'littler'), clean = TRUE, dependency = FALSE)"
Rscript -e "install.packages('BiocManager', clean = TRUE, dependency = FALSE)"
Rscript ${BUILD_SOURCE_DIR}/script/install_Rpkgs.R devtools docopt littler

## By default R_LIBS_SITE is unset, and defaults to this, so this is where `littler` will be.
## We set it here for symlinks, but don't make the env var persist (since it's already the default)
R_LIBS_SITE=/usr/local/lib/R/site-library
ln -s ${R_LIBS_SITE}/littler/examples/install.r /usr/local/bin/install.r
ln -s ${R_LIBS_SITE}/littler/examples/install2.r /usr/local/bin/install2.r
ln -s ${R_LIBS_SITE}/littler/examples/installGithub.r /usr/local/bin/installGithub.r
ln -s ${R_LIBS_SITE}/littler/bin/r /usr/local/bin/r

bash ${BUILD_SOURCE_DIR}/script/clean_install.sh

