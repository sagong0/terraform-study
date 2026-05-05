#!/bin/bash

apt-get update
apt-get install nginx -y aws-cli

rm /var/www/html/index.nginx-debian.html
aws s3 sync s3://${bucket_name} /var/www/html