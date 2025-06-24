# Use an official PHP 7.4 image as the base
FROM php:7.4-fpm

# Copy the PHP script into the container
COPY index.php /app/

# Create a custom Apache configuration file
RUN mkdir -p /etc/apache2/conf.d/
RUN echo "DocumentRoot /app" > /etc/apache2/conf.d/php.conf

# Expose port 80 for Apache to listen on
EXPOSE 80

# Install and configure Apache
RUN apt-get update && \
    apt-get install -y apache2 && \
    rm -rf /var/lib/apt/lists/*

# Start Apache when the container launches
CMD ["apache2-foreground"]
