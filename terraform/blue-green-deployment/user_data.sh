#!/bin/bash

sudo apt update
sudo apt install nginx -y

INSTANCE_PUBLIC_IP=$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)

cat << EOF | sudo tee /var/www/html/index.html
<!DOCTYPE html>
<html>
<head>
    <title>Check High Availability</title>
</head>
<body>
    <h1>Public IP: $INSTANCE_PUBLIC_IP</h1>
</body>
</html>
EOF

systemctl start nginx
systemctl enable --now nginx