source /var/www/instantboard-client/.envrc
cd /var/www/instantboard-client
rm -rf ./node_modules
nvm install
npm install
npm run build
kill -9 `ps -ax | grep instantboard-client | awk '{print $1}'`
npm start &