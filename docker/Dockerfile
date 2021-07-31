FROM alpine:3.14

# Define meta informations
MAINTAINER Flo Knapp
LABEL maintainer="office@florianknapp.de"

ENV ENV="/home/www/.profile"

# Install packages
RUN apk --no-cache update && \
    apk add --no-cache \
	supervisor \
	curl \
	php8 \
	php8-fpm \
	php8-json \
	php8-ldap \
	php8-curl \
	php8-phar \
	php8-pdo \
	php8-pdo_mysql \
	php8-pdo_sqlite \
	php8-simplexml \
	php8-dom \
	php8-ctype \
	php8-tokenizer \
	php8-xml \
	php8-xmlwriter \
	php8-session \
	nginx

RUN adduser --disabled-password --shell /bin/ash --home /home/www www && \
	addgroup www www && \
	mkdir -p /var/run/php && \
	echo "alias ll='ls -la --color=auto'" > /home/www/.profile && \
	wget -O /usr/bin/composer https://getcomposer.org/download/2.1.5/composer.phar && \
	chmod +x /usr/bin/composer && \
	ln -s /usr/bin/php8 /usr/bin/php

COPY rootfs /

WORKDIR /var/www

# Run
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]

HEALTHCHECK --interval=10s --timeout=3s \
  CMD curl -f http://localhost/health || exit 1

# Expose required ports
EXPOSE 443
