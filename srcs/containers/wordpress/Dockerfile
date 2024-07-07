FROM alpine:3.15.0

ENV BASH_VERSION=5.1.16-r0
ENV PHP_VERSION=8
ENV WGET_VERSION=1.21.2-r2

ARG DB_NAME
ARG DB_USER
ARG DB_PWD

RUN apk update && \
  apk add --no-cache \
  bash=${BASH_VERSION} \
  wget=${WGET_VERSION} \
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
  unzip && \
  sed -i "s|listen = 127.0.0.1:9000|listen = 9000|g" \
    /etc/php8/php-fpm.d/www.conf && \
  sed -i "s|;listen.owner = nobody|listen.owner = nobody|g" \
    /etc/php8/php-fpm.d/www.conf && \
  sed -i "s|;listen.group = nobody|listen.group = nobody|g" \
    /etc/php8/php-fpm.d/www.conf && \
  rm -f /var/cache/apk/*

WORKDIR /var/www

RUN wget -L https://wordpress.org/latest.zip && \
    unzip latest.zip && \
    cp -rf wordpress/* . && \
    rm -rf wordpress latest.zip

COPY containers/wordpress/script.sh .

RUN bash script.sh && chmod -R 0777 wp-content/
    
CMD ["/usr/sbin/php-fpm8", "-F"]
