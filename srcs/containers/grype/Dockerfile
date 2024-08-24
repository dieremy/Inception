FROM alpine:3.18.0

ENV CURL_VERSION=8.9.0-r0

RUN apk update && \
    apk add --no-cache \
    curl=${CURL_VERSION}

RUN curl -sSfL https://raw.githubusercontent.com/anchore/grype/main/install.sh | sh -s -- -b /usr/local/bin

RUN mkdir -p /scans/logs

#ENTRYPOINT ["grype", "alpine:3.18.0"]

RUN docker pull alpine:3.18.0

#ENTRYPOINT ["grype", "alpine:3.18.0"]
#import (
#        "fmt"
#        "log"

#        "github.com/fsouza/go-dockerclient"
#)
