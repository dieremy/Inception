FROM alpine:3.18.0

ENV BASH_VERSION=5.2.15-r5
ENV CURL_VERSION=8.9.0-r0
ENV FCGI_VERSION=2.4.2-r4
ENV PHP_VERSION=82
ENV WGET_VERSION=1.21.4-r0

ARG WORDPRESS_DB_NAME
ARG WORDPRESS_DB_USER
ARG WORDPRESS_DB_PASSWORD
ARG DOMAIN_NAME

# Add edge repositories for newer versions of packages
RUN echo http://dl-cdn.alpinelinux.org/alpine/edge/main >> /etc/apk/repositories && \
    echo http://dl-cdn.alpinelinux.org/alpine/edge/community >> /etc/apk/repositories && \
    apk update && \
    apk add --no-cache \
        bash=${BASH_VERSION} \
        curl=${CURL_VERSION} \
        fcgi=${FCGI_VERSION} \ 
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

# Symlink php to the correct path
RUN ln -s /usr/bin/php82 /usr/bin/php

# Install wp-cli
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/bin/wp-cli

# Create necessary directories
RUN mkdir -p /var/www/html && \
    chown -R root /var/www/html && \
    mkdir -p /run/php82 && \
    chown root /run/php82

RUN sed -i "s/listen = 127.0.0.1:9000/listen = 9000/g" /etc/php82/php-fpm.d/www.conf

WORKDIR /var/www/html

RUN wp-cli core download --allow-root

COPY conf/wordpress-inception.xml /wordpress-inception.xml

COPY script.sh /script.sh

RUN chmod +x /script.sh

EXPOSE 9000

ENTRYPOINT ["bash", "/script.sh"]
