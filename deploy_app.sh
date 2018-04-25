#!/bin/bash
. ~/.nvm/nvm.sh
. ~/.profile
. ~/.bashrc
. /var/www/.envrc
. /var/www/instantboard-web/.envrc
. /var/www/instantboard-app/.envrc
. /var/www/instantboard-api/.envrc

cd /var/www/instantboard-app
git reset --hard @
git pull origin master
rm -rf ./node_modules
nvm install
npm install

export NODE_ENV=production
npm run build
kill -9 `ps -ax | grep instantboard-app | awk '{print $1}'`
npm start &
