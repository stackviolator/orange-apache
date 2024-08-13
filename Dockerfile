FROM ubuntu:latest


RUN apt-get update && apt-get install -y \
    libapache2-mod-fcgid \
    apache2=2.4.7-1ubuntu4.20 \
    && apt-get clean

WORKDIR /var/www/html
COPY src/ /var/www/html
# RUN a2enmod proxy_fcgi setenvif
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf
# RUN htpasswd -cb /var/www/html/.htpasswd admin p0psm0ke
RUN chown -R www-data:www-data /var/www/html

EXPOSE 80
CMD ["apache2-foreground"]
