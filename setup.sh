#!/usr/bin/env bash
set -e

sudo apt update

sudo apt install -y erlang-nox rabbitmq-server php8.3-cli php8.3-amqp php8.3-bcmath php8.3-mbstring git curl unzip

sudo systemctl enable rabbitmq-server

sudo systemctl start rabbitmq-server

sudo apt install -y composer

PROJECT_DIR="$HOME/IT490"
if [ ! -d "$PROJECT_DIR" ]; then
  git clone https://github.com/MattToegel/IT490.git "$PROJECT_DIR"
fi
cd "$PROJECT_DIR"
sed -i 's/"type":[[:space:]]*"[^"]\+"/"type": "project"/' composer.json
composer install --no-interaction --prefer-dist
[ -f "$PROJECT_DIR/vendor/autoload.php" ] || { echo "Missing vendor/autoload.php" >&2; exit 1; }

echo "Setup complete."
