#!/bin/bash

# --------------------------------------------------------
MODULE_NAME=robot_vision_location
# --------------------------------------------------------

# --------------------------------------------------------
if [ -z $GINGER_HOME ]; then
    echo "ERROR: GINGER_HOME not set"
    exit -1
fi
echo "GINGER_HOME=${GINGER_HOME}"
cd $GINGER_HOME
# --------------------------------------------------------

# ros master on local machine
# source src/cr-tools/cmdex_tools/scripts/sh/ros_local.sh

# NOTE: modify the ip addresses according to your network environment
# export ROS_MASTER_URI=http://127.0.0.1:11311
# export ROS_IP=127.0.0.1
# export ROS_MASTER_URI=http://192.168.1.200:11311
# export ROS_IP=192.168.1.144
# export ROS_MASTER_URI=http://10.11.32.144:11311
# export ROS_MASTER_URI=http://10.11.32.149:11311
# export ROS_IP=10.11.32.66

source build/devel/setup.bash

echo "** ROS_MASTER_URI=[${ROS_MASTER_URI}]"
echo "** ROS_IP=[${ROS_IP}]"

# --------------------------------------------------------
# set log file
# --------------------------------------------------------
LOG_DIR=~/tmp/log
mkdir -p $LOG_DIR
echo "[ $THIS_FILE ]: set LOG_DIR=${LOG_DIR}"

if [ ! -d "${LOG_DIR}" ]; then
    echo "[ $THIS_FILE ]: log dir '${LOG_DIR}' not exists, create..."
    mkdir -p ${LOG_DIR}
fi

DATE_TIME=$(date +%y.%m%d.%H%M%S)
LOG_FILE=${LOG_DIR}/${MODULE_NAME}_${DATE_TIME}.log
echo "[ $THIS_FILE ]: set LOG_FILE=${LOG_FILE}"
# --------------------------------------------------------

UN_BUF="stdbuf -oL -eL "
ROS_USER_LAUNCH="roslaunch"
${UN_BUF} ${ROS_USER_LAUNCH} $MODULE_NAME $MODULE_NAME.launch debug:=true 2>&1 | tee ${LOG_FILE}
