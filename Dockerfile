FROM php:8.1-fpm-alpine

# mysqli 확장을 설치합니다.
RUN docker-php-ext-install mysqli && \
    docker-php-ext-enable mysqli
