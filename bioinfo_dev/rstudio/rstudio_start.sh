#!/bin/bash
set -e

DEFAULT_USER=${DEFAULT_USER:-"mydocker"}
PASSWORD=${RSTUDIO_PASSWORD:-"mydocker"}

# Settings required for conda+rstudio
#export RSTUDIO_WHICH_R=$(which R)
#echo rsession-which-r=${RSTUDIO_WHICH_R} > /etc/rstudio/rserver.conf

#echo "PATH=/opt/conda/bin:/opt/conda/condabin:${PATH}" >> /home/${DEFAULT_USER}/.Renviron
#echo "RETICULATE_MINICONDA_PATH=${RETICULATE_MINICONDA_PATH}" >> /home/${DEFAULT_USER}/.Renviron
echo "RETICULATE_PYTHON=${RETICULATE_PYTHON}" >> /home/${DEFAULT_USER}/.Renviron
echo "RETICULATE_PYTHON_ENV=${RETICULATE_PYTHON_ENV}" >> /home/${DEFAULT_USER}/.Renviron
echo "RETICULATE_AUTOCONFIGURE=${RETICULATE_AUTOCONFIGURE}" >> /home/${DEFAULT_USER}/.Renviron

echo "BASILISK_USE_SYSTEM_DIR=${BASILISK_USE_SYSTEM_DIR}" >> /home/${DEFAULT_USER}/.Renviron
#echo "BASILISK_EXTERNAL_CONDA=${BASILISK_EXTERNAL_CONDA}" >> /home/${DEFAULT_USER}/.Renviron
echo "BASILISK_NO_FALLBACK_R=${BASILISK_NO_FALLBACK_R}" >> /home/${DEFAULT_USER}/.Renviron

# Set root password (with podman, we need to login as root rather than "rstudio")
#echo "$DEFAULT_USER:$PASSWORD" | chpasswd
#echo "auth-minimum-user-id=0" >> /etc/rstudio/rserver.conf

# Custom settings
echo "session-timeout-minutes=0" >> /etc/rstudio/rsession.conf
echo "auth-timeout-minutes=0" >> /etc/rstudio/rserver.conf
echo "auth-stay-signed-in-days=30" >> /etc/rstudio/rserver.conf

