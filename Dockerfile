# /tmp/ci_files/Dockerfile 내용 수정

FROM docker.io/library/php:8.1-fpm-alpine

# 패키지 이름을 'mariadb-client-dev'에서 'mariadb-dev'로 수정합니다.
RUN echo "http://mirror.aarnet.edu.au/pub/alpine/v3.21/main" > /etc/apk/repositories && \
    echo "http://mirror.aarnet.edu.au/pub/alpine/v3.21/community" >> /etc/apk/repositories && \
    apk update && \
    apk add --no-cache mariadb-dev build-base && \
    docker-php-ext-install mysqli && \
    docker-php-ext-enable mysqli && \
    apk del build-base mariadb-dev

# 나머지 파일 내용은 동일하게 유지합니다.
COPY ./html /var/www/html
