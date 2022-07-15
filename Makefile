include .env

# This should only be called once for the initial setup
first-install: certificates create-env-file fix-run-permissions install

# Install everything
install: env build-app run composer-install message-okay

# Generate self-signed certificates for local development
certificates: generate-certificates fix-cert-permissions

env:
	@set -a; . ./.env; set +a

# Build image separately to use a better caching algorithm
build-app:
	@docker build -t ${PROJECT_NAME} docker

ssh:
	@docker exec -it -u www ${PROJECT_NAME} /bin/sh

# Run the application
run:
	@docker-compose up -d --build

# Remove everything
destroy:
	@docker-compose down --rmi=all

network-create:
	@docker network create ${PROJECT_NAME}

xdebug-on:
	@./bin/run.sh "/opt/xdebug.sh on" true

xdebug-off:
	@./bin/run.sh "/opt/xdebug.sh off" true

# Install composer dependencies
composer-install:
	@./bin/run.sh "composer install"

# Install composer dependencies without "require-dev"
composer-install-prod:
	@./bin/run.sh "composer install --no-dev"

# Update all composer dependencies
composer-update:
	@./bin/run.sh "composer update"

# Print okay message
message-okay:
	@echo "Setup was successful. You may now want to call https://localhost in your browser."

########################################################
# Use the commands below only if you know what they do #
########################################################
generate-certificates:
	@openssl req -new -newkey rsa:4096 -days 3650 -nodes -x509 -subj "/C=DE/ST=BY/L=M/O=eassets.net/CN=eassets.local" -keyout ./docker/rootfs/etc/nginx/ssl/privkey.pem -out ./docker/rootfs/etc/nginx/ssl/fullchain.pem

fix-cert-permissions:
	@chmod 777 ./docker/rootfs/etc/nginx/ssl/*

create-env-file:
	@if [ ! -f ".env" ] ; then cp .env.dist .env; fi

fix-run-permissions:
	chmod +x bin/run.sh
