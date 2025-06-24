# Use an official PHP 7.4 image as the base
FROM php:7.4-fpm

# Set the working directory to /app
WORKDIR /app

# Copy the PHP script into the container
COPY php/index.php /app/

# Expose port 80 for Apache to listen on
EXPOSE 80

# Install and configure Apache
RUN apt-get update && \
    apt-get install -y apache2 && \
    rm -rf /var/lib/apt/lists/*

# Create a custom Apache configuration file
RUN echo "DocumentRoot /app" >> /etc/apache2/conf.d/php.conf

# Configure Apache to serve the PHP script with the vulnerable library
RUN echo "<FilesMatch \".php$\"> SetHandler php-script </FilesMatch>" >> /etc/apache2.conf

# Start Apache when the container launches
CMD ["apache2-foreground"]
