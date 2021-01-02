FROM alpine:3.12

# Define meta informations
MAINTAINER eassets.net
LABEL maintainer="dev@eassets.net"

# Install packages
RUN apk add --no-cache \
	supervisor \
	curl \
	php7-fpm \
	php7-json \
	php7-ldap \
	php7-curl \
	php7-pdo \
	php7-pdo_mysql \
	php7-pdo_sqlite \
	php7-simplexml \
	php7-dom \
	php7-ctype \
	php7-tokenizer \
	php7-xml \
	php7-xmlwriter \
	php7-session \
	composer \
	nginx

RUN adduser --disabled-password --shell /bin/ash --home /home/www www && \
	addgroup www www && \
	mkdir -p /var/run/php && \
	rm /etc/nginx/conf.d/default.conf

COPY rootfs /

WORKDIR /var/www

# Run
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]

HEALTHCHECK --interval=10s --timeout=3s \
  CMD curl -f http://localhost/health || exit 1

# Expose required ports
EXPOSE 443