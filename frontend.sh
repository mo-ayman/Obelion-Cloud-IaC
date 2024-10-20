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

pm2 start server/server.js --name uptime-kuma &

cd ..

mkdir actions-runner && cd actions-runner

curl -o actions-runner-linux-x64-2.320.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.320.0/actions-runner-linux-x64-2.320.0.tar.gz

echo "93ac1b7ce743ee85b5d386f5c1787385ef07b3d7c728ff66ce0d3813d5f46900  actions-runner-linux-x64-2.320.0.tar.gz" | shasum -a 256 -c

tar xzf ./actions-runner-linux-x64-2.320.0.tar.gz

./config.sh --url https://github.com/mo-ayman/uptime-kuma --token ATF6WH3XCI3FQRFSQRKVNZLHCS6TQ

./run.sh &



