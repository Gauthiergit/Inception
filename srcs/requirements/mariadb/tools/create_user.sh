service mysql start

#while ! mysqladmin -h localhost ping --silent; do
#    echo "Waiting for MariaDB to be available..."
#    sleep 10
#done

# Créer la base de données et l'utilisateur
mysql -u root -p${MYSQL_ROOT_PASSWORD} <<EOF
CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'localhost' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
EOF

if [ $? -eq 0 ]; then
    echo "Database and user created successfully."
else
    echo "Failed to create database or user."
    exit 1
fi

# Arrêter le service MariaDB
mysqladmin -u root -p${MYSQL_ROOT_PASSWORD} shutdown

service mysql restart
