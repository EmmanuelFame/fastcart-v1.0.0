FROM php:8.3-fpm

#Here I am installing dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    zip \
    unzip \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    libzip-dev \
    libssl-dev \
    libcurl4-openssl-dev \
    mariadb-client \
    && docker-php-ext-install pdo pdo_mysql zip

#Here I am installing composer so I can use laravel
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html

#Here I will install node.js and Npm so I can use vite build and other nodemodules in my laravel app
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs