FROM debian:buster

RUN apt update -y
RUN apt upgrade -y
RUN apt install mariadb-server -y
RUN apt install vim -y

EXPOSE 3306

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
RUN chmod +x /etc/mysql/mariadb.conf.d

COPY tools/create_user.sh usr/bin/create_user.sh
RUN chmod +x /usr/bin/create_user.sh

ENTRYPOINT ["bash", "create_user.sh"]

#CMD ["tail", "-f"]
