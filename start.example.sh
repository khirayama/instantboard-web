apt update
apt install curl git mysql-server mysql-client nginx vim -y
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.6/install.sh | bash

source ~/.bashrc
service mysql start

export NODE_ENV=production
export SECRET_KEY=
export FACEBOOK_CLIENT_ID=
export FACEBOOK_CLIENT_SECRET=
export APP_SERVER_HOST=http://app.instantboard.cloud
export API_SERVER_HOST=http://api.instantboard.cloud
export MYSQL_USER=
export MYSQL_PASSWORD=
export MYSQL_DATABASE=
export MYSQL_HOST=

cd /var/www
git clone https://github.com/khirayama/instantboard-web.git
git clone https://github.com/khirayama/instantboard-client.git
git clone https://github.com/khirayama/instantboard-api.git

# For web
cd /var/www/instantboard-web
cp ./nginx.conf /etc/nginx/nginx.conf
nginx

# For client
cd /var/www/instantboard-client
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
