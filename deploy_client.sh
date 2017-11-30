source /var/www/.envrc
source /var/www/instantboard-web/.envrc
source /var/www/instantboard-client/.envrc
source /var/www/instantboard-api/.envrc

cd /var/www/instantboard-client
git reset --hard @
git pull origin master
rm -rf ./node_modules
nvm install
npm install
npm run build
kill -9 `ps -ax | grep instantboard-client | awk '{print $1}'`
npm start &
