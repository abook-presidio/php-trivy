# Use official PHP 7.4 with Apache
FROM php:7.4-apache

# Set working directory
WORKDIR /var/www/html

# Copy application files
COPY php/index.php php/vulnerable-lib.php ./

# Copy custom Apache config
COPY httpd.conf /etc/apache2/conf-enabled/httpd.conf

# Enable necessary Apache modules
RUN a2enmod rewrite

# Reduce layer size and install security updates
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
        curl \
        ca-certificates \
        libzip-dev \
        unzip \
        && rm -rf /var/lib/apt/lists/*

# Set correct file permissions (optional, improve security)
RUN chown -R www-data:www-data /var/www/html && chmod -R 755 /var/www/html

# Expose port
EXPOSE 80

# Start Apache (automatically handled by base image's entrypoint)
CMD ["apache2-foreground"]

