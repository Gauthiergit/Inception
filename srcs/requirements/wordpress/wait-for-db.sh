#!/bin/bash
until mysql -h"$WORDPRESS_DB_HOST" -u"$WORDPRESS_DB_USER" -p"$WORDPRESS_DB_PASSWORD" -e "show databases;" > /dev/null 2>&1; do
  echo "Waiting for MySQL to be ready..."
  sleep 2
done
