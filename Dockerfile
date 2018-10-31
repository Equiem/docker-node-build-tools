FROM node:8.12-jessie

WORKDIR /usr/src
ENV DOCKER_VERSION 18.06.1-ce 

RUN npm install -g graphql-cli wait-on
RUN curl https://cli-assets.heroku.com/install.sh | sh
RUN echo '//registry.npmjs.org/:_authToken=${NPM_TOKEN}' > $HOME/.npmrc

RUN apt-get update
RUN apt-get install zip unzip jq

# Install docker.
RUN curl -L -o /tmp/docker-$DOCKER_VERSION.tgz https://download.docker.com/linux/static/stable/x86_64/docker-$DOCKER_VERSION.tgz
RUN tar -xz -C /tmp -f /tmp/docker-$DOCKER_VERSION.tgz
RUN mv /tmp/docker/* /usr/bin
