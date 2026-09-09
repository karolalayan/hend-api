FROM php:8.3-fpm

WORKDIR /var/www

# Only what Laravel and Composer actually need
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    curl \
    unzip \
    libonig-dev \
    libzip-dev \
    && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-install pdo_mysql bcmath zip pcntl

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Keep Composer's cache out of the mounted project directory
ENV COMPOSER_HOME=/tmp/composer

# Match the host user (uid 1000) so files the container writes into the
# mounted project stay editable from outside the container.
RUN usermod -u 1000 www-data && groupmod -g 1000 www-data

USER www-data

# The code comes from the bind mount in docker-compose.yml,
# so nothing is copied into the image.
EXPOSE 9000
