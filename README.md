

# Preparing the demo

As cluster-admin run this command to install all the operators, service accounts, etc.

```sh
until oc apply -k util/bootstrap/; do sleep 2; done
```

Then go here https://www.eclipse.org/che/docs/stable/administration-guide/configuring-oauth-2-for-github/#setting-up-the-github-oauth-app_che and follow instructions to create a GH App.

Prepare .env file

```sh
cat <EOF > .env
GH_OAUTH_CLIENT_ID=23...
GH_OAUTH_CLIENT_SECRET=70...
EOF
```

And run this command to create a secret for DevSpaces to be able to create credentials for github repositories automatically.

```sh
. .env
./util/create-checluster-github-service.sh ${GH_OAUTH_CLIENT_ID} ${GH_OAUTH_CLIENT_SECRET}
```

Open DevSpaces with this link. Update to another org if you fork this repo.

[![Contribute](https://www.eclipse.org/che/contribute.svg)](https://devspaces.apps.cluster-7mggs.7mggs.sandbox952.opentlc.com/#https://github.com/atarazana/kitchensink.git)

Grant access to the organization where you have forked this repo... if you have.

Now open a terminal and start the proper lab.

# Deploying a JBOSS EAP 7.2 application manually using S2I

```sh
oc new-project s2i-${DEV_USERNAME}
```






