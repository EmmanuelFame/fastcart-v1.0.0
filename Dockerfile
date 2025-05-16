FROM php:8.3-fpm

# Install system dependencies and PHP extensions
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

# Install Redis PHP extension
RUN pecl install redis && docker-php-ext-enable redis

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Install Node.js & npm
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs

RUN docker-php-ext-install pcntl

RUN docker-php-ext-install sockets

RUN apt-get update && apt-get install -y supervisor
# Copy supervisor config
COPY .docker/supervisor/reverb.conf /etc/supervisor/conf.d/reverb.conf
COPY .docker/supervisor/supervisord.conf /etc/supervisord.conf

# Start Supervisor
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]

WORKDIR /var/www/html
