#!/bin/sh

export POSTGRESQL_DATASOURCE=kitchensink
export POSTGRESQL_DATABASE=kitchensink
export POSTGRESQL_USER=luke
export POSTGRESQL_PASSWORD=secret
export POSTGRESQL_HOST=localhost

if [ -z "${HOSTNAME}" ]; then
    export HOSTNAME=localhost
fi

./target/server/bin/standalone.sh