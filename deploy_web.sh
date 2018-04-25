#!/bin/bash
. ~/.nvm/nvm.sh
. ~/.profile
. ~/.bashrc
. /var/www/.envrc
. /var/www/instantboard-web/.envrc
. /var/www/instantboard-app/.envrc
. /var/www/instantboard-api/.envrc

cd /var/www/certbot
./certbot-auto renew

cd /var/www/instantboard-web
git reset --hard @
git pull origin master
rm -rf ./node_modules
nvm install
npm install

export NODE_ENV=production
npm run build
cp ./nginx.conf /etc/nginx/nginx.conf
nginx -s stop
nginx
