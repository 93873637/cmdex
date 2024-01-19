#!/bin/bash

# the shell file dir name
SHELL_DIR=$(
    cd "$(dirname "$BASH_SOURCE")"
    pwd
)
# echo "** SHELL_DIR=[${SHELL_DIR}]"
source $SHELL_DIR/__ginger_utils.sh

if [ $# -ne 1 ]; then
    echo "[usage]: $(basename $BASH_SOURCE) <module-name>"
    exit -1
fi
stop_ccu_module $1
