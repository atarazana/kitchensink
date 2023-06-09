export PROJECT_NAME=kitchensink-s2i

oc new-project ${PROJECT_NAME} 

# oc replace --force -f ./util/eap72-image-stream.json

# for resource in \
#   eap72-amq-persistent-s2i.json \
#   eap72-amq-s2i.json \
#   eap72-basic-s2i.json \
#   eap72-https-s2i.json \
#   eap72-sso-s2i.json
# do
#   oc apply -f ./util/${resource}
# done

# oc create secret generic github-creds \
#   --from-literal=username=cvicens \
#   --from-literal=password=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 \
#   --type=kubernetes.io/basic-auth -n ${PROJECT_NAME}

# oc annotate secret github-creds 'build.openshift.io/source-secret-match-uri-1=https://github.com/*' -n ${PROJECT_NAME}

oc new-app --name=kitchensink-db \
  -e POSTGRESQL_USER=luke \
  -e POSTGRESQL_PASSWORD=secret \
  -e POSTGRESQL_DATABASE=kitchensink centos/postgresql-10-centos7 \
  --as-deployment-config=false -n ${PROJECT_NAME}

oc label deployment/kitchensink-db app.kubernetes.io/part-of=kitchensink-app --overwrite=true  -n ${PROJECT_NAME} && \
oc label deployment/kitchensink-db app.openshift.io/runtime=postgresql --overwrite=true -n ${PROJECT_NAME} 

oc new-app --template=eap72-basic-s2i -n ${PROJECT_NAME} \
 -p MAVEN_ARGS_APPEND="-Dcom.redhat.xpaas.repo.jbossorg" \
 -p APPLICATION_NAME=kitchensink \
 -p SOURCE_REPOSITORY_URL=https://github.com/atarazana/kitchensink \
 -p SOURCE_REPOSITORY_REF=main \
 -p CONTEXT_DIR=.

oc set env dc/kitchensink DB_HOST=kitchensink-db DB_PORT=5432 DB_NAME=kitchensink DB_USERNAME=luke DB_PASSWORD=secret && \
oc set probe dc/kitchensink --readiness --initial-delay-seconds=90 --failure-threshold=5 && \
oc set probe dc/kitchensink --liveness --initial-delay-seconds=90 --failure-threshold=5

oc label dc/kitchensink app.kubernetes.io/part-of=kitchensink-app --overwrite=true -n ${PROJECT_NAME} && \
oc label dc/kitchensink app.openshift.io/runtime=jboss --overwrite=true -n ${PROJECT_NAME}

oc annotate dc/kitchensink app.openshift.io/connects-to='[{"apiVersion":"apps/v1","kind":"Deployment","name":"kitchensink-db"}]' --overwrite=true -n ${PROJECT_NAME}

# https://access.redhat.com/documentation/en-us/red_hat_jboss_enterprise_application_platform/7.4/html-single/getting_started_with_jboss_eap_for_openshift_container_platform/index#reference_clustering

# cat <<EOF | oc apply -f -
# ---
# kind: Service
# apiVersion: v1
# spec:
#     publishNotReadyAddresses: true
#     clusterIP: None
#     ports:
#     - name: ping
#       port: 8888
#     selector:
#       app.kubernetes.io/managed-by: eap-operator
#       app.kubernetes.io/name: kitchen-sink
#       app.openshift.io/runtime: eap
# metadata:
#     name: kitchen-sink-ping
#     annotations:
#         service.alpha.kubernetes.io/tolerate-unready-endpoints: "true"
#         description: "The JGroups ping port for clustering."
# ---
# kind: ConfigMap
# apiVersion: v1
# metadata:
#   name: eap-cluster-config
#   namespace: kitchensink-s2i
# data:
#   JGROUPS_PING_PROTOCOL=kubernetes.KUBE_PING
#   KUBERNETES_NAMESPACE=PROJECT_NAME
#   KUBERNETES_LABELS=application=kitchen-sink
# ---
# kind: Secret
# apiVersion: v1
# metadata:
#   name: eap-config
#   namespace: kitchensink-s2i
# stringData:
#   DB_HOST: kitchensink-db
#   DB_NAME: kitchensink
#   DB_PASSWORD: secret
#   DB_PORT: '5432'
#   DB_USERNAME: luke
# ---
# apiVersion: wildfly.org/v1alpha1
# kind: WildFlyServer
# metadata:
#   name: kitchen-sink
#   namespace: kitchensink-s2i
# spec:
#   applicationImage: 'kitchensink:latest'
#   envFrom:
#     - secretRef:
#         name: eap-config
#   replicas: 1
# EOF

# oc set probe statefulset/kitchen-sink --readiness --initial-delay-seconds=90 --failure-threshold=5 && \
# oc set probe statefulset/kitchen-sink --liveness --initial-delay-seconds=90 --failure-threshold=5