#!/bin/bash -ex

git pull

# build app
cd nodejs
npm install

cd -
# nginx
sudo cp nginx/nginx.conf /etc/nginx
sudo cp nginx/sites-available/*.conf /etc/nginx/sites-available
sudo systemctl restart nginx.service

# mysql
sudo cp mysql/conf.d/*.cnf /etc/mysql/conf.d
sudo cp mysql/mysql.conf.d/*.cnf /etc/mysql/mysql.conf.d 
sudo systemctl restart mysql.service

# deploy app
sudo cp nodejs/issumo.nodejs.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl restart issumo.nodejs.service

#　initialize log
sudo bash -c 'echo > /var/log/nginx/access.log; echo > /var/log/mysql/slow.log;'

sudo journalctl -f
