FROM alpine:3.15.0

ENV GRYPE_VERSION=grype:latest

RUN apk update && \
    apk add --no-cache \
    grype=${GRYPE_VERSION}
