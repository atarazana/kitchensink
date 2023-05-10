#!/bin/sh

# https://github.com/keycloak/keycloak-quickstarts/blob/latest/docs/getting-started.md
# https://github.com/keycloak/keycloak-quickstarts/tree/latest/service-jee-jaxrs/config
# https://github.com/keycloak/keycloak-quickstarts/tree/latest/app-profile-saml-jee-jsp

sudo podman rm keycloak

sudo podman run --name keycloak -p 8180:8180 \
     -e KEYCLOAK_ADMIN=admin -e KEYCLOAK_ADMIN_PASSWORD=admin \
     quay.io/keycloak/keycloak:latest \
     start-dev \
     --http-port 8180 \
     --http-relative-path /auth