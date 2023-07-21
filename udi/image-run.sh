#!/bin/sh

. ./image-env.sh

podman run -it --rm -p 8080:8080 --name ${PROJECT_ID}-${ARTIFACT_ID} localhost/${PROJECT_ID}-${ARTIFACT_ID}:${ARTIFACT_VERSION}
