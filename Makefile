ifneq ($(MAKECMDGOALS),clean)
-include .env
endif


# This should only be called once for the initial setup
first-install: check-env-file certificates fix-run-permissions install

# Install everything
install: check-env-file build-app run composer-install message-okay

# Generate self-signed certificates for local development
certificates: generate-certificates fix-cert-permissions

# Build image separately to use a better caching algorithm
build-app:
	@docker build -t ${PROJECT_NAME} docker

# Opens a ssh session into the container
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
	@openssl req -new -newkey rsa:4096 -days 3650 -nodes -x509 -subj "/C=DE/ST=BY/L=M/O=app/CN=app.local" -keyout ./docker/rootfs/etc/nginx/ssl/privkey.pem -out ./docker/rootfs/etc/nginx/ssl/fullchain.pem

fix-cert-permissions:
	@chmod 777 ./docker/rootfs/etc/nginx/ssl/*

check-env-file:
	@if [ ! -f ".env" ] ; then echo "Error: You first have to copy the .env.dist and adjust the project name to your needs."; exit 2; fi

create-env-file:
	@if [ ! -f ".env" ] ; then cp .env.dist .env; fi

env:
	@set -a; . ./.env; set +a

fix-run-permissions:
	@chmod +x bin/run.sh
