#!/bin/bash
sudo su
yum update -y
yum install httpd php -y
sudo service httpd start