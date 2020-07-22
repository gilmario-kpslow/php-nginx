FROM php:7.3-fpm-alpine

RUN apk add --virtual --no-cache \
    $PHPIZE_DEPS \
    curl-dev \
    imagemagick-dev \
    libtool \
    libxml2-dev \
    nginx

RUN docker-php-ext-install \
    mysqli \
    tokenizer \
    && docker-php-ext-enable mysqli \
    && rm -rf /var/lib/apt/lists/*

COPY index.php /var/www/html
COPY default.conf /etc/nginx/conf.d
COPY nginx.conf /etc/nginx/nginx.conf
COPY init.sh /opt/init.sh

RUN mkdir -p /run/nginx

EXPOSE 80
WORKDIR /var/www/html

ENTRYPOINT [ "/opt/init.sh" ]