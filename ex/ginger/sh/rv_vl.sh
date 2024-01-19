#!/bin/bash

# go to the shell file's dir
SHELL_DIR=$(dirname $BASH_SOURCE)
echo "** SHELL_DIR=${SHELL_DIR}"
cd $SHELL_DIR

./viewlog.sh robot_vision
