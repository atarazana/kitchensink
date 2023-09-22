#!/bin/bash

# Define the path to the lock file
LOCKFILE="$(pwd)/run.lock"

# Check if the lock file exists
if [ -f "$LOCKFILE" ]; then
  echo "Script is already running. Exiting."
  exit 1
fi

# Create the lock file
touch "$LOCKFILE"

# Your script logic goes here
/usr/local/s2i/assemble && DB_HOST=kitchensink-db.s2i-$(oc whoami) DB_USERNAME=luke DB_PASSWORD=secret /usr/local/s2i/run