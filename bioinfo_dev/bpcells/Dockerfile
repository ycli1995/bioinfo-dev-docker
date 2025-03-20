ARG FROM_IMAGE=bioinfo_dev
ARG FROM_VERSION=1.0.0

FROM ycli1995/${FROM_IMAGE}:${FROM_VERSION}

ARG GITHUB_TOKEN

RUN echo -e "GITHUB_TOKEN=\"${GITHUB_TOKEN}"\" >> ~/.Renviron \
    && Rscript -e 'options(timeout = 100000);devtools::install_github("bnprks/BPCells/r", upgrade = "never", clean = TRUE)' \
    && Rscript -e 'options(timeout = 100000);devtools::install_github("satijalab/seurat-data", ref = "seurat5", upgrade = "never", clean = TRUE)' \
#    && Rscript -e 'options(timeout = 100000);devtools::install_github("satijalab/azimuth", ref = "seurat5", upgrade = "never", clean = TRUE)' \
    && Rscript -e 'options(timeout = 100000);devtools::install_github("satijalab/seurat-wrappers", ref = "seurat5", upgrade = "never", clean = TRUE)' \
#    && Rscript -e 'options(timeout = 100000);devtools::install_github("stuart-lab/signac", ref = "seurat5", upgrade = "never", clean = TRUE)' \
    && sed -i '/GITHUB_TOKEN=/d' ~/.Renviron

