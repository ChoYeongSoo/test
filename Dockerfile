# /tmp/ci_files/Dockerfile 내용 수정

FROM docker.io/library/php:8.1-fpm-alpine

# 1. 미러 서버 목록을 기본값으로 강제 초기화하고,
# 2. 패키지 업데이트 및 mariadb 클라이언트 설치 시 http 접속을 허용합니다.
# **주의:** 이전에 추가했던 미러 서버 강제 지정 라인은 이 코드로 대체합니다.
RUN echo "https://dl-cdn.alpinelinux.org/alpine/v3.21/main" > /etc/apk/repositories && \
    echo "https://dl-cdn.alpinelinux.org/alpine/v3.21/community" >> /etc/apk/repositories && \
    apk update && \
    apk add --no-cache mariadb-client-dev build-base && \
    docker-php-ext-install mysqli && \
    docker-php-ext-enable mysqli && \
    apk del build-base mariadb-client-dev

# 나머지 파일 내용은 동일하게 유지합니다.
COPY ./html /var/www/html
