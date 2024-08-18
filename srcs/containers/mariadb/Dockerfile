FROM alpine:3.18.0

ENV BASH_VERSION=5.2.15-r5
ENV MARIADB_VERSION=10.11.8-r0
ENV OPENRC_VERSION=0.48-r0
ENV MYSQL_VERSION=10.11.8-r0

ARG MYSQL_DATABASE
ARG MYSQL_USER
ARG MYSQL_PASSWORD
ARG MYSQL_ROOT_PASSWORD

RUN apk update && apk upgrade && apk add --no-cache \
    bash=${BASH_VERSION} \
    mariadb=${MARIADB_VERSION} \
    mariadb-client=${MARIADB_VERSION} \
    openrc=${OPENRC_VERSION}

COPY conf/mariadb-server.cnf /etc/my.cnf

COPY script.sh /script.sh

RUN chmod +x /script.sh

EXPOSE 3306

ENTRYPOINT ["bash", "/script.sh"]
