FROM ubuntu:16.04

ENV DEBIAN_FRONTEND noninteractive

LABEL Description="This image is used to host pear.cakephp.org"

RUN apt-get update && apt-get install -y \
    build-essential \
    nginx git curl \
    php \
    php-bz2 \
    php-json \
    php-mbstring \
    php-zip \
    php-xml \
    php-fpm \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

RUN mkdir /website /root/.ssh

RUN ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts

WORKDIR /data
COPY . /data

VOLUME /data/public

# Install pirum
RUN cd /data \
  && wget https://getcomposer.org/composer.phar \
  && php composer.phar require pirum/pirum

# Build the pear channel from the zip files in the volume.
RUN cd /data/public \
  && ../vendor/bin/pirum build .

RUN rm /var/www/html/index.nginx-debian.html \
  && mv /data/nginx.conf /etc/nginx/sites-enabled/default \
  && ls /etc/nginx/sites-enabled/ /etc/nginx/

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
  && ln -sf /dev/stderr /var/log/nginx/error.log

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
