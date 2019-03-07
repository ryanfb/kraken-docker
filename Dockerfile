FROM ubuntu:18.04
MAINTAINER Ryan Baumann <ryan.baumann@gmail.com>
ENV PBR_VERSION 1.0.1
ENV DEBIAN_FRONTEND noninteractive
ENV PYTHONIOENCODING utf8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

WORKDIR /kraken

ADD kraken /kraken
ADD .git/modules/kraken /kraken/.git
RUN apt-get update && apt-get -y install --no-install-recommends \
        ca-certificates \
        build-essential \
        parallel \
        unzip \
        time \
        gcc \
        git \
        libgomp1 \
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
        wget \
    && locale-gen en_US && locale-gen en_US.UTF-8 && update-locale \
    && pip3 install wheel \
    && pip3 install pbr \
    && wget -q https://download.pytorch.org/whl/cpu/torch-1.0.1.post2-cp36-cp36m-linux_x86_64.whl \
    && pip3 install torch-1.0.1.post2-cp36-cp36m-linux_x86_64.whl \
    && pip3 install torchvision \
    && pip3 install -r requirements.txt \
    && pip3 install . \
    && apt-get -y remove --purge --auto-remove \
        gcc \
    && apt-get clean \
    && rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

VOLUME /models
RUN mkdir -pv /root/.config && ln -sv /models /root/.config/kraken
VOLUME /data
WORKDIR /data
