#Используем официальный образ PHP
FROM php:8.3-fpm

# Установим необходимые зависимости для PHP
RUN apt-get update && apt-get install -y \
    libpng-dev libjpeg-dev libfreetype6-dev libzip-dev \
    unzip git curl \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd zip pdo pdo_mysql

# Установка Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Установим рабочую директорию
WORKDIR /var/www

# Копируем файлы проекта в контейнер
COPY . .

# Установите переменные окружения для Composer
ENV COMPOSER_ALLOW_SUPERUSER=1

# Установить зависимости с помощью Composer
RUN composer install --no-interaction