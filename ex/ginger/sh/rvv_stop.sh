#!/bin/bash

#
# stop robot_vision_node by kill launch and pid together
#

MODULE_NAME=robot_vision_viewer

echo
echo "kill ${MODULE_NAME} launch pid..."
MODULE_LAUNCH_PID=`ps -efw | grep ${MODULE_NAME}.launch | grep -v grep | awk '{print $2}'`
if [ "$MODULE_LAUNCH_PID" = "" ]
then
    echo "${MODULE_NAME} launch pid not found."
else
    sudo kill -9 ${MODULE_LAUNCH_PID}
fi

echo
echo "kill ${MODULE_NAME} node pid..."
MODULE_PID=`ps -efw | grep ${MODULE_NAME}_node | grep -v grep | awk '{print $2}'`
if [ "$MODULE_PID" = "" ]
then
    echo "${MODULE_NAME} node pid not found."
else
    sudo kill -9 ${MODULE_PID}
fi

echo
echo "view ${MODULE_NAME} ps info..."
ps -efw | grep ${MODULE_NAME} | grep -v grep
