#!/bin/bash
. ~/.nvm/nvm.sh
. ~/.profile
. ~/.bashrc
. /var/www/.envrc
. /var/www/instantboard-web/.envrc
. /var/www/instantboard-app/.envrc
. /var/www/instantboard-api/.envrc

cd /var/www/instantboard-api
git reset --hard @
git pull origin master
rm -rf ./node_modules
nvm install
export NODE_ENV=production
npm install
npm run db:migrate
kill -9 `ps -ax | grep instantboard-api | awk '{print $1}'`
npm start &
