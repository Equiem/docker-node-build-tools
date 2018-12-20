# docker-node-build-tools

This repository contains the docker file that is used to create a container image containing all built time tools and utilites.
This is done so that that build time dependencies at the container level are isolated from the application container.

## FAQ

### How do I create a new version/tag of the docker image ?

The docker images are built and published on Docker Hub. An image built on docker hub uses the git tag or branch name.
Most often, you should be able to create a PR, get an image published based on docker hub, test changes locally.
After approval of the PR, one can create a tag to get the official image out to be consumed in the app.