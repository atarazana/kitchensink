#!/bin/sh

COUNT=30
PROJECT_BASE_LIST="argo appset-a appset-b kustomize-dev kustomize-test helm helm-kustomize-dev helm-kustomize-test cicd-tekton cicd-jenkins"
PROJECT_NAME_INFRA=kitchensink-infra
PROJECT_NAME_QUAY=quay-system

echo "------------------------------"
echo " Setting Up Guide Resources"

oc new-project ${PROJECT_NAME_INFRA}

for i in $(seq 6 $COUNT); 
do
  USERNAME=user${i}
  for j in ${PROJECT_BASE_LIST};
  do
    PROJECT_NAME=${j}-${USERNAME}
    echo ">>> Creating project ${PROJECT_NAME}"
    oc new-project ${PROJECT_NAME}
    oc adm policy add-role-to-user edit ${USERNAME} -n ${PROJECT_NAME}
    oc adm policy add-role-to-user monitoring-edit ${USERNAME} -n ${PROJECT_NAME}
    oc adm policy add-role-to-user alert-routing-edit ${USERNAME} -n ${PROJECT_NAME}
    echo ">>> Deleting limitrange/${PROJECT_NAME}-core-resource-limits"
    oc delete limitrange/${PROJECT_NAME}-core-resource-limits -n ${PROJECT_NAME}
    # echo ">>> Creating limitrange with /setup-files/limit-range.yaml"
    # oc create -n ${PROJECT_NAME} -f /setup-files/limit-range.yaml
    # echo ">>> Creating quota with /setup-files/resource-quota.yaml"
    # oc create -n ${PROJECT_NAME} -f /setup-files/resource-quota.yaml  
  done
  oc adm policy add-role-to-user view ${USERNAME} -n ${PROJECT_NAME_INFRA}
  oc adm policy add-role-to-user view ${USERNAME} -n ${PROJECT_NAME_QUAY}
done
echo "------------------------------"