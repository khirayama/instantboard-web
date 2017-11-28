source /var/www/.envrc
source /var/www/instantboard-web/.envrc

cd /var/www/certbot
./certbot-auto renew

cd /var/www/instantboard-web
git reset --hard @
cp ./nginx.conf /etc/nginx/nginx.conf
nginx -s stop
nginx
