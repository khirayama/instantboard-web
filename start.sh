# Install packages
apt update
apt install curl git make g++ mysql-server mysql-client nginx vim -y
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.6/install.sh | bash

# Download resources
cd /var/www
git clone https://github.com/certbot/certbot
git clone https://github.com/khirayama/instantboard-web.git
git clone https://github.com/khirayama/instantboard-app.git
git clone https://github.com/khirayama/instantboard-api.git

# Set up
source ~/.bashrc
service mysql start

cp /var/www/instantboard-web/.envrc.example /var/www/instantboard-web/.envrc
cp /var/www/instantboard-app/.envrc.example /var/www/instantboard-app/.envrc
cp /var/www/instantboard-api/.envrc.example /var/www/instantboard-api/.envrc

echo -e "export NODE_ENV=production\nexport LC_ALL=en_US.UTF-8\nexport LC_CTYPE=en_US.UTF-8" > /var/www/.envrc
vim /var/www/instantboard-web/.envrc
vim /var/www/instantboard-app/.envrc
vim /var/www/instantboard-api/.envrc

source /var/www/.envrc
source /var/www/instantboard-web/.envrc
source /var/www/instantboard-app/.envrc
source /var/www/instantboard-api/.envrc

# For app
cd /var/www/instantboard-app
nvm install
npm install
npm run build
npm start &

# For api
cd /var/www/instantboard-api
nvm install
npm install
echo "CREATE DATABASE instantboard_database_production;" > production.sql
mysql -u root < production.sql
npm run db:migrate
npm start &

# For web
cd /var/www/certbot
./certbot-auto certonly --webroot -d www.instantboard.cloud -m $EMAIL --agree-tos -n --webroot-path /var/www/instantboard-web/
./certbot-auto certonly --webroot -d app.instantboard.cloud -m $EMAIL --agree-tos -n --webroot-path /var/www/instantboard-app/dist/public
./certbot-auto certonly --webroot -d api.instantboard.cloud -m $EMAIL --agree-tos -n --webroot-path /var/www/instantboard-api/src/public

cd /var/www/instantboard-web
nvm install
npm install
npm run build
cp ./nginx.conf /etc/nginx/nginx.conf
nginx
