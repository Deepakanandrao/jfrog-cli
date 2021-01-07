FROM alpine
COPY entrypoint.sh /entrypoint.sh
ENV JFROG_CLI_OFFER_CONFIG=false
RUN apk update &&\
    yes | apk add curl &&\
    rm -rf /var/lib/apt/lists/* &&\
    curl -fL https://getcli.jfrog.io | sh &&\
    mv jfrog /bin &&\
    chmod +x entrypoint.sh &&\
    mv entrypoint.sh /bin
ENTRYPOINT ["entrypoint.sh"]
