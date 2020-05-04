FROM php:7.4-fpm

RUN docker-php-ext-install pdo_mysql

RUN pecl install apcu

RUN apt-get update && \
apt-get install -y \
zlib1g-dev git

RUN docker-php-ext-enable apcu

WORKDIR /usr/src/app

COPY apps/symfony-blog /usr/src/app

RUN PATH=$PATH:/usr/src/apps/vendor/bin:bin

