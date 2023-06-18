#!/bin/bash

sudo apt-get update
sudo apt-get install ca-certificates curl gnupg -y
sudo install -m 0755 -d /etc/apt/keyrings 
 
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
 

echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
 
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
 
echo "${DOCKERFILE_BASE64}" | base64 -d > Dockerfile
echo "${OKJPG_BASE64}" | base64 -d > ok.jpg
echo "${INDEX_HTML_BASE64}" | base64 -d > index.html
echo "${TEST_PHP_BASE64}" | base64 -d > test.php
 
sudo docker build -t mateusclira/challenge .
sudo docker run -d -p 80:80 mateusclira/challenge
