# Container image that runs your code
FROM ubuntu:latest

RUN apt-get -y update
RUN apt-get -y install git gpg

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]
