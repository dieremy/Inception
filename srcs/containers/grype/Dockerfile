FROM alpine:3.16.0

ENV GRYPE_VERSION="v0.79.1"

RUN apk update && \
    apk add --no-cache \
    grype=${GRYPE_VERSION}
