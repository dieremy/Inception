#!/bin/bash

while ! mysql -hmariadb -u$DB_USER -p$DB_PSW &>/dev/null; do
    echo "Waiting for MariaDB to be ready..."
    sleep 3
done

if [ ! -f "/var/www/wp-config.php" ]; then
    echo "Starting wp set up..."
    wp core download --allow-root
    wp config create --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_PSW --dbhost=mariadb --allow-root
    wp core install --url=$DOMAIN_NAME --title="Sdesdo's Site" --admin_user=admin --admin_password=admin --admin_email=admin@example.com --skip-email --allow-root
    wp user create sdesdo sdesdo@mail.com --role=author --user_pass=Secret1! --allow-root
    wp theme install bizboost --activate --allow-root
fi

/usr/sbin/php-fpm8 -F