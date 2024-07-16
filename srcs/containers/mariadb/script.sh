#!/bin/bash

# Set correct ownership on data directory
chown -R mysql:mysql /var/lib/mysql

# Check if database needs initialization
if mysql -uroot -e "SELECT 1" > /dev/null 2>&1; then
  echo "Database already initialized"
  exit 0
fi

echo "CREATE USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '${DB_ROOT}';" | mysql

# Disable remote root access
echo "GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' WITH GRANT OPTION;" | mysql
echo "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');" | mysql

# Create the WordPress database and user with minimal privileges
echo "CREATE DATABASE ${DB_NAME} CHARACTER SET utf8 COLLATE utf8_general_ci;" | mysql
echo "CREATE USER '${DB_USER}'@'%' IDENTIFIED BY '${DB_PSW}';" | mysql
echo "GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';" | mysql

# Flush privileges for immediate effect
echo "FLUSH PRIVILEGES;" | mysql

echo "Database initialized successfully"

# exec /usr/bin/mysqld --user=mysql --console