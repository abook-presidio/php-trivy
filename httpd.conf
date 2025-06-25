# httpd.conf

<FilesMatch "\.php$">
    SetHandler php-script
</FilesMatch>

DocumentRoot /path/to/php/script

<Directory /path/to/php/script>
    Options +Indexes +FollowSymLinks
    AllowOverride None
    Require all granted
</Directory>
