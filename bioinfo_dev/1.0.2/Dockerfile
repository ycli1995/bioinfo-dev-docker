ARG FROM_IMAGE=ubuntu
ARG FROM_VERSION=22.04.3

FROM ycli1995/${FROM_IMAGE}:${FROM_VERSION}

ARG GITHUB_TOKEN

ARG IMAGE_VERSION=1.0.1
ARG SAMTOOLS_VERSION=1.17
ARG CRAN_LINUX_VERSION=cran40
ARG R_VERSION=4.3

ENV BUILD_SOURCE_DIR=/build/

ENV TZ=Asia/Shanghai

ENV DEBIAN_FRONTEND=noninteractive
ENV TERM=xterm

# Copy sources and scripts for building
COPY ${IMAGE_VERSION}/build/ ${BUILD_SOURCE_DIR}
COPY script ${BUILD_SOURCE_DIR}/script

# Set up locales
RUN bash ${BUILD_SOURCE_DIR}/script/set_locales.sh
ENV LC_ALL=en_US.UTF-8
ENV LANG=en_US.UTF-8

# Set up fonts
COPY source/helvetica/*.ttf /usr/share/fonts/truetype/myfonts/
RUN bash ${BUILD_SOURCE_DIR}/script/set_fonts.sh /usr/share/fonts/truetype/myfonts/

# Set ENV for R
ENV CRAN=https://cloud.r-project.org/
ENV CRAN_LINUX_VERSION=${CRAN_LINUX_VERSION}
ENV R_VERSION=${R_VERSION}
ENV R_HOME=/usr/lib/R

# Set ENV for reticulate
ENV RETICULATE_AUTOCONFIGURE=0
ENV RETICULATE_MINICONDA_ENABLED=FALSE

# Install apt softwares
RUN bash ${BUILD_SOURCE_DIR}/script/install_apt_pkgs.sh \
    && bash ${BUILD_SOURCE_DIR}/script/install_R_ppa.sh \
    && bash ${BUILD_SOURCE_DIR}/script/install_python.sh \
    && bash ${BUILD_SOURCE_DIR}/script/apt_install.sh libmlpack-dev mlpack-bin \
    && bash ${BUILD_SOURCE_DIR}/script/install_bioperl.sh \
    && bash ${BUILD_SOURCE_DIR}/script/install_samtools.sh ${SAMTOOLS_VERSION} \
    && bash ${BUILD_SOURCE_DIR}/install_add_apt.sh \
    && bash ${BUILD_SOURCE_DIR}/script/clean_install.sh

# Install additional python modules
ENV NUMBA_CACHE_DIR=/tmp/
RUN bash ${BUILD_SOURCE_DIR}/install_pip.sh \
    && bash ${BUILD_SOURCE_DIR}/script/clean_install.sh \
    && bash ${BUILD_SOURCE_DIR}/script/check_reticulate.sh

# Set ENV for R package 'basilisk'
ENV BASILISK_USE_SYSTEM_DIR=1
ENV BASILISK_NO_FALLBACK_R=1

# Install additional R packages
RUN bash ${BUILD_SOURCE_DIR}/install_r_pkgs.sh ${GITHUB_TOKEN} \
    && bash ${BUILD_SOURCE_DIR}/script/install_webR.sh \
    && bash ${BUILD_SOURCE_DIR}/script/clean_install.sh \
    && bash ${BUILD_SOURCE_DIR}/script/check_reticulate.sh

