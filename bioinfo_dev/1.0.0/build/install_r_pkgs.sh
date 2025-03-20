#!/bin/bash
set -e

BUILD_SOURCE_DIR=${BUILD_SOURCE_DIR:-/build/}

GITHUB_TOKEN=$1

CRAN_BASE="anndata \
    apisensr \
    autoplotly \
    autoReg \
    bartcs \
    BayesPostEst \
    bigalgebra \
    bigsnpr \
    bruceR \
    CliquePercolation \
    clusterCrit \
    corx \
    CoSMoS \
    diffusionMap \
    dirttee \
    distrDoc \
    doMC \
    DoubleML \
    dynfeature \
    dyngen \
    dynplot \
    easypackages \
    easystats \
    emstreeR \
    exploratory \
    gateR \
    ggalignment \
    ggblanket \
    ggbump \
    ggdensity \
    ggFishPlots \
    ggheatmap \
    ggHoriPlot \
    gglm \
    ggmuller \
    ggmulti \
    ggpath \
    ggpcp \
    ggpie \
    ggplot2.utils \
    ggTimeSeries \
    ggtrace \
    hdf5r.Extra \
    immunarch \
    L1pack \
    lle \
    miRNAss \
    MLDataR \
    mlr3shiny \
    mlr3spatial \
    mlr3spatiotempcv \
    mlr3verse \
    motifr \
    Multiaovbay \
    MVT \
    MXM \
    PFIM \
    pirouette \
    plotbb \
    predict3d \
    rhub \
    Riemann \
    RKorAPClient \
    R2BayesX \
    R6causal \
    R62S3 \
    scapGNN \
    scCATCH \
    shinyML \
    shinyrecipes \
    slasso \
    sMSROC \
    sodium \
    superml \
    TDAvec \
    text2sdg \
    tidyCDISC \
    tidyCpp \
    tidydr \
    tidytable \
    transPlotR \
    TreeDimensionTest \
    treemapify \
    typed"

#CRAN_BASE=`echo $CRAN_BASE | sed "s/ /' ,'/g" | sed "s/^/'/g" | sed "s/$/'/g"`

BIOC_BASE="ADImpute \
    AgiMicroRna \
    airpart \
    alevinQC \
    ASpli \
    ASURAT \
    ATACCoGAPS \
    BaalChIP \
    bandle \
    barcodetrackR \
    BASiCStan \
    BatchQC \
    cageminer \
    ccImpute \
    celaref \
    CellaRepertorium \
    CellBench \
    CelliD \
    cellity \
    CellMixS \
    CellTrails \
    CEMiTool \
    censcyt \
    CeTF \
    ChAMP \
    CHETAH \
    chihaya \
    ChIPQC \
    chromswitch \
    circRNAprofiler \
    ClassifyR \
    ClusterSignificance \
    clustifyr \
    COCOA \
    cogena \
    COMPASS \
    compartmap \
    ctgGEM \
    DegNorm \
    derfinderPlot \
    DEScan2 \
    DESpace \
    DifferentialRegulation \
    doubletrouble \
    easier \
    EGSEA \
    enrichTF \
    epidecodeR \
    epigraHMM \
    esATAC \
    escape \
    escheR \
    EWCE \
    ExpHunterSuite \
    extraChIPs \
    factR \
    famat \
    ffpe \
    GEOquery \
    ggmsa \
    ggspavis \
    ggtreeDendro \
    GmicR \
    GOfuncR \
    granulator \
    GSEAmining \
    gsean \
    GWENA \
    hermes \
    IgGeneUsage \
    ILoReg \
    IMAS \
    ImmuneSpaceR \
    immunotation \
    infercnv \
    interacCircos \
    IRISFGM \
    maEndToEnd \
    mahmoudibrahim/genesorteR \
    memes \
    MetaNeighbor \
    MetNet \
    mfa \
    microbiomeMarker \
    MicrobiotaProcess \
    MineICA \
    miloR \
    miQC \
    mirIntegrator \
    miRLAB \
    miRSM \
    mistyR \
    MOFA2 \
    MOMA \
    Motif2Site \
    multiSight \
    mumosa \
    muscat \
    musicatk \
    NADfinder \
    nempi \
    netboost \
    netSmooth \
    NormalyzerDE \
    ODER \
    OGRE \
    OmicCircos \
    OMICsPCA \
    openPrimeR \
    phemd \
    POMA \
    POWSC \
    RcisTarget \
    RegEnrich \
    RNAAgeCalc \
    RTCGAToolbox \
    RTNsurvival \
    SCATE \
    scBFA \
    scCB2 \
    scClassify \
    scDataviz \
    scDD \
    scHOT \
    scmap \
    scone \
    scp \
    scRecover \
    scruff \
    scry \
    scTGIF \
    scTHI \
    scTreeViz \
    segmenter \
    seqArchRplus \
    SeqSQC \
    SEtools \
    signeR \
    signifinder \
    SimBu \
    simplifyEnrichment \
    SingleCellMultiModal \
    SingleCellSignalR \
    SMAD \
    snifter \
    Spaniel \
    SpatialCPie \
    spatialDE \
    spatialHeatmap \
    SPIAT \
    splatter \
    SpotClean \
    ssPATHS \
    statTarget \
    stJoincount \
    SummarizedBenchmark \
    switchde \
    tanaylab/metacell \
    TileDBArray \
    TimiRGeN \
    tradeSeq \
    traviz \
    trena \
    tripr \
    uSORT \
    VDJdive \
    velociraptor \
    VennDetail \
    Voyager \
    zenith"

#BIOC_BASE=`echo $BIOC_BASE | sed "s/ /' ,'/g" | sed "s/^/'/g" | sed "s/$/'/g"`

