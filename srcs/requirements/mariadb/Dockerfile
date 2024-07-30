FROM debian:bullseye

RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get remove --purge mariadb-server mariadb-client
RUN apt-get autoremove
RUN apt-get autoclean
RUN apt-get install mariadb-server -y
RUN apt-get install vim -y

RUN mkdir -p /run/mysqld && chown mysql:mysql /run/mysqld
RUN chmod 755 /run/mysqld
#RUN touch /run/mysqld/mysqld.sock
#RUN chmod 777 /run/mysqld/mysqld.sock

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
RUN chmod 755 /etc/mysql/mariadb.conf.d/50-server.cnf

EXPOSE 3306

COPY tools/create_user.sh /tmp/create_user.sh
RUN chmod 755 /tmp/create_user.sh

#RUN chmod 777 /var/run/mysqld

#CMD ["bash", "-c", "service mysql start && bash /usr/bin/create_user.sh"]
ENTRYPOINT ["sh", "/tmp/create_user.sh"]
CMD ["mariadbd"]
#CMD ["tail", "-f"]
