#!/bin/bash
set -e

BUILD_SOURCE_DIR=${BUILD_SOURCE_DIR:-/build/}

APT_PACKAGES="autoconf \
        automake \
        binutils-dev \
        bzip2 \
	clang \
        cmake \
        curl \
        cython3 \
	g++ \
	gcc \
	gfortran \
        git \
        gnupg2 \
        graphviz-dev \
        hdf5-tools \
        imagemagick \
        libarmadillo-dev \
        libblas-dev \
        libblas64-dev \
        libboost-dev \
        libboost-filesystem-dev \
        libboost-system-dev \
        libboost-math-dev \
        libboost-serialization-dev \
        libboost-test-dev \
        libbz2-dev \
        libcairo2-dev \
	libclang-dev \
        libcurl4-openssl-dev \
        libeigen3-dev \
        libensmallen-dev \
        libfftw3-dev \
        libfribidi-dev \
        libgdal-dev \
        libgit2-dev \
        libgmp3-dev \
        libgsl-dev \
        libharfbuzz-dev \
        libhdf5-dev \
        libigraph-dev \
        liblapack-dev \
        liblapack64-dev \
        liblzma-dev \
        libmagick++-dev \
        libmpfr-dev \
        libncurses5-dev \
        libopenblas-dev \
        libopenblas-openmp-dev \
        libopenblas64-dev \
        libopenblas64-openmp-dev \
        libopenmpi-dev \
	libomp-dev \
        libpng-dev \
        libpoppler-cpp-dev \
        libsodium-dev \
        libssl-dev \
        libstb-dev \
        libsuperlu-dev \
        libtool \
        libudunits2-dev \
        libv8-dev \
        libxml2-dev \
        libxt-dev \
	llvm-dev \
        lz4 \
        jags \
        make \
        openjdk-11-jdk \
        pandoc \
        parallel \
        perl \
        python3-dev \
        python3-pip \
        software-properties-common \
        texlive-latex-extra \
        txt2man \
        unzip \
        wget \
        xz-utils \
        zlib1g-dev"

echo -e "\n>>>>> Install apt packages...\n"
bash ${BUILD_SOURCE_DIR}/script/apt_install.sh ${APT_PACKAGES}
echo -e ">>>>> Done\n"

echo -e "\n>>>>> Install microsoft ttf...\n"
echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | debconf-set-selections \
    && bash ${BUILD_SOURCE_DIR}/script/apt_install.sh ttf-mscorefonts-installer
echo -e ">>>>> Done\n"

bash ${BUILD_SOURCE_DIR}/script/install_node.sh

bash ${BUILD_SOURCE_DIR}/script/clean_install.sh

