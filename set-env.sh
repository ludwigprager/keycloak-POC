#!/usr/bin/env bash

export KUBECONFIG=${BASEDIR:-$(pwd)}/kubeconfig

CLUSTER="keycloak-poc"

POC_IMAGE=keycloak-poc:1

export INGRESS_PORT="8133"

export DNS_DOMAIN=domain.k3d
