#!/bin/bash

# --------------------------------------------------------
MODULE_NAME=robot_vision_zero
# --------------------------------------------------------

# --------------------------------------------------------
if [ -z $GINGER_HOME ]; then
    echo "ERROR: GINGER_HOME not set"
    exit -1
fi
echo "GINGER_HOME=${GINGER_HOME}"
cd $GINGER_HOME
# --------------------------------------------------------

echo ""
echo "launch $MODULE_NAME on local machine..."
source src/cr-tools/cmdex_tools/scripts/sh/ros_local.sh
source build/devel/setup.bash
roslaunch $MODULE_NAME $MODULE_NAME.launch debug:=true tagsize:=0.254
