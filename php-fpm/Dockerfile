FROM php:8.0-fpm-alpine

COPY php.ini /usr/local/etc/php

RUN apk add libzip-dev
RUN docker-php-ext-install pdo pdo_mysql zip

RUN mkdir -p /var/www/html/resources/sessions

CMD chown -R www-data:www-data /var/www/html/resources \
    && chmod -R 0755 /var/www/html/resources \
    && php-fpm