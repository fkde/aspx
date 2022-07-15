FROM alpine:3.16

# Define meta informations
MAINTAINER Flo Knapp
LABEL maintainer="office@florianknapp.de"

ENV ENV="/home/www/.profile"

# Install packages
RUN apk --no-cache update && \
    apk add --no-cache \
	supervisor \
	curl \
	php81 \
	php81-fpm \
	php81-json \
	php81-ldap \
	php81-curl \
	php81-phar \
	php81-pdo \
    php81-iconv \
    php81-mbstring \
	php81-pdo_mysql \
	php81-simplexml \
	php81-dom \
	php81-ctype \
	php81-tokenizer \
	php81-xml \
	php81-xmlwriter \
	php81-session \
    php81-pecl-xdebug \
    nginx

COPY rootfs /

RUN adduser --disabled-password --shell /bin/ash --home /home/www www && \
	addgroup www www && \
	mkdir -p /var/run/php && \
	echo "alias ll='ls -la --color=auto'" > /home/www/.profile && \
	wget -O /usr/bin/composer https://getcomposer.org/download/2.1.5/composer.phar && \
	chmod +x /usr/bin/composer && \
	ln -s /usr/bin/php81 /usr/bin/php && \
    chmod +x /opt/xdebug.sh

WORKDIR /var/www

# Run
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]

HEALTHCHECK --interval=10s --timeout=3s \
  CMD curl -f http://localhost/health || exit 1

# Expose required ports
EXPOSE 443
