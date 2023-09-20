#!/bin/sh

# export WILDFLY_S2I_OUTPUT_DIR=/s2i-output

. ./image-env.sh

podman run -it --rm -p 8080:8080 -u 9999 \
  -e S2I_DELETE_SOURCE=false \
  -e S2I_DESTINATION_DIR=/projects/ \
  -e CUSTOM_INSTALL_DIRECTORIES=extensions \
  --name ${PROJECT_ID}-${ARTIFACT_ID} \
  localhost/${PROJECT_ID}-${ARTIFACT_ID}:${ARTIFACT_VERSION} bash
