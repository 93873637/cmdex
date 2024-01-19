#!/bin/bash

# --------------------------------------------------------
if [ -z $CMDEX_HOME ]; then
    echo "ERROR: CMDEX_HOME not set"
    exit -1
fi
echo "CMDEX_HOME=${CMDEX_HOME}"
# --------------------------------------------------------

echo
echo "# Cmdex Shell Commands"
echo

echo "[CMDEX]"
cd $CMDEX_HOME
ls *.sh
echo

echo "[CMDEX BASE]"
cd $CMDEX_HOME/sh
ls *
echo

source $CMDEX_HOME/sh/__extensions.sh
show_extensions_shell
