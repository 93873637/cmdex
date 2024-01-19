#!/bin/bash

echo
echo "** CMDEX_HOME = [${CMDEX_HOME}]"

if [ "$CMDEX_HOME" != "" ]; then
    cd $CMDEX_HOME
fi

echo

source $CMDEX_HOME/sh/__extensions.sh
show_extensions_env
