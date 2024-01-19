#!/bin/bash

# --------------------------------------------------------
if [ -z $CMDEX_HOME ]; then
    echo "ERROR: CMDEX_HOME not set"
    exit -1
fi
# echo "CMDEX_HOME=${CMDEX_HOME}"
# --------------------------------------------------------

python3 $CMDEX_HOME/py/cmd_main.py $*
