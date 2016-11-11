FROM gitlab/dind

MAINTAINER Daniel Holzmann <d@velopment.at>

RUN DEBIAN_FRONTEND=noninteractive apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates curl \
        numactl locales bzip2 build-essential libssl-dev python git \
    && rm -rf /var/lib/apt/lists/* \
    && curl -sL https://deb.nodesource.com/setup_0.10 | sudo -E bash - \
    && apt-get install -y nodejs \
    && npm i -g npm@latest \
    && npm i -g node-gyp \
    && curl https://install.meteor.com/ | sh

ENV METEOR_ALLOW_SUPERUSER true