ARG FROM_IMAGE=bioinfo_dev
ARG FROM_VERSION

FROM ycli1995/${FROM_IMAGE}:${FROM_VERSION}

ENV DEFAULT_USER=mydocker

COPY *.sh /

RUN bash /add_non_root.sh && bash /add_apt_install.sh

#USER ${DEFAULT_USER}

CMD /usr/sbin/sshd -D

#WORKDIR /home/${DEFAULT_USER}

