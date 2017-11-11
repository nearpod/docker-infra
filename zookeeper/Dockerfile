FROM nearpod/alpine-jvm:3.6-jdk8

ARG GPG_KEY=C823E3E5B12AF29C67F81976F5CECB3CB5E9BD2D
ARG ZK_DIST=zookeeper-3.4.10
ARG ZK_USER=zookeeper
ARG ZK_INSTALL_DIR=/usr/local/$ZK_DIST
ARG ZK_DATA_DIR=/var/lib/zookeeper/data
ARG ZK_DATA_LOG_DIR=/var/lib/zookeeper/log
ARG ZK_LOG_DIR=/var/log/zookeeper
ARG ZK_CONF_DIR=$ZK_INSTALL_DIR/conf

ENV ZK_USER=$ZK_USER \
    ZK_INSTALL_DIR=$ZK_INSTALL_DIR \
    ZK_DATA_DIR=$ZK_DATA_DIR \
    ZK_DATA_LOG_DIR=$ZK_DATA_LOG_DIR \
    ZK_LOG_DIR=$ZK_LOG_DIR \
    ZK_CONF_DIR=$ZK_CONF_DIR

RUN set -ex; \
    WORKDIR="$PWD"; \
    # netcat-openbsd is used by the zkOk.sh and zkMetrics.sh scripts
    apk --no-cache --update add ca-certificates netcat-openbsd curl gnupg bash; \
    curl -q -sSLO "http://www.apache.org/dist/zookeeper/$ZK_DIST/$ZK_DIST.tar.gz"; \
    curl -q -sSLO "http://www.apache.org/dist/zookeeper/$ZK_DIST/$ZK_DIST.tar.gz.asc"; \
    export GNUPGHOME="$(mktemp -d)"; \
    gpg --keyserver ha.pool.sks-keyservers.net --recv-key "$GPG_KEY"; \
    gpg --batch --verify "$ZK_DIST.tar.gz.asc" "$ZK_DIST.tar.gz"; \
    mkdir -p "$ZK_INSTALL_DIR"; \
    tar -xzf "$ZK_DIST.tar.gz" --strip-components=1 -C "$ZK_INSTALL_DIR"; \
    rm -rf "$GNUPGHOME" "$ZK_DIST.tar.gz" "$ZK_DIST.tar.gz.asc"; \
    rm -rf "$ZK_INSTALL_DIR/CHANGES.txt" "$ZK_INSTALL_DIR/README.txt" \
    "$ZK_INSTALL_DIR/NOTICE.txt" "$ZK_INSTALL_DIR/CHANGES.txt" \
    "$ZK_INSTALL_DIR/README_packaging.txt" "$ZK_INSTALL_DIR/build.xml" \
    "$ZK_INSTALL_DIR/config" "$ZK_INSTALL_DIR/contrib" \
    "$ZK_INSTALL_DIR/dist-maven" "$ZK_INSTALL_DIR/docs" \
    "$ZK_INSTALL_DIR/ivy.xml" "$ZK_INSTALL_DIR/ivysettings.xml" \
    "$ZK_INSTALL_DIR/recipes" "$ZK_INSTALL_DIR/src" \
    "$ZK_INSTALL_DIR/$ZK_DIST.jar.asc" "$ZK_INSTALL_DIR/$ZK_DIST.jar.md5" \
    "$ZK_INSTALL_DIR/$ZK_DIST.jar.sha1"; \
    apk del gnupg

# Copy configuration generator script to bin
COPY files/zkGenConfig.sh files/zkOk.sh files/zkMetrics.sh ./bin/

# Create a user for the zookeeper process and configure file system ownership
# for necessary directories and symlink the distribution as a user executable
RUN set -ex; \
    WORKDIR="$PWD"; \
    addgroup -g 1000 $ZK_USER; \
    adduser -D -h "$WORKDIR" -u 1000 -G "$ZK_USER" "$ZK_USER"; \
    [ `id -u "$ZK_USER"` -eq 1000 ]; \
    [ `id -g "$ZK_USER"` -eq 1000 ]; \
    mkdir -p "$ZK_DATA_DIR" "$ZK_DATA_LOG_DIR" "$ZK_LOG_DIR" "$WORKDIR/share/zookeeper" "$WORKDIR/etc/" /tmp/zookeeper; \
    chown -R "$ZK_USER:$ZK_USER" "$ZK_INSTALL_DIR" "$ZK_DATA_DIR" "$ZK_LOG_DIR" "$ZK_DATA_LOG_DIR" /tmp/zookeeper; \
    ln -sv "$ZK_INSTALL_DIR/conf/" "$WORKDIR/etc/zookeeper"; \
    ln -sv "$ZK_INSTALL_DIR/bin/"* "$WORKDIR/bin"; \
    ln -sv "$ZK_INSTALL_DIR/$ZK_DIST.jar" "$WORKDIR/share/zookeeper/"; \
    ln -sv "$ZK_INSTALL_DIR/lib/"* "$WORKDIR/share/zookeeper"

USER zookeeper:zookeeper
