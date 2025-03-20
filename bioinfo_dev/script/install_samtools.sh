#!/bin/bash
set -e

SAMTOOLS_VERSION=${1:-$SAMTOOLS_VERSION}

cd $HOME \
    && wget -c https://github.com/samtools/samtools/releases/download/${SAMTOOLS_VERSION}/samtools-${SAMTOOLS_VERSION}.tar.bz2 \
    && tar jxf samtools-${SAMTOOLS_VERSION}.tar.bz2 \
    && cd samtools-${SAMTOOLS_VERSION} \
    && ./configure \
    && make \
    && make install \
    && make clean \
    && cd $HOME \
    && rm -fr samtools-${SAMTOOLS_VERSION}*

cd $HOME \
    && wget -c https://github.com/samtools/htslib/releases/download/${SAMTOOLS_VERSION}/htslib-${SAMTOOLS_VERSION}.tar.bz2 \
    && tar jxf htslib-${SAMTOOLS_VERSION}.tar.bz2 \
    && cd htslib-${SAMTOOLS_VERSION} \
    && autoreconf -i \
    && ./configure \
    && make \
    && make install \
    && make clean \
    && cd $HOME \
    && rm -fr htslib-${SAMTOOLS_VERSION}*

cd $HOME \
    && wget -c https://github.com/samtools/bcftools/releases/download/${SAMTOOLS_VERSION}/bcftools-${SAMTOOLS_VERSION}.tar.bz2 \
    && tar jxf bcftools-${SAMTOOLS_VERSION}.tar.bz2 \
    && cd bcftools-${SAMTOOLS_VERSION} \
    && ./configure \
    && make \
    && make install \
    && make clean \
    && cd $HOME \
    && rm -fr bcftools-${SAMTOOLS_VERSION}*

echo -e "\n>>>>> Check the binaries...\n"
for i in bcftools samtools; do
    echo -e "###### ${i} ================="
    ${i} --version
    echo -e "\n###### ${i} done!\n"
done

