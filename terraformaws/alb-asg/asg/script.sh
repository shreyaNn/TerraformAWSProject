#!/bin/bash
yum update -y
sudo amazon-linux-extras install nginx1 -y
#mkdir -p /usr/share/nginx/html
echo "Hi Shreya" > /usr/share/nginx/html/index.html
sudo systemctl start nginx
sudo systemctl enable nginx
