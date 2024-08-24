FROM alpine:3.18.0

ENV CURL_VERSION=8.9.0-r0
ENV MAKE_VERSION=4.4.1-r1

RUN apk update && \
    apk add --no-cache \
    curl=${CURL_VERSION} \
    make=${MAKE_VERSION}

RUN curl -sSfL https://go.dev/dl/go1.23.0.linux-amd64.tar.gz -o /tmp/go.tar.gz && \
    tar -C /usr/local -xzf /tmp/go.tar.gz && \
    rm /tmp/go.tar.gz && \
    export PATH=$PATH:/usr/local/go/bin

RUN curl -sSfL https://raw.githubusercontent.com/anchore/grype/main/install.sh | sh -s -- -b /usr/local/bin

COPY greport/ /

WORKDIR greport

CMD ["make"]