FROM alpine:edge

# Define meta informations
MAINTAINER Flo Knapp
LABEL maintainer="office@florianknapp.de"

ENV ENV="/home/www/.profile"

# Install packages
RUN apk --no-cache update && \
    apk add --no-cache \
	supervisor \
	curl \
	php84 \
	php84-fpm \
	php84-json \
	php84-ldap \
	php84-curl \
	php84-phar \
	php84-pdo \
    php84-iconv \
    php84-mbstring \
	php84-pdo_mysql \
	php84-simplexml \
	php84-dom \
	php84-ctype \
	php84-tokenizer \
	php84-xml \
	php84-xmlwriter \
	php84-session \
    php84-pecl-xdebug \
    nginx

COPY rootfs /

RUN adduser --disabled-password --shell /bin/ash --home /home/www www && \
	addgroup www www && \
	mkdir -p /var/run/php && \
	echo "alias ll='ls -la --color=auto'" > /home/www/.profile && \
	wget -O /usr/bin/composer https://getcomposer.org/download/2.5.8/composer.phar && \
	chmod +x /usr/bin/composer && \
	if [ ! -e "/usr/bin/php" ]; then ln -s /usr/bin/php82 /usr/bin/php; fi && \
    chmod +x /opt/xdebug.sh

WORKDIR /var/www

# Run
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]

HEALTHCHECK --interval=10s --timeout=3s \
  CMD curl -f http://localhost/health || exit 1

# Expose required ports
EXPOSE 443
