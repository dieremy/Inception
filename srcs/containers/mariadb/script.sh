#!/bin/bash

# Initialize MySQL data directory if it doesn't exist
if [ ! -d "/var/lib/mysql/mysql" ]; then
  chown -R mysql:mysql /var/lib/mysql
  mysql_install_db --basedir=/usr --datadir=/var/lib/mysql --user=mysql --rpm
fi

# Create WordPress database if it doesn't exist
if [ ! -d "/var/lib/mysql/wordpress" ]; then

  CREATE_DB="USE mysql;
FLUSH PRIVILEGES;
CREATE DATABASE ${DB_NAME} CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE USER '${DB_USER}'@'%' IDENTIFIED by '${DB_PSW}';
GRANT ALL PRIVILEGES ON wordpress.* TO '${DB_USER}'@'%';
FLUSH PRIVILEGES;"

  echo "$CREATE_DB" > /tmp/create_db.sql

  /usr/bin/mysqld --user=mysql --bootstrap < /tmp/create_db.sql
  rm -f /tmp/create_db.sql
fi
