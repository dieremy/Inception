FROM alpine:3.15.0

ENV BASH_VERSION=5.2.26-r0
ENV MARIADB_VERSION=mariadb:10.6.13-r1
ENV MARIADB_CLIENT_VERSION=mariadb-client:10.6.13-r1

ARG	DB_NAME
ARG	DB_USER
ARG	DB_PSWD
ARG	DB_ROOT

RUN apk update && \
	apk add --no-cache \
	bash=${BASH_VERSION} \
	mariadb=${MARIADB_VERSION} \
	mariadb-client=${MARIADB_CLIENT_VERSION}

EXPOSE 3306

COPY containers/mariadb/script.sh .

RUN ["bash", "script.sh"]

RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql

USER mysql

CMD ["/usr/bin/mysqld", "--skip-log-error"]