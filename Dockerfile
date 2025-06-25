# Use official PHP with Apache
FROM php:8.2-apache
LABEL org.opencontainers.image.authors="WebTech Administrators"

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libapache2-mod-auth-cas \
    freetds-dev \
    libbz2-dev \
    libc-client-dev \
    libicu-dev \
    libldap2-dev \
    libonig-dev \
    libpng-dev \
    libpq-dev \
    libtidy-dev \
    libxml2-dev \
    libxpm-dev \
    libxslt-dev \
    libzip-dev \
    && rm -rf /var/lib/apt/lists/*

# Unneeded dependencies
# libenchant-2-2
# libffi-dev
# libkrb5-dev
# libmagickwand-dev
# unixodbc
# unixodbc-dev
# zlib1g-dev

# Not sure where this fits in, but install/accept mssql drivers
# Specific to ubuntu20... I ran into issues trying newer versions previously
#RUN apt update && apt upgrade -y
#ENV ACCEPT_EULA=Y
#RUN apt-get install -y gnupg2
#RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
#RUN curl https://packages.microsoft.com/config/ubuntu/20.04/prod.list > /etc/apt/sources.list.d/mssql-release.list
#RUN apt update

# Install PHP extensions
RUN docker-php-ext-install \
    bcmath \
    bz2 \
    calendar \
    dba \
    exif \
    gd \
    gettext \
    intl \
    ldap \
    mysqli \
    opcache \
    pdo_dblib \
    pdo_mysql \
    pdo_pgsql \
    pgsql \
    tidy \
    xsl \
    zip


# Unneeded extensions
# enchant
# ffi
# ftp
# imap
# shmop
# soap
# sockets
# sysvmsg
# sysvsem
# sysvshm


# Configure some PHP extensions
#RUN docker-php-ext-configure gd --with-freetype --with-jpeg --with-xpm --with-webp
#RUN docker-php-ext-configure imap --with-kerberos --with-imap-ssl
#RUN docker-php-ext-configure odbc --with-unixODBC=shared,/usr
#RUN docker-php-ext-configure pdo_odbc --with-pdo-odbc=unixODBC,/usr

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Set working directory
WORKDIR /var/www/html

# Copy shared configuration files
#COPY shared/000-default.conf /etc/apache2/sites-enabled/000-default.conf
COPY shared/apache2.conf /etc/apache2/apache2.conf
#COPY shared/modules.conf /etc/apache2/conf-enabled/modules.conf
#COPY shared/auth_cas_prod.conf /etc/apache2/conf-available/auth_cas_prod.conf
#COPY shared/auth_cas_stage.conf /etc/apache2/conf-available/auth_cas_stage.conf
#COPY shared/auth_cas_test.conf /etc/apache2/conf-available/auth_cas_test.conf

# Make /tmp/mod_auth_cas/ directory
RUN mkdir -p /tmp/mod_auth_cas/
RUN chown -R www-data:www-data /tmp/mod_auth_cas/
RUN chmod -R 755 /tmp/mod_auth_cas/

# Copy 404 page to error-pages directory (outside /var/www/html to avoid network mount issues)
RUN mkdir -p /etc/apache2/custom-error-pages/
##COPY shared/404-not-found.html /etc/apache2/custom-error-pages/404.html

# Add health check
#COPY shared/health-check.sh /health-check.sh
#RUN chmod +x /health-check.sh
#HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
#    CMD /bin/sh -c /health-check.sh

# Start Apache
CMD ["apache2-foreground"]
