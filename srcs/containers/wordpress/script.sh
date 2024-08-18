#!/bin/bash

set -e

# debug
# echo "Starting WordPress setup..."
# echo "Database Name: $WORDPRESS_DB_NAME"
# echo "Database User: $WORDPRESS_DB_USER"
# echo "Database Password: $WORDPRESS_DB_PASSWORD"
# echo "Domain Name: $DOMAIN_NAME"

wp core download --allow-root
wp config create --dbname=$WORDPRESS_DB_NAME --dbuser=$WORDPRESS_DB_USER --dbpass=$WORDPRESS_DB_PASSWORD --dbhost=mariadb --allow-root || { echo 'wp config create failed'; exit 1; }
wp core install --url=$DOMAIN_NAME --title="Dioporco" --admin_user=admin --admin_password=admin --admin_email=admin@example.com --skip-email --allow-root || { echo 'wp core install failed'; exit 1; }
wp user create sdesdo sdesdo@mail.com --role=author --user_pass=Secret1! --allow-root || { echo 'wp user create failed'; exit 1; }
wp theme install astra --activate --allow-root || { echo 'wp theme install failed'; exit 1; }
wp plugin install wordpress-importer --activate || { echo 'wp plugin install failed'; exit 1; }
# wp import wp-inception.xml --authors=create || { echo 'wp import failed'; exit 1; }

/usr/sbin/php-fpm82 -F
