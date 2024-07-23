# Démarrer le service MariaDB
service mysql start
sleep 10

SOCKET_DIR="/var/run/mysqld"
SOCKET_FILE="/var/run/mysqld/mysqld.sock"

# Vérifiez si le répertoire de socket existe, sinon le créer
if [ ! -d "$SOCKET_DIR" ]; then
  echo "Le répertoire $SOCKET_DIR n'existe pas. Création en cours..."
  mkdir -p "$SOCKET_DIR"
  chown mysql:mysql "$SOCKET_DIR"
fi

# Vérifiez les permissions du répertoire de socket
chown mysql:mysql "$SOCKET_DIR"

# Redémarrez MariaDB
echo "Redémarrage de MariaDB..."
service mysql restart

# Vérifiez si le fichier de socket a été créé
if [ -S "$SOCKET_FILE" ]; then
  echo "Le fichier de socket $SOCKET_FILE a été créé avec succès."
else
  echo "Le fichier de socket $SOCKET_FILE n'a pas été créé. Vérifiez les logs pour plus d'informations."
  tail -n 20 /var/log/mysql/error.log
fi

# Créer la base de données et l'utilisateur
mysql -u root -p${MYSQL_ROOT_PASSWORD} <<EOF
CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'localhost' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
EOF

# Arrêter le service MariaDB
mysqladmin -u root -p${MYSQL_ROOT_PASSWORD} shutdown
