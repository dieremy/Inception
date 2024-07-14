#!/bin/bash

# Check if MySQL/MariaDB is initialized
if [ ! -d "/var/lib/mysql/mysql" ]; then
    # Set correct ownership
    chown -R mysql:mysql /var/lib/mysql

    # Initialize database if not already initialized
    mysql_install_db --basedir=/usr --datadir=/var/lib/mysql --user=mysql --rpm

    # Check if temporary file can be created
    tfile=$(mktemp)
    if [ ! -f "$tfile" ]; then
        echo "Failed to create temporary file"
        exit 1
    fi
fi

# Check if WordPress database is created
if [ ! -d "/var/lib/mysql/${DB_NAME}" ]; then
    # Create SQL script to set up database and grant privileges
    cat << EOF > /tmp/create_db.sql
USE mysql;
FLUSH PRIVILEGES;
DELETE FROM mysql.user WHERE User='';
DROP DATABASE test;
DELETE FROM mysql.db WHERE Db='test';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT}';
CREATE DATABASE '${DB_NAME}' CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE USER '$DB_USER'@'%' IDENTIFIED BY '${DB_PSW}';
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '$DB_USER'@'%';
FLUSH PRIVILEGES;
EOF

    # Run SQL script to initialize WordPress database and grant privileges
    /usr/bin/mysqld --user=mysql --bootstrap < /tmp/create_db.sql

    # Remove temporary SQL script
    rm -f /tmp/create_db.sql
fi
