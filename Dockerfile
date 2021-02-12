FROM php:7.1.8-apache
COPY . /srv/app
COPY vhost.conf /etc/apache2/sites-available/000-default.conf
RUN docker-php-ext-install pdo_mysql mbstring
RUN chown -R www-data:www-data /srv/app \
    && a2enmod rewrite
