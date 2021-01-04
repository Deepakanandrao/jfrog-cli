# Base image
FROM ubuntu:latest


# Copies your code file  repository to the filesystem
COPY entrypoint.sh /entrypoint.sh


## Install cURL, downlopd JFrog CLI, and make the script executable
RUN apk update &&\
    yes | apk add curl &&\
    rm -rf /var/lib/apt/lists/* &&\
    curl -fL https://getcli.jfrog.io | sh &&\
    mv jfrog /bin &&\
    mv entrypoint.sh /bin

# change permission to execute the script and
RUN chmod +x /entrypoint.sh


# file to execute when the docker container starts up
ENTRYPOINT ["/entrypoint.sh"]
