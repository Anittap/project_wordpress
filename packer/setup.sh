#!/bin/bash

# Set hostname
hostnamectl set-hostname redux-wp

# Update system packages
yum update -y

# Install required packages for LEMP stack
yum install -y nginx php php-fpm php-mysqlnd git php-json php-opcache php-mbstring php-xml php-gd unzip

# Update PHP-FPM configuration to run as Nginx user
sed -i 's/^user = apache/user = nginx/' /etc/php-fpm.d/www.conf
sed -i 's/^group = apache/group = nginx/' /etc/php-fpm.d/www.conf
sed -i 's/^listen.owner = apache/listen.owner = nginx/' /etc/php-fpm.d/www.conf
sed -i 's/^listen.group = apache/listen.group = nginx/' /etc/php-fpm.d/www.conf

# Enable and start Nginx and PHP-FPM
systemctl enable nginx php-fpm
systemctl restart nginx php-fpm

# Define WordPress destination directory
DEST_DIR="/usr/share/nginx/html/"

# Ensure destination exists
cd $DEST_DIR
rm -vf index.html
git clone https://github.com/Anittap/wp_site.git
# Copy WordPress files from current directory
cp -r wp_site/* $DEST_DIR
# Set correct ownership and permissions
chown -R nginx:nginx $DEST_DIR

echo "WordPress installation and LEMP setup completed."
