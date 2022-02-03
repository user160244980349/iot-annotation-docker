FROM php:7.4-fpm

COPY php.ini /usr/local/etc/php

RUN apt-get update
RUN apt-get install -y git libzip-dev
RUN docker-php-ext-install mysqli pdo pdo_mysql zip

WORKDIR /var/www/html
RUN git clone https://github.com/user160244980349/iot-annotation.git .