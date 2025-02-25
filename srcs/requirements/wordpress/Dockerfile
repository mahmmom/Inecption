FROM alpine:3.20

ARG name

RUN apk update && apk upgrade && apk add --no-cache \
    php83 \
    php83-phar \
    php83-fpm \
    php83-mysqli \
    php83-json \
    php83-curl \
    php83-dom \
    php83-exif \
    php83-fileinfo \
    php83-mbstring \
    php83-openssl \
    php83-xml \
    php83-zip \
    php83-redis \
    wget \
    unzip \
    curl \
    less \
    bash && \
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp && \
    sed -i "s|listen = 127.0.0.1:9000|listen = 9000|g" /etc/php83/php-fpm.d/www.conf && \
    sed -i "s|;listen.owner = nobody|listen.owner = nobody|g" /etc/php83/php-fpm.d/www.conf && \
    sed -i "s|;listen.group = nobody|listen.group = nobody|g" /etc/php83/php-fpm.d/www.conf && \
    rm -f /var/cache/apk/*

WORKDIR /var/www/html

COPY requirements/wordpress/conf/wp-config-create.sh .

RUN chmod +x wp-config-create.sh

CMD ["sh", "wp-config-create.sh"]
