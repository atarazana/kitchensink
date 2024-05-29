#!/bin/sh

NAMESPACE_NAME=kitchensink-eap-8

helm uninstall kitchensink -n ${NAMESPACE_NAME}

oc delete all -l app.kubernetes.io/part-of=kitchensink-app -n ${NAMESPACE_NAME}
oc delete all -l app=kitchensink-db -n ${NAMESPACE_NAME}