FROM alpine:3.19.1

# Define meta informations
MAINTAINER Flo Knapp
LABEL maintainer="office@florianknapp.de"

ENV ENV="/home/www/.profile"

# Install packages
RUN apk --no-cache update && \
    apk add --no-cache \
	supervisor \
	curl \
	php82 \
	php82-fpm \
	php82-json \
	php82-ldap \
	php82-curl \
	php82-phar \
	php82-pdo \
    php82-iconv \
    php82-mbstring \
	php82-pdo_mysql \
	php82-simplexml \
	php82-dom \
	php82-ctype \
	php82-tokenizer \
	php82-xml \
	php82-xmlwriter \
	php82-session \
    php82-pecl-xdebug \
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
