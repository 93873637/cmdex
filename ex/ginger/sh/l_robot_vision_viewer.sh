#!/bin/bash

# --------------------------------------------------------
MODULE_NAME=robot_vision_viewer
# --------------------------------------------------------

# --------------------------------------------------------
if [ -z $GINGER_HOME ]; then
    echo "ERROR: GINGER_HOME not set"
    exit -1
fi
echo "** GINGER_HOME=[${GINGER_HOME}]"
cd $GINGER_HOME
# --------------------------------------------------------

source build/devel/setup.bash

echo ""
echo "launch $MODULE_NAME..."
echo "** ROS_MASTER_URI=[${ROS_MASTER_URI}]"
echo "** ROS_IP=[${ROS_IP}]"
roslaunch $MODULE_NAME $MODULE_NAME.launch debug:=true
