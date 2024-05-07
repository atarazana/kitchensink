#!/bin/sh

cp standalone.xml ./jboss-eap-7.4/standalone/configuration/
cp -r ../modules/* ./jboss-eap-7.4/modules/*
cp ../target/ROOT.war ./jboss-eap-7.4/standalone/deployments/