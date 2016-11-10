FROM ubuntu:16.04

ENV DEBIAN_FRONTEND noninteractive

LABEL Description="This image is used to host pear.cakephp.org"

RUN apt-get update && apt-get install -y \
    wget \
    build-essential \
    nginx git curl \
    php \
    php-bz2 \
    php-json \
    php-mbstring \
    php-zip \
    php-xml \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

RUN mkdir /app /root/.ssh

RUN ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts

WORKDIR /app
COPY . /app

VOLUME /app/public

RUN rm /var/www/html/index.nginx-debian.html \
  && mv /app/nginx.conf /etc/nginx/sites-enabled/default

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
  && ln -sf /dev/stderr /var/log/nginx/error.log

EXPOSE 80

ENTRYPOINT ["/app/docker-entrypoint.sh"]
