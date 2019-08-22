FROM php:7.3-alpine AS stat

RUN apk add --update git build-base autoconf

RUN git clone https://github.com/krakjoe/stat.git /tmp/stat
WORKDIR /tmp/stat

RUN phpize \
    &&./configure \
    && make \
    && make install

FROM wordpress:php7.3-fpm-alpine

RUN apk add --update socat screen

COPY --from=stat /usr/local/lib/php/extensions/no-debug-non-zts-20180731/stat.so /usr/local/lib/php/extensions/no-debug-non-zts-20180731/stat.so
COPY ./stat.ini /usr/local/etc/php/conf.d/stat.ini

RUN docker-php-ext-enable stat
RUN sed -i 's/127\.0\.0\.1/0.0.0.0/g' /usr/local/etc/php-fpm.d/www.conf
