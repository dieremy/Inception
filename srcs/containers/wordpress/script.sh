#!/bin/bash

# # Connect to mariadb container
# ping -c3 127.0.0.1:3306

# # Exit if MariaDB doesn't start after retries
# if [ ! $? -eq 0 ]; then
#   echo "Error: MariaDB failed to start."
#   exit 1
# fi

# until mysql -hmariadb -u${DB_USER} -p${DB_PSW} -e "show databases;" > /dev/null 2>&1; do
#   echo "Waiting for MariaDB..."
#   sleep 3
# done

# if [ ! -f wp-config.php ]; then
#     cp wp-config-sample.php wp-config.php
#     sed -i "s/database_name_here/${DB_NAME}/" wp-config.php
#     sed -i "s/username_here/${DB_USER}/" wp-config.php
#     sed -i "s/password_here/${DB_PSW}/" wp-config.php
#     sed -i "s/localhost/${DB_HOST}/" wp-config.php
# fi

if [ ! -f "/var/www/wp-config.php" ]; then

cat << EOF > /var/www/wp-config.php
<?php
define( 'DB_NAME', '${DB_NAME}' );
define( 'DB_USER', '${DB_USER}' );
define( 'DB_PASSWORD', '${DB_PSW}' );
define( 'DB_HOST', 'mariadb' );
define( 'DB_CHARSET', 'utf8' );
define( 'DB_COLLATE', '' );
define('FS_METHOD','direct');
\$table_prefix = 'wp_';
define( 'WP_DEBUG', false );
if ( ! defined( 'ABSPATH' ) ) {
define( 'ABSPATH', __DIR__ . '/' );}
define( 'WP_REDIS_HOST', 'redis' );
define( 'WP_REDIS_PORT', 6379 );
define( 'WP_REDIS_TIMEOUT', 1 );
define( 'WP_REDIS_READ_TIMEOUT', 1 );
define( 'WP_REDIS_DATABASE', 0 );
require_once ABSPATH . 'wp-settings.php';
EOF

fi
