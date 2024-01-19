#!/bin/bash

#
# launch system integrated robot vision which locate on /vendor/ginger_robot
#

# go to the shell file's dir
SHELL_DIR=$(cd "$(dirname "$0")";pwd)
echo "SHELL_DIR=${SHELL_DIR}"
cd $SHELL_DIR

echo "** stop robot_vision..."
./rv_stop.sh

echo "** start robot_vision..."
./rv_start.sh
