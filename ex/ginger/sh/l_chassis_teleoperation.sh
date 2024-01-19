#!/bin/bash

# --------------------------------------------------------
MODULE_NAME=l_chassis_teleoperation
LAUNCH_NAME=ginger_v2.launch
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
echo "launch $MODULE_NAME/$LAUNCH_NAME on local machine..."
source src/cr-tools/cmdex_tools/scripts/sh/ros_local.sh
source build/devel/setup.bash
roslaunch $MODULE_NAME $LAUNCH_NAME
