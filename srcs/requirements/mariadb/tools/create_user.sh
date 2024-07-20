# Démarrer le service MariaDB
mysqld_safe --skip-networking &
sleep 10

# Créer la base de données et l'utilisateur
mysql -u root -p${MYSQL_ROOT_PASSWORD} <<EOF
CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'localhost' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
EOF

# Arrêter le service MariaDB
mysqladmin -u root -p${MYSQL_ROOT_PASSWORD} shutdown

# Démarrer MariaDB en mode 'safe'
exec mysqld_safe
