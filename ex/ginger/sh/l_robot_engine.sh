#!/bin/bash

SHELL_DIR=$(
    cd "$(dirname "$0")"
    pwd
)
# echo "SHELL_DIR=${SHELL_DIR}"

GINGER_HOME=../../../../..
echo "GINGER_HOME=${GINGER_HOME}"

mkdir -p $GINGER_HOME && cd $GINGER_HOME

echo "stop ginger service..."
systemctl stop ginger.service

echo ""
echo "launch robot engine..."
source ./build/devel/setup.bash
roslaunch robot_engine ginger_v1.launch
