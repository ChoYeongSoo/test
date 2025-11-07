# /tmp/ci_files/Dockerfile 내용 수정

FROM docker.io/library/php:8.1-fpm-alpine

# **핵심 수정:** /etc/apk/repositories를 http://로 강제 재설정하여 HTTPS/SSL 인증 문제를 우회합니다.
# dl-cdn.alpinelinux.org 대신, http로 접근 가능한 미러 서버를 명시합니다.
# https 대신 http를 사용하면 SSL/TLS 문제를 우회할 수 있습니다.
RUN echo "http://mirror.aarnet.edu.au/pub/alpine/v3.21/main" > /etc/apk/repositories && \
    echo "http://mirror.aarnet.edu.au/pub/alpine/v3.21/community" >> /etc/apk/repositories && \
    apk update && \
    apk add --no-cache mariadb-client-dev build-base && \
    docker-php-ext-install mysqli && \
    docker-php-ext-enable mysqli && \
    apk del build-base mariadb-client-dev
    
# 나머지 파일 내용은 동일하게 유지합니다.
COPY ./html /var/www/html
