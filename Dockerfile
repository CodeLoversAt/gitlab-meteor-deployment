FROM gitlab/dind

MAINTAINER Daniel Holzmann <d@velopment.at>

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates curl \
        numactl locales bzip2 build-essential python git \
    && rm -rf /var/lib/apt/lists/*

RUN curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash - \
    && sudo apt-get install --yes nodejs \
    && rm -rf /var/lib/apt/lists/*
