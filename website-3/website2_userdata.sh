#! /bin/bash
yum update -y
amazon-linux-extras install nginx1
systemctl start nginx
cd /usr/share/nginx/html
chmod -R 777 /usr/share/nginx/html
rm index.html
FOLDER="https://raw.githubusercontent.com/serdarcw/loadbalancerproxy/main"
wget ${FOLDER}/website-3/index.html
wget ${FOLDER}/website-3/guile.jpeg
systemctl restart nginx
systemctl enable nginx