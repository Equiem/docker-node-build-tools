FROM node:12.13

WORKDIR /usr/src
ENV DOCKER_VERSION=19.03.5 \
    YQ_VERSION=2.4.0

RUN apt-get update && \
    apt-get install -y zip unzip jq python3 python3-pip && \
    curl -L -o /usr/local/bin/yq https://github.com/mikefarah/yq/releases/download/$YQ_VERSION/yq_linux_amd64 && \
    chmod a+x /usr/local/bin/yq && \
    npm install -g graphql-cli wait-on && \
    pip3 install awscli --upgrade && \
    curl https://cli-assets.heroku.com/install.sh | sh

# Install docker.
RUN curl -L -o /tmp/docker-$DOCKER_VERSION.tgz https://download.docker.com/linux/static/stable/x86_64/docker-$DOCKER_VERSION.tgz && \
    tar -xz -C /tmp -f /tmp/docker-$DOCKER_VERSION.tgz && \
    mv /tmp/docker/* /usr/bin && \
    rm /tmp/docker-$DOCKER_VERSION.tgz

COPY npmrc /root/.npmrc
