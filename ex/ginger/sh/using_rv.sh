#!/bin/bash

# go to this shell's current directory
SHELL_DIR=$(dirname $BASH_SOURCE)
# echo "SHELL_DIR=${SHELL_DIR}"

SRC_FILE=${SHELL_DIR}/../res/ginger_robot_start.sh.hc
TAR_FILE=/vendor/ginger_robot/scripts/ginger_robot_start.sh

echo "using head_camera for ginger_robot_start..."
source $SHELL_DIR/__ginger_utils.sh
sync_file ${SRC_FILE} ${TAR_FILE}
