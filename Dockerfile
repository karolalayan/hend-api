# Use the official PHP image as the base image
FROM php:8.2-fpm

# Set working directory
WORKDIR /var/www

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    locales \
    zip \
    jpegoptim optipng pngquant gifsicle \
    vim \
    unzip \
    curl \
    libonig-dev \
    libzip-dev \
    libxml2-dev

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install PHP extensions
RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Install Composer
COPY . /var/www

# Set correct permissions before copying files
RUN usermod -u 1000 www-data && groupmod -g 1000 www-data

# Ensure the project directory exists and has correct ownership
RUN mkdir -p /var/www && chown -R www-data:www-data /var/www

# Switch to www-data user
USER www-data

# Expose port 9000 and start php-fpm server
EXPOSE 9000
