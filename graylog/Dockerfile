FROM openjdk:8u151-jre-alpine3.7

ARG GRAYLOG_VERSION=2.4.3
ARG GRAYLOG_DIST=graylog-${GRAYLOG_VERSION}
ARG GRAYLOG_USER=graylog
ARG GRAYLOG_HOME=/usr/local/$GRAYLOG_DIST
ARG GRAYLOG_DATA_DIR=/var/lib/graylog/data
ARG GRAYLOG_DATA_LOG_DIR=/var/lib/graylog/log
ARG GRAYLOG_LOG_DIR=/var/log/graylog

ENV GRAYLOG_USER=$GRAYLOG_USER \
    GRAYLOG_DATA_DIR=$GRAYLOG_DATA_DIR \
    GRAYLOG_HOME=$GRAYLOG_HOME
ENV PATH=$PATH:$GRAYLOG_HOME/bin
ENV GRAYLOG_SERVER_JAVA_OPTS "-XX:+UnlockExperimentalVMOptions -XX:+UseCGroupMemoryLimitForHeap -XX:NewRatio=1 -XX:MaxMetaspaceSize=256m -server -XX:+ResizeTLAB -XX:+UseConcMarkSweepGC -XX:+CMSConcurrentMTEnabled -XX:+CMSClassUnloadingEnabled -XX:+UseParNewGC -XX:-OmitStackTraceInFastThrow"

WORKDIR $GRAYLOG_HOME

RUN set -ex; \
    WORKDIR="$PWD"; \
    apk --no-cache add ca-certificates curl bash; \
    curl -q -sSLO "https://packages.graylog2.org/releases/graylog/${GRAYLOG_DIST}.tgz"; \
    mkdir -p "$GRAYLOG_HOME"; \
    tar -xzf "$GRAYLOG_DIST.tgz" --strip-components=1 -C "$GRAYLOG_HOME"; \
    ln -s $GRAYLOG_DIST /usr/local/graylog; \
    rm -rf "$GRAYLOG_DIST.tgz";

COPY log4j2.xml $GRAYLOG_DATA_DIR/config/

RUN set -ex; \
    WORKDIR="$PWD"; \
    mkdir -p "$GRAYLOG_DATA_DIR"; \
    cd "${GRAYLOG_DATA_DIR}"; \
    mkdir -p config contentpacks journal log plugin; \
    cd "$WORKDIR"; \
    addgroup -g 1000 "$GRAYLOG_USER"; \
    adduser -D -h "$GRAYLOG_DATA_DIR" -u 1000 -G "$GRAYLOG_USER" "$GRAYLOG_USER"; \
    [ `id -u "$GRAYLOG_USER"` -eq 1000 ]; \
    [ `id -g "$GRAYLOG_USER"` -eq 1000 ]; \
    chown -R "$GRAYLOG_USER:$GRAYLOG_USER" "$GRAYLOG_HOME"; \
    chown -R "$GRAYLOG_USER:$GRAYLOG_USER" "$GRAYLOG_DATA_DIR";

EXPOSE 9000
USER graylog:graylog

COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
