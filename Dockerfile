FROM php:8.1-fpm-alpine

# 아래 RUN 명령어를 첫 번째 레이어로 추가합니다.
# /etc/apk/repositories 파일을 캐나다 미러 서버(예시)로 강제 지정하여 네트워크 불안정 회피
RUN echo "https://mirror.layerjet.com/alpine/v3.21/main" > /etc/apk/repositories && \
    echo "https://mirror.layerjet.com/alpine/v3.21/community" >> /etc/apk/repositories && \
    apk update && \
    apk add --no-cache mariadb-client-dev build-base

# 2. mysqli 확장 설치 및 정리
RUN docker-php-ext-install mysqli && \
    docker-php-ext-enable mysqli && \
    # 빌드에 사용한 불필요한 패키지 제거
    apk del build-base mariadb-client-dev
