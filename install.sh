#!/bin/sh

# Run this before...
# helm repo add jboss-eap https://jbossas.github.io/eap-charts/

NAMESPACE_NAME=kitchensink-eap-8

oc new-project ${NAMESPACE_NAME}

oc new-app --name=kitchensink-db \
 -e POSTGRESQL_USER=luke \
 -e POSTGRESQL_PASSWORD=secret \
 -e POSTGRESQL_DATABASE=kitchensink centos/postgresql-10-centos7 \
 --as-deployment-config=false -n  ${NAMESPACE_NAME}

oc label deployment/kitchensink-db app.kubernetes.io/part-of=kitchensink-app --overwrite=true -n  ${NAMESPACE_NAME} && \
oc label deployment/kitchensink-db app.openshift.io/runtime=postgresql --overwrite=true -n  ${NAMESPACE_NAME}

helm install kitchensink -f ./charts/helm.yaml jboss-eap/eap8 -n ${NAMESPACE_NAME}