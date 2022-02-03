FROM php:7.4-fpm

COPY php.ini /usr/local/etc/php

RUN apt-get update
RUN apt-get install -y libzip-dev
RUN docker-php-ext-install mysqli pdo pdo_mysql zip
