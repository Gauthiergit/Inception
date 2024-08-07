#!/bin/bash

# Wait for 10 seconds
sleep 10

# Check if /var/www/wordpress/wp-config.php doesn't exist
if [ ! -e /var/www/html/wp-config.php ]; then
    echo "CREATION WP-CONFIG.PHP on gpeyre.42.fr"

    
	sed -i "s/password_here/$WORDPRESS_DB_PASSWORD/g" /var/www/html/wp-config-sample.php
	sed -i "s/localhost/mariadb/g" /var/www/html/wp-config-sample.php
	sed -i "s/database_name_here/$WORDPRESS_DB_NAME/g" /var/www/html/wp-config-sample.php
	cp /var/www/wordpress/wp-config-sample.php /var/www/html/wp-config.php

    # Install WordPress using wp-cli
    wp core install --url=gpeyre.42.fr \
        --title=MyWordpress \
        --admin_user=$WORDPRESS_DB_USER \
        --admin_password=$WORDPRESS_DB_PASSWORD \
        --allow-root --path="/var/www/html"

    # Create a user using wp-cli
    wp user create --allow-root --role=author $WORDPRESS_DB_USER \
        --user_pass=$WORDPRESS_DB_PASSWORD --path="/var/www/html" >> /log.txt
fi

exec "$@"
