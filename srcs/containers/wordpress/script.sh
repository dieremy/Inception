#!/bin/bash

set -e

# Debug
# echo "Starting WordPress setup..."
# echo "Database Host: $WORDPRESS_DB_HOST"
# echo "Database Name: $WORDPRESS_DB_NAME"
# echo "Database User: $WORDPRESS_DB_USER"
# echo "Database Password: $WORDPRESS_DB_PASSWORD"
# echo "Domain Name: $DOMAIN_NAME"

# Generate static HTML
bash /var/www/html/generate_static.sh

# Download WordPress core
wp core download --allow-root

# Create wp-config.php file with Redis configuration
wp config create \
  --dbname=$WORDPRESS_DB_NAME \
  --dbuser=$WORDPRESS_DB_USER \
  --dbpass=$WORDPRESS_DB_PASSWORD \
  --dbhost=mariadb \
  --allow-root || { echo 'wp config create failed'; exit 1; }

# Append Redis configuration to wp-config.php
# cat <<EOF >> /var/www/html/wp-config.php

# // Redis configuration
# define('WP_REDIS_HOST', 'redis'); // Redis service name in Docker
# define('WP_REDIS_PORT', 6379); // Default Redis port
# // Uncomment and set if Redis requires a password
# // define('WP_REDIS_PASSWORD', 'your-redis-password');

# // Enable Redis object cache
# define('WP_CACHE', true);
# define('WP_REDIS_DISABLED', false);

# // Load the Redis object cache plugin
# if ( ! defined( 'WP_REDIS_DISABLED' ) || ! WP_REDIS_DISABLED ) {
#     require_once ABSPATH . 'wp-content/plugins/redis-cache/redis-cache.php';
# }
# EOF

# Install WordPress
wp core install \
  --url=$DOMAIN_NAME \
  --title="Dioporco" \
  --admin_user=admin \
  --admin_password=admin \
  --admin_email=admin@example.com \
  --skip-email \
  --allow-root || { echo 'wp core install failed'; exit 1; }

# Create an author user
wp user create sdesdo sdesdo@mail.com --role=author --user_pass=Secret1! --allow-root || { echo 'wp user create failed'; exit 1; }

# Install and activate the Astra theme
wp theme install astra --activate --allow-root || { echo 'wp theme install failed'; exit 1; }

# Install and activate the WordPress Importer plugin
wp plugin install wordpress-importer --activate --allow-root || { echo 'wp plugin install failed'; exit 1; }

# Uncomment to import content
# wp import wp-inception.xml --authors=create --allow-root || { echo 'wp import failed'; exit 1; }

# Install and activate the Redis Cache plugin
wp plugin install redis-cache --activate --allow-root || { echo 'redis-cache plugin install failed'; exit 1; }

/usr/sbin/php-fpm82 -F

# Adminer login 
curl -k -s -X POST https://127.0.0.1/adminer \
    -d "auth[driver]=mysql" \
    -d "auth[server]=mariadb" \
    -d "auth[username]=sdesdo" \
    -d "auth[password]=1234" \
    -d "auth[db]=wordpress" \
    -H "Content-Type: application/x-www-form-urlencoded"
