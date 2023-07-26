#!/bin/sh

export BUILDER_IMAGE=registry.redhat.io/jboss-eap-7/eap-74-openjdk8-openshift-rhel8:7.4.11
# export BUILDER_IMAGE=registry.redhat.io/jboss-eap-7/eap72-openshift
export ARTIFACT_VERSION="7.4"
export ARTIFACT_ID=udi
export GIT_HASH=$(git rev-parse HEAD)

export REGISTRY=quay.io
export REGISTRY_USER_ID=atarazana
export PROJECT_ID=kitchensink
export APP_NAME=${PROJECT_ID}-app

