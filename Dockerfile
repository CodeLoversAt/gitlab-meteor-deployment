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

USER gitlab

# install NVM and Meteor
RUN cd /home/gitlab && touch ~/.bashrc 

RUN curl https://raw.githubusercontent.com/creationix/nvm/v0.32.1/install.sh | bash 

RUN export NVM_DIR="/home/gitlab/.nvm" 

RUN [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" 

RUN nvm i 4.5 

RUN npm i -g npm@latest 

RUN npm i -g node-gyp 

RUN curl https://install.meteor.com/ | sh