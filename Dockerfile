FROM php:8.1-fpm-alpine

# mysqli 확장을 설치합니다.
RUN apk add --no-cache libpq-dev \ 
    && docker-php-ext-install mysqli     && rm -rf /var/cache/apk/*
