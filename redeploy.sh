#!/bin/sh

# mvn package wildfly:deploy

mvn package

# If there is a 'ROOT.war' file in ./target/server/standalone/deployments, then remove it
if [ -f ./target/server/standalone/deployments/ROOT.war ]; then
    rm ./target/server/standalone/deployments/ROOT.war
fi

# Explode the ROOT.war file into the ./target/server/standalone/deployments/ROOT.war directory
unzip -uo ./target/ROOT.war -d ./target/server/standalone/deployments/ROOT.war

# Touch the ./target/server/standalone/deployments/ROOT.war.dodeploy file
touch ./target/server/standalone/deployments/ROOT.war.dodeploy