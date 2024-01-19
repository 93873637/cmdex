#!/bin/bash

# --------------------------------------------------------
if [ -z $CMDEX_HOME ]; then
    echo "ERROR: CMDEX_HOME not set"
    exit -1
fi
echo "CMDEX_HOME=${CMDEX_HOME}"
# --------------------------------------------------------

echo
echo "[CXX]: set execute files...."
$CMDEX_HOME/sh/cx_exe_i.sh -o
echo
