# This should only be called once for the initial setup
setup: certificates install

# Install everything
install: env build-app run composer-install message-okay

# Generate self-signed certificates for local development
certificates: generate-certificates fix-cert-permissions

env:
	set -a; . ./.env; set +a

# Build image separately to use a better caching algorithm
build-app:
	docker build -t docker-php-nginx docker

ssh:
	docker exec -it -u www application /bin/sh

# Run the application
run:
	docker-compose up -d --build

# Remove everything
destroy:
	docker-compose down --rmi=all

# Install composer dependencies
composer-install:
	./bin/run.sh "composer install"

# Install composer dependencies without "require-dev"
composer-install-prod:
	./bin/run.sh "composer install --no-dev"

# Update all composer dependencies
composer-update:
	./bin/run.sh "composer update"

# Print okay message
message-okay:
	@echo "Setup was successful. You may now want to call https://localhost in your browser."

########################################################
# Use the commands below only if you know what they do #
########################################################
generate-certificates:
	openssl req -new -newkey rsa:4096 -days 3650 -nodes -x509 -subj "/C=DE/ST=BY/L=M/O=eassets.net/CN=eassets.local" -keyout ./docker/rootfs/etc/nginx/ssl/privkey.pem -out ./docker/rootfs/etc/nginx/ssl/fullchain.pem

fix-cert-permissions:
	chmod 777 ./docker/rootfs/etc/nginx/ssl/*
