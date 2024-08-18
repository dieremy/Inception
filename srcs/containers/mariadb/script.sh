#!/bin/bash

check_mariadb() {
    mysqladmin ping -h localhost --silent
}

# Initialize MariaDB if not already initialized
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing MariaDB..."
    mysql_install_db --user=mysql --datadir=/var/lib/mysql

    # Start MariaDB in the background
    mysqld_safe --datadir=/var/lib/mysql &

    echo "Waiting for MariaDB to start..."
    until check_mariadb; do
        sleep 1
    done

    echo "MariaDB started. Running initialization script..."
    echo "Starting WordPress setup..."

# debug
    # echo "MYSQL_ROOT_PASSWORD: $MYSQL_ROOT_PASSWORD"
    # echo "MYSQL_DATABASE: $MYSQL_DATABASE"
    # echo "MYSQL_USER: $MYSQL_USER"
    # echo "MYSQL_PASSWORD: $MYSQL_PASSWORD"

    # Run the initialization SQL
    mysql -u root <<-EOSQL
DELETE FROM mysql.user WHERE User='';
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE} CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
EOSQL

    echo "Stopping MariaDB..."
    mysqladmin -u root -p"${MYSQL_ROOT_PASSWORD}" shutdown

    # Wait for MariaDB to shut down completely
    sleep 5
fi

# Start MariaDB normally
echo "Starting MariaDB..."
exec mysqld_safe --datadir=/var/lib/mysql
