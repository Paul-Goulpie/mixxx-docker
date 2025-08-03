FROM ubuntu:24.04

ARG USER
ARG UID
ARG GID
ARG PWD
ARG LANG

RUN rm /etc/apt/apt.conf.d/docker-*
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install sudo bash-completion screen \
    locales sudo less alsa-utils pulseaudio pulseaudio-utils
RUN sed -i "s/# ${LANG}/${LANG}/g" /etc/locale.gen
RUN locale-gen
RUN groupadd -g ${GID} ${USER}
RUN useradd -m -G sudo,audio -s /bin/bash -g ${GID} -u ${UID} ${USER}
RUN cp /etc/skel/.bash_logout /etc/skel/.bashrc /etc/skel/.profile /home/${USER}/
RUN chown ${USER}:${USER} /home/${USER} -R
RUN sed -E -i 's/^(%sudo.*)/#\1\n%sudo ALL=(ALL) NOPASSWD: ALL/g' /etc/sudoers

USER ${USER}
ENV USER=${USER}
ENV LANG=${LANG}
WORKDIR ${PWD}
COPY mixxx ${PWD}/docker/mixxx
RUN docker/mixxx/tools/debian_buildenv.sh setup
