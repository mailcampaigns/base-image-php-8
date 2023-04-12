FROM php:8.2-fpm-alpine

RUN apk add --no-cache autoconf build-base curl git icu-dev linux-headers wget zip \
    && pecl install apcu xdebug \
    && docker-php-ext-configure intl \
    && docker-php-ext-enable apcu xdebug \
    && docker-php-ext-install intl opcache pdo pdo_mysql

COPY .docker/php/conf.d/ $PHP_INI_DIR/conf.d/

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

ENV DOCKERIZE_VERSION v0.6.1
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz
