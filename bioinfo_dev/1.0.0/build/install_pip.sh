#!/bin/bash
set -e

echo -e "\n>>>>> Check pip3...\n"
which pip3
echo -e "\n\n"

pip3_install="pip3 install --timeout=10000 --retries=10000 --no-cache-dir"

$pip3_install phate \
    && $pip3_install git+https://github.com/bhargavchippada/forceatlas2 \
    && $pip3_install \
        anndata2ri \
        bbknn \
        cello-classify \
        celltypist \
        cna \
        cutadapt \
        diopy \
        doubletdetection \
        dropkick \
        episcanpy \
	harmonypy \
        infercnvpy \
        'ivis[cpu]' \
        macs3 \
	mlpack \
        mofapy2 \
        muon \
        palantir \
        paste-bio \
        PhenoGraph \
        sam-algorithm \
        scanorama \
        scarches \
        sccoda \
        scglue \
        scirpy \
	scplot \
        scrublet \
        scvi-tools \
        sinto \
    && $pip3_install \
        ktplotspy \
        multiprocess \
	secuer \
        spatialde \
        squidpy \
        swan_vis \
        tiledb \
        'tiledb-ml[full]' \
        trimap \
        velocyto \
    && $pip3_install git+https://github.com/theislab/cellrank \
    && $pip3_install git+https://github.com/u1234x1234/pyspectra.git@0.0.2 \
    && $pip3_install git+https://github.com/lyc-1995/sccaf.git@bae615d \
    && $pip3_install --upgrade anndata numpy pandas numba==0.56.4 xarray

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
