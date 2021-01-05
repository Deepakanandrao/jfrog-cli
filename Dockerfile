FROM ubuntu

## Copy code from your action repository to the filesystem path `/` in the container
COPY entrypoint.sh /entrypoint.sh

## Disallow storing credentials
ENV JFROG_CLI_OFFER_CONFIG=false

## Install cURL,  get the JFrog CLI, and make the script executable
RUN apt-get update &&\
    yes | apt-get install curl &&\
    rm -rf /var/lib/apt/lists/* &&\
    curl -fL https://getcli.jfrog.io | sh &&\
    mv jfrog /bin &&\
    apt-get install openjdk-8-jdk &&\
    chmod +x entrypoint.sh &&\
    mv entrypoint.sh /bin &&\
    java -version

## When the container starts, run the entrypoint script
ENTRYPOINT ["entrypoint.sh"]
