#!/bin/bash

# while ! mysql -hmariadb -u$DB_USER -p$DB_PSW &>/dev/null; do
#     echo "Waiting for MariaDB to be ready..."
#     sleep 3
# done

# if [ ! -f "/var/www/html/wp-config.php" ]; then
cd /var/www/html/

echo "Starting WordPress setup..."
wp core download --allow-root
wp config create --dbname=$WORDPRESS_DB_NAME --dbuser=$WORDPRESS_DB_USER --dbpass=$WORDPRESS_DB_PASSWORD --dbhost=mariadb --allow-root
wp core install --url=$DOMAIN_NAME --title="Your Site" --admin_user=admin --admin_password=admin --admin_email=admin@example.com --skip-email --allow-root
wp user create sdesdo sdesdo@mail.com --role=author --user_pass=Secret1! --allow-root
wp theme install bizboost --activate --allow-root
wp-cli plugin install wordpress-importer --activate
wp-cli import wordpress-inception.xml --authors=create
# fi

/usr/sbin/php-fpm82 -F