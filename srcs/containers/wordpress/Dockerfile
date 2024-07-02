FROM alpine:3.15.0

ENV BASH_VERSION=5.2.26-r0
ENV CURL_VERSION=8.5.0-r0
ENV PHP_VERSION=7.4

ARG DB_NAME
ARG DB_USER
ARG DB_PWD

RUN apk update && \
  apk add --no-cache \
  bash=${BASH_VERSION} \
  curl=${CURL_VERSION} \
  php${PHP_VERSION} \
  php${PHP_VERSION}-fpm \
  php${PHP_VERSION}-mysqli \
  php${PHP_VERSION}-json \
  php${PHP_VERSION}-curl \
  php${PHP_VERSION}-dom \
  php${PHP_VERSION}-exif \
  php${PHP_VERSION}-fileinfo \
  php${PHP_VERSION}-mbstring \
  php${PHP_VERSION}-openssl \
  php${PHP_VERSION}-xml \
  php${PHP_VERSION}-zip \
  php${PHP_VERSION}-redis

WORKDIR /var/www

# .zip or .tar.gz ?
RUN curl -L https://wordpress.org/latest.zip && \
    unzip latest.zip && \
    cp -rf wordpress/* . && \
    rm -rf wordpress latest.zip

COPY containers/wordpress/script.sh .

RUN bash script.sh
RUN chmod -R 755 wp-content
RUN chown -R www-data:www-data .

CMD ["/usr/sbin/php-fpm8", "-F"]
