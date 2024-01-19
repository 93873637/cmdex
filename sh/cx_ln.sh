#!/bin/bash

# --------------------------------------------------------
if [ -z $CMDEX_HOME ]; then
    echo "ERROR: CMDEX_HOME not set"
    exit -1
fi
echo "CMDEX_HOME=${CMDEX_HOME}"
# --------------------------------------------------------

echo
echo "[CXL]: set link files...."
source $CMDEX_HOME/sh/utils/comfuns.sh

cd $CMDEX_HOME
setlink $CMDEX_HOME/cmdex.sh cx

cd $CMDEX_HOME/sh
source $CMDEX_HOME/sh/__setlink.sh

source $CMDEX_HOME/sh/__extensions.sh
print_link cmdex
add_extensions_link
