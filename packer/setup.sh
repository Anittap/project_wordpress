#!/bin/bash

echo "ClientAliveInterval 60" >> /etc/ssh/sshd_config
systemctl restart sshd.service

hostnamectl set-hostname redux-wp
yum update -y
yum install -y python3 python3-pip