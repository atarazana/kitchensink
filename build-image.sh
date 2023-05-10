#!/bin/sh

podman build --build-arg JBOSS_EAP_BUILDER_IMAGE="registry.redhat.io/jboss-eap-7/eap72-openshift:1.2" . -f Containerfile.s2i -t kitchensink:s2i

