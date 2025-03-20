#!/bin/bash
set -e

echo -e "\n>>>>> Check pip3...\n"
which pip3
echo -e "\n\n"

pip3_install="pip3 install --timeout=10000 --retries=10000 --no-cache-dir"

$pip3_install -U pip setuptools

$pip3_install phate cython \
    && $pip3_install git+https://github.com/bioFAM/mofapy2 \
    && $pip3_install bbknn \
    && $pip3_install anndata2ri \
    && $pip3_install cello-classify \
    && $pip3_install celltypist \
    && $pip3_install cna \
    && $pip3_install cutadapt \
    && $pip3_install diopy \
    && $pip3_install doubletdetection \
    && $pip3_install dropkick \
    && $pip3_install episcanpy \
    && $pip3_install harmonypy \
    && $pip3_install infercnvpy \
    && $pip3_install 'ivis[cpu]' \
    && $pip3_install mlpack \
    && $pip3_install muon \
    && $pip3_install palantir \
    && $pip3_install paste-bio \
    && $pip3_install PhenoGraph \
    && $pip3_install sam-algorithm \
    && $pip3_install scanorama \
    && $pip3_install scanpy \
    && $pip3_install scarches \
    && $pip3_install sccoda \
    && $pip3_install scglue \
    && $pip3_install scirpy \
    && $pip3_install scplot \
    && $pip3_install scrublet \
    && $pip3_install scvi-tools \
    && $pip3_install sinto \
    && $pip3_install ktplotspy \
    && $pip3_install multiprocess \
    && $pip3_install secuer \
    && $pip3_install spatialde \
    && $pip3_install squidpy \
    && $pip3_install swan_vis \
    && $pip3_install tiledb \
    && $pip3_install 'tiledb-ml[full]' \
    && $pip3_install trimap \
    && $pip3_install velocyto \
    && $pip3_install cellrank \
    && $pip3_install git+https://github.com/u1234x1234/pyspectra \
    && $pip3_install git+https://github.com/lyc-1995/sccaf.git@bae615d

$pip3_install --force-reinstall --ignore-installed cython macs3

$pip3_install --upgrade anndata numpy pandas numba xarray

not_run(){
echo -e "\n>>>>> Check the binary files install with pip3 ...\n"
for i in cutadapt dropkick macs3 velocyto; do
    echo -e "###### ${i} ================="
    ${i} --version
    echo -e "###### ${i} done!\n"
done

for i in cello_predict celltypist scanpy scdior sinto spatialde; do
    echo -e "###### ${i} ================="
    ${i} --help
    echo -e "###### ${i} done!\n"
done
}
