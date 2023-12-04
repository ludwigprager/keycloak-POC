#!/usr/bin/env bash

set -eu
BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $BASEDIR


source ./functions.sh
source ./set-env.sh

FOO_PID=""
function finish {
  echo killing $FOO_PID
  kill $FOO_PID
}
trap finish INT TERM EXIT


# apply the manifests in the following order
./kubectl apply -f manifest/whoami.yaml
./kubectl apply -f manifest/keycloak.yaml
./kubectl apply -f manifest/ingress.yaml

#j./kubectl wait --for=condition=complete --timeout=30s podl

echo "waiting for keycloak deployment to get ready"
./kubectl rollout status deployment keycloak -n default --timeout=300s


#echo http://$(get-primary-ip):8081/
##echo http://$(get-primary-ip):8081/postgres-operator-ui

./kubectl port-forward --address 0.0.0.0 svc/keycloak 8333:80 &
FOO_PID=$!
wait-for-port-forward 8333

#sensible-browser http://localhost:9898 &
#sensible-browser http://$(get-primary-ip):8333 &
#sensible-browser http://localhost:8333
firefox http://localhost:8333

sleep 5
echo press "<enter>" to terminate port-forwarding
read a
