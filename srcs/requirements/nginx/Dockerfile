FROM debian:buster

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y nginx openssl

RUN mkdir -p /etc/nginx/ssl

COPY ./conf/nginx.conf /etc/nginx/nginx.conf

# Copier la configuration de votre site
COPY ./conf/gpeyre.conf /etc/nginx/sites-available/gpeyre.conf

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/inception.key -out /etc/nginx/ssl/inception.crt -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=gpeyre.42.fr"

# Créer un lien symbolique dans sites-enabled
RUN rm -f /etc/nginx/sites-enabled/default && ln -s /etc/nginx/sites-available/gpeyre.conf /etc/nginx/sites-enabled/

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
 
