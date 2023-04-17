FROM ubuntu:18.04@sha256:0779371f96205678dbcaa3ef499be2e5f262c8b09aadc11754bf3daf9f35e03e

ENV WORKDIR /scarab-dev
WORKDIR ${WORKDIR}
COPY ./scarab/bin/requirements.txt ./requirements.txt

RUN apt-get update \
 && apt-get install -y \
    autoconf \
    build-essential \
    clang \
    git \
    gnupg \
    libconfig++-dev \
    libsnappy-dev \
    libtool \
    lsb-release \
    python3 \
    python3-pip \
    software-properties-common \
    unzip \
    vim \
    wget \
    zlib1g-dev \
 && rm -rf /var/lib/apt/lists/* \
 && pip3 install --no-cache-dir -U pip setuptools \
 && python3 -m pip install --no-cache-dir -r ./requirements.txt

ENV CMAKE_VERSION=3.25.3
RUN wget https://github.com/Kitware/CMake/releases/download/v${CMAKE_VERSION}/cmake-${CMAKE_VERSION}-linux-x86_64.sh \
 && chmod +x cmake-${CMAKE_VERSION}-linux-x86_64.sh \
 && ./cmake-${CMAKE_VERSION}-linux-x86_64.sh --skip-license --prefix /usr/ \
 && rm cmake-${CMAKE_VERSION}-linux-x86_64.sh

ADD ./scarab/ ./scarab/
ENV PIN_ROOT=${WORKDIR}/pinplay-3.5/
ADD ./pinplay-drdebug-3.5-pin-3.5-97503-gac534ca30-gcc-linux/ ${PIN_ROOT}
ENV SCARAB_ENABLE_MEMTRACE=1
RUN cd scarab/src \
 && make clean \
 && make
