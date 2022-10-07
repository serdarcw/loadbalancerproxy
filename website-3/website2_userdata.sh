#! /bin/bash
yum update -y
amazon-linux-extras install nginx1
# get private ip address of ec2 instance using instance metadata
TOKEN=`curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600"` \
&& PRIVATE_IP=`curl -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/local-ipv4`
# get public ip address of ec2 instance using instance metadata
TOKEN=`curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600"` \
&& PUBLIC_IP=`curl -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/public-ipv4` 
# get date and time of server
DATE_TIME=`date`
systemctl start nginx
cd /usr/share/nginx/html
chmod -R 777 /usr/share/nginx/html
rm index.html
FOLDER="https://raw.githubusercontent.com/serdarcw/loadbalancerproxy/main"
wget ${FOLDER}/website-3/guile.jpeg
echo "<html>
<head>
    <title> Application Load Balancer Listener Port Forwarding </title>
</head>
<body>
    <h1>Testing Application Load Balancer with GUILE</h1>
    <h3>This web server is launched from the launch template by YOUR_NAME</h3>
    <p>This instance is created at <b>$DATE_TIME</b></p>
    <p>Private IP address of this instance is <b>$PRIVATE_IP</b></p>
    <p>Public IP address of this instance is <b>$PUBLIC_IP</b></p>
    <center><h1> This is the Demo of ALB - This is Guile </h1><center>
    <center><img src="guile.jpeg" alt="This is the Demo of LoadBalancer Listerner Port Forwarding"</center>
</body>
</html>" > /usr/share/nginx/html/index.html
systemctl restart nginx
systemctl enable nginx