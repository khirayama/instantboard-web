#!/bin/bash
. ~/.bashrc
. /var/www/.envrc
. /var/www/instantboard-web/.envrc
. /var/www/instantboard-client/.envrc
. /var/www/instantboard-api/.envrc

cd /var/www/certbot
./certbot-auto renew

cd /var/www/instantboard-web
git reset --hard @
git pull origin master
cp ./nginx.conf /etc/nginx/nginx.conf
nginx -s stop
nginx
