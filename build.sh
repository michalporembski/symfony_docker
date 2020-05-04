#!/bin/bash

if [ "$1" == "-h" ]; then
    echo "Usage: ./build [option]"
    echo " -h for help"
    echo " -f to fore rebuild containers"
    exit 0
fi

if [ ! -f "./.env" ]; then
    cp ./.env.dist ./.env
fi

if [ ! -f "./apps/symfony-blog/README.md" ]; then
    git clone https://github.com/michalporembski/symfony_blog.git ./apps/symfony-blog
fi

if [ ! -f "./apps/symfony-blog/composer.phar" ]; then
    curl -o ./apps/symfony-blog/composer.phar https://getcomposer.org/composer-stable.phar
fi

if [ ! -f "./apps/symfony-blog/.env" ]; then
    cp ./apps/symfony-blog/.env.dist ./apps/symfony-blog/.env
fi

if [ "$1" == "-f" ]; then
    docker-compose down
    docker-compose build --no-cache
fi

docker-compose up -d
docker exec -u 0 -it symfony_php_1 chmod 777 -R /.composer
docker exec -it symfony_php_1 php composer.phar install