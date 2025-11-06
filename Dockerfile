FROM php:8.1-fpm-alpine

# 1. 패키지 목록 업데이트 및 빌드 도구 설치 (별도 레이어)
#    이는 네트워크 불안정 문제를 완화하는 데 도움을 줍니다.
RUN apk update && \
    apk add --no-cache mariadb-client-dev build-base

# 2. mysqli 확장 설치 및 정리
RUN docker-php-ext-install mysqli && \
    docker-php-ext-enable mysqli && \
    # 빌드에 사용한 불필요한 패키지 제거
    apk del build-base mariadb-client-dev
