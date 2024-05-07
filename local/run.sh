#!/bin/sh

./setup.sh

export DB_NAME=kitchensink
export DB_USERNAME=luke
export DB_PASSWORD=secret
export DB_HOST=localhost

if [ -z "${HOSTNAME}" ]; then
    export HOSTNAME=localhost
fi

./jboss-eap-7.4/bin/standalone.sh