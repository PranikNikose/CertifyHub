#!/bin/bash
set -e

dnf update -y

dnf install -y \
docker \
git \
wget \
unzip \
jq

systemctl enable docker
systemctl start docker

usermod -aG docker ec2-user

curl -SL https://github.com/docker/compose/releases/latest/download/docker-compose-linux-x86_64 \
-o /usr/local/bin/docker-compose

chmod +x /usr/local/bin/docker-compose

ln -sf /usr/local/bin/docker-compose /usr/bin/docker-compose