CRAN_OTHER="AnanseSeurat \
    bbknnR \
    bcTSNE \
    conos \
    dsb \
    GeneralizedWendland \
    ggmotif \
    iCellR \
    jrSiCKLSNMF \
    MARVEL \
    MOCHA \
    numbat \
    pagoda2 \
    pathfindR \
    pGRN \
    Platypus \
    ProFAST \
    RaceID \
    RapidoPGS \
    rliger \
    RNAseqQC \
    scAnnotate \
    scCustomize \
    scDHA \
    scellpam \
    scGate \
    scImmuneGraph \
    scISR \
    SCINA \
    scITD \
    scMappR \
    scOntoMatch \
    SCORPION \
    SCORPIUS \
    scPloidy \
    scpoisson \
    SCpubr \
    SCRIP \
    shinyExprPortal \
    Signac \
    SignacX \
    singleCellHaystack \
    SpatialDDLS \
    survivalSL \
    symphony \
    tidyHeatmap \
    tidyseurat \
    ZetaSuite"

#CRAN_OTHER=`echo $CRAN_OTHER | sed "s/ /' ,'/g" | sed "s/^/'/g" | sed "s/$/'/g"`

BIOC_OTHER="ChromSCape \
    corral \
    GeneTonic \
    ggcoverage \
    igvR \
    KaradaColor \
    Nebulosa \
    scBubbletree \
    SCFA \
    scRepertoire \
    singleCellTK \
    tidybulk \
    tidySingleCellExperiment \
    tidySummarizedExperiment"

#BIOC_OTHER=`echo $BIOC_OTHER | sed "s/ /' ,'/g" | sed "s/^/'/g" | sed "s/$/'/g"`

GITHUB_PKGS="chris-mcginnis-ucsf/DoubletFinder \
    cran/speedglm \
    cole-trapnell-lab/garnett \
    cole-trapnell-lab/monocle3 \
    dzhang32/ggtranscript \
    GfellerLab/SuperCell \
    immunogenomics/lisi \
    immunogenomics/presto \
    JiekaiLab/dior \
    kharchenkolab/cacoa \
    korsunskylab/rcna \
    linxihui/NNLM \
    LTLA/scran.chan \
    lyc-1995/MyColors \
    mojaveazure/seurat-disk \
    navinlabcode/copykat \
    pcahan1/singleCellNet \
    rconsortium/OOP-WG \
    rnabioco/djvdj \
    saeyslab/nichenetr \
    satijalab/azimuth \
    satijalab/seurat-data \
    satijalab/seurat-wrappers \
    sqjin/CellChat \
    thackl/thacklr \
    thackl/gggenomes \
    tiledb-inc/tiledbsc \
    velocyto-team/velocyto.R \
    Vivianstats/scImpute \
    YuLab-SMU/scplot \
    ZJUFanLab/SpaTalk \
    zktuong/ktplots"

#GITHUB_PKGS=`echo $GITHUB_PKGS | sed "s/ /' ,'/g" | sed "s/^/'/g" | sed "s/$/'/g"`

if [[ -z $GITHUB_TOKEN ]]; then
    exit 1
fi

echo -e "GITHUB_TOKEN=\"${GITHUB_TOKEN}"\" >> ~/.Renviron \
    && Rscript ${BUILD_SOURCE_DIR}/script/install_Rpkgs.R ${CRAN_BASE} \
    && Rscript ${BUILD_SOURCE_DIR}/script/install_Rpkgs.R "tpq/propr" \
    && Rscript ${BUILD_SOURCE_DIR}/script/install_Rpkgs.R ${BIOC_BASE} \
    && Rscript -e 'options(timeout = 100000);install.packages(c("conosPanel", "p2data"), repos = "https://kharchenkolab.github.io/drat/", type = "source", clean = TRUE, dependency = FALSE)' \
    && Rscript ${BUILD_SOURCE_DIR}/script/install_Rpkgs.R ${CRAN_OTHER} ${BIOC_OTHER} \
    && Rscript -e 'options(timeout = 100000);install.packages("https://bioconductor.org/packages/3.12/bioc/src/contrib/simpleaffy_2.66.0.tar.gz", repos = NULL, clean = TRUE, dependency = FALSE)' \
    && Rscript ${BUILD_SOURCE_DIR}/script/install_Rpkgs.R ${GITHUB_PKGS} \
    && Rscript -e 'options(timeout = 100000);devtools::install_github("prabhakarlab/Banksy", dependencies = TRUE)' \
    && Rscript -e 'options(timeout = 100000);devtools::install_github("cole-trapnell-lab/cicero-release", ref = "monocle3", upgrade = "never", clean = TRUE)' \
    && Rscript -e 'options(timeout = 100000);devtools::install_github(repo = "aertslab/SCopeLoomR", upgrade = "never", clean = TRUE, build_vignettes = TRUE)' \
    && Rscript -e 'options(timeout = 100000);devtools::install_github(repo = c("aertslab/cisTopic", "aertslab/SCENIC"), upgrade = "never", clean = TRUE)' \
    && Rscript -e 'options(timeout = 100000);devtools::install_github(repo = "wycwycpku/RSCORE", build_opts = NULL, upgrade = "never", clean = TRUE)' \
    && Rscript -e 'options(timeout = 100000);devtools::install_github(repo = "GreenleafLab/ArchR", ref="master", repos = BiocManager::repositories(), upgrade = "never", clean = TRUE)' \
    && Rscript -e 'options(timeout = 100000);tinytex::install_tinytex(force = TRUE)' \
    && sed -i '/GITHUB_TOKEN=/d' ~/.Renviron \
    && rm -rf /usr/local/lib/R/site-library/*/basilisk/_pkgs/ /tmp/Rtmp* 
