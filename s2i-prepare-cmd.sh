#!/bin/bash

# Define the path to the lock file
LOCKFILE="$(pwd)/prepare.lock"

# Check if the lock file exists
if [ -f "$LOCKFILE" ]; then
  echo "Script is already been run. Exiting."
  exit 1
fi

# Create the lock file
touch "$LOCKFILE"

# Your script logic goes here
mkdir -p artifacts/configuration && \
  sed -i 's|# configure_drivers ${injected_dir}/driver-postgresql.env|configure_drivers ${injected_dir}/driver-postgresql.env|g' src/extensions/install.sh

