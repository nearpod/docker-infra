FROM alpine:3.8
RUN set -ex; apk add --no-cache tomcat-native

FROM nearpod/alpine-jvm:3.8-adoptopenjdk-jdk8

ARG JIRA_HOME=/var/atlassian/jira
ARG JIRA_INSTALL=/opt/atlassian/jira
ARG JIRA_VERSION=7.13.1
ARG JDBC_MYSQL_VERSION=5.1.47
ARG JDBC_POSTGRES_VERSION=42.2.5

ENV JIRA_VERSION=$JIRA_VERSION \
    JIRA_HOME=$JIRA_HOME \
    JIRA_INSTALL=$JIRA_INSTALL

COPY --from=0 /usr/lib/libtcnative-1.so.0.2* /usr/lib

RUN set -ex; \
  ln -nsf /usr/lib/libtcnative-1.so.0.2* /usr/lib/libtcnative-1.so; \
  ln -nsf /usr/lib/libtcnative-1.so.0.2* /usr/lib/libtcnative-1.so.0;

RUN set -ex; \
  apk --no-cache add xmlstarlet java-cacerts java-common apr libcrypto1.0 libssl1.0 openssl fontconfig ttf-dejavu; \
  mkdir -p /usr/lib/jvm; \
  ln -nsf /opt/java/openjdk /usr/lib/jvm/default-jvm; \
  echo "version=1" > "${JAVA_HOME}/lib/fontconfig.properties"; \
  echo "sequence.allfonts=default" >> "${JAVA_HOME}/lib/fontconfig.properties"; \
  mkdir -p "${JIRA_HOME}"; \
  mkdir -p "${JIRA_INSTALL}/conf/Catalina"; \
  curl -q -sSL "https://www.atlassian.com/software/jira/downloads/binary/atlassian-jira-software-${JIRA_VERSION}.tar.gz" | tar -xz --directory "${JIRA_INSTALL}" --strip-components=1 --no-same-owner; \
  curl -q -sSLO "http://central.maven.org/maven2/mysql/mysql-connector-java/$JDBC_MYSQL_VERSION/mysql-connector-java-$JDBC_MYSQL_VERSION.jar"; \
  curl -q -sSLO "http://central.maven.org/maven2/mysql/mysql-connector-java/$JDBC_MYSQL_VERSION/mysql-connector-java-$JDBC_MYSQL_VERSION.jar.md5"; \
  echo "$(cat mysql-connector-java-$JDBC_MYSQL_VERSION.jar.md5)  mysql-connector-java-$JDBC_MYSQL_VERSION.jar" | md5sum -c; \
  mkdir -p "$KEYCLOAK_HOME/modules/system/layers/base/com/mysql/jdbc/main/"; \
  mv "mysql-connector-java-$JDBC_MYSQL_VERSION.jar" "${JIRA_INSTALL}/lib/"; \
  curl -q -sSLO "http://central.maven.org/maven2/org/postgresql/postgresql/$JDBC_POSTGRES_VERSION/postgresql-$JDBC_POSTGRES_VERSION.jar"; \
  curl -q -sSLO "http://central.maven.org/maven2/org/postgresql/postgresql/$JDBC_POSTGRES_VERSION/postgresql-$JDBC_POSTGRES_VERSION.jar.md5"; \
  echo "$(cat postgresql-$JDBC_POSTGRES_VERSION.jar.md5)  postgresql-$JDBC_POSTGRES_VERSION.jar" | md5sum -c; \
  rm -f "${JIRA_INSTALL}/lib/postgresql-9.1-903.jdbc4-atlassian-hosted.jar"; \
  mv "postgresql-$JDBC_POSTGRES_VERSION.jar" "${JIRA_INSTALL}/lib/postgresql-${POSTGRES_JDBC_VERSION}.jar"; \
  mkdir -p /var/atlassian/jira; \
  rm -f "mysql-connector-java-$JDBC_MYSQL_VERSION.jar.md5" "postgresql-$JDBC_POSTGRES_VERSION.jar.md5"; \
  chmod -R 700 "${JIRA_INSTALL}/" /var/atlassian/jira; \
  chown -R daemon:daemon  "${JIRA_INSTALL}/" /var/atlassian/jira; \
  echo -e "\njira.home=$JIRA_HOME" >> "${JIRA_INSTALL}/atlassian-jira/WEB-INF/classes/jira-application.properties"; \
  sed -i -e 's/JVM_MINIMUM_MEMORY="384m"/[ -z "${JVM_MINIMUM_MEMORY}" ] \&\& JVM_MINIMUM_MEMORY="384m"/g' "${JIRA_INSTALL}/bin/setenv.sh"; \
  sed -i -e 's/JVM_MAXIMUM_MEMORY="768m"/[ -z "${JVM_MAXIMUM_MEMORY}" ] \&\& JVM_MAXIMUM_MEMORY="768m"/g' "${JIRA_INSTALL}/bin/setenv.sh"; \
  touch -d "@0" "${JIRA_INSTALL}/conf/server.xml"

USER daemon:daemon

# Expose default HTTP connector port.
EXPOSE 8080

# Set volume mount points for installation and home directory. Changes to the
# home directory needs to be persisted as well as parts of the installation
# directory due to eg. logs.
VOLUME ["/var/atlassian/jira", "/opt/atlassian/jira/logs"]

# Set the default working directory as the installation directory.
WORKDIR /var/atlassian/jira

COPY "docker-entrypoint.sh" "/"
ENTRYPOINT ["/docker-entrypoint.sh"]

# Run Atlassian JIRA as a foreground process by default.
CMD ["/opt/atlassian/jira/bin/catalina.sh", "run"]
