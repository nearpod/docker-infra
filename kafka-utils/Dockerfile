FROM frolvlad/alpine-glibc:alpine-3.7

ARG KAFKA_UTILS_USER=kafka

ENV HOME=/config

RUN set -ex; \
    apk add --no-cache bash bash-completion curl ca-certificates python2 openssl; \
    apk add --no-cache --virtual build-dependencies python-dev build-base py2-pip libffi-dev openssl-dev; \
    pip install kafka-utils; \
    apk del build-dependencies

WORKDIR /config

RUN set -ex; \
    WORKDIR="$PWD"; \
    addgroup -g 1000 "$KAFKA_UTILS_USER"; \
    adduser -D -h "$WORKDIR" -u 1000 -G "$KAFKA_UTILS_USER" "$KAFKA_UTILS_USER"; \
    [ `id -u "$KAFKA_UTILS_USER"` -eq 1000 ]; \
    [ `id -g "$KAFKA_UTILS_USER"` -eq 1000 ]; \
    kafka-utils -v


USER kafka
