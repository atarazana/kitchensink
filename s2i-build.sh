#!/bin/sh

# systemctl enable --now podman.socket
# export DOCKER_HOST='unix:///var/run/docker.sock'

# --as-dockerfile ./Containerfile.s2i 

# sudo podman login -u cvicensa@redhat.com -p \!N0str0m075. registry.redhat.io
# sudo podman pull registry.redhat.io/jboss-eap-7/eap72-openshift:latest

sudo rm -rf upload

sudo /var/home/cvicensa/bin/s2i build -c . registry.redhat.io/jboss-eap-7/eap72-openshift:1.2 \
  --env CUSTOM_INSTALL_DIRECTORIES="extensions" \
  --env MAVEN_ARGS_APPEND="-Dcom.redhat.xpaas.repo.jbossorg" kitchensink:latest
sudo podman tag docker.io/library/kitchensink:latest localhost/kitchensink:latest

