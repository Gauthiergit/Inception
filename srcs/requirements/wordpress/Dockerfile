FROM debian:buster

RUN apt update -y
RUN apt upgrade -y
RUN apt install vim -y
RUN apt install curl -y
RUN apt-get -y install wget
RUN apt-get install -y php7.3\
	php-fpm\
	php-mysql\
	mariadb-client

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp && \
    wp --info

RUN wget https://fr.wordpress.org/wordpress-6.5.5-fr_FR.tar.gz -P /var/www
RUN cd /var/www && tar -xzf wordpress-6.5.5-fr_FR.tar.gz && rm wordpress-6.5.5-fr_FR.tar.gz
RUN chown -R root:root /var/www/wordpress

#COPY conf/php.ini /etc/php/7.3/fpm/php.ini
COPY conf/www.conf /etc/php/7.3/fpm/pool.d/


COPY wait-for-db.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/wait-for-db.sh

#RUN sleep 10
#RUN wp config create --allow-root \
#	--dbname=$WORDPRESS_DB_NAME \
#	--dbuser=$WORDPRESS_DB_USER \
#	--dbpass=$WORDPRESS_DB_PASSWORD \
#	--dbhost=$WORDPRESS_DB_HOST \
#	--path='/var/www/wordpress'

EXPOSE 9000

#RUN wp core install --url=gpeyre.42.fr --title=MyWordpress --admin_user=gpeyre
#RUN wp user create gpeyre --user_pass=$MYSQL_PASSWORD --role=author
#RUN wp user create max --porcelain

COPY create-config.sh /usr/bin/create-config.sh
RUN chmod +x /usr/bin/create-config.sh
ENTRYPOINT ["bash", "create-config.sh"]

#CMD ["/bin/bash", "-c", "php-fpm7.3 -F"]
