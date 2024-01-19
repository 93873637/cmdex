#!/bin/bash

#
# launch system integrated robot vision which locate on /vendor/ginger_robot
#

# go to the shell file's dir
SHELL_DIR=$(dirname $BASH_SOURCE)
echo "** SHELL_DIR=${SHELL_DIR}"
cd $SHELL_DIR

echo "** launch system robot_vision..."
./l_robot_vision_location.sys.sh
