#!/bin/bash

# --------------------------------------------------------
MODULE_NAME=robot_grasping_test
# --------------------------------------------------------

# --------------------------------------------------------
if [ -z $GINGER_HOME ]; then
    echo "ERROR: GINGER_HOME not set"
    exit -1
fi
echo "** GINGER_HOME=[${GINGER_HOME}]"
cd $GINGER_HOME
# --------------------------------------------------------

export ROS_MASTER_URI=http://192.168.1.200:11311
export ROS_IP=192.168.1.144

source build/devel/setup.bash

echo ""
echo "launch $MODULE_NAME..."
echo "** ROS_MASTER_URI=[${ROS_MASTER_URI}]"
echo "** ROS_IP=[${ROS_IP}]"

roslaunch robot_grasping_test ginger_making_coffee_demo.launch
