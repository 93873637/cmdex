#!/bin/bash

# the shell file dir name
SHELL_DIR=$(
    cd "$(dirname "$BASH_SOURCE")"
    pwd
)
# echo "** SHELL_DIR=[${SHELL_DIR}]"
source $SHELL_DIR/__ginger_utils.sh

kill_process_by_name rosmaster
kill_process_by_name rosout
