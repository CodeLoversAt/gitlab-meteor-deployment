FROM gitlab/dind

MAINTAINER Daniel Holzmann <d@velopment.at>

RUN DEBIAN_FRONTEND=noninteractive apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates curl \
        numactl locales bzip2 build-essential libssl-dev python git \
    && rm -rf /var/lib/apt/lists/* \
    && groupadd gitlab \
    && mkdir -p /home/gitlab \
    && useradd -g gitlab -d /home/gitlab gitlab \
    && chsh -s /bin/bash gitlab \
    && chown -R gitlab:gitlab /home/gitlab \
    && usermod -a -G sudo gitlab

# install Node.js
RUN curl -sL https://deb.nodesource.com/setup_0.10 | sudo -E bash - \
    && apt-get install -y nodejs \
    && npm i -g npm@latest \
    && npm i -g node-gyp 

RUN curl https://install.meteor.com/ | sh

USER gitlab
