#!/bin/sh
# set -o nounset
set -o errexit

if [ -z $1 ] || [ -z $2 ];
then 
    printf "%s %s %s\n" "$0" '${GH_OAUTH_CLIENT_ID}' '${GH_OAUTH_CLIENT_SECRET}'
    exit 1
fi

BASE64_GH_OAUTH_CLIENT_ID=$(echo $1 | base64)
BASE64_GH_OAUTH_CLIENT_SECRET=$(echo $2 | base64)

# openshift-devspaces
DEVSPACES_NAMESPACE=openshift-operators

if [ -z ${BASE64_GH_OAUTH_CLIENT_ID+x} ]; then 
  echo "Error: BASE64_GH_OAUTH_CLIENT_ID is unset"
  exit 1
fi

if [ -z ${BASE64_GH_OAUTH_CLIENT_SECRET+x} ]; then 
  echo "Error: BASE64_GH_OAUTH_CLIENT_SECRET is unset"
  exit 1
fi

createOAuthSecret() {
cat << EOF | kubectl apply -f -
  kind: Secret
  apiVersion: v1
  metadata:
    name: github-oauth-config
    namespace: ${DEVSPACES_NAMESPACE}
    labels:
        app.kubernetes.io/part-of: che.eclipse.org
        app.kubernetes.io/component: oauth-scm-configuration
    annotations:
        che.eclipse.org/oauth-scm-server: github
        che.eclipse.org/scm-server-endpoint: https://github.com
        che.eclipse.org/scm-github-disable-subdomain-isolation: "false"
  type: Opaque
  data:
    id: ${BASE64_GH_OAUTH_CLIENT_ID}
    secret: ${BASE64_GH_OAUTH_CLIENT_SECRET}
EOF
}

setOAuthSecret() {
  kubectl patch checluster devspaces --type=merge -p '{"spec":{"gitServices":{"github":[{"endpoint":"https://github.com","secretName":"github-oauth-config"}]}}}' -n ${DEVSPACES_NAMESPACE}
}

createOAuthSecret
setOAuthSecret

echo "Now follow intructions => https://www.eclipse.org/che/docs/stable/administration-guide/configuring-oauth-2-for-github/#setting-up-the-github-oauth-app_che"