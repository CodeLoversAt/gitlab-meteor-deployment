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

# install NVM and Meteor
ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 0.10.48

# Install nvm with node and npm
RUN curl https://raw.githubusercontent.com/creationix/nvm/v0.32.1/install.sh | bash \
    && source $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH      $NVM_DIR/v$NODE_VERSION/bin:$PATH

USER gitlab

RUN npm i -g npm@latest \
    && npm i -g node-gyp 

RUN curl https://install.meteor.com/ | sh