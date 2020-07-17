FROM php:7.4-apache

RUN apt-get update && apt-get install -y vim nano iputils-ping wget curl ssh zip libfreetype6-dev libjpeg62-turbo-dev libpng-dev libzip-dev &&  \
    docker-php-ext-configure gd --with-freetype --with-jpeg &&  \
    docker-php-ext-install -j$(nproc) gd &&  \
    docker-php-ext-install pdo_mysql && \
    docker-php-ext-install zip && \
    docker-php-ext-install opcache && \
    docker-php-ext-install mysqli  && \
    a2enmod rewrite && \
    apt-get clean

# composer install
USER root
WORKDIR /var/www
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php composer-setup.php && php -r "unlink('composer-setup.php');"
RUN mv /var/www/composer.phar /usr/local/bin/composer