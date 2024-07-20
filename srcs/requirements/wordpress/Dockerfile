FROM debian:latest

RUN apt update -y
RUN apt upgrade -y
RUN apt install vim -y
RUN apt-get -y install wget
RUN apt-get install -y php7.3\
	php-fpm\
	php-mysql\
	mariadb-client
RUN wget https://fr.wordpress.org/wordpress-6.5.5-fr_FR.tar.gz -P /var/www
RUN cd /var/www && tar -xzf wordpress-6.5.5-fr_FR.tar.gz && rm wordpress-6.5.5-fr_FR.tar.gz
RUN chown -R root:root /var/www/wordpress
COPY conf/php.ini /etc/php/7.3/fpm/php.ini
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp
RUN useradd -ms /bin/bash wordpress
RUN chown -R wordpress:wordpress /var/www/wordpress
USER wordpress
WORKDIR /var/www/wordpress
EXPOSE 9000

RUN sleep 20
RUN wp config create --allow-root \
	--dbname=$WORDPRESS_DB_NAME \
	--dbuser=$WORDPRESS_DB_USER \
	--dbpass=$WORDPRESS_DB_PASSWORD \
	--dbhost=$WORDPRESS_DB_HOST \
	--path='/var/www/wordpress'

#ENTRYPOINT ["bash", "create-config.sh"]
RUN wp core install --url=gpeyre.42 --title=MyWordpress --admin_user=gpeyre
RUN wp user create gpeyre --user_pass=$USER_PASSWORD --role=author
RUN wp user create max --porcelain
CMD ["/bin/bash", "-c", "php-fpm7.3 -F"]
