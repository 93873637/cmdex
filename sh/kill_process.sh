#!/bin/bash

if [ $# -ne 1 ];then
    echo "[usage]: $(basename $BASH_SOURCE) <process-name>"
    exit -1
fi

# the shell file dir name
SHELL_DIR=$(cd "$(dirname "$BASH_SOURCE")";pwd)
# echo "** SHELL_DIR=[${SHELL_DIR}]"
source $SHELL_DIR/utils/comfuns.sh

kill_process_by_name $1
