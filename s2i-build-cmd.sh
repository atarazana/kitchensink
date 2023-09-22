#!/bin/bash

# Define the path to the lock file
LOCKFILE="$(pwd)/build.lock"

# Check if the lock file exists
if [ -f "$LOCKFILE" ]; then
  echo "Script is already running. Exiting."
  exit 1
fi

# Create the lock file
touch "$LOCKFILE"

# Your script logic goes here
mvn clean package
cp target/kitchensink.war /deployments/ROOT.war

rm "$LOCKFILE"