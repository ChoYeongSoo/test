FROM php:8.1-fpm-alpine

# 1. mysqli 확장 설치에 필요한 빌드 도구 및 DB 클라이언트 개발 패키지 설치
#    mariadb-client-dev: mysqli를 컴파일하는 데 필요한 라이브러리 제공
#    build-base: 컴파일 도구 (gcc, make 등) 제공
RUN apk add --no-cache mariadb-client-dev build-base && \
    # 2. mysqli 확장 설치 및 활성화
    docker-php-ext-install mysqli && \
    docker-php-ext-enable mysqli && \
    # 3. 빌드에 사용한 불필요한 패키지 제거하여 최종 이미지 크기 최적화
    apk del build-base mariadb-client-dev
