#!/bin/bash


sudo apt-get update -y
sudo apt-get install git curl -y

# Download the NodeSource Node.js 18.x repository setup script
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -

# Install Node.js 20
sudo apt-get install -y nodejs

node -v

git clone https://github.com/louislam/uptime-kuma.git
cd uptime-kuma
npm run setup

sudo npm install pm2 -g && pm2 install pm2-logrotate

pm2 start server/server.js --name uptime-kuma 


