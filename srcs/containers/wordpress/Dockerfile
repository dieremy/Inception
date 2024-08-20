FROM alpine:3.18.0

ENV BASH_VERSION=5.2.15-r5
ENV CURL_VERSION=8.9.0-r0
ENV FCGI_VERSION=2.4.2-r4
ENV JQ_VERSION=1.7.1-r0
ENV PHP_VERSION=82
ENV WGET_VERSION=1.21.4-r0

# debug
# ENV MARIADB_VERSION=10.11.8-r0
# ENV MYSQL_VERSION=10.11.8-r0

ARG WORDPRESS_DB_HOST
ARG WORDPRESS_DB_NAME
ARG WORDPRESS_DB_USER
ARG WORDPRESS_DB_PASSWORD
ARG DOMAIN_NAME

# Add edge repositories for newer versions of packages
RUN echo http://dl-cdn.alpinelinux.org/alpine/edge/main >> /etc/apk/repositories && \
    echo http://dl-cdn.alpinelinux.org/alpine/edge/community >> /etc/apk/repositories && \
    echo http://dl-cdn.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories && \
    apk update && \
    apk add --no-cache \
        bash=${BASH_VERSION} \
        curl=${CURL_VERSION} \
        fcgi=${FCGI_VERSION} \
        jq=${JQ_VERSION} \
        # mariadb=${MARIADB_VERSION} \
        # mariadb-client=${MARIADB_VERSION} \
        # mysql=${MYSQL_VERSION}\
        # mysql-client=${MYSQL_VERSION} \ 
        wget=${WGET_VERSION} \
        php${PHP_VERSION} \
        php${PHP_VERSION}-cli \
        php${PHP_VERSION}-phar \
        php${PHP_VERSION}-fpm \
        php${PHP_VERSION}-gd \
        php${PHP_VERSION}-mysqli \
        php${PHP_VERSION}-json \
        php${PHP_VERSION}-cgi \
        php${PHP_VERSION}-curl \
        php${PHP_VERSION}-dom \
        php${PHP_VERSION}-exif \
        php${PHP_VERSION}-fileinfo \
        php${PHP_VERSION}-mbstring \
        php${PHP_VERSION}-openssl \
        php${PHP_VERSION}-session \
        php${PHP_VERSION}-xml \
        php${PHP_VERSION}-zip \
        php${PHP_VERSION}-redis \
        unzip

# Symlink php to the correct paths
RUN ln -s /usr/bin/php82 /usr/bin/php

# Install wp-cli
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

# Create necessary directories
RUN mkdir -p /var/www/html && \
    chown -R root /var/www/html && \
    mkdir -p /run/php82 && \
    chown root /run/php82

RUN sed -i "s/listen = 127.0.0.1:9000/listen = 9000/g" /etc/php82/php-fpm.d/www.conf

WORKDIR /var/www/html

COPY asset/cat-meme-png.png /var/www/html/cat-meme-png.png

COPY app/generate_static.sh /var/www/html/generate_static.sh

COPY conf/wp-inception.xml /var/www/html/wp-inception.xml

COPY script.sh /var/www/html/script.sh

RUN chmod +x /var/www/html/script.sh \
    && chmod +x /var/www/html/generate_static.sh

# Convert script to Unix line endings
RUN sed -i 's/\r$//' /var/www/html/generate_static.sh

EXPOSE 9000

ENTRYPOINT ["bash", "/var/www/html/script.sh"]
