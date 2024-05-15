#!/bin/sh

# Run this before...
# helm repo add jboss-eap https://jbossas.github.io/eap-charts/

oc project kitchensink-eap-8

helm upgrade kitchensink -f ./charts/helm.yaml jboss-eap/eap8