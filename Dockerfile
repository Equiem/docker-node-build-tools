FROM node:8.12-jessie

WORKDIR /usr/src

RUN npm install -g npm@6.4.1
RUN echo '//registry.npmjs.org/:_authToken=${NPM_TOKEN}' > $HOME/.npmrc

RUN apt-get update
RUN apt-get install zip unzip
