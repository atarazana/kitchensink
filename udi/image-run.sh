#!/bin/sh

# export WILDFLY_S2I_OUTPUT_DIR=/s2i-output

. ./image-env.sh

podman run -it --rm -p 8080:8080 -u 9999 \
  -e S2I_DELETE_SOURCE=false \
  -e S2I_DESTINATION_DIR=/projects/ \
  -e CUSTOM_INSTALL_DIRECTORIES=extensions \
  -e DB_HOST=192.168.50.17 \
  -e DB_USERNAME=luke \
  -e DB_PASSWORD=secret \
  --name ${PROJECT_ID}-${ARTIFACT_ID} \
  localhost/${PROJECT_ID}-${ARTIFACT_ID}:${ARTIFACT_VERSION} bash
