#!/bin/bash

SRC_DIR=/home/tomli/projs/ginger/pisces_devel/packages/apps/robot_vision/robot_vision
CODE_STYLE=Google

# go to this shell's current directory
SHELL_DIR=$(cd $(dirname $BASH_SOURCE) && pwd)
# echo "** SHELL_DIR=$SHELL_DIR"

source $SHELL_DIR/__ginger_utils.sh
format_cpp_code_on_dir $SRC_DIR "$CODE_STYLE"
