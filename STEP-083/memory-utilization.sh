#!/bin/bash

set -e

NGINX_VERSION="1.24.0"

apt-get -y install build-essential zlib1g zlib1g-dev libssl-dev libpcre3 libpcre3-dev

wget http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz -O /tmp/nginx-${NGINX_VERSION}.tar.gz

cd /tmp
tar -xzf /tmp/nginx-${NGINX_VERSION}.tar.gz 
cd nginx-${NGINX_VERSION}

./configure --sbin-path=/usr/bin/nginx --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --http-log-path=/var/log/nginx/access.log --pid-path=/var/run/nginx.pid --with-http_ssl_module --with-pcre

make
make install

nginx -v