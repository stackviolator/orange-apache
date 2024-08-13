FROM php:7.2-apache


RUN apt update && apt install python-software-properties
RUN add-apt-repository ppa:ondrej/php
RUN apt-get update && apt-get install -y \
    libapache2-mod-fcgid \
    php7.2-fpm \
    && apt-get clean

WORKDIR /var/www/html
COPY src/ /var/www/html
RUN a2dismod php7.2
RUN a2dismod mpm_prefork
RUN a2enmod mpm_event
RUN a2enmod rewrite
RUN a2enconf php7.2-fpm
RUN a2enmod proxy
RUN a2enmod proxy_fcgi setenvif
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf
RUN htpasswd -cb /var/www/html/.htpasswd admin p0psm0ke
RUN chown -R www-data:www-data /var/www/html

EXPOSE 80
CMD ["apache2-foreground"]
