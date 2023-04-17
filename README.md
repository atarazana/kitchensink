
[![Contribute](https://www.eclipse.org/che/contribute.svg)](https://devspaces.apps.cluster-5k9m9.5k9m9.sandbox3072.opentlc.com/#https://github.com/atarazana/kitchensink.git)

```sh
until oc apply -k util/bootstrap/; do sleep 2; done
```

```sh
./util/create-checluster-github-service.sh ${GH_OAUTH_CLIENT_ID} ${GH_OAUTH_CLIENT_SECRET}
```

# EAP Kitchen sink application using external MySQL database.

To run, first start a mysql database using docker-compose

`docker-compose up`

Run wildfly, from the EAP_HOME folder, run:

`./bin/standalone.sh`

Copy the contents of the modules folder to the EAP_HOME/modules folder.

deploy the Kitchen sink application, from the repo location run:


`mvn clean install wildfly:deploy`

Add the driver and datasource, from the EAP_HOME folder, run:


```

jboss-cli.sh

/subsystem=datasources/jdbc-driver=mysql:add(driver-name=mysql,driver-module-name=com.mysql)

data-source add --name=mysql --jndi-name=java:/jdbc/mysql --driver-name=mysql --connection-url=jdbc:mysql://127.0.0.1:3306/books --user-name=root --password=root
```

Test the kitchen sink app at url:  http://127.0.0.1:8080/kitchensink/index.jsf

SECRET!



./util/create-registry-secret.sh demo-6 myregistry-quay-app.quay-system demos demos+cicd 9QS9LSMK1DR15I9TJVAZ5LOXB6XRK991D9MN1ZQU4ASB13CXB13Z6ABKYV7B8TT0 quay-creds
