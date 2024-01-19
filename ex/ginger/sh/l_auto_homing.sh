#!/bin/bash

# NOTE: need launch robot_engine first

SHELL_DIR=$(
    cd "$(dirname "$0")"
    pwd
)
# echo "SHELL_DIR=${SHELL_DIR}"

GINGER_HOME=../../../../..
echo "GINGER_HOME=${GINGER_HOME}"

mkdir -p $GINGER_HOME && cd $GINGER_HOME

source ./build/devel/setup.bash
roslaunch robot_auto_homing ginger102.launch
