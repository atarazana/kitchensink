#!/bin/sh

podman run -it --rm \
  -e DB_HOST=192.168.50.17 \
  -e DB_PORT=5432 \
  -e DB_NAME=kitchensink \
  -e DB_USERNAME=luke \
  -e DB_PASSWORD=secret \
  -p 8080:8080 \
  localhost/kitchensink:s2i
