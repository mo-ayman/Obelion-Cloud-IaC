#!/bin/bash

# Ensure the script stops if any command fails

# Set variables
APP_DIR="laravel"

sudo add-apt-repository ppa:ondrej/php -y
# Step 1: Update the server and install required packages
sudo apt-get update -y

# Install necessary software
sudo apt-get install -y \
    git \
    curl \
    nginx

sudo apt-get install php8.2 php8.2-cli php8.2-fpm php8.2-mbstring php8.2-xml php8.2-curl php8.2-mysql php8.2-zip php8.2-bcmath -y


# Install Composer (PHP dependency manager)
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer

# Step 3: Pull the latest changes from GitHub
echo "Cloning Laravel..."
git clone https://github.com/mo-ayman/laravel.git

cd $APP_DIR
# Step 4: Install PHP dependencies using Composer
# echo "Installing PHP dependencies..."
composer install --no-interaction --prefer-dist --optimize-autoloader

# Step 6: Run database migrations
echo "Running database migrations..."
php artisan migrate --force &

cd ..

mkdir actions-runner && cd actions-runner

curl -o actions-runner-linux-x64-2.320.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.320.0/actions-runner-linux-x64-2.320.0.tar.gz

echo "93ac1b7ce743ee85b5d386f5c1787385ef07b3d7c728ff66ce0d3813d5f46900  actions-runner-linux-x64-2.320.0.tar.gz" | shasum -a 256 -c

tar xzf ./actions-runner-linux-x64-2.320.0.tar.gz

./config.sh --url https://github.com/mo-ayman/laravel --token ATF6WH7CEQCLMZBNE4XDMALHCS6YS

./run.sh &


echo "Deployment complete!"

