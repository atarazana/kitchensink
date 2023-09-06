#!/bin/sh

COUNT=30
PROJECT_BASE_LIST="argo appset-a appset-b kustomize-dev kustomize-test helm helm-kustomize-dev helm-kustomize-test cicd-tekton cicd-jenkins"
PROJECT_NAME_INFRA=kitchensink-infra
PROJECT_NAME_QUAY=quay-system

echo "------------------------------"
echo " Setting Up Guide Resources"

for i in $(seq 6 $COUNT); 
do
  USERNAME=user${i}
  for j in ${PROJECT_BASE_LIST};
  do
    PROJECT_NAME=${j}-${USERNAME}
    echo ">>> Deleting project ${PROJECT_NAME}"
    oc delete project ${PROJECT_NAME} --wait=false
  done
  oc adm policy remove-role-to-user view ${USERNAME} -n kitchensink-infra
  oc adm policy remove-role-to-user view ${USERNAME} -n quay-system
done

echo "------------------------------"