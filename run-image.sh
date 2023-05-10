#!/bin/sh

podman run -it --rm \
  -e DB_HOST=192.168.50.17 \
  -e DB_PORT=5432 \
  -e DB_NAME=kitchensink \
  -e DB_USERNAME=luke \
  -e DB_PASSWORD=secret \
  -e SP_URL=http://localhost:8080 \
  -e IDP_URL=http://0.0.0.0:8180/saml \
  -e IDP_SSO_BINDING_URL=http://0.0.0.0:8180/auth/realms/saml-demo/protocol/saml \
  -e IDP_SLS_POST_BINDING_URL=http://0.0.0.0:8180/auth/realms/saml-demo/protocol/saml \
  -e IDP_SLS_REDIRECT_BINDING_URL=http://0.0.0.0:8180/auth/realms/saml-demo/protocol/saml \
  -p 8080:8080 \
  localhost/kitchensink:s2i /usr/local/s2i/run
