#!/usr/bin/env bash

set -eu
BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $BASEDIR

source ./functions.sh
source ./set-env.sh

echo
echo "whoami:              http://$(get-primary-ip):8081/whoami"
echo "keycloak ui:         http://$(get-primary-ip):8081/keycloak"

