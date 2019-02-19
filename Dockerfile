FROM ubuntu:18.04
MAINTAINER Ryan Baumann <ryan.baumann@gmail.com>
ENV PBR_VERSION 0.8.0
ENV DEBIAN_FRONTEND noninteractive
ENV PYTHONIOENCODING utf8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

WORKDIR /kraken

ADD kraken /kraken
ADD MANIFEST.in /kraken/MANIFEST.in
RUN apt-get update && apt-get -y install --no-install-recommends \
        ca-certificates \
        gcc \
        python3-setuptools \
        python3-dev \
        python3-scipy \
        python3-numpy \
        python3-pip \
        python3-pil \
        python3-click \
        python3-regex \
        python3-lxml \
        locales \
    && locale-gen en_US && locale-gen en_US.UTF-8 && update-locale \
    && pip3 install wheel \
    && pip3 install pbr \
    && pip3 install -r requirements.txt \
    && pip3 install . \
    && apt-get -y remove --purge --auto-remove \
        gcc \
    && apt-get clean \
    && rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/* .git
RUN    kraken get default \
    && kraken get fraktur \
    && kraken get script-detection \
    && kraken get goodell \
    && kraken get loeb \
    && kraken get migne-njp \
    && kraken get migne \
    && kraken get non-teubner-german-serif \
    && kraken get omnibus \
    && kraken get porson \
    && kraken get rahlfs \
    && kraken get teubner-serif

VOLUME /data
WORKDIR /data
