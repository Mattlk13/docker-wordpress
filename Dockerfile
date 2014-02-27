FROM base/arch
MAINTAINER DPaW Applications <asi@dpaw.wa.gov.au>
# Basic Requirements
RUN pacman -Syu --noconfirm base-devel archlinux-keyring
RUN pacman -S --noconfirm mariadb mariadb-clients nginx php-fpm php-apcu pwgen git unzip procps-ng supervisor

# Wordpress Requirements
RUN pacman -S --noconfirm php-gd php-intl php-pear php-mcrypt php-memcache php-pspell php-sqlite php-tidy php-xsl php-ldap imagemagick
RUN pecl config-set php_ini /etc/php/php.ini && pear config-set php_ini /etc/php/php.ini
RUN pecl channel-update pecl.php.net && echo yes | pecl -q install imagick

# php config
RUN sed -i "s/;\(extension=\(curl\|imap\|intl\|ldap\|mcrypt\|memcache\|mysqli\|pspell\|gd\|sqlite3\|tidy\|xmlrpc\|xsl\).so\)/\1/g" /etc/php/php.ini /etc/php/conf.d/*.ini
RUN sed -i "s/;cgi.fix_pathinfo=.*/cgi.fix_pathinfo=0/g" /etc/php/php.ini
RUN sed -i "s/upload_max_filesize =.*/upload_max_filesize = 1024M/g" /etc/php/php.ini
RUN sed -i "s/post_max_size =.*/post_max_size = 1024M/g" /etc/php/php.ini

# Install Wordpress
ADD http://wordpress.org/latest.tar.gz /usr/share/nginx/latest.tar.gz
RUN cd /usr/share/nginx/ && tar xf latest.tar.gz && rm latest.tar.gz
RUN mv /usr/share/nginx/wordpress /usr/share/nginx/www
RUN mv /usr/share/nginx/html/5* /usr/share/nginx/www/ && chown -R http:http /usr/share/nginx/www

# nginx config
ADD nginx.conf /etc/nginx/nginx.conf

# Supervisor Config
ADD supervisord.conf /etc/supervisord.conf

# Wordpress Initialization and Startup Script
ADD start.sh /usr/local/bin/start.sh

# private expose
EXPOSE 80

CMD ["start.sh"]

