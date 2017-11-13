#!/bin/bash -ex

DB_VENDOR=$1
KEYCLOAK_BIN=$( dirname $0 )
cd $KEYCLOAK_BIN/..

bin/jboss-cli.sh --file=cli/databases/$DB_VENDOR/standalone-configuration.cli
rm -rf standalone/configuration/standalone_xml_history

bin/jboss-cli.sh --file=cli/databases/$DB_VENDOR/standalone-ha-configuration.cli
rm -rf standalone/configuration/standalone_xml_history/current/*
