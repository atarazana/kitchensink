#!/bin/sh

export POSTGRESQL_DATASOURCE=kitchensink 
export POSTGRESQL_DATABASE=kitchensink 
export POSTGRESQL_USER=luke 
export POSTGRESQL_PASSWORD=secret 
export POSTGRESQL_HOST=localhost

./target/server/bin/standalone.sh 