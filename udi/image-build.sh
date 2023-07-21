
#!/bin/sh

. ./image-env.sh

podman build --build-arg BUILDER_IMAGE=${BUILDER_IMAGE} -f Containerfile -t ${PROJECT_ID}-${ARTIFACT_ID}:${GIT_HASH} .

podman tag ${PROJECT_ID}-${ARTIFACT_ID}:${GIT_HASH} ${PROJECT_ID}-${ARTIFACT_ID}:${ARTIFACT_VERSION}
