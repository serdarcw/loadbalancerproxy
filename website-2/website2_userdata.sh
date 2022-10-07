#! /bin/bash
yum update -y
amazon-linux-extras install nginx1
systemctl start nginx
cd /usr/share/nginx/html
chmod -R 777 /usr/share/nginx/html
rm index.html
FOLDER="https://raw.githubusercontent.com/serdarcw/loadbalancerproxy/main"
wget ${FOLDER}/website-2/index.html
wget ${FOLDER}/website-2/ken.png
systemctl restart nginx
systemctl enable nginx