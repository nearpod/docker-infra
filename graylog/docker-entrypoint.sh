#!/bin/bash

set -ex

if [ "${1:0:1}" = '-' ]; then
  set -- graylog "$@"
fi

# Delete outdated PID file
rm -f /tmp/graylog.pid

# Start Graylog server
exec "$JAVA_HOME/bin/java" $GRAYLOG_SERVER_JAVA_OPTS \
    -Dlog4j.configurationFile="${GRAYLOG_DATA_DIR}"/config/log4j2.xml \
    -Djava.library.path="${GRAYLOG_HOME}"/lib/sigar/ \
    -Dgraylog2.installation_source=docker \
    -jar "${GRAYLOG_HOME}"/graylog.jar \
    server \
    -f "${GRAYLOG_DATA_DIR}"/config/graylog.conf ${GRAYLOG_SERVER_OPTS}
