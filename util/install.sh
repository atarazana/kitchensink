#!/bin/sh
OC_USER=$(oc whoami)

if [ -z "${OC_USER}" ]
then
    echo "You have to log in the OpenShift cluster and have cluster-admin permissions"
    exit 1
fi

until oc apply -k ./bootstrap/; do sleep 2; done


