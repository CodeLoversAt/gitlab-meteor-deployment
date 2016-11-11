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
    && chown -R gitlab:gitlab /home/gitlab

# install global NVM and meteor
RUN touch ~/.bashrc \
    && curl https://raw.githubusercontent.com/creationix/nvm/v0.32.1/install.sh | bash \

    && export NVM_DIR="/root/.nvm" \
    && [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" \

    && nvm i 4.5 \
    && npm i -g npm@latest node-gyp \
    && curl https://install.meteor.com/ | sh

USER gitlab

# install NVM for user gitlab
RUN touch ~/.bashrc \
    && curl https://raw.githubusercontent.com/creationix/nvm/v0.32.1/install.sh | bash \
    && export NVM_DIR="/home/gitlab/.nvm" \
    && [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" \
    && nvm i 4.5 \
    && npm i -g npm@latest node-gyp