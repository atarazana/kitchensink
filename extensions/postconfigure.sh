#!/usr/bin/env bash
echo ">>>>>> Executing postconfigure.sh <<<<<<<"

if [ "${SCRIPT_DEBUG}" = "true" ] ; then
    set -x
    echo "Script debugging is enabled, allowing bash commands and their arguments to be printed as they are executed"
fi

echo ">>>>>> Executing setup.cli <<<<<<<"
$JBOSS_HOME/bin/jboss-cli.sh --file=$JBOSS_HOME/extensions/setup.cli

