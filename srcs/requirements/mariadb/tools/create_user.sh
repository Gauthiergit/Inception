service mysql start

mysql -e "CREATE DATABASE IF NOT EXISTS ${WORDPRESS_DB_NAME};"
mysql -e "CREATE USER IF NOT EXISTS ${WORDPRESS_DB_USER}@'localhost' IDENTIFIED BY '${WORDPRESS_DB_PASSWORD}';"
mysql -e "GRANT ALL PRIVILEGES ON ${WORDPRESS_DB_NAME}.* TO ${WORDPRESS_DB_USER}@'%' IDENTIFIED BY '${WORDPRESS_DB_PASSWORD}';"
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"
mysql -e "FLUSH PRIVILEGES;"
mysqladmin -u root -p'no' shutdown
