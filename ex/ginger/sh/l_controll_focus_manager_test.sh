#!/bin/bash

SHELL_DIR=$(
    cd "$(dirname "$0")"
    pwd
)
# echo "SHELL_DIR=${SHELL_DIR}"

GINGER_HOME=../../../../..
echo "GINGER_HOME=${GINGER_HOME}"

mkdir -p $GINGER_HOME && cd $GINGER_HOME

echo ""
echo "launch controller_focus_manager test..."

source ./build/devel/setup.bash
roslaunch controller_focus_manager test.launch
