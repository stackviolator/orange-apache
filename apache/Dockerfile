FROM httpd:2.4

COPY ./apache/.htaccess /var/www/html/.htaccess
COPY ./apache/apache.vhost.conf /usr/local/apache2/conf/extra/apache.vhost.conf

# Uncomment the configuration in httpd.conf
RUN sed -i \
    -e '/#LoadModule deflate_module/s/^#//g' \
    -e '/#LoadModule proxy_module/s/^#//g' \
    -e '/#LoadModule proxy_fcgi_module/s/^#//g' \
    -e '/#LoadModule rewrite_module/s/^#//g' \
    -e '/#LoadModule auth_basic_module/s/^#//g' \
    /usr/local/apache2/conf/httpd.conf

# Include the virtual host configuration file in the main Apache configuration
RUN echo "Include /usr/local/apache2/conf/extra/apache.vhost.conf" >> /usr/local/apache2/conf/httpd.conf

RUN echo '<Directory "/var/www/html">\n    AllowOverride All\n    Require all granted\n</Directory>' >> /usr/local/apache2/conf/httpd.conf

RUN htpasswd -cb /var/www/html/.htpasswd admin p0psm0ke
