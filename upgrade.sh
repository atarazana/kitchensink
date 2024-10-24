#!/bin/sh

# Run this before...
# helm repo add jboss-eap https://jbossas.github.io/eap-charts/

NAMESPACE_NAME=kitchensink-eap-8

oc project ${NAMESPACE_NAME}

oc start-build kitchensink-build-artifacts --follow -n ${NAMESPACE_NAME}

helm upgrade kitchensink -f ./charts/helm.yaml jboss-eap/eap8 -n ${NAMESPACE_NAME}