#!/bin/bash

# --------------------------------------------------------
if [ -z $CMDEX_HOME ]; then
    echo "ERROR: CMDEX_HOME not set"
    exit -1
fi
echo "CMDEX_HOME=${CMDEX_HOME}"
# --------------------------------------------------------

echo
echo "[CXX]: remove link files...."
rm $CMDEX_HOME/cx
find $CMDEX_HOME/sh/ -type l -delete
echo

echo
echo "[CXX]: remove python cache files...."
rm -rf $CMDEX_HOME/py/__pycache__
echo

source $CMDEX_HOME/sh/__extensions.sh
remove_extensions_link
