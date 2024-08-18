FROM alpine:3.18.0

ENV BASH_VERSION=5.2.15-r5
ENV MARIADB_VERSION=10.11.8-r0
ENV OPENRC_VERSION=0.48-r0
ENV MYSQL_VERSION=10.11.8-r0

ARG	MYSQL_DATABASE
ARG	MYSQL_USER
ARG	MYSQL_PASSWORD
ARG	MYSQL_ROOT_PASSWORD

RUN apk update && apk upgrade && apk add --no-cache \
	bash=${BASH_VERSION} \
	mariadb=${MARIADB_VERSION} \
	mariadb-client=${MARIADB_VERSION} \
  mysql=${MYSQL_VERSION}\
  mysql-client=${MYSQL_VERSION} \
  openrc=${OPENRC_VERSION}

RUN openrc 
RUN touch /run/openrc/softlevel

# RUN mkdir /var/run/mysqld; \
#   chmod 777 /var/run/mysqld; \
#   { echo '[mysqld]'; \
#     echo 'skip-host-cache'; \
#     echo 'skip-name-resolve'; \
#     echo 'bind-address=0.0.0.0'; \
#   } | tee /etc/my.cnf.d/docker.cnf; \
#   sed -i "s|skip-networking|skip-networking=0|g" /etc/my.cnf.d/mariadb-server.cnf
COPY conf/mariadb-server.cnf /etc/my.cnf

COPY instance.sql /instance.sql

RUN rc-service mariadb setup && rc-service mariadb start && mysql -sfu root < /instance.sql

EXPOSE 3306

# RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql

COPY script.sh /script.sh

RUN chmod +x /script.sh

ENTRYPOINT ["bash", "/script.sh"]
# USER mysql 

# CMD ["/usr/bin/mysqld", "--skip-log-error"]
