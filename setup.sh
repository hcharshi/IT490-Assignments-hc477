#!/bin/bash

# Update package list
sudo apt update && sudo apt upgrade -y

# Install PHP and needed extensions
sudo apt install -y php php-cli php-mbstring php-curl php-xml php-bcmath

# Install Composer if not available
if ! [ -x "$(command -v composer)" ]; then
    curl -sS https://getcomposer.org/installer | php
    sudo mv composer.phar /usr/local/bin/composer
fi

# Install RabbitMQ
sudo apt install -y rabbitmq-server

# Start and enable RabbitMQ
sudo systemctl enable rabbitmq-server
sudo systemctl start rabbitmq-server

# Enable and start SSH (if not already running)
sudo apt install -y openssh-server
sudo systemctl enable ssh
sudo systemctl start ssh

# Go to project folder and install PHP dependencies
cd ~/IT490
if [ ! -d "vendor" ]; then
    composer install
fi

echo "✅ Setup completed successfully!"
