ARG FROM_IMAGE=bioinfo_dev
ARG FROM_VERSION

FROM ycli1995/${FROM_IMAGE}:${FROM_VERSION}

ENV DEFAULT_USER=mydocker

COPY *.sh /install_jupyter/

RUN bash /install_jupyter/install_jupyter.sh

EXPOSE 8888

CMD ["jupyter", "lab", "--port=8888", "--no-browser", "--allow-root", "--ip=0.0.0.0"]

USER ${DEFAULT_USER}

WORKDIR /home/${DEFAULT_USER}

