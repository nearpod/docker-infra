#!/bin/bash -ex

KEYCLOAK_BIN=$( dirname $0 )
if [ $KEYCLOAK_USER ] && [ $KEYCLOAK_PASSWORD ]; then
    $KEYCLOAK_BIN/add-user-keycloak.sh --user $KEYCLOAK_USER --password $KEYCLOAK_PASSWORD
fi

if [ "$DB_VENDOR" == "POSTGRES" ]; then
  databaseToInstall="postgres"
elif [ "$DB_VENDOR" == "MYSQL" ]; then
  databaseToInstall="mysql"
elif [ "$DB_VENDOR" == "H2" ]; then
  databaseToInstall=""
else
    if (printenv | grep '^POSTGRES_' &>/dev/null); then
      databaseToInstall="postgres"
    elif (printenv | grep '^MYSQL_' &>/dev/null); then
      databaseToInstall="mysql"
    fi
fi

if [ "$databaseToInstall" != "" ]; then
    echo "[KEYCLOAK DOCKER IMAGE] Using the external $databaseToInstall database"
    $KEYCLOAK_BIN/change-database.sh $databaseToInstall
else
    echo "[KEYCLOAK DOCKER IMAGE] Using the embedded H2 database"
fi

$KEYCLOAK_BIN/add-user-keycloak.sh -r master -u ${KEYCLOAK_MASTER_USER:admin} -p $KEYCLOAK_MASTER_PASSWORD

if [ "$PROXY_ADDRESS_FORWARDING" == "true" ]; then
  $KEYCLOAK_BIN/jboss-cli.sh --file=cli/proxy-https.cli
fi

exec $KEYCLOAK_BIN/standalone.sh $@
exit $?
