.PHONY: certificates install-dev

# Install everything
install: build-app run

# Generate self-signed certificates for local development
certificates: generate-certificates fix-cert-permissions

build-app:
	docker build -t eassets.net/application docker/app

# Run the application
run:
	docker-compose up -d

########################################################
# Use the commands below only if you know what they do #
########################################################
generate-certificates:
	openssl req -new -newkey rsa:4096 -days 3650 -nodes -x509 -subj "/C=DE/ST=BY/L=M/O=eassets.net/CN=eassets.local" -keyout ./docker/rootfs/etc/nginx/ssl/privkey.pem -out ./docker/rootfs/etc/nginx/ssl/fullchain.pem

fix-cert-permissions:
	chmod 777 ./docker/rootfs/etc/nginx/ssl/*
