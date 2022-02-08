#!/bin/sh
git clone https://github.com/user160244980349/iot-annotation-frontend.git nginx/iot-annotation-frontend
git clone https://github.com/user160244980349/iot-annotation.git php-fpm/iot-annotation

cp php-fpm/iot-annotation/example.env.php php-fpm/iot-annotation/env.php

sudo docker-compose build