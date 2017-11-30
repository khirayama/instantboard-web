source /var/www/.envrc
source /var/www/instantboard-web/.envrc
source /var/www/instantboard-client/.envrc
source /var/www/instantboard-api/.envrc

cd /var/www/instantboard-api
git reset --hard @
git pull origin master
rm -rf ./node_modules
nvm install
npm install
npm run db:migrate
kill -9 `ps -ax | grep instantboard-api | awk '{print $1}'`
npm start &
