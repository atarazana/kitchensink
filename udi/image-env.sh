#!/bin/sh

# export CONTAINER_FILE=Containerfile
# export BUILDER_IMAGE=registry.redhat.io/jboss-eap-7/eap-74-openjdk8-openshift-rhel8:7.4.11
# export ARTIFACT_VERSION="7.4.11"
export CONTAINER_FILE=Containerfile.7.2
export BUILDER_IMAGE=registry.redhat.io/jboss-eap-7/eap72-openshift:1.2-23
export ARTIFACT_VERSION="1.2-23"

export ARTIFACT_ID=udi
export GIT_HASH=$(git rev-parse HEAD)

export REGISTRY=quay.io
export REGISTRY_USER_ID=atarazana
export PROJECT_ID=kitchensink
export APP_NAME=${PROJECT_ID}-app

