#!/bin/bash

# NOTE: if control head moving, launch robot_engine first

SHELL_DIR=$(
    cd "$(dirname "$0")"
    pwd
)
# echo "SHELL_DIR=${SHELL_DIR}"

GINGER_HOME=../../../../..
echo "GINGER_HOME=${GINGER_HOME}"

mkdir -p $GINGER_HOME && cd $GINGER_HOME

echo "launch head_camera..."

export GST_DEBUG_DUMP_DOT_DIR=~/tmp/
echo "export GST_DEBUG_DUMP_DOT_DIR=$GST_DEBUG_DUMP_DOT_DIR"

source ./build/devel/setup.bash
roslaunch head_camera head_camera.launch display:=false
