#!/bin/bash

SRC_DIR=/home/kevin/work/nx441_4.7rel_make_coffee/packages/apps/robot_manager/robot_wrapper_plugins
CODE_STYLE=Google

# go to this shell's current directory
SHELL_DIR=$(cd $(dirname $BASH_SOURCE) && pwd)
# echo "** SHELL_DIR=$SHELL_DIR"

source $SHELL_DIR/__ginger_utils.sh
# format_cpp_code_on_dir $SRC_DIR "$CODE_STYLE"

# modified:   robot_grasping_wrapper_plugins/config/ginger.yaml
# modified:   robot_grasping_wrapper_plugins/config/ginger_making_coffee_config.yaml

# modified:   robot_grasping_wrapper_plugins/include/robot_grasping_wrapper_plugins/ginger_coffee_config.h
# modified:   robot_grasping_wrapper_plugins/include/robot_grasping_wrapper_plugins/ginger_coffee_ctrl.h
# modified:   robot_grasping_wrapper_plugins/include/robot_grasping_wrapper_plugins/ginger_making_coffee_common.h
# modified:   robot_grasping_wrapper_plugins/include/robot_grasping_wrapper_plugins/ginger_making_coffee_tutorial.h
# modified:   robot_grasping_wrapper_plugins/include/robot_grasping_wrapper_plugins/ginger_move_ctrl.h

# modified:   robot_grasping_wrapper_plugins/src/robot_grasping_wrapper_plugins/ginger_coffee_config.cpp
# modified:   robot_grasping_wrapper_plugins/src/robot_grasping_wrapper_plugins/ginger_coffee_ctrl.cpp
# modified:   robot_grasping_wrapper_plugins/src/robot_grasping_wrapper_plugins/ginger_move_ctrl.cpp
# modified:   robot_grasping_wrapper_plugins/src/robot_grasping_wrapper_plugins/robot_grasping_wrapper.cpp

format_cpp_code $SRC_DIR/robot_grasping_wrapper_plugins/include/robot_grasping_wrapper_plugins/ginger_coffee_config.h "$CODE_STYLE"
format_cpp_code $SRC_DIR/robot_grasping_wrapper_plugins/include/robot_grasping_wrapper_plugins/ginger_coffee_ctrl.h "$CODE_STYLE"
format_cpp_code $SRC_DIR/robot_grasping_wrapper_plugins/include/robot_grasping_wrapper_plugins/ginger_making_coffee_common.h "$CODE_STYLE"
format_cpp_code $SRC_DIR/robot_grasping_wrapper_plugins/include/robot_grasping_wrapper_plugins/ginger_making_coffee_tutorial.h "$CODE_STYLE"
format_cpp_code $SRC_DIR/robot_grasping_wrapper_plugins/include/robot_grasping_wrapper_plugins/ginger_move_ctrl.h "$CODE_STYLE"

format_cpp_code $SRC_DIR/robot_grasping_wrapper_plugins/include/robot_grasping_wrapper_plugins/ginger_coffee_config.cpp "$CODE_STYLE"
format_cpp_code $SRC_DIR/robot_grasping_wrapper_plugins/include/robot_grasping_wrapper_plugins/ginger_coffee_ctrl.cpp "$CODE_STYLE"
format_cpp_code $SRC_DIR/robot_grasping_wrapper_plugins/include/robot_grasping_wrapper_plugins/ginger_move_ctrl.cpp "$CODE_STYLE"
format_cpp_code $SRC_DIR/robot_grasping_wrapper_plugins/include/robot_grasping_wrapper_plugins/robot_grasping_wrapper.cpp "$CODE_STYLE"
