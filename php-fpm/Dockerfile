FROM php:8.0-fpm

COPY php.ini /usr/local/etc/php

RUN apt-get update
RUN apt-get install -y libzip-dev
RUN docker-php-ext-install mysqli pdo pdo_mysql zip
RUN mkdir -p /var/www/html/resources/sessions

WORKDIR /var/www/html/
RUN mkdir -p resources/sessions

CMD cp example.env.php env.php \
    && chown -R www-data:www-data resources \
    && chmod -R 0755 resources \
    && php-fpm