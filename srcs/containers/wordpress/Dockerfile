FROM alpine:3.15

ARG PHP_VERSION=7.4 DB_NAME DB_USER DB_PSWD

RUN apk update && apk upgrade && apk add --no-cache \
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
  php${PHP_VERSION}-redis \

